/* Event 16 -Stop posting and releasing the sales Order if no 
attachment is attached.*/

codeunit 60140 Event16
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
}