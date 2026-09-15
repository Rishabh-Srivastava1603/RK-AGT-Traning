codeunit 60129 DateControl
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", "OnAfterOnInsert", '', false, false)]
    local procedure Datechange(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."Shipment Date" := 0D;
        Message('Shipment Date is null');
    end;
}