report 60140 "Customer Balance Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './CustomerBalanceReport.rdlc';

    dataset
    {
        dataitem(CustomerData; Customer)
        {
            column(Customer_no; "No.") { }
            column(Customer_name; Name) { }
            column(Sales_PersonCode; "Salesperson Code") { }
            column(CountryCode; "Country/Region Code") { }
            column(BalanceLCY; "Balance (LCY)") { }
            column(BalanceDueLCY; "Balance Due (LCY)") { }
            column(CreditLimitLCY; "Credit Limit (LCY)") { }
            column(Overdue; Overdue)
            {
            }
            trigger OnPreDataItem()
            begin
                if SalesPersonCode <> '' then begin
                    SetRange("Salesperson Code", SalesPersonCode);
                end;
                if "Country/RegionCode" <> '' then begin
                    SetRange("Country/Region Code", "Country/RegionCode");
                end;
                if "Country/RegionCode" <> '' then begin
                    SetRange("Country/Region Code", "Country/RegionCode");
                end;
                if (stDate <> 0D) and (endDate <> 0D) then begin
                    SetRange("Date Filter", stDate, endDate);
                end;
                if WithbalanceDue then begin
                    CalcFields("Balance Due (LCY)");
                    SetFilter("Balance Due (LCY)", '>0');
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                CalcFields("Balance Due (LCY)");
                Overdue := false;
                if "Balance Due (LCY)" > "Credit Limit (LCY)" then begin
                    Overdue := true;
                end;
            end;


        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)

                {
                    field(SalesPersonCode; SalesPersonCode)
                    {
                        Caption = 'Sales Person Code :-';
                        ApplicationArea = all;
                        TableRelation = "Salesperson/Purchaser".Code;


                    }
                    field("Country/RegionCode"; "Country/RegionCode")
                    { Caption = 'Country/RegionCode :-'; }
                    field("Start Date"; stDate) { }
                    field("End Date"; endDate) { }
                    field("Customer with Balance Due"; WithbalanceDue) { }
                }
            }
        }


    }



    var
        WithbalanceDue: Boolean;
        SalesPersonCode: Code[20];
        "Country/RegionCode": code[20];
        stDate: Date;
        endDate: Date;
        Overdue: boolean;


}