table 60140 LogTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; LogId; Integer)
        {
            DataClassification = ToBeClassified;
            caption = 'Log Id.';
            AutoIncrement = true;

        }
        field(2; UserName; text[30])
        {
            DataClassification = ToBeClassified;
            caption = 'Log Id.';

        }
        field(3; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Action; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(pk; LogId)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}