pageextension 60140 SalesOrderSubformExt extends "Sales Order Subform"
{
    layout
    {
        addbefore(Description)
        {
            field(StartDate; Rec.StartDate)
            {
                ApplicationArea = all;
                Caption = 'Start Date';
            }
        }
    }


}