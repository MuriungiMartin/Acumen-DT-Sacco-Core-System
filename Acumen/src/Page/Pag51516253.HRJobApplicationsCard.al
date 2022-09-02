#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516253 "HR Job Applications Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Other Details';
    SourceTable = "HR Job Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application No";"Application No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Date Applied";"Date Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("First Name";"First Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Middle Name";"Middle Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Last Name";"Last Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Initials;Initials)
                {
                    ApplicationArea = Basic;
                }
                field("First Language (R/W/S)";"First Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                    Caption = '1st Language (R/W/S)';
                    Importance = Promoted;
                }
                field("First Language Read";"First Language Read")
                {
                    ApplicationArea = Basic;
                    Caption = '1st Language Read';
                }
                field("First Language Write";"First Language Write")
                {
                    ApplicationArea = Basic;
                    Caption = '1st Language Write';
                }
                field("First Language Speak";"First Language Speak")
                {
                    ApplicationArea = Basic;
                    Caption = '1st Language Speak';
                }
                field("Second Language (R/W/S)";"Second Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                    Caption = '2nd Language (R/W/S)';
                    Importance = Promoted;
                }
                field("Second Language Read";"Second Language Read")
                {
                    ApplicationArea = Basic;
                }
                field("Second Language Write";"Second Language Write")
                {
                    ApplicationArea = Basic;
                }
                field("Second Language Speak";"Second Language Speak")
                {
                    ApplicationArea = Basic;
                }
                field("Additional Language";"Additional Language")
                {
                    ApplicationArea = Basic;
                }
                field("Applicant Type";"Applicant Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Enabled = true;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Employee No";"Employee No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Internal';
                    Editable = true;
                }
                field("ID Number";"ID Number")
                {
                    ApplicationArea = Basic;
                }
                field(Gender;Gender)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Citizenship;Citizenship)
                {
                    ApplicationArea = Basic;
                }
                field("Country Details";"Citizenship Details")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee Requisition No";"Employee Requisition No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application Reff No.';
                    Importance = Promoted;
                }
                field("Job Applied For";"Job Applied For")
                {
                    ApplicationArea = Basic;
                    Caption = 'Position Applied For';
                    Editable = true;
                    Enabled = true;
                    Importance = Promoted;
                }
                field(Expatriate;Expatriate)
                {
                    ApplicationArea = Basic;
                }
                field("Interview Invitation Sent";"Interview Invitation Sent")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Qualification Status";"Qualification Status")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Marital Status";"Marital Status")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Ethnic Origin";"Ethnic Origin")
                {
                    ApplicationArea = Basic;
                }
                field(Disabled;Disabled)
                {
                    ApplicationArea = Basic;
                }
                field("Health Assesment?";"Health Assesment?")
                {
                    ApplicationArea = Basic;
                }
                field("Health Assesment Date";"Health Assesment Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth";"Date Of Birth")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin

                        if "Date Of Birth" >= Today then begin
                          Error('Invalid Entry');
                        end;
                        DAge:= Dates.DetermineAge("Date Of Birth",Today);
                         Age:=DAge;
                    end;
                }
                field(Age;Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Home Phone Number";"Home Phone Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Postal Address";"Postal Address")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Postal Address2";"Postal Address2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Address 2';
                }
                field("Postal Address3";"Postal Address3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Address 3';
                }
                field("Post Code";"Post Code")
                {
                    ApplicationArea = Basic;
                }
                field("Residential Address";"Residential Address")
                {
                    ApplicationArea = Basic;
                }
                field("Residential Address2";"Residential Address2")
                {
                    ApplicationArea = Basic;
                }
                field("Residential Address3";"Residential Address3")
                {
                    ApplicationArea = Basic;
                }
                field("Post Code2";"Post Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code 2';
                }
                field("Cell Phone Number";"Cell Phone Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Work Phone Number";"Work Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Ext.";"Ext.")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail";"E-Mail")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Fax Number";"Fax Number")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755009;"HR Job Applications Factbox")
            {
                SubPageLink = "Application No"=field("Application No");
            }
            systempart(Control1102755008;Outlook)
            {
            }
            systempart(Control3;Links)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Other Details")
            {
                Caption = 'Other Details';
                action(Qualifications)
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Qualifications";
                    RunPageLink = "Application No"=field("Application No");
                }
                action("Page HR Training Needs Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Training Need';
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Training Needs Card";
                }
                action(Referees)
                {
                    ApplicationArea = Basic;
                    Caption = 'Referees';
                    Image = ContactReference;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Referees";
                    RunPageLink = "Job Application No"=field("Application No");
                }
                action(Hobbies)
                {
                    ApplicationArea = Basic;
                    Caption = 'Hobbies';
                    Image = Holiday;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Hobbies";
                    RunPageLink = "Job Application No"=field("Application No");
                }
                action("Generate Offer Letter")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Offer Letter';
                    Promoted = true;
                    RunObject = Report "HR Employement Letter";
                }
                action("Upload Attachments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Upload Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Attachments SF";
                    RunPageLink = "Employee No"=field("Application No");
                    Visible = false;
                }
            }
            group("&Functions")
            {
                Caption = '&Functions';
                action("&Send Interview Invitation")
                {
                    ApplicationArea = Basic;
                    Caption = '&Send Interview Invitation';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        TestField(Qualified);


                        HRJobApplications.SetFilter(HRJobApplications."Application No","Application No");
                        Report.Run(53940,false,false,HRJobApplications);
                    end;
                }
                action("&Upload to Employee Card")
                {
                    ApplicationArea = Basic;
                    Caption = '&Upload to Employee Card';
                    Image = ImportDatabase;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if "Employee No" = '' then begin
                        //IF NOT CONFIRM('Are you sure you want to Upload Applicants information to the Employee Card',FALSE) THEN EXIT;
                        HRJobApplications.SetFilter(HRJobApplications."Application No","Application No");
                        Report.Run(55600,true,false,HRJobApplications);
                        end else begin
                        Message('This applicants information already exists in the employee card');
                        end;
                    end;
                }
                action("&Print")
                {
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No","Application No");
                        if HRJobApplications.Find('-') then
                        Report.Run(55523,true,true,HRJobApplications);
                    end;
                }
            }
        }
    }

    var
        HRJobApplications: Record "HR Job Applications";
        SMTP: Codeunit "SMTP Mail";
        HREmailParameters: Record "HR E-Mail Parameters";
        Employee: Record "HR Employees";
        Text19064672: label 'Shortlisting Summary';
        Dates: Codeunit "HR Datess";
        DAge: Text[100];
}

