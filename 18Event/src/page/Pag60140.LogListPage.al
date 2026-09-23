page 60140 LogListPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LogTable;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(LogId; Rec.LogId)
                {
                    ApplicationArea = All;
                    Caption = 'Log Id';
                }

                field(UserName; Rec.UserName)
                {
                    ApplicationArea = All;
                    Caption = 'User Name';
                }

                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                    Caption = 'Time';
                }

                field(Action; Rec.Action)
                {
                    ApplicationArea = All;
                    Caption = 'Action';
                }
            }
        }
    }
}