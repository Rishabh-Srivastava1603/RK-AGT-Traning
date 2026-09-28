codeunit 60140 AutoShip
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]
    local procedure OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean; SkipWhseRequestOperations: Boolean)
    var
        SalesPostRec: Codeunit "Sales-Post";
    begin
        Message('OnAfterReleaseSalesDoc is Triggers ');
        SalesHeader.Ship := true;
        SalesHeader.Invoice := false;



        SalesPostRec.Run(SalesHeader);
    end;
}