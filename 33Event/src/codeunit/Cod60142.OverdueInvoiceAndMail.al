/* Q. You need to create a custom  "Overdue Invoice Email" page that displays all customers who have invoices
 overdue based on a posting‑date range defined by the user. To support this, you’ll add another simple setup
page where the user selects the posting‑date duration that determines which invoices should be pulled into
 the overdue list. Once the overdue data is populated, the page should include an action that sends reminder
 emails to all listed customers, using the "Email" field from the Customer Card and a hardcoded email body
 for now. After this foundation is complete, you’ll extend the feature further based on the next set of requirements.
*/

codeunit 60142 OverdueInvoiceAndMail
{
    procedure DueDateReminderMailGenerator()
    var
        MailData: Record CustomerOverdueEmail;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
    begin
        if MailData.FindSet() then
            repeat
                Subject := 'Overdue Invoice Reminder';

                Body :=
        'Dear Mr.Bharth Ranjan ' + MailData.CustomerName +
        MailData.CustomerNo + ' pay outstanding 10 cr otherwise we take leagal action'
    ;

                EmailMessage.Create(MailData.CustomerEmail, Subject, Body, true);
                Email.Send(EmailMessage);
            until MailData.Next() = 0;
        Message('Mail is sended go and check');
    end;


    procedure PopulateOverdueInvoices(StartDate: Date; EndDate: Date);
    var
        Overdue: Record "CustomerOverdueEmail";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        Count: Integer;

    begin
        Overdue.DeleteAll();

        Message('Searching from %1 to %2', StartDate, EndDate);
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
        CustLedgerEntry.SetFilter("Remaining Amt. (LCY)", '>%1', 0);
        CustLedgerEntry.SetFilter("Due Date", '<%1', Today);
        if CustLedgerEntry.FindSet() then
            repeat
                if not Overdue.Get(CustLedgerEntry."Customer No.") then begin// allow one customer prevent duplicate entry 
                    Overdue.Init();

                    Overdue.CustomerNo := CustLedgerEntry."Customer No.";
                    Overdue.OverdueAmount := CustLedgerEntry."Remaining Amt. (LCY)";

                    if Customer.Get(CustLedgerEntry."Customer No.") then begin
                        Overdue.CustomerName := Customer.Name;
                        Overdue.CustomerEmail := Customer."E-Mail";
                    end;

                    Overdue.Insert();
                end;


            until CustLedgerEntry.Next() = 0;
    end;

}