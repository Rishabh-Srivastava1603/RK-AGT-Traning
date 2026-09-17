pageextension 60131 ItemLedgerExt extends "Item Ledger Entries"
{
    layout
    {
        addafter("Entry Type")
        {
            field(VendorNickName; Rec.VendorNickName)
            {
                Caption = 'Vendor Nick Name';
                ApplicationArea = all;
            }
        }
    }


}
