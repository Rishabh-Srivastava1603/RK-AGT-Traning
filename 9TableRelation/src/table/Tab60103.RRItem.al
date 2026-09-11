table 60103 "RR Item"
{
    DataClassification = ToBeClassified;
    caption = 'RR Item';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }

        field(2; "Item Name"; Text[100])
        {
            Caption = 'Item Name';
        }

        field(3; "Item Type"; Option)
        {
            Caption = 'Item Type';
            OptionMembers = Product,Service;
        }

        field(4; "Service Cost"; Decimal)
        {
            Caption = 'Service Cost';
        }
        field(5; "Total Assignments"; Integer)
        {
            Caption = 'Total Assignments';
            FieldClass = FlowField;
            CalcFormula = Count(
                "RR Service Assignment"
                WHERE("Item No." = FIELD("Item No."))
            );
        }
    }
    keys
    {
        key(PK; "Item No.")
        {
            Clustered = true;
        }
    }
}