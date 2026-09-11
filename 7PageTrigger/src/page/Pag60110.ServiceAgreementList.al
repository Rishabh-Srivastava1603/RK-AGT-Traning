page 60130 ServiceAgreementList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ServiceAssignment;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Assignment No."; Rec."Assignment No.")
                {
                    caption = 'Assignment No.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    caption = 'Customer Name';
                }
                field("Service Cost"; Rec."Service Cost")
                {
                    caption = 'Service Cost';
                }
                field("Status"; Rec."Status")
                {
                    caption = 'Status';
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
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        rec.SetRange(Status, rec.status::open);
        Message('Showing only open service Assignment');
    end;

    trigger OnAfterGetRecord()
    begin
        if rec."Service Cost" > 10000 then begin
            Message('High value Service Assignment');
        end;

    end;

}