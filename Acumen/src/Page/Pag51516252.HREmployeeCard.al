#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516252 "HR Employee Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Print,Functions,Employee,Attachments';
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            group("General Details")
            {
                Caption = 'General Details';
                field("Contract Type"; "Contract Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    AssistEdit = true;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        // IF AssistEdit() THEN
                        CurrPage.Update;
                    end;
                }
                field(Title; Title)
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("ID Number"; "ID Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Passport Number"; "Passport Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Citizenship; Citizenship)
                {
                    ApplicationArea = Basic;
                }
                field("Citizenship Text"; "Citizenship Text")
                {
                    ApplicationArea = Basic;
                    Caption = 'Country / Region Code';
                    Editable = false;
                }
                field(Office; Office)
                {
                    ApplicationArea = Basic;
                    Caption = 'Department';
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = Basic;
                }
                field("Postal Address"; "Postal Address")
                {
                    ApplicationArea = Basic;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                }
                field(County; County)
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        SupervisorNames := GetSupervisor("User ID");
                    end;
                }
                field("Fosa Account"; "Fosa Account")
                {
                    ApplicationArea = Basic;
                }
                field(SupervisorNames; SupervisorNames)
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor ';
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Employee Classification"; "Employee Classification")
                {
                    ApplicationArea = Basic;
                }
                field("Institutional Base"; "Institutional Base")
                {
                    ApplicationArea = Basic;
                }
                field(Supervisor; Supervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Is Supervisor';
                }
            }
            group("Communication Details")
            {
                Caption = 'Communication Details';
                field("Cell Phone Number"; "Cell Phone Number")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                }
                field("Home Phone Number"; "Home Phone Number")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                }
                field("Fax Number"; "Fax Number")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                }
                field("Work Phone Number"; "Work Phone Number")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                }
                field("Ext."; "Ext.")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = EMail;
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = EMail;
                    Importance = Promoted;
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Signature; Signature)
                {
                    ApplicationArea = Basic;
                }
                field("First Language (R/W/S)"; "First Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = false;
                }
                field("First Language Read"; "First Language Read")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("First Language Write"; "First Language Write")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("First Language Speak"; "First Language Speak")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Second Language (R/W/S)"; "Second Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = false;
                }
                field("Second Language Read"; "Second Language Read")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Second Language Write"; "Second Language Write")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Second Language Speak"; "Second Language Speak")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Additional Language"; "Additional Language")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Vehicle Registration Number"; "Vehicle Registration Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Number Of Dependants"; "Number Of Dependants")
                {
                    ApplicationArea = Basic;
                }
                field(Disabled; Disabled)
                {
                    ApplicationArea = Basic;
                }
                field("Health Assesment?"; "Health Assesment?")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme No."; "Medical Scheme No.")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme Head Member"; "Medical Scheme Head Member")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme Name"; "Medical Scheme Name")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Out-Patient Limit"; "Medical Out-Patient Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Medical In-Patient Limit"; "Medical In-Patient Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Maximum Cover"; "Medical Maximum Cover")
                {
                    ApplicationArea = Basic;
                }
                field("Medical No Of Dependants"; "Medical No Of Dependants")
                {
                    ApplicationArea = Basic;
                }
                field("Cause of Inactivity Code"; "Cause of Inactivity Code")
                {
                    ApplicationArea = Basic;
                }
                field("Health Assesment Date"; "Health Assesment Date")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bank Details")
            {
                Caption = 'Bank Details';
                field("Main Bank"; "Main Bank")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("<Bank Code>"; "Bank Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Code';
                }
                field("Branch Bank"; "Branch Bank")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("<Branch Code>"; "Branch Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch Code';
                }
                field("Bank Account Number"; "Bank Account Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        if "Date Of Birth" >= Today then begin
                            Error('Invalid Entry');
                        end;
                        DAge := Dates.DetermineAge("Date Of Birth", Today);
                    end;
                }
                field(DAge; DAge)
                {
                    ApplicationArea = Basic;
                    Caption = 'Age';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Date Of Join"; "Date Of Join")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        DService := Dates.DetermineAge("Date Of Join", Today);
                    end;
                }
                field(DService; DService)
                {
                    ApplicationArea = Basic;
                    Caption = 'Length of Service';
                    Editable = false;
                    Enabled = false;
                }
                field("End Of Probation Date"; "End Of Probation Date")
                {
                    ApplicationArea = Basic;
                }
                field("Pension Scheme Join Date"; "Pension Scheme Join Date")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        DPension := Dates.DetermineAge("Pension Scheme Join Date", Today);
                    end;
                }
                field("Medical Scheme Join Date"; "Medical Scheme Join Date")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        DMedical := Dates.DetermineAge("Medical Scheme Join Date", Today);
                    end;
                }
                field(DMedical; DMedical)
                {
                    ApplicationArea = Basic;
                    Caption = 'Time On Medical Aid Scheme';
                    Editable = false;
                    Enabled = false;
                }
                field("Wedding Anniversary"; "Wedding Anniversary")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Job Details")
            {
                Caption = 'Job Details';
                field("Job Specification"; "Job Specification")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Grade; Grade)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Payroll Code"; "Payroll Code")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Terms of Service")
            {
                Caption = 'Terms of Service';
                field("Secondment Institution"; "Secondment Institution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Seondment';
                }
                field("Contract End Date"; "Contract End Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                }
                field("Notice Period"; "Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field("Send Alert to"; "Send Alert to")
                {
                    ApplicationArea = Basic;
                }
                field("Full / Part Time"; "Full / Part Time")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
            group("Payment Information")
            {
                Caption = 'Payment Information';
                field("PIN No."; "PIN No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("NSSF No."; "NSSF No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("NHIF No."; "NHIF No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
            group("Separation Details")
            {
                Caption = 'Separation Details';
                field("Date Of Leaving the Company"; "Date Of Leaving the Company")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        /*
                        FrmCalendar.SetDate("Date Of Leaving the Company");
                        FrmCalendar.RUNMODAL;
                        D := FrmCalendar.GetDate;
                        CLEAR(FrmCalendar);
                        IF D <> 0D THEN
                          "Date Of Leaving the Company":= D;
                        //DAge:= Dates.DetermineAge("Date Of Birth",TODAY);
                        
                        */

                    end;
                }
                field("Termination Grounds"; "Termination Grounds")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Exit Interview Date"; "Exit Interview Date")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Exit Interview Done by"; "Exit Interview Done by")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
            group("Leave Details/Medical Claims")
            {
                Caption = 'Leave Details/Medical Claims';
                field("Reimbursed Leave Days"; "Reimbursed Leave Days")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Allocated Leave Days"; "Allocated Leave Days")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Total (Leave Days)"; "Total (Leave Days)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Total Leave Taken"; "Total Leave Taken")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Leave Balance"; "Leave Balance")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Acrued Leave Days"; "Acrued Leave Days")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Cash per Leave Day"; "Cash per Leave Day")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Cash - Leave Earned"; "Cash - Leave Earned")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Leave Status"; "Leave Status")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Leave Type Filter"; "Leave Type Filter")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Leave Period Filter"; "Leave Period Filter")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Claim Limit"; "Claim Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Amount Used"; "Claim Amount Used")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Remaining Amount"; "Claim Remaining Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Employees Factbox")
            {
                SubPageLink = "No." = field("No.");
            }
            systempart(Control1102755002; Outlook)
            {
            }
            systempart(Control1; Links)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Personal Information File")
                {
                    ApplicationArea = Basic;
                    Caption = 'Personal Information File';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", "No.");
                        if HREmp.Find('-') then
                            Report.Run(55585, true, true, HREmp);
                    end;
                }
                action("Misc. Article Info")
                {
                    ApplicationArea = Basic;
                    Caption = 'Misc. Article Info';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Misc.Reset;
                        Misc.SetRange(Misc."Employee No.", "No.");
                        if Misc.Find('-') then
                            Report.Run(5202, true, true, Misc);
                    end;
                }
                action("Confidential Info")
                {
                    ApplicationArea = Basic;
                    Caption = 'Confidential Info';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Conf.Reset;
                        Conf.SetRange(Conf."Employee No.", "No.");
                        if Conf.Find('-') then
                            Report.Run(5203, true, true, Conf);
                    end;
                }
                action(Label)
                {
                    ApplicationArea = Basic;
                    Caption = 'Label';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", "No.");
                        if HREmp.Find('-') then
                            Report.Run(5200, true, true, HREmp);
                    end;
                }
                action(Addresses)
                {
                    ApplicationArea = Basic;
                    Caption = 'Addresses';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", "No.");
                        if HREmp.Find('-') then
                            Report.Run(5207, true, true, HREmp);
                    end;
                }
                action("Alt. Addresses")
                {
                    ApplicationArea = Basic;
                    Caption = 'Alt. Addresses';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", "No.");
                        if HREmp.Find('-') then
                            Report.Run(5213, true, true, HREmp);
                    end;
                }
                action("Phone Nos")
                {
                    ApplicationArea = Basic;
                    Caption = 'Phone Nos';
                    Image = PrintReport;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", "No.");
                        if HREmp.Find('-') then
                            Report.Run(5210, true, true, HREmp);
                    end;
                }
            }
            group("&Employee")
            {
                Caption = '&Employee';
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = field("No.");
                    RunPageView = where(Type = filter("Next of Kin"));
                }
                action(Beneficiaries)
                {
                    ApplicationArea = Basic;
                    Caption = 'Beneficiaries';
                    Image = Opportunity;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = field("No.");
                    RunPageView = where(Type = filter(Beneficiary));
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const(Employee),
                                  "No." = field("No.");
                }
                action(Qualifications)
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Qualification Line";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Employment History")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employment History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employment History Lines";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Alternative Addresses")
                {
                    ApplicationArea = Basic;
                    Caption = 'Alternative Addresses';
                    Image = AlternativeAddress;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Alternative Address Card";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Misc. Articles")
                {
                    ApplicationArea = Basic;
                    Caption = 'Misc. Articles';
                    Image = ExternalDocument;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Misc. Articles Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Misc. Articles Overview';
                    Image = ViewSourceDocumentLine;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Articles Overview";
                }
                action("&Confidential Information")
                {
                    ApplicationArea = Basic;
                    Caption = '&Confidential Information';
                    Image = SNInfo;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Co&nfidential Info. Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&nfidential Info. Overview';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Confidential Info. Overview";
                }
                action("A&bsences")
                {
                    ApplicationArea = Basic;
                    Caption = 'A&bsences';
                    Image = AbsenceCalendar;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = field("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(5200),
                                  "No." = field("No.");
                }
                action("Education Sponsor")
                {
                    ApplicationArea = Basic;
                    Caption = 'Education Sponsor';
                    RunObject = Page "HR Education Assistance List";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Leave Family Employees List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Family Employees List';
                    RunObject = Page "HR Leave Family Employees List";
                    RunPageLink = "Employee No" = field("No.");
                }
                action(Grievances)
                {
                    ApplicationArea = Basic;
                    Caption = 'Grievances';
                    RunObject = Page "HR Leave Period List";
                    //RunPageLink = "Starting Date"=field("No.");
                }
                action(Supervisees)
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisees';
                    RunObject = Page "HR Employees Supervisee";
                }
            }
        }
        area(processing)
        {
            action("Employee Attachements")
            {
                ApplicationArea = Basic;
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HR Employee Attachments";
                RunPageLink = "No." = field("No.");

                trigger OnAction()
                begin
                    //PAGE.RUN(55699,Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        //Recalculate Important Dates
        if ("Date Of Leaving the Company" = 0D) then begin
            if ("Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge("Date Of Birth", Today);
            if ("Date Of Joining the Company" <> 0D) then
                DService := Dates.DetermineAge("Date Of Joining the Company", Today);
            if ("Pension Scheme Join Date" <> 0D) then
                DPension := Dates.DetermineAge("Pension Scheme Join Date", Today);
            if ("Medical Scheme Join Date" <> 0D) then
                DMedical := Dates.DetermineAge("Medical Scheme Join Date", Today);
            //MODIFY;
        end else begin
            if ("Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge("Date Of Birth", "Date Of Leaving the Company");
            if ("Date Of Joining the Company" <> 0D) then
                DService := Dates.DetermineAge("Date Of Joining the Company", "Date Of Leaving the Company");
            if ("Pension Scheme Join Date" <> 0D) then
                DPension := Dates.DetermineAge("Pension Scheme Join Date", "Date Of Leaving the Company");
            if ("Medical Scheme Join Date" <> 0D) then
                DMedical := Dates.DetermineAge("Medical Scheme Join Date", "Date Of Leaving the Company");
            //MODIFY;
        end;

        //Recalculate Leave Days
        Validate("Allocated Leave Days");
        SupervisorNames := GetSupervisor("User ID");
    end;

    trigger OnClosePage()
    begin
        /* TESTFIELD("First Name");
         TESTFIELD("Middle Name");
         TESTFIELD("Last Name");
         TESTFIELD("ID Number");
         TESTFIELD("Cellular Phone Number");
        */

    end;

    trigger OnQueryClosePage(CloseAction: action): Boolean
    begin
        //IF "First Name"='' THEN ERROR('Error First Name is not specified');
        //IF "Last Name"='' THEN ERROR('Error Last Name is not specified');
        //IF  THEN ERROR('Error General posting group is not specified');
    end;

    var
        PictureExists: Boolean;
        Text001: label 'Do you want to replace the existing picture of %1 %2?';
        Text002: label 'Do you want to delete the picture of %1 %2?';
        Dates: Codeunit "HR Datess";
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        D: Date;
        DoclLink: Record "HR Employee Attachments";
        "Filter": Boolean;
        prEmployees: Record "HR Employees";
        prPayrollType: Record "prPayroll Type";
        Mail: Codeunit Mail;
        HREmp: Record "HR Employees";
        SupervisorNames: Text[60];
        Misc: Record "Misc. Article Information";
        Conf: Record "Confidential Information";
        HRValueChange: Record "HR Value Change";
        SMTP: Codeunit "SMTP Mail";
        CompInfo: Record "Company Information";
        Body: Text[1024];
        Text003: label 'Welcome to Lotus Capital Limited';
        Filename: Text;
        Recordlink: Record "Record Link";
        Text004a: label 'It is a great pleasure to welcome you to Moi Teaching and Referral Hospital. You are now part of an organization that has its own culture and set of values. On your resumption and during your on-boarding process,  to help you to understand and adapt quickly and easily to the LOTUS CAPITAL culture and values, HR Unit shall provide you with various important documents that you are encouraged to read and understand.';
        Text004b: label 'On behalf of the Managing Director, I congratulate you for your success in the interview process and I look forward to welcoming you on board LOTUS CAPITAL Limited.';
        Text004c: label 'Adebola SAMSON-FATOKUN';
        Text004d: label 'Strategy & Corporate Services';
        NL: Char;
        LF: Char;
        objpostingGroup: Record "prEmployee Posting Group";
        objDimVal: Record "Dimension Value";
        "Citizenship Text": Text[200];


    procedure GetSupervisor(var sUserID: Code[50]) SupervisorName: Text[200]
    var
        UserSetup: Record "User Setup";
    begin
        if sUserID <> '' then begin
            UserSetup.Reset;
            if UserSetup.Get(sUserID) then begin

                SupervisorName := UserSetup."Approver ID";
                if SupervisorName <> '' then begin

                    HREmp.SetRange(HREmp."User ID", SupervisorName);
                    if HREmp.Find('-') then
                        SupervisorName := HREmp.FullName;

                end else begin
                    SupervisorName := '';
                end;


            end else begin
                Error('User' + ' ' + sUserID + ' ' + 'does not exist in the user setup table');
                SupervisorName := '';
            end;
        end;
    end;


    procedure GetSupervisorID(var EmpUserID: Code[50]) SID: Text[200]
    var
        UserSetup: Record "User Setup";
        SupervisorID: Code[20];
    begin
        if EmpUserID <> '' then begin
            SupervisorID := '';

            UserSetup.Reset;
            if UserSetup.Get(EmpUserID) then begin
                SupervisorID := UserSetup."Approver ID";
                if SupervisorID <> '' then begin
                    SID := SupervisorID;
                end else begin
                    SID := '';
                end;
            end else begin
                Error('User' + ' ' + EmpUserID + ' ' + 'does not exist in the user setup table');
            end;
        end;
    end;
}

