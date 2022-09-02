#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516246 "HR Company Attachments"
{
    Caption = 'HR Company Attachments';
    PageType = List;
    SourceTable = UnknownTable51516205;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Document Description";"Document Description")
                {
                    ApplicationArea = Basic;
                }
                field(Attachment;Attachment)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Attachment")
            {
                Caption = '&Attachment';
                action(Open)
                {
                    ApplicationArea = Basic;
                    Caption = 'Open';

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Code,"Document Description") then

                        begin
                        if InteractTemplLanguage.Get(DocLink.Code,DocLink."Language Code (Default)",DocLink."Document Description") then
                          InteractTemplLanguage.OpenAttachment;
                        end;
                    end;
                }
                action(Create)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Code,"Document Description") then
                        begin
                        if not InteractTemplLanguage.Get(DocLink.Code,DocLink."Language Code (Default)",DocLink."Document Description") then
                        begin
                          InteractTemplLanguage.Init;
                          InteractTemplLanguage."Interaction Template Code" := Code;
                          InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                          InteractTemplLanguage.Description := "Document Description";
                        end;
                        InteractTemplLanguage.CreateAttachment;
                        CurrPage.Update;
                        DocLink.Attachment:=DocLink.Attachment::"1";
                        DocLink.Modify;
                        end;
                    end;
                }
                action("Copy &from")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy &from';
                    Ellipsis = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Code,"Document Description") then
                        begin

                        if InteractTemplLanguage.Get(DocLink.Code,DocLink."Language Code (Default)",DocLink."Document Description") then

                        InteractTemplLanguage.CopyFromAttachment;
                        CurrPage.Update;
                        //DocLink.Attachment:=DocLink.Attachment::Yes;
                        //DocLink.MODIFY;
                        end;
                    end;
                }
                action(Import)
                {
                    ApplicationArea = Basic;
                    Caption = 'Import';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Code,"Document Description") then
                        begin
                        if not InteractTemplLanguage.Get(DocLink."Document Description",DocLink."Language Code (Default)") then begin
                          InteractTemplLanguage.Init;
                          InteractTemplLanguage."Interaction Template Code" := Code;
                          InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                          InteractTemplLanguage.Description := DocLink."Document Description";
                          InteractTemplLanguage.Insert;
                        end;
                        InteractTemplLanguage.ImportAttachment;
                        CurrPage.Update;
                        DocLink.Attachment:=DocLink.Attachment::"1";
                        DocLink.Modify;
                        end;
                    end;
                }
                action("E&xport")
                {
                    ApplicationArea = Basic;
                    Caption = 'E&xport';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Code,"Document Description") then
                        begin
                        if InteractTemplLanguage.Get(DocLink.Code,DocLink."Language Code (Default)",DocLink."Document Description") then
                          InteractTemplLanguage.ExportAttachment;
                        end;
                    end;
                }
                action(Remove)
                {
                    ApplicationArea = Basic;
                    Caption = 'Remove';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Code,"Document Description") then
                        begin
                        if InteractTemplLanguage.Get(DocLink.Code,DocLink."Language Code (Default)",DocLink."Document Description") then begin
                          InteractTemplLanguage.RemoveAttachment(true);
                          DocLink.Attachment:=DocLink.Attachment::"0";
                          DocLink.Modify;
                        end;
                        end;
                    end;
                }
            }
        }
    }

    var
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        DocLink: Record UnknownRecord51516205;


    procedure GetDocument() Document: Text[200]
    begin
        Document:="Document Description";
    end;
}

