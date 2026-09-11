page 60140 RRStudentList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = RRStudentTable;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(StudentNO; Rec.StudentNO)
                {
                    Caption = 'Student No.';
                }

                field(StudentName; Rec.StudentName)
                {
                    Caption = 'Student Name';
                }

                field(TotalFees; Rec.TotalFees)
                {
                    Caption = 'Total Fees';
                }

                field(TotalPayment; Rec.TotalPayment)
                {
                    Caption = 'Total Payments';
                }

                field(LastPaymentAmount; Rec.LastPaymentAmount)
                {
                    Caption = 'Last Payment Amount';
                }

                field(DateFilter; Rec.DateFilter)
                {
                    Caption = 'Payment Date Filter';
                }
            }
        }
    }
}