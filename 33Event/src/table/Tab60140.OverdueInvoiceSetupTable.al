table 60140 "Overdue Invoice Setup Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; StartDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; EndDate; Date)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Pk; EntryNo)
        {
            Clustered = true;
        }
    }


}