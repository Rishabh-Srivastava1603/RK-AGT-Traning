pageextension 60113 MyExtension extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field(RkExpense; Rec.RkExpense)
            {
                Caption = 'Rk Expense';
                ApplicationArea = all;
            }
        }
    }


}