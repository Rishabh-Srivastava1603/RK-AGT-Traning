report 60140 "Custom Invoice Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Custom Invoice Report.rdl';
    Caption = 'CIR';

    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "Posting Date";
            // Company
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyVATRegNo; CompanyInfo."VAT Registration No.") { }
            column(CompanyPhone; CompanyInfo."Phone No.") { }
            column(CompanyLogo; CompanyLogoBase64) { }

            // Header & Address Section 2
            column(InvoiceNo; "No.") { }
            column(PostingDate; Format("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(DueDate; Format("Due Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(BillToNo; "Bill-to Customer No.") { }
            column(BillToName; "Bill-to Name") { }
            column(BillToAddressLine1; CustAddr[1]) { }
            column(BillToAddressLine2; CustAddr[2]) { }
            column(BillToAddressLine3; CustAddr[3]) { }
            column(BillToAddressLine4; CustAddr[4]) { }
            column(BillToAddressLine5; CustAddr[5]) { }
            column(BillToAddressLine6; CustAddr[6]) { }
            column(BillToAddressLine7; CustAddr[7]) { }
            column(BillToAddressLine8; CustAddr[8]) { }
            column(ShipToAddressLine1; ShipToAddr[1]) { }
            column(ShipToAddressLine2; ShipToAddr[2]) { }
            column(ShipToAddressLine3; ShipToAddr[3]) { }
            column(ShipToAddressLine4; ShipToAddr[4]) { }
            column(ShipToAddressLine5; ShipToAddr[5]) { }
            column(ShipToAddressLine6; ShipToAddr[6]) { }
            column(ShipToAddressLine7; ShipToAddr[7]) { }
            column(ShipToAddressLine8; ShipToAddr[8]) { }
            column(PaymentTermsCode; "Payment Terms Code") { }
            column(CurrencyCode; GetCurrencyCode("Currency Code")) { }
            column(ExternalDocNo; "External Document No.") { }
            column(YourReference; "Your Reference") { }
            column(ShowInternalInfo; ShowInternalInfo) { }
            // Totals
            column(TotalExclVAT; TotalExclVAT) { }
            column(TotalVAT; TotalVAT) { }
            column(TotalInclVAT; TotalInclVAT) { }

            dataitem(Line; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = SalesInvoiceHeader;
                DataItemTableView = sorting("Document No.", "Line No.");

                column(LineNo; "Line No.") { }
                column(LineType; Format(Type)) { }
                column(ItemNo; "No.") { }
                column(LineDescription; Description) { }
                column(Quantity; Quantity) { }
                column(UnitOfMeasure; "Unit of Measure") { }
                column(UnitPrice; "Unit Price") { }
                column(LineDiscountPct; "Line Discount %") { }
                column(LineAmount; Amount) { }
                column(VATPct; "VAT %") { }
                column(AmountInclVAT; "Amount Including VAT") { }

                trigger OnAfterGetRecord()
                begin
                    TotalExclVAT += Amount;
                    TotalInclVAT += "Amount Including VAT";
                    TotalVAT += ("Amount Including VAT" - Amount);

                    if ("VAT %" <> 0) or (Amount <> 0) then begin
                        TempVATAmountLine.Reset();
                        TempVATAmountLine.SetRange("VAT %", "VAT %");
                        TempVATAmountLine.SetRange("VAT Identifier", "VAT Identifier");
                        if TempVATAmountLine.FindFirst() then begin
                            TempVATAmountLine."VAT Base" += Amount;
                            TempVATAmountLine."VAT Amount" += ("Amount Including VAT" - Amount);
                            TempVATAmountLine."Amount Including VAT" += "Amount Including VAT";
                            TempVATAmountLine.Modify();
                        end else begin
                            TempVATAmountLine.Init();
                            TempVATAmountLine."VAT %" := "VAT %";
                            TempVATAmountLine."VAT Identifier" := "VAT Identifier";
                            TempVATAmountLine."VAT Base" := Amount;
                            TempVATAmountLine."VAT Amount" := ("Amount Including VAT" - Amount);
                            TempVATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            TempVATAmountLine.Insert();
                        end;
                    end;
                end;
            }

            dataitem(VATSummary; Integer)
            {
                DataItemTableView = sorting(Number);
                column(VATPctSummary; TempVATAmountLine."VAT %") { }
                column(VATBase; TempVATAmountLine."VAT Base") { }
                column(VATAmount; TempVATAmountLine."VAT Amount") { }

                trigger OnPreDataItem()
                begin
                    TempVATAmountLine.Reset();
                    SetRange(Number, 1, TempVATAmountLine.Count);
                end;

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then
                        TempVATAmountLine.FindSet()
                    else
                        TempVATAmountLine.Next();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                FormatAddress.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
                FormatAddress.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvoiceHeader);

                Clear(TotalExclVAT);
                Clear(TotalVAT);
                Clear(TotalInclVAT);
                TempVATAmountLine.Reset();
                TempVATAmountLine.DeleteAll();
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
                    field(ShowInternalInfoField; ShowInternalInfo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Internal Info';
                    }
                    field(LogInteractionField; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                    }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        GetCompanyLogoBase64();
    end;


    var
        CompanyInfo: Record "Company Information";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        FormatAddress: Codeunit "Format Address";
        Base64Convert: Codeunit "Base64 Convert";
        CompanyLogoBase64: Text;
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        ShowInternalInfo: Boolean;
        LogInteraction: Boolean;
        TotalExclVAT: Decimal;
        TotalVAT: Decimal;
        TotalInclVAT: Decimal;

    local procedure GetCompanyLogoBase64()
    var
        ImageInStream: InStream;
    begin
        if CompanyInfo.Picture.HasValue then begin
            CompanyInfo.Picture.CreateInStream(ImageInStream);
            CompanyLogoBase64 := Base64Convert.ToBase64(ImageInStream);
        end;
    end;

    local procedure GetCurrencyCode(CurrCode: Code[10]): Code[10]
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        if CurrCode <> '' then
            exit(CurrCode);
        GeneralLedgerSetup.Get();
        exit(GeneralLedgerSetup."LCY Code");
    end;

}