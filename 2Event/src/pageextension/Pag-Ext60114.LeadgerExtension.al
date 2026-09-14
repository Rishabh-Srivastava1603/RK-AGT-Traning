pageextension 60114 LeadgerExtension extends "Customer Ledger Entries"
{
    layout
    {
        addbefore(Description)
        {
            field(RkExpense; Rec.RkExpense)
            {
                Caption = 'Rk Expense';
                ApplicationArea = all;
            }
        }
    }


}