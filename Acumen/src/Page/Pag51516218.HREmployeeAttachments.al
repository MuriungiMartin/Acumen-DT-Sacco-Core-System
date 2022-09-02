#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516218 "HR Employee Attachments"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Attachments';
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            group("Employee Details")
            {
                Caption = 'Employee Details';
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field(FullName;FullName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field("Job Title";"Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field("Postal Address";"Postal Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = true;
                }
                field(Gender;Gender)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = true;
                }
                field("Post Code";"Post Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = true;
                    Visible = false;
                }
                field("Cell Phone Number";"Cell Phone Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = true;
                }
                field("E-Mail";"E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = true;
                }
            }
            part(Attachments;"HR Employee Attachments SF")
            {
                Caption = 'Employee Attachments';
                SubPageLink = "Employee No"=field("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control1102755005;"HR Employees Factbox")
            {
                SubPageLink = "No."=field("No.");
            }
            systempart(Control1102755001;Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Attachment)
            {
                Caption = 'Attachment';
                Visible = false;
                action(Import)
                {
                    ApplicationArea = Basic;
                    Caption = 'Import';
                    Ellipsis = true;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;
                    Visible = false;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get("No.",CurrPage.Attachments.Page.GetDocument) then
                        begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code",DocLink."Employee No");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code",DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description,DocLink."Document Description");
                        if not InteractTemplLanguage.FindFirst then
                        begin
                          InteractTemplLanguage.Init;
                          InteractTemplLanguage."Interaction Template Code" := "No.";
                          InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                          InteractTemplLanguage.Description := DocLink."Document Description";
                          InteractTemplLanguage.Insert;
                        end;
                        InteractTemplLanguage.ImportAttachment;
                        CurrPage.Update;
                        DocLink.Attachment:=DocLink.Attachment::Yes;
                        DocLink.Modify;
                        end;
                    end;
                }
                action("E&xport")
                {
                    ApplicationArea = Basic;
                    Caption = 'E&xport';
                    Ellipsis = true;
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;
                    Visible = false;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get("No.",CurrPage.Attachments.Page.GetDocument) then
                        begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code",DocLink."Employee No");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code",DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description,DocLink."Document Description");
                        if InteractTemplLanguage.FindFirst then begin
                          InteractTemplLanguage.ExportAttachment;
                        end;
                        end
                    end;
                }
                action(Open)
                {
                    ApplicationArea = Basic;
                    Caption = 'Open';
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;
                    Visible = false;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get("No.",CurrPage.Attachments.Page.GetDocument) then
                        begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code",DocLink."Employee No");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code",DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description,DocLink."Document Description");
                        if InteractTemplLanguage.FindFirst then begin
                          InteractTemplLanguage.OpenAttachment;
                        end;
                        end
                    end;
                }
                action(Create)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create';
                    Ellipsis = true;
                    Image = Create_Movement;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;
                    Visible = false;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get("No.",CurrPage.Attachments.Page.GetDocument) then
                        begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code",DocLink."Employee No");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code",DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description,DocLink."Document Description");
                        if InteractTemplLanguage.FindFirst then begin

                          InteractTemplLanguage.Init;
                          InteractTemplLanguage."Interaction Template Code" := "No.";
                          InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                          InteractTemplLanguage.Description := CurrPage.Attachments.Page.GetDocument;

                        end;
                        InteractTemplLanguage.CreateAttachment;
                        CurrPage.Update;
                        DocLink.Attachment:=DocLink.Attachment::Yes;
                        DocLink.Modify;
                        end;
                    end;
                }
                action("Copy &from")
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy &from';
                    Ellipsis = true;
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;
                    Visible = false;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get("No.",CurrPage.Attachments.Page.GetDocument) then
                        begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code",DocLink."Employee No");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code",DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description,DocLink."Document Description");
                        if InteractTemplLanguage.FindFirst then begin
                        InteractTemplLanguage.CopyFromAttachment;
                        CurrPage.Update;
                        DocLink.Attachment:=DocLink.Attachment::Yes;
                        DocLink.Modify;
                        end;
                        end
                    end;
                }
                action(Remove)
                {
                    ApplicationArea = Basic;
                    Caption = 'Remove';
                    Ellipsis = true;
                    Image = RemoveContacts;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;
                    Visible = false;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get("No.",CurrPage.Attachments.Page.GetDocument) then
                        begin
                        Error('%1',DocLink."Document Description");
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code",DocLink."Employee No");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code",DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description,DocLink."Document Description");
                        if InteractTemplLanguage.FindFirst then begin

                          InteractTemplLanguage.RemoveAttachment(true);
                          DocLink.Attachment:=DocLink.Attachment::No;
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
        DocLink: Record "HR Employee Attachments";
        EmpNames: Text[30];
}

