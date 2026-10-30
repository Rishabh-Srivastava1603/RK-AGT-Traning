report 60140 CustomerWordReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = WordLayout;
    Caption = 'WR';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", Name, City;

            column(Customer_No; "No.") { }
            column(Customer_Name; Name) { }
            column(Country_Region_Code; "Country/Region Code") { }
            column(Balance_LCY_; "Balance (LCY)") { }
            column(Credit_Limit__LCY_; "Credit Limit (LCY)") { }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Balance (LCY)");
                TempExcelBuffer.NewRow();// blank line 
                TempExcelBuffer.NewRow();

                AddCell(Customer."No.", false, TempExcelBuffer."Cell Type"::Text);
                AddCell(Customer.Name, false, TempExcelBuffer."Cell Type"::Text);
                AddCell(Customer."Phone No.", false, TempExcelBuffer."Cell Type"::Text);
                AddCell(Customer."E-Mail", false, TempExcelBuffer."Cell Type"::Text);
                AddCell(Customer.City, false, TempExcelBuffer."Cell Type"::Text);
                AddCell(Format(Customer."Balance (LCY)"), false, TempExcelBuffer."Cell Type"::Number);

            end;

        }
    }




    rendering
    {
        layout(WordLayout)
        {
            Type = Word;
            LayoutFile = 'MyReport.docx';
        }
        layout(RDLCLayout)
        {
            Type = RDLC;
            LayoutFile = 'CustomerWordReport.rdlc';
        }
        layout(ExcelLayout)
        {
            Type = Excel;
            LayoutFile = 'CustomerExcel.xlsx';
        }
    }
    trigger OnPreReport()
    begin
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        AddCell(Customer.FieldCaption("No."), true, TempExcelBuffer."Cell Type"::Text);
        AddCell(Customer.FieldCaption("Name"), true, TempExcelBuffer."Cell Type"::Text);
        AddCell(Customer.FieldCaption("Phone No."), true, TempExcelBuffer."Cell Type"::Text);
        AddCell(Customer.FieldCaption("E-Mail"), true, TempExcelBuffer."Cell Type"::Text);
        AddCell(Customer.FieldCaption(City), true, TempExcelBuffer."Cell Type"::Text);
        AddCell(Customer.FieldCaption("Balance (LCY)"), true, TempExcelBuffer."Cell Type"::Text);
    end;

    trigger OnPostReport()
    begin
        TempExcelBuffer.CreateNewBook('Customers');
        TempExcelBuffer.WriteSheet('Customers', CompanyName(), UserId());
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('RK CUSTOMER BOOK');
        TempExcelBuffer.OpenExcel();
    end;

    local procedure AddCell(Value: Text; IsBold: Boolean; CellType: Option)
    begin
        TempExcelBuffer.AddColumn(Value, false, '', IsBold, false, false, '', CellType);
    end;


    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
}