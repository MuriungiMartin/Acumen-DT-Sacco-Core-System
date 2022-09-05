#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516840 "MC Individual Application Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";
    SourceTableView = where("Account Category" = filter(<> Group),
                            "Group Account" = const(false),
                            "Customer Posting Group" = const('MICRO'),
                            Source = const(Micro));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("BOSA Account No."; "BOSA Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Account Category';
                    Editable = false;

                    trigger OnValidate()
                    begin

                        BosaAccNoVisible := true;
                        FosaAccNoVisible := true;
                        MemCatVisible := true;
                        PayrollVisible := true;
                        IDNoVisible := true;
                        PassVisible := true;
                        MaritalVisible := true;
                        GenderVisible := true;
                        DoBVisible := true;
                        BenvVisible := true;
                        WstationVisible := true;
                        DeptVisible := true;
                        SecVisible := true;
                        OccpVisible := true;
                    end;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FOSA Account No."; "FOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Customer Type"; "Customer Type")
                {
                    ApplicationArea = Basic;
                    OptionCaption = ' ,,,,,Micro';
                    Visible = false;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Visible = true;

                    trigger OnValidate()
                    begin


                        Cust.Reset;
                        Cust.SetRange(Cust."ID No.", "ID No.");
                        Cust.SetFilter(Cust."Account Category", '<>%1', Cust."account category"::Group);
                        Cust.SetFilter(Cust."Group Account", '%1', false);
                        Cust.SetRange(Cust."Customer Posting Group", 'MICRO');
                        if Cust.Find('-') then begin
                            Error(Text005, Cust."Group Account Name");
                        end;

                        CustMember.Reset;
                        CustMember.SetRange(CustMember."ID No.", "ID No.");
                        CustMember.SetRange(CustMember."Customer Type", CustMember."customer type"::Member);
                        if CustMember.Find('-') then
                            repeat
                                Validate("BOSA Account No.", CustMember."No.");
                            until CustMember.Next = 0;
                    end;
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = PassEditable;
                    Visible = true;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Editable = AddressEditable;
                }
                field("Postal Code"; "Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = PostCodeEditable;
                    Importance = Promoted;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        if MembershipApplications.Get("Postal Code") then begin
                            City := MembershipApplications.City;
                        end;
                    end;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = CountryEditable;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field("E-Mail (Personal)"; "E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Village/Residence"; "Village/Residence")
                {
                    ApplicationArea = Basic;
                    Editable = VillageResidence;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Signature; Signature)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Employer Type"; "Employer Type")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Group Information")
            {
                Caption = 'Group Information';
                field("Group Account No"; "Group Account No")
                {
                    ApplicationArea = Basic;
                    TableRelation = Customer where("Group Account No" = filter('YES'),
                                                             "Customer Posting Group" = filter('MICRO'));
                }
                field("Group Account Name"; "Group Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Recruited By"; "Recruited By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Salesperson Name"; "Salesperson Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'MC OFFICER';
                    Editable = false;
                    Visible = true;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Other Information")
            {
                Caption = 'Other Information';
                field("Monthly Contribution"; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyContributionEdit;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = Basic;
                    Editable = BankAEditable;
                    Visible = false;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Account No"; "Bank Account No")
                {
                    ApplicationArea = Basic;
                    Editable = BankNEditable;
                    Visible = false;
                }
                field("Office Branch"; "Office Branch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Work Station';
                    Editable = OfficeBranchEditable;
                    Visible = false;
                }
                field(Department; Department)
                {
                    ApplicationArea = Basic;
                    Editable = DeptEditable;
                    Visible = false;
                }
                field(Section; Section)
                {
                    ApplicationArea = Basic;
                    Editable = SectionEditable;
                    Visible = false;
                }
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = OccupationEditable;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = GlobalDim2Editable;
                }
                field("FOSA Account Type"; "FOSA Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000026; "Member Picture-App")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                Editable = MobileEditable;
                Enabled = MobileEditable;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000024; "Member Signature-App")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                Editable = MobileEditable;
                Enabled = MobileEditable;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Nominee Detail";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");
                }
                group(Approvals)
                {
                    Caption = '-';
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::MembershipApplication;
                        ApprovalEntries.Setfilters(Database::"Membership Applications", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        if (Status <> Status::Open) then
                            Error('Status must be Open');
                        //SendEmail();
                        //IF ApprovalsMgmt.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) THEN
                        //ApprovalsMgmt.OnSendMembershipApplicationForApproval(Rec);

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                }
                action("Create Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Account';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Status <> Status::Approved then
                            Error('This application has not been approved');

                        if Confirm('Are you sure you want to Create Account Application?', false) = true then begin

                            GenSetUp.Get;

                            if "ID No." <> '' then begin
                                Cust.Reset;
                                Cust.SetRange(Cust."ID No.", "ID No.");
                                Cust.SetRange(Cust."Customer Posting Group", 'MICRO');
                                if Cust.Find('-') then begin
                                    if Cust."No." <> "No." then
                                        Error('This Member Account has Already been Created');
                                end;
                            end;

                            //Create Micro Account



                            Saccosetup.Get();
                            NewMembNo := "Group Account No" + '/' + "BOSA Account No.";

                            //Create BOSA account

                            TestField("Global Dimension 2 Code");
                            Cust."No." := Format(NewMembNo);
                            Cust.Name := UpperCase(Name);
                            Cust.Address := Address;
                            Cust."Post Code" := "Postal Code";
                            Cust.City := City;
                            Cust.County := City;
                            Cust."Country/Region Code" := "Country/Region Code";
                            Cust."Phone No." := "Phone No.";
                            Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                            Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                            Cust."Customer Posting Group" := "Customer Posting Group";
                            Cust."Registration Date" := Today;//Registration date must be the day the application is converted to a member and not day of capture
                            Cust.Status := Cust.Status::"Non-Active";
                            Cust."Employer Code" := "Employer Code";
                            Cust."Date of Birth" := "Date of Birth";
                            Cust."Station/Department" := "Station/Department";
                            Cust."E-Mail" := "E-Mail (Personal)";
                            Cust.Location := Location;
                            Cust."Group Account Name" := "Group Account Name";


                            //**
                            Cust."Office Branch" := "Office Branch";
                            Cust.Department := Department;
                            Cust.Occupation := Format(Occupation);
                            Cust.Designation := Designation;
                            Cust."Bank Code" := "Bank Code";
                            //Cust."Bank Branch Code":="Bank Name";
                            Cust."Bank Account No." := "Bank Account No";
                            //**
                            Cust."Sub-Location" := "Sub-Location";
                            Cust.District := District;
                            //Cust."Payroll/Staff No":="Payroll/Staff No";
                            Cust."ID No." := "ID No.";
                            Cust."Passport No." := "Passport No.";
                            //Cust."Business Loan Officer":="Salesperson Code";
                            Cust."Mobile Phone No" := "Mobile Phone No";
                            Cust."Marital Status" := "Marital Status";
                            Cust."Customer Type" := Cust."customer type"::MicroFinance;
                            Cust.Gender := Gender;

                            //CALCFIELDS(Signature,Picture);
                            Cust.Picture := Picture;
                            Cust.Signature := Signature;
                            Cust."Monthly Contribution" := "Monthly Contribution";
                            Cust."Account Category" := "Account Category";
                            Cust."Contact Person" := "Contact Person";
                            Cust."Contact Person Phone" := "Contact Person Phone";
                            Cust."ContactPerson Relation" := "ContactPerson Relation";
                            Cust."Recruited By" := "Recruited By";
                            Cust."Business Loan Officer" := "Salesperson Name";
                            Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                            Cust."Village/Residence" := "Village/Residence";
                            Cust."Group Account" := "Group Account";
                            Cust."Group Account No" := "Group Account No";
                            Cust."Group Account Name" := "Group Account Name";
                            Cust."FOSA Account" := "FOSA Account No.";
                            Cust.Status := Cust.Status::Active;
                            Cust.Insert(true);

                            Cust.Reset;
                            if Cust.Get(BOSAACC) then begin
                                Cust.Validate(Cust.Name);
                                Cust.Validate(Cust."Global Dimension 1 Code");
                                Cust.Validate(Cust."Global Dimension 2 Code");
                                Cust.Modify;
                            end;

                            Saccosetup.BosaNumber := IncStr(Saccosetup.BosaNumber);
                            Saccosetup.Modify;
                            BOSAACC := Cust."No.";
                            Status := Status::Approved;
                            "Created By" := UserId;
                            Message('The member account has been created successfully, the member no. is %1', BOSAACC);




                            AccountSignatoriesApp.Reset;
                            AccountSignatoriesApp.SetRange(AccountSignatoriesApp."Account No", "No.");
                            if AccountSignatoriesApp.Find('-') then begin

                                AccountSignatoriesApp.Reset;
                                AccountSignatoriesApp.SetRange(AccountSignatoriesApp."Account No", "No.");
                                AccountSignatoriesApp.SetRange(AccountSignatoriesApp."Send SMS", false);
                                if AccountSignatoriesApp.Find('-') then begin
                                    repeat

                                        SMSMessage.Reset;
                                        if SMSMessage.Find('+') then begin
                                            iEntryNo := SMSMessage."Entry No";
                                            iEntryNo := iEntryNo + 1;
                                        end
                                        else begin
                                            iEntryNo := 1;
                                        end;


                                        SMSMessage.Init;
                                        SMSMessage."Entry No" := iEntryNo;
                                        //SMSMessage."Account No":="Payroll/Staff No";
                                        SMSMessage."Date Entered" := Today;
                                        SMSMessage."Time Entered" := Time;
                                        SMSMessage.Source := 'MEMBERACCOUNT';
                                        SMSMessage."Entered By" := UserId;
                                        SMSMessage."System Created Entry" := true;
                                        SMSMessage."Document No" := "No.";
                                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                                        SMSMessage."SMS Message" := Name + ' has been succesfuly created. NAFAKA SACCO';
                                        SMSMessage."Telephone No" := AccountSignatoriesApp."Mobile Phone No.";
                                        SMSMessage.Insert;

                                        AccountSignatoriesApp."Send SMS" := true;
                                        AccountSignatoriesApp.Modify;

                                    until AccountSignatoriesApp.Next = 0;
                                end;
                            end;
                        end;
                        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        // SEND SMS
                        //ELSE
                        //ERROR('Application Not approved');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //"Responsibility Centre" := UserMgt.GetSalesFilter;

        "Customer Type" := "customer type"::Member;
        "Global Dimension 1 Code" := 'MICRO';
        "Customer Posting Group" := 'MICRO';
        Source := Source::Micro;
        "Account Type" := "account type"::Single;
        "Account Category" := "account category"::Single;
        "Group Account" := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        "Customer Type" := "customer type"::Member;
        "Global Dimension 1 Code" := 'MICRO';
        "Customer Posting Group" := 'MICRO';
        Source := Source::Micro;
        "Account Type" := "account type"::Single;
        "Account Category" := "account category"::Single;
        "Group Account" := false
    end;

    trigger OnOpenPage()
    begin

        if Status = Status::Approved then
            CurrPage.Editable := false;

        "Customer Type" := "customer type"::Member;
        "Global Dimension 1 Code" := 'MICRO';
        "Customer Posting Group" := 'MICRO';
        Source := Source::Micro;
        "Account Type" := "account type"::Single;
        "Account Category" := "account category"::Single;
        "Group Account" := false;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        Cust: Record Customer;
        Accounts: Record Vendor;
        NextOfKinApp: Record "Members Nominee";
        NextofKinFOSA: Record "FOSA Account NOK Details";
        AccountSign: Record "Member Account Signatories";
        AccSignatories: Record "Member Account Signatories";
        AccountSignApp: Record "Member App Signatories";
        GetSeUp: Record "Sacco General Set-Up";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "Members Nominee";
        SignCount: Integer;
        NOKBOSA: Record "Members Nominee";
        BOSAACC: Code[20];
        NextOfKin: Record "Members Nominee";
        PictureExists: Boolean;
        UserMgt: Codeunit "User Setup Management";
        NotificationE: Codeunit Mail;
        MailBody: Text[250];
        ccEmail: Text[1000];
        toEmail: Text[1000];
        GenSetUp: Record "Sacco General Set-Up";
        ClearingAcctNo: Code[20];
        AdvrAcctNo: Code[20];
        AccountTypes: Record "Account Types-Saving Products";
        DivAcctNo: Code[20];
        text001: label 'Status must be open';
        NameEditable: Boolean;
        AddressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        CustPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        MaritalstatusEditable: Boolean;
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        OfficeBranchEditable: Boolean;
        DeptEditable: Boolean;
        SectionEditable: Boolean;
        OccupationEditable: Boolean;
        DesignationEdiatble: Boolean;
        EmployerCodeEditable: Boolean;
        DOBEditable: Boolean;
        EmailEdiatble: Boolean;
        StaffNoEditable: Boolean;
        GenderEditable: Boolean;
        MonthlyContributionEdit: Boolean;
        PostCodeEditable: Boolean;
        CityEditable: Boolean;
        WitnessEditable: Boolean;
        StatusEditable: Boolean;
        BankCodeEditable: Boolean;
        BranchCodeEditable: Boolean;
        BankAccountNoEditable: Boolean;
        VillageResidence: Boolean;
        SignatureExists: Boolean;
        ForceNo: Boolean;
        ContPhone: Boolean;
        ContRelation: Boolean;
        ContOcuppation: Boolean;
        Recruitedby: Boolean;
        PassEditable: Boolean;
        EmployerEditable: Boolean;
        CountryEditable: Boolean;
        SalesEditable: Boolean;
        text002: label 'Kindly specify the next of kin';
        AccountCategory: Boolean;
        text003: label 'You must specify Signatories for this type of membership';
        GetAccountType: Record "Account Types-Saving Products";
        Text004: label 'You MUST specify the next of kin Benevolent';
        CustMember: Record Customer;
        "BenvNo.": Code[10];
        BankAEditable: Boolean;
        MemEditable: Boolean;
        BenvEditable: Boolean;
        BankNEditable: Boolean;
        InserFEditable: Boolean;
        FosAEditable: Boolean;
        Memb: Record "Membership Applications";
        BosaAccNoVisible: Boolean;
        FosaAccNoVisible: Boolean;
        MemCatVisible: Boolean;
        PayrollVisible: Boolean;
        IDNoVisible: Boolean;
        PassVisible: Boolean;
        MaritalVisible: Boolean;
        GenderVisible: Boolean;
        DoBVisible: Boolean;
        BenvVisible: Boolean;
        WstationVisible: Boolean;
        DeptVisible: Boolean;
        SecVisible: Boolean;
        OccpVisible: Boolean;
        MembCust: Record Customer;
        AccountSignatoriesApp: Record "FOSA Account App Signatories";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        AccoutTypes: Record "Account Types-Saving Products";
        Text005: label 'Member already belongs to group %1.';
        MembrCount: Integer;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        Saccosetup: Record "Sacco No. Series";
        AcctNo: Code[50];
        BCode: Code[20];
        DValues: Record "Dimension Value";
        LastNoUsed: Code[20];
        SavProducts: Record "Account Types-Saving Products";
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions;
        notifymail: Codeunit "SMTP Mail";
        NewMembNo: Code[20];
        MembershipApplications: Record "Membership Applications";
        GroupCode: Code[10];
        MobileEditable: Boolean;


    procedure UpdateControls()
    begin

        if Status = Status::Approved then begin
            NameEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            ForceNo := false;
            ContPhone := false;
            ContRelation := false;
            ContOcuppation := false;
            Recruitedby := false;
            PassEditable := false;
            EmployerEditable := false;
            CountryEditable := false;
            SalesEditable := false;
            AccountCategory := false;
            BankAEditable := false;
            MemEditable := false;
            BenvEditable := false;
            BankNEditable := false;
            MobileEditable := false;
        end;

        if Status = Status::Open then begin
            NameEditable := true;
            AddressEditable := true;
            GlobalDim1Editable := false;
            GlobalDim2Editable := true;
            CustPostingGroupEdit := false;
            PhoneEditable := true;
            MaritalstatusEditable := true;
            IDNoEditable := true;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            OfficeBranchEditable := true;
            DeptEditable := true;
            SectionEditable := true;
            OccupationEditable := true;
            DesignationEdiatble := true;
            EmployerCodeEditable := true;
            DOBEditable := true;
            EmailEdiatble := true;
            StaffNoEditable := true;
            GenderEditable := true;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := false;
            WitnessEditable := true;
            BankCodeEditable := true;
            BranchCodeEditable := true;
            BankAccountNoEditable := true;
            VillageResidence := true;
            ForceNo := true;
            ContPhone := true;
            ContRelation := true;
            ContOcuppation := true;
            Recruitedby := true;
            PassEditable := true;
            EmployerEditable := true;
            CountryEditable := true;
            SalesEditable := true;
            AccountCategory := true;
            BankAEditable := true;
            MemEditable := true;
            BenvEditable := true;
            BankNEditable := true;
            MobileEditable := true;

        end
    end;

    local procedure SendEmail()
    begin
        GenSetUp.Get;



        if GenSetUp."Auto Open FOSA Savings Acc." = true then begin



            notifymail.CreateMessage(' Kenversity sacco Ltd Membership', GenSetUp."Sender Address", "E-Mail (Personal)", 'You membership application was received',

                            'Your Membership Application No is ' + "No." + ' Thank you for Kenversity sacco Ltd', false);



            notifymail.Send;



        end;
    end;

    local procedure SendEmailAct()
    begin
        GenSetUp.Get;



        if GenSetUp."Auto Open FOSA Savings Acc." = true then begin



            notifymail.CreateMessage(' Kenversity sacco Ltd Membership', GenSetUp."Sender Address", "E-Mail (Personal)", 'You membership application was received and approved',

                            'Your Membership no is ' + Cust."No." + ' Thank you for Kenversity sacco Ltd', false);



            notifymail.Send;



        end;
    end;
}

