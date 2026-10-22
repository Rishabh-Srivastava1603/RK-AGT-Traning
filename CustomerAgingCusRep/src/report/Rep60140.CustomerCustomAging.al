report 60140 "Customer Custom Aging"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportsAndAnalysis.rdlc';


    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.") { }
            column(Name; Name) { }
            column(Balance_Due__LCY_; "Balance Due (LCY)") { }
            column(NotDueAmount; AgingAmount[1]) { }
            column(Overdue1To30; AgingAmount[2]) { }
            column(Overdue31To60; AgingAmount[3]) { }
            column(Overdue61To90; AgingAmount[4]) { }
            column(OverdueOver90; AgingAmount[5]) { }
            column(Aging0To30StartHeader; Aging0To30StartHeader) { }
            column(Aging0To30EndHeader; Aging0To30EndHeader) { }
            column(Aging31To60StartHeader; Aging31To60StartHeader) { }
            column(Aging31To60EndHeader; Aging31To60EndHeader) { }
            column(Aging61To90StartHeader; Aging61To90StartHeader) { }
            column(Aging61To90EndHeader; Aging61To90EndHeader) { }


            //--------------- for calculation of due amoun in the bucket pool ------------------
            trigger OnAfterGetRecord()
            var
                i: Integer;
            begin
                for i := 1 to 5 do
                    AgingAmount[i] := 0;

                CustLedgEntry.Reset();
                CustLedgEntry.SetFilter("Customer No.", Customer."No.");
                CustLedgEntry.SetRange(Open, true);

                if CustLedgEntry.FindSet() then
                    repeat
                        CustLedgEntry.CalcFields("Remaining Amt. (LCY)");
                        if CustLedgEntry."Due Date" < PeriodStartDate[1] then
                            AgingAmount[5] += CustLedgEntry."Remaining Amt. (LCY)"
                        else
                            if CustLedgEntry."Due Date" < PeriodStartDate[2] then
                                AgingAmount[2] += CustLedgEntry."Remaining Amt. (LCY)"
                            else
                                if CustLedgEntry."Due Date" < PeriodStartDate[3] then
                                    AgingAmount[3] += CustLedgEntry."Remaining Amt. (LCY)"
                                else
                                    if CustLedgEntry."Due Date" < PeriodStartDate[4] then
                                        AgingAmount[4] += CustLedgEntry."Remaining Amt. (LCY)"
                                    else
                                        AgingAmount[1] += CustLedgEntry."Remaining Amt. (LCY)";
                    until CustLedgEntry.Next() = 0;
                CustLedgEntry.CalcFields("Remaining Amt. (LCY)");
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
                group("Group Aging")
                {
                    field(StartingDate; StartingDate) { }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        StartingDate := WorkDate();

    end;

    trigger OnPreReport()
    begin
        PeriodStartDate[1] := StartingDate;
        PeriodStartDate[2] := CalcDate('<1M>', PeriodStartDate[1]);
        PeriodStartDate[3] := CalcDate('<1M>', PeriodStartDate[2]);
        PeriodStartDate[4] := CalcDate('<1M>', PeriodStartDate[3]);

        Aging0To30StartHeader := Format(PeriodStartDate[1], 0, '<Month>/<Day,2>/<Year,2>');
        Aging0To30EndHeader := Format(CalcDate('<-1D>', PeriodStartDate[2]), 0, '<Month>/<Day,2>/<Year,2>');
        Aging31To60StartHeader := Format(PeriodStartDate[2], 0, '<Month>/<Day,2>/<Year,2>');
        Aging31To60EndHeader := Format(CalcDate('<-1D>', PeriodStartDate[3]), 0, '<Month>/<Day,2>/<Year,2>');
        Aging61To90StartHeader := Format(PeriodStartDate[3], 0, '<Month>/<Day,2>/<Year,2>');
        Aging61To90EndHeader := Format(CalcDate('<-1D>', PeriodStartDate[4]), 0, '<Month>/<Day,2>/<Year,2>');
    end;


    var
        StartingDate: Date;
        PeriodStartDate: array[4] of Date;
        AgingAmount: array[5] of Decimal;
        CustLedgEntry: Record "Cust. Ledger Entry";
        Aging0To30StartHeader: Text[10];
        Aging0To30EndHeader: Text[10];
        Aging31To60StartHeader: Text[10];
        Aging31To60EndHeader: Text[10];
        Aging61To90StartHeader: Text[10];
        Aging61To90EndHeader: Text[10];
}