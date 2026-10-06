codeunit 60142 DimensionTableUpdate
{
    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", OnAfterInsertEvent, '', False, False)]
    local procedure OnBeforeValidateEvent(var Rec: Record "Default Dimension")
    var
        Employee: Record Employee;
    begin

        if Employee.Get(Rec."No.") then begin
            Employee.CustDimensionCode := Rec."Dimension Code";
            Message('On After Insert trigger is Working Dimension code is modified 1-%1 2- %2', Employee.CustDimensionCode, Rec."Dimension Code");
            Employee.Modify();
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", OnAfterDeleteEvent, '', False, False)]

    local procedure OnAfterDeleteEvent(var Rec: Record "Default Dimension")
    var
        Employee: Record Employee;
    begin

        if Employee.Get(Rec."No.") then begin
            Employee.CustDimensionCode := '';
            Message('On After Delete trigger is working Dimension code is modified 1-%1 2- %2', Employee.CustDimensionCode, Rec."Dimension Code");
            Employee.Modify();
        end;

    end;
}