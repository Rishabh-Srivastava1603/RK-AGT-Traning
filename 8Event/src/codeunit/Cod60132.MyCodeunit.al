codeunit 60132 MyCodeunit
{
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterCopyGenJnlLineFromSalesHeader, '', false, false)]
    local procedure MyProcedure(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine.CustomerTitle := SalesHeader.CustomerTitle;
        Message('Data is copy from Sales Header to the GenJournalLine');
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure CopyFromGenjournal(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry.CustomerTitle := GenJournalLine.CustomerTitle;
        Message('Data is copy from GenJournalLine to the Genleadger');
    end;
}