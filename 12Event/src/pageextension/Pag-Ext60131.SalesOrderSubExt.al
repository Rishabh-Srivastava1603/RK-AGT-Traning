pageextension 60131 SalesOrderSubExt extends "Sales Order Subform"
{
    layout
    {
        addbefore(Description)
        {
            field(FoodDelivery; Rec.FoodDelivery)
            {
                Caption = 'Food Delivery';
                ApplicationArea = all;
            }
        }
    }


}