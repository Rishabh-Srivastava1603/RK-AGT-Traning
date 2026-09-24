pageextension 60140 PurchaseOrderExt extends "Purchase Order"
{
    layout
    {
        addfirst(General)
        {

            field(PlaningCost; Rec.PlaningCost)
            {
                ApplicationArea = all;
                Caption = 'Planing Cost';
            }
        }

    }


}