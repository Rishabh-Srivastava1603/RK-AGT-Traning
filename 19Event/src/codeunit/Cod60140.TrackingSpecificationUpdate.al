codeunit 60140 TrackingSpecificationUpdate
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, 'Qty. to Ship', false, false)]
    local procedure OnAfterValidateEvent(var Rec: Record "Sales Line")
    var

        Reservation: Record "Reservation Entry";
        item: Record Item;




    begin
        Reservation.Init();
        if Reservation.FindLast() then begin
            Reservation."Entry No." += 1;
        end
        else
            Reservation."Entry No." := 1;

        if item.Get(Rec."No.") then begin
            Reservation."Lot No." := item."Lot Nos.";
            Message('Lot no is - %1', Reservation."Lot No.");
        end;


        Reservation.Validate(Reservation."Item No.", Rec."No.");
        Reservation.Validate(Reservation."Location Code", Rec."Location Code");
        Reservation.Validate(Reservation."Quantity (Base)", Rec."Quantity Shipped");
        Reservation.Validate(Reservation.Description, Rec.Description);
        Reservation.Validate(Reservation."Creation Date", Rec."Shipment Date");
        Reservation.Validate(Reservation."Shipment Date", Rec."Shipment Date");
        Reservation.Validate(Reservation."Created By", UserId());
        Reservation.Validate(Reservation."Item No.", Rec."No.");

        Message('Reservation entry created ');

        Reservation.Insert();
    end;
}