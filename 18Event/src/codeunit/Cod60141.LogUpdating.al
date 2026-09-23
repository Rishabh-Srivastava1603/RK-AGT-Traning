/*
 On sales order after clicking on release/reopen then 
user name, time and action clicked(release/reopen) needs to be logged in a new table.
*/
codeunit 60141 LogUpdating
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]
    local procedure OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    var
        LogTable: Record LogTable;
        UserLog: Record "Access Control";
    begin
        Message('OnAfterReleaseSalesDoc runs');
        LogTable.UserName := UserId();
        LogTable.Time := Time;
        LogTable.Action := 'Release';

        LogTable.Insert();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReopenSalesDoc, '', false, false)]
    local procedure OnAfterReopenSalesDoc(var SalesHeader: Record "Sales Header")
    var
        LogTable: Record LogTable;
        UserLog: Record "Access Control";
    begin
        Message('OnAfterReopenSalesDoc runs');
        LogTable.UserName := UserId();
        LogTable.Time := Time;
        LogTable.Action := 'Reopen';

        LogTable.Insert();

    end;
}