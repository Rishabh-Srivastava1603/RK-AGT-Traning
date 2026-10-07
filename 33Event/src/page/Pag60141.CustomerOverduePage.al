page 60141 "Customer Overdue Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = CustomerOverdueEmail;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(CustomerNo; Rec.CustomerNo)
                {
                    Caption = 'CustomerNo';
                }
                field(CustomerName; Rec.CustomerName)
                {
                    Caption = 'Customer Name';
                }

                field(CustomerEmail; Rec.CustomerEmail)
                {
                    Caption = 'Customer Email';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(Reminder)
            {
                ApplicationArea = all;
                Caption = 'Mail Reminder';
                trigger OnAction()
                var
                    OverdueInvoiceAndMail: Codeunit OverdueInvoiceAndMail;
                begin
                    OverdueInvoiceAndMail.DueDateReminderMailGenerator();
                end;
            }
        }

    }

}