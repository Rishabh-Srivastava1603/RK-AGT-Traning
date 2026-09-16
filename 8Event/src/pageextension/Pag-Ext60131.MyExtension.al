pageextension 60131 MyExtension extends "General Ledger Entries"
{
    layout
    {
        addbefore(Description)
        {
            field(CustomerTitle; Rec.CustomerTitle)
            {
                Caption = 'Customer Title';
                ApplicationArea = all;
            }
        }
    }


}