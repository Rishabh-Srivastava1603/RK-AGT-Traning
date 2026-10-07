table 60141 CustomerOverdueEmail
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; CustomerNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; CustomerName; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; OverdueAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; CustomerEmail; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Pk; CustomerNo)
        {
            Clustered = true;
        }
    }


}