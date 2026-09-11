codeunit 60147 MyCodeunit
{
    [EventSubscriber(ObjectType::Table, DataBase::Customer, OnAfterValidateEvent, 'Name', false, false)]

    local procedure MyProcedure(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)

    begin
        if Rec.Name <> '' then
            Message('New name Rk is Inserted %1', Rec.Name);

    end;
}