// /*Throwing an error and restricting posting when the 
// quantity entered for an item is greater
//  than the quantity i n hand for that particular item in inventory.
// */

// codeunit 60140 PrePostingValidation
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostSalesLines, '', false, false)]
//     local procedure OnBeforePostSalesLines(var TempSalesLineGlobal: Record "Sales Line" temporary)
//     var
//         Item: Record Item;
//     begin


//         if Item.Get(TempSalesLineGlobal."No.") then begin
//             Item.CalcFields(Inventory); 

//             if Item.Inventory < TempSalesLineGlobal.Quantity then begin
//                 Error('Inventory Does not have enough Quantity');
//             end
//         end;

//     end;
// }