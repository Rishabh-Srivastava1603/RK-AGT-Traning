/*The goal of this task is to ensure that the "Dimension Code" field (which will be a custom field)
 in the Employee table is always updated based on changes made to the Default Dimension table.
  This includes insertions and deletions in the Default Dimension table. and  as per changes 
  move data from Default Dimension "Dimesnion Code" to Custom "Dimension Code.*/

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