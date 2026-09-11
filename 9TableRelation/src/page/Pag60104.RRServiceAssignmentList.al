page 60104 "RR Service Assignment List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RR Service Assignment";
    Caption = 'RR Service Assignment List';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Assignment No."; Rec."Assignment No.")
                {
                    ApplicationArea = All;
                }

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }

                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                }

                field("Service Cost"; Rec."Service Cost")
                {
                    ApplicationArea = All;
                }

                field("Technician Name"; Rec."Technician Name")
                {
                    ApplicationArea = All;
                }

                field("Assignment Date"; Rec."Assignment Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}