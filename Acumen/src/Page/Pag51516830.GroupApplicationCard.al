#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516830 "Group Application Card"
{
    // //Cust.VALIDATE(Cust."ID No.");
    // //CLEAR(Picture);
    // //CLEAR(Signature);
    // //MODIFY;

    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";

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
                    Visible = false;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Account Category';
                    Editable = false;
                    Enabled = true;

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
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Business Account Type';
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Group Account"; "Group Account")
                {
                    ApplicationArea = Basic;
                    Editable = GroupAccEditable;

                    trigger OnValidate()
                    begin
                        TestField("Account Category", "account category"::Group);
                    end;
                }
                field("FOSA Account No."; "FOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Visible = FosaAccNoVisible;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                    Caption = 'Group/Cooperate Logo';
                }
                field("Personal No"; "Personal No")
                {
                    ApplicationArea = Basic;
                    Editable = StaffNoEditable;
                    Visible = PayrollVisible;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Certificate No.';
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                    Visible = true;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = RegistrationDateEdit;
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = PassEditable;
                    Visible = PassVisible;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Editable = AddressEditable;
                }
                field("Postal Code"; "Postal Code")
                {
                    ApplicationArea = Basic;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                    Caption = 'City';
                    Editable = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = CountryEditable;
                }
                field("Contact Person No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Contact Person No.';
                    Editable = PhoneEditable;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = PhoneEditable;
                    Visible = false;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = MaritalstatusEditable;
                    Visible = MaritalVisible;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    Editable = GenderEditable;
                    Visible = GenderVisible;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = DOBEditable;
                    Visible = DoBVisible;
                }
                field("E-Mail (Personal)"; "E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Email';
                    Editable = EmailEdiatble;
                    ShowMandatory = false;
                }
                field("Village/Residence"; "Village/Residence")
                {
                    ApplicationArea = Basic;
                    Editable = VillageResidence;
                    ShowMandatory = true;
                }
                field("Employer Type"; "Employer Type")
                {
                    ApplicationArea = Basic;
                }
                field("No. Of Male Members"; "No. Of Male Members")
                {
                    ApplicationArea = Basic;
                }
                field("No. Of Female Members"; "No. Of Female Members")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Days"; "Meeting Days")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Meeting Venue"; "Meeting Venue")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Meeting Time"; "Meeting Time")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
            }
            group("Other Information")
            {
                Caption = 'Other Information';
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerEditable;
                    Visible = false;
                }
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = Basic;
                    Editable = BankAEditable;
                    HideValue = true;
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
                    Visible = WstationVisible;
                }
                field(Department; Department)
                {
                    ApplicationArea = Basic;
                    Editable = DeptEditable;
                    Visible = DeptVisible;
                }
                field(Section; Section)
                {
                    ApplicationArea = Basic;
                    Editable = SectionEditable;
                    Visible = SecVisible;
                }
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = OccupationEditable;
                    Visible = OccpVisible;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Group Code"; "Micro Group Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Group Code';
                    Editable = false;
                    Visible = false;
                }
                field("FOSA Account Type"; "FOSA Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field("Sales Code"; "Sales Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'MC Officer';
                }
                field("Salesperson Name"; "Salesperson Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'MC Officer Name';
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000030; "Member Picture-App")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                Editable = MobileEditable;
                Enabled = MobileEditable;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000029; "Member Signature-App")
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
                action("Next of Kin BOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nominee';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Members Nominee Details List";
                    RunPageLink = "Account No" = field("No.");
                    Visible = false;
                }
                action("Next of Kin Benevolent")
                {
                    ApplicationArea = Basic;
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
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
                    RunPageOnRec = false;
                }
                action("Group Members")
                {
                    ApplicationArea = Basic;
                    Image = ListPage;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "MC Group List-Members";
                    RunPageLink = "Document No. Filter" = field("No.");
                }
                group(Approvals)
                {
                    Caption = '-';
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Status <> Status::Open then
                            Error('This application Should be Open');
                        //SendEmail();
                        //IF ApprovalsMgmt.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) THEN
                        //ApprovalsMgmt.OnSendMembershipApplicationForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.//OnCancelMembershipApplicationApprovalRequest(Rec);
                    end;
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::MembershipApplication;
                        ApprovalEntries.Setfilters(Database::"Membership Applications", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                separator(Action7)
                {
                    Caption = '       -';
                }
                action("Create Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Account';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        if Status <> Status::Approved then
                            Error('This application has not been approved');


                        if Confirm('Are you sure you want to Create Account Application?', false) = true then begin

                            GenSetUp.Get;


                            if "ID No." <> '' then begin
                                Cust.Reset;
                                Cust.SetRange(Cust."ID No.", "ID No.");
                                //Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::MicroFinance);
                                if Cust.Find('-') then begin
                                    if Cust."No." <> "No." then
                                        Error('This Group Account has Already been Created');
                                end;
                            end;

                            //****
                            Dimen.Reset;
                            Dimen.SetRange(Dimen.Code, "Global Dimension 2 Code");
                            if Dimen.Find('-') then begin
                                if "No." = '' then begin
                                    Dimen.TestField(Dimen."No. Series");
                                    NoSeriesMgt.InitSeries(Dimen."No. Series", xRec."No. Series", 0D, "No.", "No. Series");

                                end;
                            end;



                            SaccoNoSeries.Get();
                            AcctNo := SaccoNoSeries."Microfinance Last No Used";
                            Cust."No." := AcctNo;
                            Cust."Business Loan Officer" := "Salesperson Name";
                            Cust.Name := UpperCase(Name);
                            Cust.Address := Address;
                            Cust.City := City;
                            Cust.County := City;
                            Cust."Country/Region Code" := "Country/Region Code";
                            Cust."Phone No." := "Phone No.";
                            Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                            Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                            Cust."Customer Posting Group" := "Customer Posting Group";
                            Cust."Registration Date" := Today;//Registration date must be the day the application is converted to a member and not day of capture.
                            Cust.Status := Cust.Status::Active;
                            Cust."Employer Code" := "Employer Code";
                            Cust."Date of Birth" := "Date of Birth";
                            Cust."Station/Department" := "Station/Department";
                            Cust."E-Mail" := "E-Mail (Personal)";
                            Cust.Location := Location;
                            Cust."Office Branch" := "Office Branch";
                            Cust.Department := Department;
                            Cust.Occupation := Format(Occupation);
                            Cust.Designation := Designation;
                            Cust."Bank Code" := "Bank Code";
                            Cust."Bank Account No." := "Bank Account No";
                            Cust."Sub-Location" := "Sub-Location";
                            Cust.District := District;
                            Cust."ID No." := "ID No.";
                            Cust."Passport No." := "Passport No.";
                            Cust."Business Loan Officer" := "Salesperson Name";
                            Cust."Mobile Phone No" := "Mobile Phone No";
                            Cust."Marital Status" := "Marital Status";
                            Cust."Customer Type" := Cust."customer type"::Member;
                            Cust.Gender := Gender;
                            Cust."Monthly Contribution" := "Monthly Contribution";
                            Cust."Account Category" := "Account Category";
                            Cust."Contact Person" := "Contact Person";
                            Cust."Contact Person Phone" := "Contact Person Phone";
                            Cust."ContactPerson Relation" := "ContactPerson Relation";
                            Cust."Recruited By" := "Recruited By";
                            Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                            Cust."Village/Residence" := "Village/Residence";
                            Cust."Group Account" := "Group Account";
                            Cust."Group Account No" := Cust."No.";
                            Cust."Group Account Name" := Cust.Name;
                            Cust."Recruited By" := "Recruited By";
                            Cust."Business Loan Officer" := "Salesperson Name";
                            Cust.Insert(true);
                            SaccoNoSeries."Microfinance Last No Used" := IncStr(SaccoNoSeries."Microfinance Last No Used");
                            SaccoNoSeries.Modify;
                            BOSAACC := AcctNo;
                            Message('Microfinance Account No. is  %1', BOSAACC);
                            Cust.Reset;
                            if Cust.Get(BOSAACC) then begin
                                Cust.Validate(Cust.Name);
                                Cust.Validate(Cust."Global Dimension 1 Code");
                                Cust.Validate(Cust."Global Dimension 2 Code");
                                Cust."Group Account No" := Cust."No.";
                                Cust.Modify;
                            end;


                            //Group Members
                            GroupMembersApp.Reset;
                            GroupMembersApp.SetRange(GroupMembersApp.No, "No.");
                            if GroupMembersApp.Find('-') then begin
                                repeat
                                    GroupMembers.Init;
                                    GroupMembers.No := BOSAACC;
                                    GroupMembers."Member Name" := GroupMembersApp."Member Name";
                                    GroupMembers."Member ID No" := GroupMembersApp."Member ID No";
                                    GroupMembers."Member Designation" := GroupMembersApp."Member Designation";
                                    GroupMembers."Member Phone No" := GroupMembersApp."Member Phone No";
                                    GroupMembers.Insert;
                                until GroupMembersApp.Next = 0;
                            end;

                            AccountSignApp.Reset;
                            AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
                            if AccountSignApp.Find('-') then begin
                                //AccountSignApp.CALCFIELDS(AccountSignApp.Picture,AccountSignApp.Signature);
                                repeat

                                    AccSignatories.Init;

                                    AccSignatories."Account No" := AcctNo;
                                    AccSignatories."BOSA No." := AccountSignApp."BOSA No.";
                                    AccSignatories.Names := AccountSignApp.Names;
                                    AccSignatories."Date Of Birth" := AccountSignApp."Date Of Birth";
                                    AccSignatories."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                                    AccSignatories."ID No." := AccountSignApp."ID No.";
                                    AccSignatories.Signatory := AccountSignApp.Signatory;
                                    AccSignatories."Must Sign" := AccountSignApp."Must Sign";
                                    AccSignatories."Must be Present" := AccountSignApp."Must be Present";
                                    AccSignatories.Picture := AccountSignApp.Picture;
                                    AccSignatories.Signature := AccountSignApp.Signature;
                                    AccSignatories."Expiry Date" := AccountSignApp."Expiry Date";
                                    //AccSignatories."Mobile Phone No.":=AccountSignApp."Mobile Phone No.";


                                    //Update Group Accounts
                                    Cust.Reset;
                                    Cust.SetRange(Cust."No.", AccountSignApp."BOSA No.");
                                    if Cust.FindSet then begin
                                        Cust."Group Account No" := AcctNo;
                                        Cust.Modify;
                                    end;


                                    AccSignatories.Insert;
                                until AccountSignApp.Next = 0;
                            end;



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
                                        // SMSMessage."Account No":="Payroll/Staff No";
                                        SMSMessage."Account No" := "Payroll/Staff No2";
                                        SMSMessage."Date Entered" := Today;
                                        SMSMessage."Time Entered" := Time;
                                        SMSMessage.Source := 'MEMBERACCOUNT';
                                        SMSMessage."Entered By" := UserId;
                                        SMSMessage."System Created Entry" := true;
                                        SMSMessage."Document No" := "No.";
                                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                                        SMSMessage."SMS Message" := Name + ' has been succesfully created.  SACCO';
                                        SMSMessage."Telephone No" := AccountSignatoriesApp."Mobile Phone No";
                                        SMSMessage.Insert;

                                        AccountSignatoriesApp."Send SMS" := true;
                                        AccountSignatoriesApp.Modify;

                                    until AccountSignatoriesApp.Next = 0;
                                end;
                            end;

                            /*GenSetUp."Business Loans A/c Format":=INCSTR(GenSetUp."Business Loans A/c Format");
                            GenSetUp.MODIFY;
                            BOSAACC:=Cust."No.";

                                    IF DValues.FIND('-') THEN BEGIN
                                    BCode:=DValues."Branch Code";
                                    END;

                                    AccoutTypes.RESET;
                                    AccoutTypes.SETRANGE(AccoutTypes.Code,'MCJSAVING');
                                    IF AccoutTypes.FIND('-') THEN BEGIN
                                    LastNoUsed:=AccountTypes."Last No Used";
                                      AcctNo:=AccoutTypes."Account No Prefix"+'-'+BCode+'-'+AccoutTypes."Product Code"+'-'+AccoutTypes."Last No Used";
                                    END;


                                    SavProducts.RESET;
                                    SavProducts.SETRANGE(SavProducts.Code,'MCJSAVING');
                                    IF SavProducts.FIND('-') THEN BEGIN
                                    LastNoUsed:=SavProducts."Last No Used";*/

                            Accounts.Init;
                            Accounts."No." := AcctNo;
                            Accounts."Date of Birth" := "Date of Birth";
                            Accounts.Name := Name;
                            Accounts."Creditor Type" := Accounts."creditor type"::Account;
                            Accounts."Personal No." := "Personal No";
                            Accounts."ID No." := "ID No.";
                            Accounts."Mobile Phone No" := "Mobile Phone No";
                            Accounts."Registration Date" := "Registration Date";
                            Accounts."Post Code" := "Postal Code";
                            Accounts.County := City;
                            Accounts."BOSA Account No" := Cust."No.";
                            Accounts.Picture := Picture;
                            Accounts.Signature := Signature;
                            Accounts."Passport No." := "Passport No.";
                            Accounts."Employer Code" := "Employer Code";
                            Accounts.Status := Accounts.Status::New;
                            /*IF (ProductsApp.Product='') THEN BEGIN
                            Accounts."Account Type":='101'
                            END ELSE*/
                            Accounts."Account Type" := 'SAVINGS';
                            // Accounts."Account Type":=ProductsApp.Product;
                            Accounts."Date of Birth" := "Date of Birth";
                            Accounts."Global Dimension 1 Code" := 'MICRO';
                            Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                            Accounts.Address := Address;
                            Accounts."Vendor Posting Group" := 'SAVINGS';
                            Accounts.Validate(Accounts."Account Type");
                            Accounts."Account Type" := AccountTypes.Code;
                            if "Account Category" = "account category"::Corporate then begin
                                Accounts."Account Category" := Accounts."account category"::Corporate
                            end else
                                Accounts."Account Category" := "Account Category";
                            Accounts."Address 2" := "Address 2";
                            Accounts."Phone No." := "Phone No.";
                            Accounts."Registration Date" := Today;
                            Accounts.Status := Accounts.Status::Active;
                            Accounts.Section := Section;
                            Accounts."Home Address" := "Home Address";
                            Accounts.District := District;
                            Accounts.Location := Location;
                            Accounts."Sub-Location" := "Sub-Location";
                            Accounts."Registration Date" := Today;
                            Accounts."Monthly Contribution" := "Monthly Contribution";
                            Accounts."E-Mail" := "E-Mail (Personal)";
                            Accounts."Group/Corporate Trade" := "Group/Corporate Trade";
                            Accounts."Name of the Group/Corporate" := "Name of the Group/Corporate";
                            Accounts."Certificate No" := "Certificate No";
                            Accounts."Registration Date" := "Registration Date";
                            Accounts."Signing Instructions" := "Signing Instructions";


                            //*************To sort for Joint Accounts****************
                            Accounts."Name 2" := "Name 2";
                            Accounts."Address3-Joint" := Address3;
                            Accounts."Postal Code 2" := "Postal Code 2";
                            Accounts."Home Postal Code2" := "Home Postal Code2";
                            Accounts."Home Town2" := "Home Town2";
                            Accounts."ID No.2" := "ID No.2";
                            Accounts."Passport 2" := "Passport 2";
                            Accounts.Gender2 := Gender2;
                            Accounts."Marital Status2" := "Marital Status2";
                            Accounts."E-Mail (Personal2)" := "E-Mail (Personal2)";
                            Accounts."Employer Code2" := "Employer Code2";
                            Accounts."Employer Name2" := "Employer Name2";
                            Accounts."Picture 2" := "Picture 2";
                            Accounts."Signature  2" := "Signature  2";
                            Accounts."Member's Residence" := "Member's Residence";
                            Accounts."Joint Account Name" := "First Name" + ' ' + "First Name2";


                            Accounts."Name 3" := "Name 3";
                            Accounts."Address3-Joint" := Address4;
                            Accounts."Postal Code 3" := "Postal Code 3";
                            Accounts."Home Postal Code3" := "Home Postal Code3";
                            Accounts."Home Town3" := "Home Town3";
                            Accounts."ID No.3" := "ID No.3";
                            Accounts."Passport 3" := "Passport 3";
                            Accounts.Gender3 := Gender3;
                            Accounts."Marital Status3" := "Marital Status3";
                            Accounts."E-Mail (Personal3)" := "E-Mail (Personal3)";
                            Accounts."Employer Code3" := "Employer Code3";
                            Accounts."Employer Name3" := "Employer Name3";
                            Accounts."Picture 3" := "Picture 3";
                            Accounts."Signature  3" := "Signature  3";
                            Accounts."Member Parish Name 3" := "Member Parish Name 3";
                            Accounts."Member Parish Name 3" := "Member Parish Name 3";
                            Accounts."Joint Account Name" := "First Name" + ' &' + "First Name2" + ' &' + "First Name3";

                            //************End to Sort for Joint Accounts*************
                            Accounts.Insert;


                            Accounts.Reset;
                            if Accounts.Get(AcctNo) then begin
                                Accounts.Validate(Accounts.Name);
                                Accounts.Validate(Accounts."Account Type");
                                Accounts.Modify;
                            end;
                            AccoutTypes.Reset;
                            AccoutTypes.SetRange(AccoutTypes.Code, 'SAVINGS');
                            if AccoutTypes.Find('-') then begin
                                AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                AccoutTypes.Modify;
                            end;

                            //Update BOSA with FOSA Account
                            if Cust.Get(AcctNo) then begin
                                Cust."FOSA Account No." := AcctNo;
                                Cust.Modify;
                            end;
                        end;
                        //Morris ***End Auto opening Fosa Account***///
                        /*
                       GenSetUp.GET();
                        Notification.CreateMessage('Dynamics NAV',GenSetUp."Sender Address","E-Mail (Personal)",'Member Acceptance Notification',
                                       'Member application '+ "No." + ' has been approved'
                                      + ' (Dynamics NAV ERP)',FALSE);
                       Notification.Send;
                         */
                        SendEmailAct();
                        //"Converted By":=USERID;
                        // MESSAGE('Account created successfully.');
                        // MESSAGE('The Group Account no is %1', Cust."No.");

                        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        //END;
                        Status := Status::Approved;
                        "Created By" := UserId;
                        Modify;

                        //Send SMS
                        GenSetUp.Get();
                        if GenSetUp."Send Membership Reg SMS" = true then
                            SURESTEPFactory.FnSendSMS('MCMEMBERAPP', 'Your Microfinance account has been successfully created ', Cust."No.", "Mobile Phone No");

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
    end;

    trigger OnInit()
    begin

        "Group Account" := true;
        "Account Category" := "account category"::Group;
        "Account Type" := "account type"::Group;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin


        "Responsibility Centre" := UserMgt.GetSalesFilter;
        /*
        IF MemApp.COUNT >0 THEN BEGIN
        ERROR(Text005);
        END;
        */

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GenSetUp.Get();
        "Customer Type" := "customer type"::Member;
        "Group Account" := true;
        "Account Category" := "account category"::Group;
        "Account Type" := "account type"::Group;
        "Customer Posting Group" := GenSetUp."Default Micro Credit Posting G";
        "Global Dimension 1 Code" := 'MICRO';
    end;

    trigger OnOpenPage()
    begin
        GenSetUp.Get();
        "Group Account" := true;
        "Account Category" := "account category"::Group;
        "Customer Posting Group" := GenSetUp."Default Micro Credit Posting G";
        "Global Dimension 1 Code" := 'MF';
        "Account Type" := "account type"::Group;

        if UserMgt.GetSalesFilter <> '' then begin
            FilterGroup(2);
            SetRange("Responsibility Centre", UserMgt.GetSalesFilter);
            FilterGroup(0);
        end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        Cust: Record Customer;
        Accounts: Record Vendor;
        AcctNo: Code[20];
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
        text001: label 'Status must be open';
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
        text003: label 'No of Signatories cannot be less/More than %1';
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
        Memb: Record Customer;
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
        GroupAccEditable: Boolean;
        AccTypeEditable: Boolean;
        AccountSignatoriesApp: Record "Member Account Signatories";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        MessageFailed: Boolean;
        MemApp: Record "Membership Applications";
        Text005: label 'There are still some incomplete Applications. Please utilise them first';
        Dimen: Record "Dimension Value";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        AccoutTypes: Record "Account Types-Saving Products";
        Saccosetup: Record "Sacco General Set-Up";
        BCode: Code[20];
        DValues: Record "Dimension Value";
        LastNoUsed: Code[20];
        SavProducts: Record "Account Types-Saving Products";
        GroupMembers: Record "Group Members";
        GroupMembersApp: Record "Group Members Applications";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions;
        ApprovalEntries: Page "Approval Entries";
        notifymail: Codeunit "SMTP Mail";
        SaccoNoSeries: Record "Sacco No. Series";
        EnableCreateMember: Boolean;
        OpenApprovalEntriesExist: Integer;
        EnabledApprovalWorkflowsExist: Boolean;
        SURESTEPFactory: Codeunit "SURESTEP Factory.";
        MobileEditable: Boolean;


    procedure UpdateControls()
    begin
        if Status = Status::Approved then begin
            NameEditable := false;
            GroupAccEditable := false;
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
            AccTypeEditable := false;
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
            GroupAccEditable := true;
            AccTypeEditable := true;
            MobileEditable := true;
        end;
        if (Status = Status::"Pending Approval") or (Status = Status::Rejected) then
            CurrPage.Editable := false;



    end;

    local procedure SendEmail()
    begin
        GenSetUp.Get;



        if GenSetUp."Auto Open FOSA Savings Acc." = true then begin



            notifymail.CreateMessage(' Nafaka sacco Ltd Membership', GenSetUp."Sender Address", "E-Mail (Personal)", 'You membership application was received',

                            'Your Group Application No is ' + "No." + ' Thank you for Nafaka sacco Ltd', false);



            notifymail.Send;



        end;
    end;

    local procedure SendEmailAct()
    begin
        /*GenSetUp.GET;
        
        
        
        IF GenSetUp."Send Email Notifications" = TRUE THEN BEGIN
        
        
        
        notifymail.CreateMessage(' Kenversity sacco Ltd Membership',GenSetUp."Sender Address","E-Mail (Personal)",'You Group application was received and approved',
        
                        'Your Membership no is '+ Cust."No." + ' Thank you for Kenversity sacco Ltd',FALSE);
        
        
        
        notifymail.Send;
        
        
        
        END;
        */

    end;
}

