/*
29 .Creating log entries for credit limit changes. The log entries display the
 old and new credit limits, username, and date and time.

*/
codeunit 60141 LogUpdate
{
    [EventSubscriber(ObjectType::Table, Database::Customer, OnAfterModifyEvent, '', false, false)]
    local procedure OnAfterModifyEvent(var Rec: Record "Customer"; xRec: Record Customer)
    var
        CreditTable: Record CreditLog;

    begin
        Message('OnAfterModify is running ');
        if Rec."Credit Limit (LCY)" <> xRec."Credit Limit (LCY)" then begin
            CreditTable.OldCredit := xRec."Credit Limit (LCY)";
            CreditTable.NewCredit := Rec."Credit Limit (LCY)";
            CreditTable.Time := Time;
            CreditTable.Date := WorkDate();
            CreditTable.UserName := UserId();
            CreditTable.Insert();

        end;

    end;
}