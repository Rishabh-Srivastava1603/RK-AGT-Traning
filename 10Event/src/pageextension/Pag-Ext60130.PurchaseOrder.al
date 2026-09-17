pageextension 60130 PurchaseOrder extends "Purchase Order"
{
    layout
    {
        addfirst(General)
        {
            field(VendorNickName; Rec.VendorNickName)
            {
                Caption = 'Vendor Nick Name';
                ApplicationArea = all;
            }
        }
    }


}
