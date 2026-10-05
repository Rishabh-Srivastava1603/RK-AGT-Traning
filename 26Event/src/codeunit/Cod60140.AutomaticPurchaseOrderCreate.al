/*Creating a purchase order when the quantity entered in a
 sales order's line for an item exceeds the quantity in
 inventory for that item . 
*/

codeunit 60140 AutomaticPurchaseOrderCreate
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, 'Quantity', false, false)]
    local procedure OnAfterValidateEvent(var Rec: Record "Sales Line")
    var
        Item: Record Item;
        Vendor: Record Vendor;
        QuantityReq: Decimal;
        ItemNo: Code[20];
        VendorName: Text[50];
        VendorNo: Code[20];

    begin
        if Rec.Type = Rec.Type::Item then begin
            if Item.Get(Rec."No.") then begin
                Item.CalcFields(Inventory);
                if Rec.Quantity > Item.Inventory then begin
                    QuantityReq := Rec.Quantity - Item.Inventory;
                    ItemNo := Rec."No.";
                    VendorNo := Item."Vendor No.";
                    if Vendor.Get(VendorNo) then begin
                        VendorName := Vendor.Name;
                    end;
                    Message('Rk Item %1 is Less then %2 QuantityReq %3', Rec.Quantity, Item.Inventory, QuantityReq);

                    Message('Creating Purchase Order for the Item no- %1 and vendor- %2 and Req Quantity- %3 ', ItemNo, VendorNo, QuantityReq);
                    // call Purchase order creator method 
                    PurchaseOrderCreator(VendorNo, ItemNo, QuantityReq, VendorName);
                end;
            end;
        end;
    end;

    local procedure PurchaseOrderCreator(VendorNo: code[20]; ItemNo: code[20]; QuantityReq: Decimal; VendorName: Text[50])
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";

    begin
        PurchaseHeader.Init();
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
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