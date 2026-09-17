codeunit 60133 MyCodeunit
{
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterCopyGenJnlLineFromPurchHeader, '', false, false)]
    local procedure CopyFromPurchaseHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine.VendorNickName := PurchaseHeader.VendorNickName;
        Message('Copying data from the Purchase Header to the GenJournalLine');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", OnAfterCopyVendLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure CopyFromGenJournalline(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry.VendorNickName := GenJournalLine.VendorNickName;
        Message('Copying data from the GenJournalLine Header to the VendorLedgerEntery');
    end;
}