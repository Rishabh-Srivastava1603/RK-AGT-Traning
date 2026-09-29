pageextension 60141 PostedSalesShipExt extends "Posted Sales Shipment"
{
    layout
    {
        addfirst(General)
        {
            field(TravelCost; Rec.TravelCost)
            {
                ApplicationArea = all;
                Caption = 'Travel Cost';
            }
        }
    }


}