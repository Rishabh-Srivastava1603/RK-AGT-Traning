codeunit 60133 MyCodeunit
{
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterCopyItemJnlLineFromPurchHeader, '', false, false)]
    local procedure CopyFromPurchaseHeader(var ItemJnlLine: Record "Item Journal Line"; PurchHeader: Record "Purchase Header")
    begin
        ItemJnlLine.VendorNickName := PurchHeader.VendorNickName;
        Message('Copying data from the Purchase Header to the ItemJnlLine');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", OnAfterCopyTrackingFromItemJnlLine, '', false, false)]
    local procedure MyProcedure(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJnlLine: Record "Item Journal Line")
    begin
        ItemLedgerEntry.VendorNickName := ItemJnlLine.VendorNickName;
        Message('Copying data from the ItemJnlLine to the ItemLedgerEntery');
    end;

}