page 60103 "RR Item List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RR Item";
    Caption = 'RR Item List';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }

                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                }

                field("Item Type"; Rec."Item Type")
                {
                    ApplicationArea = All;
                }

                field("Service Cost"; Rec."Service Cost")
                {
                    ApplicationArea = All;
                }

                field("Total Assignments"; Rec."Total Assignments")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}