// tableextension 60140 SalesLineExt extends "Sales Line"
// {
//     fields
//     {
//         field(60140; PlanningCost; Decimal)
//         {
//             DataClassification = ToBeClassified;
//             trigger OnValidate()
//             begin
//                 Message('PlanningCost OnValidate is running. Value = %1', PlanningCost);
//                 // its a test message that use to check when event run base validation trigger on validate or not 
//             end;
//         }
//     }


// }