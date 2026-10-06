/*
1. Block invoice  only if:
The overdue amount exceeds  (₹10,000).
OR the number of overdue invoices is more than a limit (3 overdue invoices).
Also:
If a invoice is blocked, show a confirmation dialog.
Only users with a  SUPER user should be allowed to override and continue posting.

*/
codeunit 60140 BlockInvoiceIfOverdueExceed
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostInvoice, '', false, false)]
    local procedure OnBeforePostInvoice(var SalesHeader: Record "Sales Header"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        Customer: Record Customer;
        OverDueAmount: Decimal;
        OverdueCount: Integer;
        UserPermissions: Codeunit "User Permissions";
    begin
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Customer No.", SalesHeader."Bill-to Customer No.");
        if CustLedgerEntry.FindSet() then
            repeat
                if CustLedgerEntry."Due Date" < Today then begin
                    OverdueCount += 1;
                    OverDueAmount += CustLedgerEntry."Remaining Amt. (LCY)";
                end;
            until CustLedgerEntry.Next() = 0;
        Message('Overdue Amount  is - %1, Overdue Invoice -%2', OverDueAmount, OverdueCount);

        if (OverDueAmount > 10000) or (OverdueCount > 3) then begin

            if not UserPermissions.IsSuper(UserSecurityId()) then
                Error(
                    'You cannot post this invoice because the customer has exceeded the overdue limit.');

            if not Confirm(
                'The customer has exceeded the overdue limit. Do you want to override the restriction and continue posting?')
            then
                Error('Posting cancelled.');

        end;
    end;
}