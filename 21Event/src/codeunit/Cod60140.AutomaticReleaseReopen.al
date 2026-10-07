/*In Sales order while releasing a order if i try to modify 
sales line it should not throw error instead it it reopen it
 and after changing values it automatically release it .
*/


codeunit 60140 AutomaticReleaseReopen
{
    SingleInstance = true;

    var
        ReleaseReopen: Codeunit "Release Sales Document";
        ReleasedSalesOrderNo: Code[20];
        ReleasedSalesOrderType: Enum "Sales Document Type";

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnBeforeTestStatusOpen, '', false, false)]
    local procedure OnBeforeTestStatusOpen(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var StatusCheckSuspended: Boolean)
    begin
        if SalesHeader.Status = SalesHeader.Status::Released then begin
            Message('1.Sales header status - %1', SalesHeader.Status);
            ReleasedSalesOrderNo := SalesHeader."No.";
            ReleasedSalesOrderType := SalesHeader."Document Type";
            ReleaseReopen.Reopen(SalesHeader);
            Message('Sales header status - %1', SalesHeader.Status);
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterModifyEvent, '', false, false)]
    local procedure OnAfterModifyEvent(
    var Rec: Record "Sales Line";
    var xRec: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
    begin
        if (ReleasedSalesOrderNo = Rec."Document No.") and
           (ReleasedSalesOrderType = Rec."Document Type")
        then begin

            ReleasedSalesOrderNo := '';
            Clear(ReleasedSalesOrderType);

            if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then begin
                if SalesHeader.Status = SalesHeader.Status::Open then
                    ReleaseReopen.PerformManualRelease(SalesHeader);
                Message('3Sales header status - %1', SalesHeader.Status);
            end
        end
    end;

}