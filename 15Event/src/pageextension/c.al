codeunit 60142 Event14Codeunit
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", OnAfterInitFromSalesLine, '', false, false)]
    local procedure OnAfterInitFromSalesLine(var SalesShptLine: Record "Sales Shipment Line"; SalesLine: Record "Sales Line")
    begin
        SalesShptLine.ResearchExp := SalesLine.ResearchExp;
        SalesShptLine.DevelopmentExp := SalesLine.DevelopmentExp;
        Message('OnAfterInitFromSalesLine Event is running ');
    end;
}