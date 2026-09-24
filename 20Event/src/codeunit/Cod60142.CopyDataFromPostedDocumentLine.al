codeunit 60142 CopyDataFromPostedDocumentLine
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostItemLine, '', false, False)]
    local procedure OnAfterPostItemLine(var SalesLine: Record "Sales Line"; QtyToInvoice: Decimal; QtyToInvoiceBase: Decimal; CommitIsSuppressed: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line")
    var

        Item: Record Item;
    begin

        begin
            if Item.Get(SalesLine."No.") then begin
                Item.UnitPrice1 := SalesLine."Unit Price";
                Item.UnitPrice2 := SalesLine."Unit Price";
                Item.Modify();
            end

        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterPostPurchLine, '', false, False)]
    local procedure OnAfterPostPurchLine(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line")
    var

        Item1: Record Item;
    begin

        begin
            if Item1.Get(PurchaseLine."No.") then begin
                Item1.UnitPrice1 := PurchaseLine."Direct Unit Cost";
                Item1.UnitPrice2 := PurchaseLine."Direct Unit Cost";
                Item1.Modify();
            end

        end;

    end;
}