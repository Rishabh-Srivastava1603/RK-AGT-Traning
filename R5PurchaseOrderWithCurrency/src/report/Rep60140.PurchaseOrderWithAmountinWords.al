report 60140 PurchaseOrderWithAmountinWords
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Rdlc;
    RDLCLayout = './PurchaseOrder.Rdlc';
    Caption = 'POWR';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Order Date";


            column(OrderNo; "No.") { }
            column(OrderDate; Format("Order Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(ExpectedReceiptDate; Format("Expected Receipt Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(BuyFromNo; "Buy-from Vendor No.") { }
            column(BuyFromName; "Buy-from Vendor Name") { }
            column(CurrencyCode; "Currency Code") { }
            column(CurrencyFactor; "Currency Factor") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(Vendor_Order_No_; "Vendor Order No.") { }

            // --- Company Address ---
            column(CompanyAddress1; CompanyAddress[1]) { }
            column(CompanyAddress2; CompanyAddress[2]) { }
            column(CompanyAddress3; CompanyAddress[3]) { }
            column(CompanyAddress4; CompanyAddress[4]) { }
            column(CompanyAddress5; CompanyAddress[5]) { }
            column(CompanyAddress6; CompanyAddress[6]) { }
            column(CompanyAddress7; CompanyAddress[7]) { }
            column(CompanyAddress8; CompanyAddress[8]) { }
            column(CompanyPicture; CompanyInformation.Picture) { }
            column(CompanyPhoneNo; CompanyInformation."Phone No.") { }
            column(CompanyEmail; CompanyInformation."E-Mail") { }

            // --- Buy-from Address ---
            column(BuyFromAddressLine1; BuyFromAddress[1]) { }
            column(BuyFromAddressLine2; BuyFromAddress[2]) { }
            column(BuyFromAddressLine3; BuyFromAddress[3]) { }
            column(BuyFromAddressLine4; BuyFromAddress[4]) { }
            column(BuyFromAddressLine5; BuyFromAddress[5]) { }
            column(BuyFromAddressLine6; BuyFromAddress[6]) { }
            column(BuyFromAddressLine7; BuyFromAddress[7]) { }
            column(BuyFromAddressLine8; BuyFromAddress[8]) { }

            // --- Ship-to Address ---
            column(ShipToAddress1; ShipToAddress[1]) { }
            column(ShipToAddress2; ShipToAddress[2]) { }
            column(ShipToAddress3; ShipToAddress[3]) { }
            column(ShipToAddress4; ShipToAddress[4]) { }
            column(ShipToAddress5; ShipToAddress[5]) { }
            column(ShipToAddress6; ShipToAddress[6]) { }
            column(ShipToAddress7; ShipToAddress[7]) { }
            column(ShipToAddress8; ShipToAddress[8]) { }

            // --- Totals (Required by Question) ---
            column(TotalAmount; TotalAmount) { }
            column(TotalAmountLCY; TotalAmountLCY) { }
            column(CurrencyLabel; CurrencyLabel) { }
            column(SubTotal; SubTotal) { }
            column(InvoiceDiscount; InvoiceDiscount) { }
            column(TotalTax; Tax) { }
            column(ShowAmountInWords; ShowAmountInWords) { }
            column(AmountInWords; AmountInWords) { }


            dataitem(PurchaseLine; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                // --- Line Fields (Required by Question) ---
                column(LineNo; "Line No.") { }
                column(ItemNo; "No.") { }
                column(LineDescription; Description) { }
                column(Quantity; Quantity) { }
                column(UnitOfMeasure; "Unit of Measure") { }
                column(DirectUnitCost; "Direct Unit Cost") { }
                column(LineAmount; Amount) { }
                column(LineAmountIncludingVAT; "Amount Including VAT") { }

                trigger OnAfterGetRecord()
                begin
                    // Accumulate totals
                    InvoiceDiscount += "Inv. Discount Amount";
                    SubTotal += Amount + "Inv. Discount Amount";
                    Tax += "Amount Including VAT" - Amount;
                    TotalAmount += "Amount Including VAT";
                    AmountInWords := AmountToWords(TotalAmount);
                    if CurrencyFactorValue <> 0 then
                        TotalAmountLCY += Round("Amount Including VAT" / CurrencyFactorValue, GLSetup."Amount Rounding Precision")
                    else
                        TotalAmountLCY += "Amount Including VAT";
                end;
            }

            trigger OnPreDataItem()
            begin
                "Purchase Header".SetFilter("Document Type", '%1', "Purchase Header"."Document Type"::Order);
                if OrderNo <> '' then
                    "Purchase Header".SetFilter("No.", OrderNo);
            end;

            trigger OnAfterGetRecord()
            begin
                // Format Addresses
                Clear(BuyFromAddress);
                FormatAddress.PurchHeaderBuyFrom(BuyFromAddress, "Purchase Header");

                Clear(ShipToAddress);
                FormatAddress.PurchHeaderShipTo(ShipToAddress, "Purchase Header");

                // Determine Currency Label (shows LCY Code when Currency Code is blank)
                GLSetup.Get();
                if "Currency Code" <> '' then
                    CurrencyLabel := "Currency Code"
                else
                    CurrencyLabel := GLSetup."LCY Code";

                // Reset Totals before lines run
                Clear(SubTotal);
                Clear(InvoiceDiscount);
                Clear(Tax);
                Clear(TotalAmount);
                Clear(TotalAmountLCY);
                CurrencyFactorValue := "Currency Factor";
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowAmountInWordsField; ShowAmountInWords)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Amount in Words';
                    }
                    field(OrderNo; OrderNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Order No.';
                        TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        Clear(CompanyAddress);
        if CompanyInformation.Get() then begin
            CompanyInformation.CalcFields(Picture);
            FormatAddress.Company(CompanyAddress, CompanyInformation);
        end;
    end;

    var
        CompanyInformation: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        FormatAddress: Codeunit "Format Address";
        CompanyAddress: array[8] of Text[100];
        BuyFromAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        SubTotal: Decimal;
        InvoiceDiscount: Decimal;
        Tax: Decimal;
        TotalAmount: Decimal;
        TotalAmountLCY: Decimal;
        CurrencyLabel: Code[10];
        ShowAmountInWords: Boolean;
        OrderNo: Code[250];
        CurrencyFactorValue: Decimal;
        AmountInWords: Text[250];

    local procedure AmountToWords(Amount: Decimal): Text[250]
    var
        CheckTranslationManagement: Report "Check Translation Management";
        Language: Codeunit Language;
        NoText: array[2] of Text[80];
    begin
        CheckTranslationManagement.FormatNoText(
            NoText,
            Amount,
            Language.GetLanguageIdOrDefault('ENU'),
            CurrencyLabel);

        exit(DelChr(DelChr(NoText[1] + NoText[2], '=', '*'), '<>', ' '));
    end;
}