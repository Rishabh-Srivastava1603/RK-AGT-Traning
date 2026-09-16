pageextension 60130 SalesPageExt extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field(CustomerTitle; rec.CustomerTitle)
            {
                caption = 'Customer Title';
                ApplicationArea = all;
            }
        }

    }


}