pageextension 60141 EmployeePageExt extends "Employee List"
{
    layout
    {
        addbefore("First Name")
        {
            field(CustDimensionCode; Rec.CustDimensionCode)
            {
                ApplicationArea = all;

            }
        }
    }


}