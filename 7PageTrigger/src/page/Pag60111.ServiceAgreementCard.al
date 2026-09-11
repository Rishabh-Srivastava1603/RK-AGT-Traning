page 60131 ServiceAgreementCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = ServiceAssignment;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Assignment No."; Rec."Assignment No.")
                {
                    Caption = 'Assignment No.';
                }

                field("Customer Name"; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                }

                field("Service Cost"; Rec."Service Cost")
                {
                    Caption = 'Service Cost';
                }

                field("Status"; Rec."Status")
                {
                    Caption = 'Status';
                }

                field("Assignment Date"; Rec."Assignment Date")
                {
                    Caption = 'Assignment Date';
                }
                field("Customer No"; rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field("Total Amount"; rec."Total Amount")
                {
                    caption = 'Total Amount';
                }
            }
        }

        area(Factboxes)
        {
        }
    }

    actions
    {
        area(Processing)
        {
        }
    }
}