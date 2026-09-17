pageextension 60131 VendorLedgerEntriesExt extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Document Type")
        {
            field(VendorNickName; Rec.VendorNickName)
            {
                Caption = 'Vendor Nick Name';
                ApplicationArea = all;
            }
        }
    }


}