table 60140 RRStudentTable
{
    DataClassification = ToBeClassified;
    caption = 'RR Student Table';

    fields
    {
        field(1; StudentNO; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; StudentName; text[100])
        {
            DataClassification = ToBeClassified;
            caption = 'Student Name';
        }
        field(3; TotalFees; decimal)
        {

            caption = 'TotalFees';
            FieldClass = FlowField;
        }
        field(4; TotalPayment; decimal)
        {
            caption = 'TotalPayment';
            FieldClass = FlowField;

        }
        field(5; LastPaymentAmount; integer)
        {
            caption = 'Last Payment Amount';
            FieldClass = FlowField;
        }
        field(6; DateFilter; Date)
        {
            caption = 'Date Filter';
            FieldClass = FlowFilter;
        }

    }

    keys
    {
        key(Key1; StudentNo)
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