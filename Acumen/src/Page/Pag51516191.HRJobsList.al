#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516191 "HR Jobs List"
{
    ApplicationArea = Basic;
    CardPageID = "HR Jobs Card";
    DelayedInsert = false;
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions,Job,Administration';
    RefreshOnActivate = true;
    SourceTable = "HR Jobss";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Job ID";"Job ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Job Description";"Job Description")
                {
                    ApplicationArea = Basic;
                }
                field("No of Posts";"No of Posts")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Created";"Date Created")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Style = StandardAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002;"HR Jobs Factbox")
            {
                SubPageLink = "Job ID"=field("Job ID");
            }
            systempart(Control1102755004;Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition",Job;
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType:=Documenttype::Job;
                        ApprovalEntries.Setfilters(Database::"HR Jobss",DocumentType,"Job ID");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*
                        IF CONFIRM('Send this job position for Approval?',TRUE)=FALSE THEN EXIT;
                        AppMgmt.SendJobApprovalReq(Rec);
                        */

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*
                        IF CONFIRM('Cancel Approval Request?',TRUE)=FALSE THEN EXIT;
                        AppMgmt.CancelJobAppRequest(Rec,TRUE,TRUE);
                         */

                    end;
                }
            }
            group(Job)
            {
                Caption = 'Job';
                action("Raise Requisition")
                {
                    ApplicationArea = Basic;
                    Caption = 'Raise Requisition';
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Employee Requisitions List";
                    RunPageLink = "Job ID"=field("Job ID");
                    RunPageOnRec = false;

                    trigger OnAction()
                    begin
                        CurrPage.Close;
                    end;
                }
                action("Job Qualifications")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Qualifications';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines";
                    RunPageLink = "Job Id"=field("Job ID");
                }
                action(Responsibilities)
                {
                    ApplicationArea = Basic;
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Responsiblities Lines";
                    RunPageLink = "Job ID"=field("Job ID");
                }
                action(Occupants)
                {
                    ApplicationArea = Basic;
                    Caption = 'Occupants';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Occupants";
                    RunPageLink = "Job ID"=field("Job ID");
                }
            }
        }
        area(navigation)
        {
            action("Job Requirements")
            {
                ApplicationArea = Basic;
                Caption = 'Job Requirements';
                Image = ApplicationWorksheet;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "HR Job Requirements";
                RunPageLink = "Job ID"=field("Job ID");
            }
            action(Action1102755018)
            {
                ApplicationArea = Basic;
                Caption = 'Job Qualifications';
                Image = QualificationOverview;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "HR Job Qualifications";
            }
            action("Job Responsibilities")
            {
                ApplicationArea = Basic;
                Caption = 'Job Responsibilities';
                Image = Relationship;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "HR Job Responsibilities";
                RunPageLink = "Job ID"=field("Job ID");
            }
            action("Appraisal Evaluation Areas")
            {
                ApplicationArea = Basic;
                Caption = 'Appraisal Evaluation Areas';
                Image = Evaluate;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page UnknownPage55633;
            }
            action("Lookup Values")
            {
                ApplicationArea = Basic;
                Caption = 'Lookup Values';
                Image = List;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "HR Lookup Values List";
            }
        }
        area(reporting)
        {
            action(Jobs)
            {
                ApplicationArea = Basic;
                Caption = 'Jobs';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Jobs";
            }
            action("Job Occupants")
            {
                ApplicationArea = Basic;
                Caption = 'Job Occupants';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Job Occupants";
            }
            action("<Report HR Jobs (Vacant)>")
            {
                ApplicationArea = Basic;
                Caption = 'Vacant Jobs';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report UnknownReport55583;
            }
            action("<Report HR Jobs (Occupied)>")
            {
                ApplicationArea = Basic;
                Caption = 'Occupied Jobs';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report UnknownReport55584;
            }
            action("<Report HR Job Responsibilities>")
            {
                ApplicationArea = Basic;
                Caption = 'Job Responsibilities';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report UnknownReport55590;
            }
            action("<Report HR Job Requirements>")
            {
                ApplicationArea = Basic;
                Caption = 'Job Qualifications';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report UnknownReport55591;
            }
        }
    }
}

