page 60141 StudentPaymentList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = StudentPayment;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(EnteryNo; Rec.EnteryNo)
                {
                    Caption = 'Entry No.';
                }

                field(StudentNo; Rec.StudentNo)
                {
                    Caption = 'Student No.';
                }

                field(PaymentDate; Rec.PaymentDate)
                {
                    Caption = 'Payment Date';
                }

                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
            }
        }
    }
}