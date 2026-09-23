/* Event 16 -Stop posting and releasing the sales Order if no 
attachment is attached.*/

codeunit 60140 StopPostingIfNoAttachment
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostSalesDoc, '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    var
        Attachment: Record "Document Attachment";

    begin
        Attachment.SetRange("Table ID", Database::"Sales Header");
        Attachment.SetRange("No.", SalesHeader."No.");
        if Attachment.FindFirst() then begin
            Message('Attachment is Attached Now Order Post');
        end
        else begin
            Error('Order cannot be posted without an attachment.');
        end;


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(SalesHeader: Record "Sales Header")
    var
        SalseAttachment: Record "Document Attachment";

    begin

        SalseAttachment.SetRange("Table ID", Database::"Sales Header");
        SalseAttachment.SetRange("No.", SalesHeader."No.");
        if SalseAttachment.IsEmpty() then begin
            Error('Order cannot be Released without an attachment.');

        end
        else begin
            Message('Attachment is Attached Now Order Release');
        end;


    end;
}