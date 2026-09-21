codeunit 60139 Event7
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterOnInsert, '', false, false)]
    local procedure OnAfterOnInsert(var SalesHeader: Record "Sales Header")
    var

        Salesperson: Record "Salesperson/Purchaser";
        SalesHeader2: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";

        OrderCount: Integer;
        InvoiceCount: Integer;
        TotalCount: Integer;

        MinCount: Integer;
        SelectedSalespersonCode: Code[20]; // use to record lowest salesperson code of lowest sales+ invoice 

    begin
        Message('OnAfterOnInsert is working now ');
        MinCount := 2147483647;
        if Salesperson.FindSet() then
            repeat

                // Count Orders for current salesperson
                SalesHeader2.Reset(); // remove any existing filter
                SalesHeader2.SetRange("Document Type", SalesHeader2."Document Type"::Order);
                SalesHeader2.SetRange("Salesperson Code", Salesperson.Code);
                OrderCount := SalesHeader2.Count();

                // Count Invoices for current salesperson
                SalesInvoiceHeader.Reset();
                SalesInvoiceHeader.SetRange("Salesperson Code", Salesperson.Code);
                InvoiceCount := SalesInvoiceHeader.Count();

                // Add them
                TotalCount := OrderCount + InvoiceCount;
                //Test Messge 
                //Message('Salesperson: %1\Orders: %2\Invoices: %3\Total: %4', Salesperson.Code,
                //OrderCount, InvoiceCount, TotalCount);
                // Compare with minimum
                if TotalCount < MinCount then begin
                    MinCount := TotalCount;
                    SelectedSalespersonCode := Salesperson.Code;

                end;


            until Salesperson.Next() = 0;
        SalesHeader."Salesperson Code" := SelectedSalespersonCode;

    end;
}