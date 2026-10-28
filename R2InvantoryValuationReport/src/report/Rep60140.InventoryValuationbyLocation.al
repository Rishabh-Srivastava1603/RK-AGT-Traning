report 60140 "Inventory Valuation byLocation"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Inventory Valuation.rdlc';
    Caption = 'Rk Inv';

    dataset
    {
        dataitem(Item; Item)
        {
            column(ItemNo; "No.") { }
            column(ItemDescreption; Description) { }
            column(ItemCategoryCode; "Item Category Code") { }
            column(AsOfDate; "AsOfDate") { }
            column(PageBreak; PageBreak) { }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Item No." = field("No.");
                column(Location_Code; "Location Code") { }
                column(Item_Ledger_Entry_Quantity; "Item Ledger Entry Quantity") { }
                column(Cost_Amount_Actual; "Cost Amount (Actual)") { }
                column(Posting_Date; "Posting Date") { }
                column(UnitCost; UnitCost) { }
                trigger OnAfterGetRecord()
                begin

                    if "Item Ledger Entry Quantity" <> 0 then
                        UnitCost := "Cost Amount (Actual)" / "Item Ledger Entry Quantity"
                    else
                        UnitCost := 0;
                end;

                trigger OnPreDataItem()
                begin
                    if LocationCode <> '' then begin
                        SetRange("Location Code", LocationCode);
                    end;
                    if ValuationDate <> 0D then
                        SetRange("Posting Date", 0D, ValuationDate);
                end;
            }
            trigger OnPreDataItem()
            begin

                if ItemCategoryCode <> '' then begin
                    SetRange("Item Category Code", ItemCategoryCode);
                end;

            end;

            trigger OnAfterGetRecord()
            begin
                if ValuationDate <> 0D then AsOfDate := ValuationDate;
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
                group(GroupName)
                {
                    field(ValuationDate; ValuationDate) { }
                    field(ItemCategoryCode; ItemCategoryCode)
                    {
                        TableRelation = "Item Category".Code;
                    }
                    field(LocationCode; LocationCode)
                    {
                        TableRelation = "Location".Code;
                    }
                    field(PageBreak; PageBreak) { }

                }
            }
        }

    }



    var
        AsOfDate: Date;
        PageBreak: Boolean;
        UnitCost: decimal;
        ItemCategoryCode: code[20];
        LocationCode: code[10];
        ValuationDate: Date;
        UnitPrice: Decimal;
        SubTotalQantity: Decimal;
        SubTotalAmount: Decimal;


}