table 60140 CreditLog
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; OldCredit; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(3; NewCredit; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(4; UserName; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(5; Date; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(6; Time; Time)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Pk; Id)
        {
            Clustered = true;
        }
    }



}