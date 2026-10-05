codeunit 60140 AutoPurchaseQuoteCreator
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]

    local procedure OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header")

    var
        Item: Record Item;
        SalesLine: Record "Sales Line";
        Vendor: Record Vendor;

        ItemNo: Code[20];
        SelectedVendorNo: Code[20];

        QuantityReq: Decimal;
        MinVendorBalance: Decimal;
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                if SalesLine.Type = SalesLine.Type::Item then begin
                    ItemNo := SalesLine."No.";
                    if Item.Get(ItemNo) then begin
                        Item.CalcFields(Inventory);

                        if SalesLine.Quantity > Item.Inventory then begin

                            QuantityReq := SalesLine.Quantity - Item.Inventory;

                            MinVendorBalance := 2147483647;
                            // Check vendors
                            if Vendor.FindSet() then
                                repeat

                                    Vendor.CalcFields("Balance Due (LCY)");

                                    if Vendor."Balance Due (LCY)" < MinVendorBalance then begin

                                        MinVendorBalance := Vendor."Balance Due (LCY)";

                                        SelectedVendorNo := Vendor."No.";
                                    end;

                                until Vendor.Next() = 0;

                        end;
                    end;
                end;

            until SalesLine.Next() = 0;
        if SelectedVendorNo <> '' then begin

            CreatePurchaseQuote(ItemNo, SelectedVendorNo, QuantityReq);

            Message('Purchase Quote created for Item %1, Vendor %2, Quantity %3', ItemNo, SelectedVendorNo, QuantityReq);
        end;
    end;




    local procedure CreatePurchaseQuote(ItemNo: code[20]; VendorNo: Code[20]; QuantityReq: Integer)

    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseHeader.Init();
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Quote;
        PurchaseHeader.Validate("Buy-from Vendor No.", VendorNo);
        PurchaseHeader.Insert(true);
        PurchaseLine.Init();

        PurchaseLine."Document Type" := PurchaseHeader."Document Type";
        PurchaseLine."Document No." := PurchaseHeader."No.";
        PurchaseLine."Line No." := 10000;

        PurchaseLine.Validate(Type, PurchaseLine.Type::Item);

        PurchaseLine.Validate("No.", ItemNo);

        PurchaseLine.Validate(Quantity, QuantityReq);
        PurchaseLine.Insert(true);
    end;
}