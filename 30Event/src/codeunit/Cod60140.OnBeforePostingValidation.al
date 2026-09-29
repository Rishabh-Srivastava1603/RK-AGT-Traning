
codeunit 60140 OnBeforePostingValidation
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostSalesLines, '', false, false)]
    local procedure OnBeforePostSalesLines(var TempSalesLineGlobal: Record "Sales Line" temporary; var SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
        BalanceOverDue: Decimal;
        CurrentAmount: Decimal;
    begin
        Message('On before sales line is running');

        if Customer.Get(SalesHeader."Bill-to Customer No.") then begin


            CurrentAmount := TempSalesLineGlobal."Amount";
            BalanceOverDue := Customer.CalcOverdueBalance();
            if Customer."Credit Limit (LCY)" < CurrentAmount + BalanceOverDue then begin

                Error('The Customer %1 has exceed Credit Limit');
            end;
        end;

    end;
}