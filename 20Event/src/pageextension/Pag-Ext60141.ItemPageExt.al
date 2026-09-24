pageextension 60141 ItemPageExt extends "Item Card"
{
    layout
    {
        addfirst(Item)
        {
            field(UnitPrice1; Rec.UnitPrice1)
            {
                Caption = 'Unit Price 1';
                ApplicationArea = all;
            }
            field(UnitPrice2; Rec.UnitPrice2)
            {
                Caption = 'Unit Price 2';
                ApplicationArea = all;
            }
        }
    }


}