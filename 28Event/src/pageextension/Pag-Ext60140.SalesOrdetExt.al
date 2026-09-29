pageextension 60140 SalesOrdetExt extends "Sales Order"
{
    layout
    {
        addfirst(General)
        {
            field(TravelCost; Rec.TravelCost)
            {
                ApplicationArea = all;
                Caption = 'Travel Cost';
            }
        }
    }


}