/*
Ensuring the new field flows from the                                                                                                                                                                                                                                       Sales header to the posted Sales header
 while shipping, with different IDs for
 the new field but the same name.
*/
codeunit 60142 TransferCustomFieldAfterPost
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeSalesShptHeaderInsert, '', false, false)]
    local procedure OnBeforeSalesShptHeaderInsert(var SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header")
    begin
        Message('OnafterSales is working');

        SalesShptHeader.TravelCost := SalesHeader.TravelCost;
    end;
}
