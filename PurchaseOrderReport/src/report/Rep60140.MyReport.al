report 60140 MyReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Rdlc;
    RDLCLayout = './PurchaseOrder.Rdlc';
    Caption = 'Purchase Order Clone Report';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = const(Order));
            column(PurchaseOrderNo; "No.") { }
            column(PurchaseOrderDate; "Order Date") { }
            // company address
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

            // Buy-from address
            column(BuyFromAddress1; BuyFromAddress[1]) { }
            column(BuyFromAddress2; BuyFromAddress[2]) { }
            column(BuyFromAddress3; BuyFromAddress[3]) { }
            column(BuyFromAddress4; BuyFromAddress[4]) { }
            column(BuyFromAddress5; BuyFromAddress[5]) { }
            column(BuyFromAddress6; BuyFromAddress[6]) { }
            column(BuyFromAddress7; BuyFromAddress[7]) { }
            column(BuyFromAddress8; BuyFromAddress[8]) { }

            // Ship-to address
            column(ShipToAddress1; ShipToAddress[1]) { }
            column(ShipToAddress2; ShipToAddress[2]) { }
            column(ShipToAddress3; ShipToAddress[3]) { }
            column(ShipToAddress4; ShipToAddress[4]) { }
            column(ShipToAddress5; ShipToAddress[5]) { }
            column(ShipToAddress6; ShipToAddress[6]) { }
            column(ShipToAddress7; ShipToAddress[7]) { }
            column(ShipToAddress8; ShipToAddress[8]) { }


            // Payment terms
            column(Payment_Terms_Code; "Payment Terms Code") { }
            // vendor Invoice no
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            // vendor ord no 
            column(Vendor_Order_No_; "Vendor Order No.") { }
            column(SubTotal; Format(SubTotal, 0, '<Precision,2:2><Standard Format,0>')) { }
            column(InvoiceDiscount; Format(InvoiceDiscount, 0, '<Precision,2:2><Standard Format,0>')) { }
            column(TotalTax; Format(Tax, 0, '<Precision,2:2><Standard Format,0>')) { }
            column(TotalIncludingVAT; Format(TotalUSD, 0, '<Precision,2:2><Standard Format,0>')) { }
            column(DocumentCurrencyCode; "Currency Code") { }


            dataitem(PurchaseLine; "Purchase Line")
            {
                DataItemLink =
                "Document Type" = field("Document Type"),
                "Document No." = field("No.");
                column(ItemNo; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(UnitOfMeasure; "Unit of Measure") { }
                column(UnitCost; Format("Direct Unit Cost", 0, '<Precision,2:2><Standard Format,0>')) { }
                column(LineAmount; Format(Amount, 0, '<Precision,2:2><Standard Format,0>')) { }

            }

            trigger OnAfterGetRecord()
            begin
                Clear(BuyFromAddress);
                FormatAddress.PurchHeaderBuyFrom(BuyFromAddress, "Purchase Header");

                Clear(ShipToAddress);
                FormatAddress.PurchHeaderShipTo(ShipToAddress, "Purchase Header");

                Clear(SubTotal);
                Clear(InvoiceDiscount);
                Clear(Tax);
                Clear(TotalUSD);

                PurchaseLineTotals.Reset();
                PurchaseLineTotals.SetRange("Document Type", "Purchase Header"."Document Type");
                PurchaseLineTotals.SetRange("Document No.", "Purchase Header"."No.");
                if PurchaseLineTotals.FindSet() then
                    repeat
                        InvoiceDiscount += PurchaseLineTotals."Inv. Discount Amount";
                        SubTotal += PurchaseLineTotals.Amount + PurchaseLineTotals."Inv. Discount Amount";
                        Tax += PurchaseLineTotals."Amount Including VAT" - PurchaseLineTotals.Amount;
                        TotalUSD += PurchaseLineTotals."Amount Including VAT";
                    until PurchaseLineTotals.Next() = 0;
            end;

            trigger OnPreDataItem()
            begin
                if "Order No" = '' then
                    Error('Please select a Purchase Order No.');

                SetFilter("No.", "Order No");

            end;

        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(FilterRecord)
                {
                    field("Order No"; "Order No")
                    {
                        Caption = 'Purchase Order No.';
                        TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
                        ToolTip = 'Enter one purchase order number, or separate multiple numbers with |.';
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
        "Order No": Text[250];
        CompanyInformation: Record "Company Information";
        FormatAddress: Codeunit "Format Address";
        CompanyAddress: array[8] of Text[100];
        BuyFromAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        PurchaseLineTotals: Record "Purchase Line";
        SubTotal: Decimal;
        InvoiceDiscount: Decimal;
        Tax: Decimal;
        TotalUSD: Decimal;
}