table 60104 "RR Service Assignment"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Assignment No."; Code[20])
        {
            Caption = 'Assignment No.';
        }

        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = "RR Item"."Item No."
        WHERE("Item Type" = CONST(Service));
            trigger OnValidate()
            var
                Item: Record "RR Item";
            begin
                if Item.Get("Item No.") then begin
                    "Item Name" := Item."Item Name";
                    "Service Cost" := Item."Service Cost";
                end;
            end;
        }

        field(3; "Item Name"; Text[100])
        {
            Caption = 'Item Name';
        }

        field(4; "Service Cost"; Decimal)
        {
            Caption = 'Service Cost';
        }

        field(5; "Technician Name"; Text[100])
        {
            Caption = 'Technician Name';
        }

        field(6; "Assignment Date"; Date)
        {
            Caption = 'Assignment Date';
        }
    }

    keys
    {
        key(PK; "Assignment No.")
        {
            Clustered = true;
        }
    }
}