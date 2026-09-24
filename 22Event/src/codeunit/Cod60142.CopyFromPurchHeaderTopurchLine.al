codeunit 60142 CopyFromPurchHeaderTopurchLine
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterValidateEvent, 'Type', false, false)]
    local procedure OnAfterValidateType(var Rec: Record "Purchase Line")
    var
        PurchaseHeader: Record "Purchase Header";
    begin

        if Rec.Type = Rec.Type::Item then begin
            if PurchaseHeader.Get(Rec."Document Type", Rec."Document No.") then begin
                Rec.PlaningCost := PurchaseHeader.PlaningCost;

            end;
        end;

    end;
}