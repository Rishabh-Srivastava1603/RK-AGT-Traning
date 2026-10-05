/*when a user adds an item to a Sales Order, check if quantity is insufficient at the
 selected location.  create and post an Item Journal entry to
 increase inventory.
*/

codeunit 60140 InvantoryAdjustment
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, 'Quantity', false, false)]
    local procedure OnAfterValidateQuantity(var Rec: Record "Sales Line")
    var
        Item: Record Item;
        AvailableQty: Decimal;
        RequiredQty: Decimal;
        ItemNo: Code[20];
        LocationCode: Code[10];
    begin

        if Rec.Type <> Rec.Type::Item then
            exit;

        ItemNo := Rec."No.";
        LocationCode := Rec."Location Code";
        RequiredQty := Rec.Quantity;

        // Check inventory location
        Item.SetRange("Location Filter", LocationCode); // Apply Location filter
        Item.CalcFields(Inventory);
        AvailableQty := Item.Inventory;

        Message('Item: %1\Location: %2\Required Quantity: %3\Available Quantity: %4', ItemNo, LocationCode, RequiredQty, AvailableQty);

        // Check  inventory Shortage  
        if AvailableQty < RequiredQty then begin

            Message('Inventory is insufficient. Shortage: %1', RequiredQty - AvailableQty);
            // Create and post Item Journal
            CreateAndPostItemJournal(ItemNo, LocationCode, RequiredQty - AvailableQty);
        end;
    end;



    local procedure CreateAndPostItemJournal(ItemNo: Code[20]; LocationCode: Code[10]; QtyToAdd: Decimal)
    var
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalBatch: Record "Item Journal Batch";
        LineNo: Integer;
    begin
        LineNo := 10000;
        ItemJournalLine.Init();

        ItemJournalLine."Journal Template Name" := 'ITEM';
        ItemJournalLine."Journal Batch Name" := 'DEFAULT';
        ItemJournalLine."Line No." := LineNo;

        ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Positive Adjmt.";
        ItemJournalLine."Item No." := ItemNo;
        ItemJournalLine."Location Code" := LocationCode;
        ItemJournalLine.Quantity := QtyToAdd;

        ItemJournalLine.Insert();

        Message('Item Journal Line created. Item: %1, Location: %2, Quantity: %3', ItemNo, LocationCode, QtyToAdd);
        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJournalLine);
    end;
}