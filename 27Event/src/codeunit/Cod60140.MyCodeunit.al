/*Concatenating my name in the description field of the last
 line of sales lines in the sales invoice.

*/

codeunit 60140 MyCodeunit
{
    Permissions = tabledata "Sales Invoice Line" = rm;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesLine, '', false, false)]
    local procedure OnAfterPostSalesLine(var SalesInvLine: Record "Sales Invoice Line")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", SalesInvLine."Order No.");

        if SalesLine.FindLast() then begin
            if SalesInvLine."Order Line No." = SalesLine."Line No." then begin
                SalesInvLine.Description := SalesInvLine.Description + ' Rishabh Raj Srivastava';
                SalesInvLine.Modify();
            end;
        end;
    end;
}