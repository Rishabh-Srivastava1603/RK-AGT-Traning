codeunit 60116 MyCodeunit
{
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", "OnAfterCopyGenJnlLineFromSalesHeader", '', false, false)]
    local procedure CopyFromSalesHeadertoGenral(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine.RkExpense := SalesHeader.RkExpense;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", "OnAfterCopyCustLedgerEntryFromGenJnlLine", '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry.RkExpense := GenJournalLine.RkExpense;
    end;
}