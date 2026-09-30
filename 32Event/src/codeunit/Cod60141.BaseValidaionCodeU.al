/*
Create a custom field in sales line and it should have same base validation as other
 fields when order is released.Create a custom field in sales line and it should have
  same base validation as other fields when order is released.Create a custom field 
  in sales line and it should have same base validation as other fields when order
   is released.
*/

codeunit 60141 BaseValidaionCodeU
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                SalesLine.Validate(PlanningCost);
            until SalesLine.Next() = 0;
    end;
}