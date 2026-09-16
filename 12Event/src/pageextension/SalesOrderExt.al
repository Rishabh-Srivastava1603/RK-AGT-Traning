pageextension 60130 SalesOrderExt extends "Sales Order"
{
    layout
    {
        addfirst(General)
        {
            field(FoodDelivery; Rec.FoodDelivery)
            {
                Caption = 'Food Delivery';
                ApplicationArea = all;
            }
        }
    }


}