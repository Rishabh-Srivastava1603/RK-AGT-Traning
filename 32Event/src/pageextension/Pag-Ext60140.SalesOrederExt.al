pageextension 60140 SalesOrederExt extends "Sales Order Subform"
{
    layout
    {
        addbefore(Description)
        {
            field(PlanningCost; Rec.PlanningCost)
            {
                ApplicationArea = all;
                Caption = 'Planning Cost';
            }
        }
    }


}