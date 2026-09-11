table 60141 StudentPayment
{
    DataClassification = ToBeClassified;
    caption = 'Student Payment';

    fields
    {
        field(1; EnteryNo; Integer)
        {
            DataClassification = ToBeClassified;
            caption = 'Entery No';
        }
        field(2; StudentNo; code[20])
        {
            DataClassification = ToBeClassified;
            caption = 'Student No';
            TableRelation = RRStudentTable.StudentNo;
        }
        field(3; PaymentDate; Date)
        {

            DataClassification = ToBeClassified;
            caption = 'Payment Date';
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            caption = 'Amount';
        }
    }

    keys
    {
        key(Key1; EnteryNo)
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