table 60130 ServiceAssignment
{
    DataClassification = ToBeClassified;
    Caption = 'Service Assignment';

    fields
    {
        field(1; "Assignment No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Assignment No.';
        }
        field(2; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Assignment No.';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                customer: Record customer;
            begin
                if Customer.get("Customer No.") then begin
                    "Customer Name" := Customer.Name;
                end;
            end;
        }

        field(3; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
            Editable = False;

        }

        field(5; "Service Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Cost';
            trigger OnValidate()

            begin

                "Total Amount" := "Service Cost" + ("Service Cost" * 18) / 100;


            end;
        }

        field(6; Status; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            OptionMembers = Open,Released,Completed;
        }

        field(7; "Assignment Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Assignment Date';
        }
        field(8; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Amount';
        }

    }

    keys
    {
        key(PK; "Assignment No.")
        {
            Clustered = true;
        }
    }
    trigger OnModify()
    begin
        if "Status" = "Status"::Completed then begin
            Message('Completed Service assignment can not modify ');
        end;
    end;

}