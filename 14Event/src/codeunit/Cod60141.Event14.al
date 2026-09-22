codeunit 60141 Event14
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnBeforeValidateEvent, 'StartDate', false, false)]
    local procedure OnValidateShipmentDateOnAfterSalesLineVerifyChange(var Rec: Record "Sales Line")
    begin
        if Rec."StartDate" < Today then begin
            error('Start Date cannot be earlier than todays date');
        end;
        Rec.Validate("Shipment Date", Rec."StartDate" - 2);
        Message('Sales shipment line is assigned two days before to stard date ');
    end;
}