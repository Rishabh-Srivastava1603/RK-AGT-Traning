pageextension 60141 PostedSalesShipSubFormExt extends "Posted Sales Shpt. Subform"
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