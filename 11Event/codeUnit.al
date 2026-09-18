/* Problem Statment :- When using the "Copy Item" function on the Item Card, 
automatically append "Copied item" text to the new item’s description.*/



codeunit 60130 CopyItem
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Item", "OnAfterCopyItem", '', false, false)]
    local procedure MyProcedure(var CopyItemBuffer: Record "Copy Item Buffer"; SourceItem: Record Item; var TargetItem: Record Item)
    begin
        SourceItem.Description += 'Copy Item by Custom Code of Rishabh';
        SourceItem.Modify();
        Message('OnAfterCopyItem Run');
    end;
}