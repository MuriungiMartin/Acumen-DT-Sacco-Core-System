#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516430 "FOSA Accounts Applications"
{
    ApplicationArea = Basic;
    CardPageID = "FOSA Account Application Card";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "FOSA Account Applicat. Details";
    SourceTableView = where("Application Status" = filter(<> Converted));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Staff No"; "Staff No")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account No"; "BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                }
                field("Account Category"; "Account Category")
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
                    RunObject = Page "FOSA Accounts Applications NOK";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Employees Attachements";
                    RunPageLink = "First Name" = field("No.");
                }
            }
        }
        area(processing)
        {
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    //TESTFIELD("Employer Code");
                    TestField("Account Type");
                    TestField("ID No.");
                    TestField("Staff No");
                    //TESTFIELD("BOSA Account No");
                    TestField("Date of Birth");
                    TestField("Global Dimension 2 Code");
                    /*
                    IF ("Micro Group"=FALSE) OR ("Micro Single"=FALSE) THEN
                    IF "BOSA Account No"='' THEN
                    ERROR('Please specify the Bosa Account.');
                    //TESTFIELD("BOSA Account No");
                    //TESTFIELD("Employer Code");
                    */

                    /*IF "Global Dimension 2 Code" = '' THEN
                    ERROR('Please specify the branch.');
                     */
                    if "Application Status" = "application status"::Converted then
                        Error('Application has already been converted.');

                    if ("Account Type" = 'SAVINGS') then begin
                        Nok.Reset;
                        Nok.SetRange(Nok."Account No", "No.");
                        /*IF Nok.FIND('-') = FALSE THEN BEGIN
                        ERROR('Next of Kin have not been specified.');
                        END;*/

                    end;


                    if Confirm('Are you sure you want to approve & create this account', true) = false then
                        exit;


                    "Application Status" := "application status"::Converted;
                    Modify;



                    BranchC := '';
                    IncrementNo := '';
                    /*
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE(DimensionValue.Code,"Global Dimension 2 Code");
                    IF DimensionValue.FIND('-') THEN
                    BranchC:=DimensionValue."Account Code";
                    IncrementNo:=INCSTR(DimensionValue."No. Series");
                    
                    DimensionValue."No. Series":=IncrementNo;
                    DimensionValue.MODIFY;
                    */

                    if AccoutTypes.Get("Account Type") then begin
                        if AccoutTypes."Fixed Deposit" = true then begin
                            TestField("Savings Account No.");
                            //TESTFIELD("Maturity Type");
                            //TESTFIELD("Fixed Deposit Type");
                        end;



                        //Based on BOSA
                        /*
                        IF (AccoutTypes.Code = 'CHILDREN') OR (AccoutTypes.Code = 'FIXED') THEN BEGIN
                        IF  "Kin No" = '' THEN
                          AcctNo:=AccoutTypes."Account No Prefix" + '-' + BranchC + '-' + PADSTR("BOSA Account No",6,'0') + '-' + AccoutTypes."Ending Series
                        "
                        ELSE
                        AcctNo:=AccoutTypes."Account No Prefix" + '-' + BranchC + '-' + PADSTR("BOSA Account No",6,'0') + '-' + "Kin No";
                        END ELSE BEGIN
                          AcctNo:=AccoutTypes."Account No Prefix" + '-' + BranchC + '-' + PADSTR("BOSA Account No",6,'0') + '-' + AccoutTypes."Ending Series
                        ";
                        END;
                        */
                        //Based on BOSA
                        ///////
                        /*
                        IF "Parent Account No." = '' THEN BEGIN
                        IF DimensionValue.GET('BRANCH',"Global Dimension 2 Code") THEN BEGIN
                        //DimensionValue.TESTFIELD(DimensionValue."Account Code");
                        //AcctNo:=AccoutTypes."Account No Prefix" + '-' + DimensionValue."Account Code" + '-' + DimensionValue."No. Series"
                        // + '-' + AccoutTypes."Ending Series";
                        //AcctNo:=AccoutTypes."Account No Prefix" + '-' + INCSTR(DimensionValue."No. Series")
                         //+ '-' + AccoutTypes."Ending Series";


                        IF (AccoutTypes."Use Savings Account Number" = TRUE)  THEN BEGIN
                        TESTFIELD("Savings Account No.");
                        AcctNo:=AccoutTypes."Account No Prefix" + COPYSTR("Savings Account No.",4)
                        END ELSE
                        //DimensionValue."No. Series":=INCSTR(DimensionValue."No. Series");
                        //DimensionValue.MODIFY;
                        END;

                        END ELSE BEGIN
                        TESTFIELD("Kin No");
                        AcctNo:=COPYSTR("Parent Account No.",1,14) + "Kin No";
                        END;
                        IF AccoutTypes."Fixed Deposit" = TRUE THEN BEGIN
                        IF "Kin No" <> '' THEN
                        AcctNo:=COPYSTR(AcctNo,1,14) + "Kin No";
                        END;
                        ///////

                        */
                        Accounts.Init;
                        //Accounts."No.":=AcctNo;
                        Accounts."No." := "No.";
                        AcctNo := "No.";
                        Accounts."Date of Birth" := "Date of Birth";
                        Accounts.Name := Name;
                        Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                        Accounts."Debtor Type" := "Debtor Type";
                        if "Micro Single" = true then
                            Accounts."Group Account" := false
                        else
                            if "Micro Group" = true then
                                Accounts."Group Account" := false;
                        Accounts."Personal No." := "Staff No";
                        Accounts."ID No." := "ID No.";
                        Accounts."Mobile Phone No" := "Mobile Phone No";
                        Accounts."Registration Date" := "Registration Date";
                        //Accounts."Marital Status":="Marital Status";
                        Accounts."BOSA Account No" := "BOSA Account No";
                        Accounts.Picture := Picture;
                        Accounts.Signature := Signature;
                        Accounts."Passport No." := "Passport No.";
                        Accounts."Employer Code" := "Employer Code";
                        Accounts.Status := Accounts.Status::New;
                        Accounts."Account Type" := "Account Type";
                        Accounts."Account Category" := "Account Category";
                        Accounts."Date of Birth" := "Date of Birth";
                        Accounts."Global Dimension 1 Code" := 'FOSA';
                        Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        Accounts.Address := Address;
                        Accounts."Address 2" := "Address 2";
                        Accounts.City := City;
                        Accounts."Phone No." := "Phone No.";
                        Accounts."Telex No." := "Telex No.";
                        Accounts."Post Code" := "Post Code";
                        Accounts.County := County;
                        Accounts."E-Mail" := "E-Mail";
                        Accounts."Home Page" := "Home Page";
                        Accounts."Registration Date" := Today;
                        //Accounts.Status:=Status::New;
                        Accounts.Status := Status::Open;
                        Accounts.Section := Section;
                        Accounts."Home Address" := "Home Address";
                        Accounts.District := District;
                        Accounts.Location := Location;
                        Accounts."Sub-Location" := "Sub-Location";
                        Accounts."Savings Account No." := "Savings Account No.";
                        //Accounts."Signing Instructions":="Signing Instructions";
                        Accounts."Fixed Deposit Type" := "Fixed Deposit Type";
                        Accounts."FD Maturity Date" := "FD Maturity Date";
                        Accounts."Registration Date" := Today;
                        Accounts."Monthly Contribution" := "Monthly Contribution";
                        Accounts."Formation/Province" := "Formation/Province";
                        Accounts."Division/Department" := "Division/Department";
                        Accounts."Station/Sections" := "Station/Sections";
                        Accounts."Force No." := "Force No.";
                        Accounts."Vendor Posting Group" := "Account Type";
                        Accounts.Insert;

                    end;


                    Accounts.Reset;
                    if Accounts.Get(AcctNo) then begin
                        Accounts.Validate(Accounts.Name);
                        Accounts.Validate(Accounts."Account Type");
                        Accounts.Validate(Accounts."Global Dimension 1 Code");
                        Accounts.Validate(Accounts."Global Dimension 2 Code");
                        Accounts.Modify;

                        //Update BOSA with FOSA Account
                        if ("Account Type" = 'ORDINARY') then begin
                            if Cust.Get("BOSA Account No") then begin
                                Cust."FOSA Account No." := AcctNo;
                                Cust."FOSA Account" := AcctNo;
                                Cust.Modify;
                            end;
                        end;

                    end;

                    NextOfKinApp.Reset;
                    NextOfKinApp.SetRange(NextOfKinApp."Account No", "No.");
                    if NextOfKinApp.Find('-') then begin
                        repeat
                            NextOfKin.Init;
                            //NextOfKin."Account No":=AcctNo;
                            NextOfKin."Account No" := "No.";

                            NextOfKin.Name := NextOfKinApp.Name;
                            NextOfKin.Relationship := NextOfKinApp.Relationship;
                            NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                            NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                            NextOfKin.Address := NextOfKinApp.Address;
                            NextOfKin.Telephone := NextOfKinApp.Telephone;
                        /*NextOfKin.Fax:=NextOfKinApp.Fax;
                        NextOfKin.Email:=NextOfKinApp.Email;
                        NextOfKin."ID No.":=NextOfKinApp."ID No.";
                        NextOfKin."%Allocation":=NextOfKinApp."%Allocation";
                        NextOfKin.INSERT;*/

                        until NextOfKinApp.Next = 0;
                    end;

                    AccountSignApp.Reset;
                    AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
                    if AccountSignApp.Find('-') then begin
                        repeat
                            AccountSign.Init;
                            AccountSign."Account No" := AcctNo;
                            AccountSign.Names := AccountSignApp.Names;
                            AccountSign."Date Of Birth" := AccountSignApp."Date Of Birth";
                            AccountSign."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                            AccountSign."ID No." := AccountSignApp."ID No.";
                            AccountSign.Signatory := AccountSignApp.Signatory;
                            AccountSign."Must Sign" := AccountSignApp."Must Sign";
                            AccountSign."Must be Present" := AccountSignApp."Must be Present";
                            AccountSign.Picture := AccountSignApp.Picture;
                            AccountSign.Signature := AccountSignApp.Signature;
                            AccountSign."Expiry Date" := AccountSignApp."Expiry Date";
                            AccountSign.Insert;

                        until AccountSignApp.Next = 0;
                    end;


                    Message('Account approved & created successfully.');

                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if "Application Status" = "application status"::Converted then
                        Error('Application has already been converted.');

                    if Confirm('Are you sure you want to reject this application', true) = true then begin
                        "Application Status" := "application status"::Rejected;
                        Modify;
                    end;
                end;
            }
            group(Approvals)
            {
                action(Create)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Product';
                    Enabled = EnableCreateMember;
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        //-----Check Mandatory Fields---------
                        TestField("Employer Code");
                        TestField("Account Type");
                        TestField("ID No.");
                        TestField("Staff No");
                        TestField("BOSA Account No");
                        TestField("Date of Birth");
                        TestField("Global Dimension 2 Code");
                        if "Global Dimension 2 Code" = '' then
                            Error('Please specify the branch.');

                        //-----End Check Mandatory Fields---------

                        //----Check If account Already Exists------
                        Acc.Reset;
                        Acc.SetRange(Acc."ID No.", "ID No.");
                        Acc.SetRange(Acc."Account Type", "Account Type");
                        Acc.SetRange(Acc.Status, Acc.Status::Active);
                        if Acc.Find('-') then
                            Error('Account already exists. %1', Acc."No.");
                        //----End Check If account Already Exists------


                        //---Checkfields If Fixed Deposit------------
                        if AccoutTypes.Get("Account Type") then begin
                            if AccoutTypes."Fixed Deposit" = true then begin
                                TestField("Savings Account No.");
                                //TESTFIELD("Maturity Type");
                                //TESTFIELD("Fixed Deposit Type");
                            end;
                            //---End Checkfields If Fixed Deposit------------

                            if "Application Status" = "application status"::Converted then
                                Error('Application has already been converted.');


                            /*
                            Approvalusers.RESET;
                            Approvalusers.SETRANGE(Approvalusers."User ID",USERID);
                            Approvalusers.SETRANGE(Approvalusers."Function",Approvalusers."Function"::"Account Opening");
                            IF Approvalusers.FIND('-') = FALSE THEN
                            IF Approvalusers."Function"<> Approvalusers."Function"::"Account Opening" THEN
                            ERROR('You do not have permissions to open an Account.');
                            */


                            if Confirm('Are you sure you want to create this account?', true) = false then
                                exit;
                            "Application Status" := "application status"::Converted;
                            "Registration Date" := Today;
                            Modify;

                            //--Assign Account Nos Based On The Product Type-----
                            //FOSA A/C FORMAT =PREFIX-MEMBERNO-PRODUCTCODE
                            if AccoutTypes.Get("Account Type") then
                                AcctNo := AccoutTypes."Account No Prefix" + '-' + "BOSA Account No" + '-' + AccoutTypes."Product Code";

                            //---Create Account on Vendor Table----
                            Accounts.Init;
                            Accounts."No." := AcctNo;
                            Accounts."Date of Birth" := "Date of Birth";
                            Accounts.Name := Name;
                            Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                            Accounts."Personal No." := "Staff No";
                            Accounts."ID No." := "ID No.";
                            Accounts."Mobile Phone No" := "Mobile Phone No";
                            Accounts."Registration Date" := "Registration Date";
                            Accounts."Employer Code" := "Employer Code";
                            Accounts."BOSA Account No" := "BOSA Account No";
                            Accounts.Picture := Picture;
                            Accounts.Signature := Signature;
                            Accounts."Passport No." := "Passport No.";
                            Accounts.Status := Accounts.Status::Active;
                            Accounts."Account Type" := "Account Type";
                            Accounts."Account Category" := "Account Category";
                            Accounts."Date of Birth" := "Date of Birth";
                            Accounts."Global Dimension 1 Code" := 'FOSA';
                            Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                            Accounts.Address := Address;
                            Accounts."Address 2" := "Address 2";
                            Accounts.City := City;
                            Accounts."Phone No." := "Phone No.";
                            Accounts."Telex No." := "Telex No.";
                            Accounts."Post Code" := "Post Code";
                            Accounts.County := County;
                            Accounts."E-Mail" := "E-Mail";
                            Accounts."Home Page" := "Home Page";
                            Accounts."Registration Date" := Today;
                            Accounts.Status := Status::Approved;
                            Accounts.Section := Section;
                            Accounts."Home Address" := "Home Address";
                            Accounts.District := District;
                            Accounts.Location := Location;
                            Accounts."Sub-Location" := "Sub-Location";
                            Accounts."Savings Account No." := "Savings Account No.";
                            Accounts."Registration Date" := Today;
                            Accounts."Vendor Posting Group" := "Vendor Posting Group";
                            Accounts.Insert;
                            "Application Status" := "application status"::Converted;
                        end;
                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                        AccoutTypes.Modify;

                        Accounts.Reset;
                        if Accounts.Get(AcctNo) then begin
                            Accounts.Validate(Accounts.Name);
                            Accounts.Validate(Accounts."Account Type");
                            Accounts.Validate(Accounts."Global Dimension 1 Code");
                            Accounts.Validate(Accounts."Global Dimension 2 Code");
                            Accounts.Modify;

                            //---Update BOSA with FOSA Account----
                            if ("Account Type" = 'ORDINARY') then begin
                                if Cust.Get("BOSA Account No") then begin
                                    Cust."FOSA Account No." := AcctNo;
                                    Cust."FOSA Account" := AcctNo;
                                    Cust.Modify;
                                end;
                            end;
                            //---End Update BOSA with FOSA Account----
                        end;

                        //----Insert Nominee Information------
                        NextOfKinApp.Reset;
                        NextOfKinApp.SetRange(NextOfKinApp."Account No", "No.");
                        if NextOfKinApp.Find('-') then begin
                            repeat
                                NextOfKin.Init;
                                NextOfKin."Account No" := "No.";
                                NextOfKin.Name := NextOfKinApp.Name;
                                NextOfKin.Relationship := NextOfKinApp.Relationship;
                                NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                                NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                                NextOfKin.Address := NextOfKinApp.Address;
                                NextOfKin.Telephone := NextOfKinApp.Telephone;
                                //NextOfKin.Fax:=NextOfKinApp.Fax;
                                NextOfKin.Email := NextOfKinApp.Email;
                                NextOfKin."ID No." := NextOfKinApp."ID No.";
                                NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
                                NextOfKin.Insert;
                            until NextOfKinApp.Next = 0;
                        end;
                        //----End Insert Nominee Information------

                        //Insert Account Signatories------
                        AccountSignApp.Reset;
                        AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
                        if AccountSignApp.Find('-') then begin
                            repeat
                                AccountSign.Init;
                                AccountSign."Account No" := AcctNo;
                                AccountSign.Names := AccountSignApp.Names;
                                AccountSign."Date Of Birth" := AccountSignApp."Date Of Birth";
                                AccountSign."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                                AccountSign."ID No." := AccountSignApp."ID No.";
                                AccountSign.Signatory := AccountSignApp.Signatory;
                                AccountSign."Must Sign" := AccountSignApp."Must Sign";
                                AccountSign."Must be Present" := AccountSignApp."Must be Present";
                                AccountSign.Picture := AccountSignApp.Picture;
                                AccountSign.Signature := AccountSignApp.Signature;
                                AccountSign."Expiry Date" := AccountSignApp."Expiry Date";
                                AccountSign.Insert;
                                "Application Status" := "application status"::Converted;
                            until AccountSignApp.Next = 0;
                        end;
                        //Insert Account Signatories------

                        //--Send Confirmation Sms to The Member------
                        SFactory.FnSendSMS('FOSA ACC', 'Your Account successfully created.Account No=' + AcctNo, AcctNo, "Mobile Phone No");
                        Message('You have successfully created a %1 Product, A/C No=%2. Member will be notified via SMS', "Account Type", AcctNo);

                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Suite;
                    Caption = 'Send Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Confirm('Are you sure you want to send Approval request for this record?', true) = false then
                            exit;
                        if "Micro Group" <> true then begin
                            TestField("Account Type");
                            TestField("ID No.");
                            //TESTFIELD("Staff No");
                            //TESTFIELD("BOSA Account No");
                            TestField("Date of Birth");
                            TestField("Global Dimension 2 Code");
                        end;

                        if ("Micro Single" = true) then begin
                            TestField("Group Code");
                            TestField("Global Dimension 2 Code");
                            TestField("Account Type");
                        end;

                        if ("Micro Single" <> true) and ("Micro Group" <> true) then
                            if "Account Type" = 'SAVINGS' then begin
                                TestField("BOSA Account No");
                            end;

                        if Status <> Status::Open then
                            Error(Text001);
                        //IF ApprovalsMgmt.CheckFAccountApplicationApprovalsWorkflowEnabled(Rec) THEN
                        //ApprovalsMgmt.OnSendFAccountApplicationForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Suite;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Confirm('Are you sure you want cancel Approval request for this record?', true) = false then
                            exit;
                        //Approvalmgt.OnCancelFAccountApplicationApprovalRequest(Rec);
                    end;
                }
                action(Approval)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::ProductApplication;
                        ApprovalEntries.Setfilters(Database::"FOSA Account Applicat. Details", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        EnableCreateMember := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec.Status = Status::Approved) then
            EnableCreateMember := true;
    end;

    trigger OnOpenPage()
    begin
        ObjUserSetup.Reset;
        ObjUserSetup.SetRange("User ID", UserId);
        if ObjUserSetup.Find('-') then begin
            if ObjUserSetup."Approval Administrator" <> true then
                SetRange("Created By", UserId);
        end;
    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        PictureExists: Boolean;
        AccoutTypes: Record "Account Types-Saving Products";
        Accounts: Record Vendor;
        AcctNo: Code[50];
        DimensionValue: Record "Dimension Value";
        NextOfKin: Record "FOSA Account NOK Details";
        NextOfKinApp: Record "FOSA Account App Kin Details";
        AccountSign: Record "FOSA Account Sign. Details";
        AccountSignApp: Record "FOSA Account App Signatories";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "FOSA Account App Kin Details";
        Cust: Record "Member Register";
        NOKBOSA: Record "FOSA Account NOK Details";
        BranchC: Code[20];
        DimensionV: Record "Dimension Value";
        IncrementNo: Code[20];
        MicSingle: Boolean;
        MicGroup: Boolean;
        BosaAcnt: Boolean;
        EmailEdiatble: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions;
        SaccoSetup: Record "Sacco No. Series";
        MicroGroupCode: Boolean;
        Vendor: Record Vendor;
        NameEditable: Boolean;
        NoEditable: Boolean;
        AddressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        VendorPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        MaritalstatusEditable: Boolean;
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        EmployerCodeEditable: Boolean;
        DOBEditable: Boolean;
        StaffNoEditable: Boolean;
        GenderEditable: Boolean;
        MonthlyContributionEdit: Boolean;
        PostCodeEditable: Boolean;
        CityEditable: Boolean;
        RecruitedEditable: Boolean;
        ContactPEditable: Boolean;
        ContactPRelationEditable: Boolean;
        ContactPOccupationEditable: Boolean;
        ContactPPhoneEditable: Boolean;
        Accountype: Boolean;
        Approvalusers: Record "Status Change Permision";
        Member: Record "Member Register";
        IncrementNoF: Code[20];
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        ParentEditable: Boolean;
        SavingsEditable: Boolean;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        SFactory: Codeunit "SURESTEP Factory.";
        ObjUserSetup: Record "User Setup";
}

