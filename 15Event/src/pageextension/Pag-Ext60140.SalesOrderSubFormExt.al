pageextension 60140 SalesOrderSubFormExt extends "Sales Order Subform"
{
    layout
    {
        addbefore(Description)
        {
            field(ResearchExp; Rec.ResearchExp)
            {
                ApplicationArea = All;
                Caption = 'ResearchExp';
            }
            field(DevelopmentExp; Rec.DevelopmentExp)
            {
                ApplicationArea = All;
                Caption = 'DevelpmentExp';
            }
        }

    }


}