page 60140 CreditLog
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = CreditLog;
    Caption = 'Credit Log';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                }

                field(OldCredit; Rec.OldCredit)
                {
                    ApplicationArea = All;
                    Caption = 'Old Credit';
                }

                field(NewCredit; Rec.NewCredit)
                {
                    ApplicationArea = All;
                    Caption = 'New Credit';
                }

                field(UserName; Rec.UserName)
                {
                    ApplicationArea = All;
                    Caption = 'User Name';
                }

                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }

                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}