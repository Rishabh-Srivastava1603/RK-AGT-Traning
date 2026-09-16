codeunit 60132 MyCodeunit
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterInitHeaderDefaults, '', false, false)]
    local procedure MyProcedure(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; xSalesLine: Record "Sales Line")
    begin
        SalesLine.FoodDelivery := SalesHeader.FoodDelivery;
        Message('Data copy from SalesHeader to SalesLine');
    end;
}