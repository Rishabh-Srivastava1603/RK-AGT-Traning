/*Concatenating my name in the description field of the last
 line of sales lines in the sales invoice.

*/

codeunit 60140 MyCodeunit
{
    Permissions = tabledata "Sales Invoice Line" = rm;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesLine, '', false, false)]
    local procedure OnAfterPostSalesLine(var SalesInvLine: Record "Sales Invoice Line")
    begin
        SalesInvLine.Description := SalesInvLine.Description + 'Rishabh Raj AlProgrammer';
        SalesInvLine.Modify();
    end;
}