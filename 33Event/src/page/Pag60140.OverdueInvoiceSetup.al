page 60140 "Overdue Invoice Setup"
{
    PageType = card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Overdue Invoice Setup Table";

    layout
    {
        area(Content)
        {
            group(DateFilter)
            {
                field(StartDate; Rec.StartDate)
                {
                    Caption = 'Start Date';
                }
                field(EndDate; Rec.EndDate)
                {
                    Caption = 'End Date';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Filter Overdue Invoice")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    OverdueInvoiceAndMail: Codeunit OverdueInvoiceAndMail;
                begin
                    OverdueInvoiceAndMail.PopulateOverdueInvoices(Rec.StartDate,
                 Rec.EndDate);
                end;
            }
        }
    }


}
