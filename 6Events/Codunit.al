codeunit 60129 MyCodeunit
{
    [EventSubscriber(ObjectType::CodeUnit, Codeunit::"Sales-Post", OnBeforePostSalesLines, '', False, False)]
    local procedure MyProcedure(var SalesHeader: Record "Sales Header"; var TempSalesLineGlobal: Record "Sales Line" temporary; var TempVATAmountLine: Record "VAT Amount Line" temporary; var EverythingInvoiced: Boolean)
    begin
        if TempSalesLineGlobal."No." = '1896-S' then begin
            Error('1896-S item no can not post RkS');
        end;

    end;
}