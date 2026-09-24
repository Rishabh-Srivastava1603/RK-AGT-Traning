pageextension 60141 PurchaseOrderSubExt extends "Purchase Order Subform"
{
    layout
    {
        addbefore(Description)
        {

            field(PlaningCost; Rec.PlaningCost)
            {
                ApplicationArea = all;
                Caption = 'Planing Cost';
            }
        }

    }


}