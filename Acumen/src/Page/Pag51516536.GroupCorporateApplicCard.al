#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516536 "Group/Corporate Applic Card"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'General Info';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'No.';
                    Editable = false;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                    OptionCaption = 'Single,Joint,Corporate,Group,Parish,Church,Church Department';

                    trigger OnValidate()
                    begin
                        Joint2DetailsVisible := false;

                        if "Account Category" = "account category"::Joint then begin
                            Joint2DetailsVisible := true;
                        end;
                        if "Account Category" <> "account category"::Group then begin
                            NumberofMembersEditable := false
                        end else
                            NumberofMembersEditable := true;
                    end;
                }
                field("Name of the Group/Corporate"; "Name of the Group/Corporate")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                    ShowMandatory = true;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = EditableField;
                    ShowMandatory = true;
                }
                field("Postal Code"; "Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                }
                field(Town; Town)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = CountryEditable;
                }
                field("Date of Registration"; "Date of Registration")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("No of Members"; "No of Members")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                }
                field("Group/Corporate Trade"; "Group/Corporate Trade")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("Certificate No"; "Certificate No")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("KRA PIN"; "KRA PIN")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                    ShowMandatory = true;
                }
                field("Signing Instructions"; "Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                }
                field("Need a Cheque book"; "Need a Cheque book")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                }
                field("Application Category"; "Application Category")
                {
                    ApplicationArea = Basic;
                    Editable = AppCategoryEditable;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = CustPostingGroupEdit;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Contribution"; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
            group("Referee Details")
            {
                label(Control10)
                {
                    ApplicationArea = Basic;
                    Editable = ;
                }
                label(Control9)
                {
                    ApplicationArea = Basic;
                }
                label(Control8)
                {
                    ApplicationArea = Basic;
                }
                label(Control1)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Communication/Location Info")
            {
                Caption = 'Communication/Location Info';
                Editable = EditableField;
                field("Office Telephone No."; "Office Telephone No.")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                }
                field("Office Extension"; "Office Extension")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                }
                field("E-Mail (Personal)"; "E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = EmailEdiatble;
                    Enabled = EditableField;
                }
                field("Home Address"; "Home Address")
                {
                    ApplicationArea = Basic;
                }
                field("Home Postal Code"; "Home Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = HomeAddressPostalCodeEditable;
                }
                field("Home Town"; "Home Town")
                {
                    ApplicationArea = Basic;
                }
                field(County; County)
                {
                    ApplicationArea = Basic;
                }
                field(District; District)
                {
                    ApplicationArea = Basic;
                }
                field(Location; Location)
                {
                    ApplicationArea = Basic;
                }
                field("Sub-Location"; "Sub-Location")
                {
                    ApplicationArea = Basic;
                }
                field("Contact Person"; "Contact Person")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPEditable;
                    ShowMandatory = true;
                }
                field("Contact Person Phone"; "Contact Person Phone")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPPhoneEditable;
                    ShowMandatory = true;
                }
                field("ContactPerson Relation"; "ContactPerson Relation")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPRelationEditable;
                }
            }
            group("Trade Information")
            {
                Caption = 'Trade Information';
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                }
                field("Others Details"; "Others Details")
                {
                    ApplicationArea = Basic;
                    Editable = OthersEditable;
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
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Select Products")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Products";
                    RunPageLink = "Membership Applicaton No" = field("No.");
                }
                separator(Action6)
                {
                    Caption = '-';
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if "ID No." <> '' then begin
                            Cust.Reset;
                            Cust.SetRange(Cust."ID No.", "ID No.");
                            Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                            if Cust.Find('-') then begin
                                if (Cust."No." <> "No.") and ("Account Category" = "account category"::Single) then
                                    Error('Member has already been created');
                            end;
                        end;

                        //-------------------Check ID Or Passport---------------------------------------
                        // IF ("ID No."='') AND ("Passport No."='') THEN
                        //ERROR('You Must Specify Either ID or Passport No for the Applicant');
                        //-------------------Check ID Or Passport---------------------------------------


                        if ("Account Category" = "account category"::Single) then begin
                            TestField(Name);
                            TestField("ID No.");
                            TestField("Mobile Phone No");
                            TestField("Monthly Contribution");
                            //TESTFIELD("E-Mail (Personal)");
                            //TESTFIELD("Employer Code");
                            //TESTFIELD("Received 1 Copy Of ID");
                            //TESTFIELD("Copy of Current Payslip");
                            //TESTFIELD("Member Registration Fee Receiv");
                            //TESTFIELD("Copy of KRA Pin");
                            TestField("Customer Posting Group");
                            TestField("Global Dimension 1 Code");
                            TestField("Global Dimension 2 Code");
                        end else

                            if ("Account Category" = "account category"::Group) or ("Account Category" = "account category"::Corporate) then begin
                                TestField(Name);
                                //TESTFIELD("Registration No");
                                TestField("Contact Person");
                                TestField("Contact Person Phone");
                                TestField("Date of Registration");
                                TestField("Group/Corporate Trade");
                                TestField("Customer Posting Group");
                                TestField("Global Dimension 1 Code");
                                TestField("Global Dimension 2 Code");
                                TestField("Contact Person Phone");
                                TestField("Monthly Contribution");

                            end;

                        /*IF ("Account Category"="Account Category"::Single)OR ("Account Category"="Account Category"::Junior)OR ("Account Category"="Account Category"::Joint)  THEN BEGIN
                        NOkApp.RESET;
                        NOkApp.SETRANGE(NOkApp."Account No","No.");
                        IF NOkApp.FIND('-')=FALSE THEN BEGIN
                        ERROR('Please Insert Next 0f kin Information');
                        END;
                        END;*/

                        if ("Account Category" = "account category"::Group) or ("Account Category" = "account category"::Corporate) then begin
                            AccountSignApp.Reset;
                            AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
                            if AccountSignApp.Find('-') = false then begin
                                Error('Please insert Account Signatories');
                            end;
                        end;



                        if Status <> Status::Open then
                            Error(Text001);

                        //End allocate batch number
                        Doc_Type := Doc_type::"Account Opening";
                        Table_id := Database::"Membership Applications";
                        //IF Approvalmgt.SendApproval(Table_id,"No.",Doc_Type,Status)THEN;

                        if ApprovalsMgmt.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendMembershipApplicationForApproval(Rec);



                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
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
                        if Confirm('Are you sure you want to cancel this approval request', false) = true then
                            ApprovalsMgmt.OnCancelMembershipApplicationApprovalRequest(Rec);
                        // Status:=Status::Open;
                        Modify;
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
                        DocumentType := Documenttype::"Account Opening";
                        ApprovalEntries.Setfilters(Database::"Membership Applications", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                separator(Action2)
                {
                    Caption = '       -';
                }
                action("Create Account ")
                {
                    ApplicationArea = Basic;
                    Enabled = EnableCreateMember;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('This application has not been approved');
                        //TESTFIELD("Global Dimension 2 Code");
                        //TESTFIELD("Personal No");
                        //TESTFIELD("Employer Code");
                        TestField("Monthly Contribution");

                        if Confirm('Are you sure you want to create account application?', false) = true then begin


                            ProductsApp.Reset;
                            ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                            ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
                            ProductsApp.SetRange(ProductsApp.Product, 'MEMBERSHIP');
                            if ProductsApp.FindSet then begin
                                repeat

                                    //Back office Account***********************************************************************************************
                                    if "ID No." <> '' then begin
                                        Cust.Reset;
                                        Cust.SetRange(Cust."ID No.", "ID No.");
                                        Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                                        if Cust.Find('-') then begin
                                            Error('Member has already been created');
                                        end;
                                    end;

                                    ///NewMembNo:=Saccosetup.BosaNumber;
                                    Saccosetup.Get();

                                    NewMembNo := Saccosetup.BosaNumber;

                                    //Create BOSA account
                                    Cust."No." := Format(NewMembNo);
                                    Cust.Name := Name;
                                    Cust.Address := Address;
                                    Cust."Post Code" := "Postal Code";
                                    Cust.County := City;
                                    Cust."Phone No." := "Mobile Phone No";
                                    Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                    Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                    Cust."Customer Posting Group" := "Customer Posting Group";
                                    Cust."Registration Date" := Today;
                                    Cust."Mobile Phone No" := "Mobile Phone No";
                                    Cust.Status := Cust.Status::Active;
                                    Cust."Employer Code" := "Employer Code";
                                    Cust."Date of Birth" := "Date of Birth";
                                    Cust.Picture := Picture;
                                    Cust.Signature := Signature;
                                    Cust."Station/Department" := "Station/Department";
                                    Cust."E-Mail" := "E-Mail (Personal)";
                                    Cust.Location := Location;
                                    Cust.Title := Title;
                                    Cust."Home Address" := "Home Address";
                                    Cust."Home Postal Code" := "Home Postal Code";
                                    Cust."Home Town" := "Home Town";
                                    Cust."Recruited By" := "Recruited By";
                                    Cust."Contact Person" := "Contact Person";
                                    Cust."ContactPerson Relation" := "ContactPerson Relation";
                                    Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                                    Cust."Members Parish" := "Members Parish";
                                    Cust."Parish Name" := "Parish Name";
                                    Cust."Member Share Class" := "Member Share Class";
                                    Cust."Member's Residence" := "Member's Residence";
                                    //Cust."Employer Address":="Employer Address";
                                    //Cust."Nature Of Business":="Nature Of Business";
                                    //Cust."Date of Employment":="Date of Employment";
                                    //Cust."Position Held":="Position Held";
                                    //Cust.Industry:=Industry;
                                    //Cust."Business Name":="Business Name";
                                    //Cust."Physical Business Location":="Physical Business Location";
                                    //Cust."Year of Commence":="Year of Commence";
                                    /*Cust."Identification Document":="Identification Document";
                                    Cust."Referee Member No":="Referee Member No";
                                    Cust."Referee Name":="Referee Name";
                                    Cust."Referee ID No":="Referee ID No";
                                    Cust."Referee Mobile Phone No":="Referee Mobile Phone No";
                                    Cust."Email Indemnified":="E-mail Indemnified";
                                    */


                                    //*****************************to Sort Joint
                                    Cust."Name 2" := "Name 2";
                                    Cust."Address3-Joint" := Address3;
                                    Cust."Postal Code 2" := "Postal Code 2";
                                    Cust."Home Postal Code2" := "Home Postal Code2";
                                    Cust."Home Town2" := "Home Town2";
                                    Cust."ID No.2" := "ID No.2";
                                    Cust."Passport 2" := "Passport 2";
                                    Cust.Gender2 := Gender2;
                                    Cust."Marital Status2" := "Marital Status2";
                                    Cust."E-Mail (Personal2)" := "E-Mail (Personal2)";
                                    Cust."Employer Code2" := "Employer Code2";
                                    Cust."Employer Name2" := "Employer Name2";
                                    Cust."Picture 2" := "Picture 2";
                                    Cust."Signature  2" := "Signature  2";
                                    //Cust."Member Parish 2":="Member Parish 2";
                                    //Cust."Member Parish Name 2":="Member Parish Name 2";


                                    Cust."Name 3" := "Name 3";
                                    Cust."Address3-Joint" := Address4;
                                    Cust."Postal Code 3" := "Postal Code 3";
                                    Cust."Home Postal Code3" := "Home Postal Code3";
                                    Cust."Mobile No. 4" := "Mobile No. 4";
                                    Cust."Home Town3" := "Home Town3";
                                    Cust."ID No.3" := "ID No.3";
                                    Cust."Passport 3" := "Passport 3";
                                    Cust.Gender3 := Gender3;
                                    Cust."Marital Status3" := "Marital Status3";
                                    Cust."E-Mail (Personal2)" := "E-Mail (Personal3)";
                                    Cust."Employer Code3" := "Employer Code3";
                                    Cust."Employer Name3" := "Employer Name3";
                                    Cust."Picture 3" := "Picture 3";
                                    Cust."Signature  3" := "Signature  3";
                                    Cust."Member Parish Name 3" := "Member Parish Name 3";
                                    Cust."Member Parish Name 3" := "Member Parish Name 3";
                                    if Cust."Account Category" = Cust."account category"::Joint then
                                        Cust."Joint Account Name" := "First Name" + '& ' + "First Name2" + '& ' + "First Name3" + 'JA';
                                    Cust."Account Category" := "Account Category";

                                    //****************************End to Sort Joint

                                    //**
                                    Cust."Office Branch" := "Office Branch";
                                    Cust.Department := Department;
                                    Cust.Occupation := Occupation;
                                    Cust.Designation := Designation;
                                    Cust."Bank Code" := "Bank Code";
                                    Cust."Bank Branch Code" := "Bank Name";
                                    Cust."Bank Account No." := "Bank Account No";
                                    //**
                                    Cust."Sub-Location" := "Sub-Location";
                                    Cust.District := District;
                                    Cust."Personal No" := "Payroll No";
                                    Cust."ID No." := "ID No.";
                                    Cust."Mobile Phone No" := "Mobile Phone No";
                                    Cust."Marital Status" := "Marital Status";
                                    Cust."Customer Type" := Cust."customer type"::Member;
                                    Cust.Gender := Gender;

                                    Cust.Picture := Picture;
                                    Cust.Signature := Signature;

                                    Cust."Monthly Contribution" := "Monthly Contribution";
                                    Cust."Contact Person" := "Contact Person";
                                    Cust."Contact Person Phone" := "Contact Person Phone";
                                    Cust."ContactPerson Relation" := "ContactPerson Relation";
                                    Cust."Recruited By" := "Recruited By";
                                    Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                                    Cust."Village/Residence" := "Village/Residence";
                                    Cust.Pin := "KRA PIN";
                                    Cust.Insert(true);

                                    NextOfKinApp.Reset;
                                    NextOfKinApp.SetRange(NextOfKinApp."Account No", "No.");
                                    if NextOfKinApp.Find('-') then begin
                                        repeat
                                            NextOfKin.Init;
                                            NextOfKin."Account No" := Cust."No.";
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
                                            NextOfKin.Description := NextOfKinApp.Description;
                                            NextOfKin.Insert;
                                        until NextOfKinApp.Next = 0;
                                    end;

                                    AccountSignApp.Reset;
                                    AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
                                    if AccountSignApp.Find('-') then begin
                                        repeat
                                            MAccountSign.Init;
                                            MAccountSign."Account No" := AcctNo;
                                            MAccountSign.Names := AccountSignApp.Names;
                                            MAccountSign."Date Of Birth" := AccountSignApp."Date Of Birth";
                                            MAccountSign."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                                            MAccountSign."ID No." := AccountSignApp."ID No.";
                                            MAccountSign.Signatory := AccountSignApp.Signatory;
                                            MAccountSign."Must Sign" := AccountSignApp."Must Sign";
                                            MAccountSign."Must be Present" := AccountSignApp."Must be Present";
                                            MAccountSign.Picture := AccountSignApp.Picture;
                                            MAccountSign.Signature := AccountSignApp.Signature;
                                            MAccountSign."Expiry Date" := AccountSignApp."Expiry Date";
                                            //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                            MAccountSign.Insert;
                                        until AccountSignApp.Next = 0;
                                    end;

                                    //Insert Member Agents------
                                    ObjMemberAppAgent.Reset;
                                    ObjMemberAppAgent.SetRange(ObjMemberAppAgent."Account No", "No.");
                                    //ObjMemberAppAgent.CALCFIELDS(ObjMemberAppAgent.Picture,ObjMemberAppAgent.Signature);
                                    if ObjMemberAppAgent.Find('-') then begin
                                        repeat
                                            ObjMemberAgent.Init;
                                            ObjMemberAgent."Account No" := Cust."No.";
                                            ;
                                            ObjMemberAgent.Names := ObjMemberAppAgent.Names;
                                            ObjMemberAgent."Date Of Birth" := ObjMemberAppAgent."Date Of Birth";
                                            ObjMemberAgent."Staff/Payroll" := ObjMemberAppAgent."Staff/Payroll";
                                            ObjMemberAgent."ID No." := ObjMemberAppAgent."ID No.";
                                            ObjMemberAgent."Allowed  Correspondence" := ObjMemberAppAgent."Allowed  Correspondence";
                                            ObjMemberAgent."Allowed Balance Enquiry" := ObjMemberAppAgent."Allowed Balance Enquiry";
                                            ObjMemberAgent."Allowed FOSA Withdrawals" := ObjMemberAppAgent."Allowed FOSA Withdrawals";
                                            ObjMemberAgent."Allowed Loan Processing" := ObjMemberAppAgent."Allowed Loan Processing";
                                            ObjMemberAgent."Must Sign" := ObjMemberAppAgent."Must Sign";
                                            ObjMemberAgent."Must be Present" := ObjMemberAppAgent."Must be Present";
                                            ObjMemberAgent.Picture := ObjMemberAppAgent.Picture;
                                            ObjMemberAgent.Signature := ObjMemberAppAgent.Signature;
                                            ObjMemberAgent."Expiry Date" := ObjMemberAppAgent."Expiry Date";
                                            ObjMemberAgent.Insert;

                                        until ObjMemberAppAgent.Next = 0;
                                    end;
                                    //Insert Member Agents------

                                    //CLEAR(Picture);
                                    //CLEAR(Signature);
                                    Modify;

                                    Saccosetup.BosaNumber := IncStr(NewMembNo);
                                    Saccosetup.Modify;
                                    BOSAACC := Cust."No.";

                                until ProductsApp.Next = 0;
                            end;
                        end;
                        //End Back Office Account*****************************************************************************

                        //Front Office Accounts*******************************************************************************
                        ProductsApp.Reset;
                        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::FOSA);
                        if ProductsApp.FindSet then begin
                            repeat

                                AccountTypes.Reset;
                                AccountTypes.SetRange(AccountTypes.Code, ProductsApp.Product);
                                if AccountTypes.FindSet then begin
                                    AcctNo := AccountTypes."Account No Prefix" + '-' + AccountTypes."Product Code" + '-' + NewMembNo;
                                end;
                                ////
                                /*
                                Accounts.RESET;
                                Accounts.SETRANGE(Accounts."ID No.","ID No.");
                                Accounts.SETRANGE(Accounts."Account Type",ProductsApp.Product);
                                IF Accounts.FINDSET THEN BEGIN
                                 // ERROR('The Member has an existing %1',Accounts."Account Type");
                                  END;
                                  */
                                //Create FOSA account
                                Message(Format(NewMembNo));
                                Accounts.Init;
                                Accounts."No." := AcctNo;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts.Name := Name;
                                Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                Accounts."Personal No." := "Payroll No";
                                Accounts."ID No." := "ID No.";
                                Accounts."Mobile Phone No" := "Mobile Phone No";
                                Accounts."Phone No." := "Mobile Phone No";
                                Accounts."Registration Date" := "Registration Date";
                                Accounts."Post Code" := "Postal Code";
                                Accounts.County := City;
                                Accounts."BOSA Account No" := Cust."No.";
                                Accounts.Picture := Picture;
                                Accounts.Signature := Signature;
                                Accounts."Passport No." := "Passport No.";
                                Accounts."Employer Code" := "Employer Code";
                                Accounts.Status := Accounts.Status::New;
                                Accounts."Account Type" := ProductsApp.Product;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts."Global Dimension 1 Code" := 'FOSA';
                                Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Accounts.Address := Address;
                                if "Account Category" = "account category"::Corporate then begin
                                    Accounts."Account Category" := Accounts."account category"::Corporate
                                end else
                                    Accounts."Account Category" := "Account Category";
                                Accounts."Address 2" := "Address 2";
                                Accounts."Phone No." := "Mobile Phone No";
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
                                //Accounts."Member Parish 2":="Member Parish 2";
                                //Accounts."Member Parish Name 2":="Member Parish Name 2";
                                Accounts."Member's Residence" := "Member's Residence";
                                if Cust."Account Category" = Cust."account category"::Joint then
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
                                if Cust."Account Category" = Cust."account category"::Joint then
                                    Accounts."Joint Account Name" := "First Name" + ' &' + "First Name2" + ' &' + "First Name3" + 'JA';

                                //************End to Sort for Joint Accounts*************
                                Accounts.Insert;


                                Accounts.Reset;
                                if Accounts.Get(AcctNo) then begin
                                    Accounts.Validate(Accounts.Name);
                                    Accounts.Validate(Accounts."Account Type");
                                    Accounts.Modify;


                                    //Update BOSA with FOSA Account
                                    if Cust.Get(BOSAACC) then begin
                                        Cust."FOSA Account No." := AcctNo;
                                        Cust.Modify;
                                    end;
                                end;


                                NextOfKinApp.Reset;
                                NextOfKinApp.SetRange(NextOfKinApp."Account No", "No.");
                                if NextOfKinApp.Find('-') then begin
                                    repeat
                                        NextofKinFOSA.Init;
                                        NextofKinFOSA."Account No" := AcctNo;
                                        NextofKinFOSA.Name := NextOfKinApp.Name;
                                        NextofKinFOSA.Relationship := NextOfKinApp.Relationship;
                                        NextofKinFOSA.Beneficiary := NextOfKinApp.Beneficiary;
                                        NextofKinFOSA."Date of Birth" := NextOfKinApp."Date of Birth";
                                        NextofKinFOSA.Address := NextOfKinApp.Address;
                                        NextofKinFOSA.Telephone := NextOfKinApp.Telephone;
                                        //NextOfKin.Fax:=NextOfKinApp.Fax;
                                        NextofKinFOSA.Email := NextOfKinApp.Email;
                                        NextofKinFOSA."ID No." := NextOfKinApp."ID No.";
                                        NextofKinFOSA."%Allocation" := NextOfKinApp."%Allocation";
                                        NextofKinFOSA.Insert;
                                    until NextOfKinApp.Next = 0;
                                end;

                                //Insert Member Agents------
                                ObjMemberAppAgent.Reset;
                                ObjMemberAppAgent.SetRange(ObjMemberAppAgent."Account No", "No.");
                                //ObjMemberAppAgent.CALCFIELDS(ObjMemberAppAgent.Picture,ObjMemberAppAgent.Signature);
                                if ObjMemberAppAgent.Find('-') then begin
                                    repeat
                                        ObjAccountAgents.Init;
                                        ObjAccountAgents."Account No" := AcctNo;
                                        ObjAccountAgents.Names := ObjMemberAppAgent.Names;
                                        ObjAccountAgents."Date Of Birth" := ObjMemberAppAgent."Date Of Birth";
                                        ObjAccountAgents."Staff/Payroll" := ObjMemberAppAgent."Staff/Payroll";
                                        ObjAccountAgents."ID No." := ObjMemberAppAgent."ID No.";
                                        ObjAccountAgents."Allowed  Correspondence" := ObjMemberAppAgent."Allowed  Correspondence";
                                        ObjAccountAgents."Allowed Balance Enquiry" := ObjMemberAppAgent."Allowed Balance Enquiry";
                                        ObjAccountAgents."Allowed FOSA Withdrawals" := ObjMemberAppAgent."Allowed FOSA Withdrawals";
                                        ObjAccountAgents."Allowed Loan Processing" := ObjMemberAppAgent."Allowed Loan Processing";
                                        ObjAccountAgents."Must Sign" := ObjMemberAppAgent."Must Sign";
                                        ObjAccountAgents."Must be Present" := ObjMemberAppAgent."Must be Present";
                                        //ObjAccountAgents.Picture:=ObjMemberAppAgent.Picture;
                                        //ObjAccountAgents.Signature:=ObjMemberAppAgent.Signature;
                                        ObjAccountAgents."Expiry Date" := ObjMemberAppAgent."Expiry Date";
                                        ObjAccountAgents.Insert;

                                    until ObjMemberAppAgent.Next = 0;
                                end;
                                //Insert Member Agents------


                                AccountSignApp.Reset;
                                AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
                                if AccountSignApp.Find('-') then begin
                                    repeat
                                        PAccountSign.Init;
                                        PAccountSign."Account No" := AcctNo;
                                        PAccountSign.Names := AccountSignApp.Names;
                                        PAccountSign."Date Of Birth" := AccountSignApp."Date Of Birth";
                                        PAccountSign."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                                        PAccountSign."ID No." := AccountSignApp."ID No.";
                                        PAccountSign.Signatory := AccountSignApp.Signatory;
                                        PAccountSign."Must Sign" := AccountSignApp."Must Sign";
                                        PAccountSign."Must be Present" := AccountSignApp."Must be Present";
                                        PAccountSign.Picture := AccountSignApp.Picture;
                                        PAccountSign.Signature := AccountSignApp.Signature;
                                        PAccountSign."Expiry Date" := AccountSignApp."Expiry Date";
                                        PAccountSign.Insert;
                                    until AccountSignApp.Next = 0;
                                end;
                                //END;
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                GenJournalLine.DeleteAll;

                                GenSetUp.Get();
                                //Charge Registration Fee
                                if GenSetUp."Charge FOSA Registration Fee" = true then begin

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'REGFee';
                                    GenJournalLine."Document No." := "No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := AcctNo;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine."External Document No." := 'REGFEE/' + Format("Payroll No");
                                    GenJournalLine.Description := 'Registration Fee';
                                    GenJournalLine.Amount := GenSetUp."BOSA Registration Fee Amount";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := GenSetUp."FOSA Registration Fee Account";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        //GenJournalLine.INSERT;



                                        GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                    GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                    if GenJournalLine.Find('-') then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                    end;
                                end;
                                Message('You have successfully created a %1 Product, A/C No=%2', ProductsApp.Product, AcctNo);

                            //End Charge Registration Fee
                            until ProductsApp.Next = 0;
                        end;
                        Message('You have successfully Registered a New Sacco Member. Membership No=%1.The Member will be notifed via an SMS', Cust."No.");
                        //End Front Office Accounts*******************************************************************************






                        GenSetUp.Get();

                        //Send SMS********************************
                        if GenSetUp."Send Membership Reg SMS" = true then begin
                            SFactory.FnSendSMS('MEMBERAPP', 'You member Registration has been completed.', BOSAACC, "Mobile Phone No");
                        end;

                        //Send Email********************************
                        /*IF GenSetUp."Send Membership Reg Email"=TRUE THEN BEGIN
                        FnSendRegistrationEmail("No.","E-Mail (Personal)","ID No.");
                        END;*/
                        FnUpdateMemberSubAccounts();

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
        EditableField := true;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;

        if (Rec.Status = Status::Approved) and (Rec."Assigned No." = '') then
            EnableCreateMember := true;
        if Status <> Status::Open then
            EditableField := false;
    end;

    trigger OnAfterGetRecord()
    begin
        "Self Recruited" := true;
        EmployedEditable := false;
        ContractingEditable := false;
        OthersEditable := false;

        if "Account Category" <> "account category"::Joint then begin
            Joint2DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;




        if "Account Category" <> "account category"::Group then begin
            NumberofMembersEditable := false
        end else
            NumberofMembersEditable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Responsibility Centre" := UserMgt.GetSalesFilter;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //GenSetUp.GET();
        //"Monthly Contribution":=GenSetUp."Monthly Share Contributions";
        "Account Category" := "account category"::Group;
    end;

    trigger OnOpenPage()
    begin

        if UserMgt.GetSalesFilter <> '' then begin
            FilterGroup(2);
            SetRange("Responsibility Centre", UserMgt.GetSalesFilter);
            FilterGroup(0);
        end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        Cust: Record "Member Register";
        Accounts: Record Vendor;
        AcctNo: Code[20];
        NextOfKinApp: Record "Member App Nominee";
        MAccountSign: Record "Member Account Signatories";
        PAccountSign: Record "FOSA Account Sign. Details";
        AccountSignApp: Record "Member App Signatories";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "Member App Nominee";
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
        AccountTypes: Record "Account Types-Saving Products";
        DivAcctNo: Code[20];
        NameEditable: Boolean;
        AddressEditable: Boolean;
        NoEditable: Boolean;
        DioceseEditable: Boolean;
        HomeAdressEditable: Boolean;
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
        NewMembNo: Code[30];
        Saccosetup: Record "Sacco No. Series";
        NOkApp: Record "Member App Nominee";
        TitleEditable: Boolean;
        PostalCodeEditable: Boolean;
        HomeAddressPostalCodeEditable: Boolean;
        HomeTownEditable: Boolean;
        RecruitedEditable: Boolean;
        ContactPEditable: Boolean;
        ContactPRelationEditable: Boolean;
        ContactPOccupationEditable: Boolean;
        CopyOFIDEditable: Boolean;
        CopyofPassportEditable: Boolean;
        SpecimenEditable: Boolean;
        ContactPPhoneEditable: Boolean;
        PictureEditable: Boolean;
        SignatureEditable: Boolean;
        PayslipEditable: Boolean;
        RegistrationFeeEditable: Boolean;
        CopyofKRAPinEditable: Boolean;
        membertypeEditable: Boolean;
        FistnameEditable: Boolean;
        dateofbirth2: Boolean;
        registrationeditable: Boolean;
        EstablishdateEditable: Boolean;
        RegistrationofficeEditable: Boolean;
        Signature2Editable: Boolean;
        Picture2Editable: Boolean;
        MembApp: Record "Membership Applications";
        title2Editable: Boolean;
        mobile3editable: Boolean;
        emailaddresEditable: Boolean;
        gender2editable: Boolean;
        postal2Editable: Boolean;
        town2Editable: Boolean;
        passpoetEditable: Boolean;
        maritalstatus2Editable: Boolean;
        payrollno2editable: Boolean;
        Employercode2Editable: Boolean;
        address3Editable: Boolean;
        DateOfAppointmentEDitable: Boolean;
        TermsofServiceEditable: Boolean;
        HomePostalCode2Editable: Boolean;
        Employername2Editable: Boolean;
        ageEditable: Boolean;
        CopyofconstitutionEditable: Boolean;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening";
        RecruitedByEditable: Boolean;
        RecruiterNameEditable: Boolean;
        RecruiterRelationShipEditable: Boolean;
        AccoutTypes: Record "Account Types-Saving Products";
        NomineeEditable: Boolean;
        TownEditable: Boolean;
        CountryEditable: Boolean;
        MobileEditable: Boolean;
        PassportEditable: Boolean;
        RejoiningDateEditable: Boolean;
        PrevousRegDateEditable: Boolean;
        AppCategoryEditable: Boolean;
        RegistrationDateEditable: Boolean;
        DataSheet: Record "Data Sheet Main";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cuat: Integer;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        OthersEditable: Boolean;
        Joint2DetailsVisible: Boolean;
        ProductsApp: Record "Membership Reg. Products Appli";
        NextofKinFOSA: Record "FOSA Account NOK Details";
        NumberofMembersEditable: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        EnableCreateMember: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory.";
        WelcomeMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        RegistrationMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to  Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership registration has been successfully processed</p><p style="font-family:Verdana,Arial;font-size:9pt">Your membership number is <b>%2</b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        EditableField: Boolean;
        RefereeEditable: Boolean;
        EmailIndemnifiedEditable: Boolean;
        SendEStatementsEditable: Boolean;
        ObjAccountAppAgent: Record "Account Agents App Details";
        ObjAccountAgent: Record "Account Agent Details";
        ObjMemberAppAgent: Record "Member Agents App Details";
        ObjMemberAgent: Record "Member Agent Details";
        IdentificationDocTypeEditable: Boolean;
        PhysicalAddressEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
        ObjAccountAgents: Record "Account Agent Details";
        ObjMembers: Record "Member Register";
        ObjBOSAAccount: Record "BOSA Accounts No Buffer";
        CompInfo: Record "Company Information";


    procedure UpdateControls()
    begin

        if Status = Status::Approved then begin
            NameEditable := false;
            NoEditable := false;
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
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            EmployerCodeEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;

        if Status = Status::"Pending Approval" then begin
            NameEditable := false;
            NoEditable := false;
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
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            EmployerCodeEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;


        if Status = Status::Open then begin
            NameEditable := true;
            AddressEditable := true;
            GlobalDim1Editable := true;
            GlobalDim2Editable := true;
            CustPostingGroupEdit := true;
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
            CityEditable := true;
            WitnessEditable := true;
            BankCodeEditable := true;
            BranchCodeEditable := true;
            BankAccountNoEditable := true;
            VillageResidence := true;
            TitleEditable := true;
            PostalCodeEditable := true;
            HomeAddressPostalCodeEditable := true;
            HomeTownEditable := true;
            RecruitedEditable := true;
            ContactPEditable := true;
            ContactPRelationEditable := true;
            ContactPOccupationEditable := true;
            CopyOFIDEditable := true;
            CopyofPassportEditable := true;
            SpecimenEditable := true;
            ContactPPhoneEditable := true;
            HomeAdressEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            PayslipEditable := true;
            RegistrationFeeEditable := true;
            title2Editable := true;
            emailaddresEditable := true;
            gender2editable := true;
            HomePostalCode2Editable := true;
            town2Editable := true;
            passpoetEditable := true;
            maritalstatus2Editable := true;
            payrollno2editable := true;
            Employercode2Editable := true;
            address3Editable := true;
            Employername2Editable := true;
            ageEditable := true;
            mobile3editable := true;
            CopyofconstitutionEditable := true;
            NomineeEditable := true;
            TownEditable := true;
            CountryEditable := true;
            MobileEditable := true;
            PassportEditable := true;
            RejoiningDateEditable := true;
            PrevousRegDateEditable := true;
            AppCategoryEditable := true;
            RegistrationDateEditable := true;
            TermsofServiceEditable := true;
            EmployerCodeEditable := true;
            RecruitedByEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            IdentificationDocTypeEditable := true;
            PhysicalAddressEditable := true;
            RefereeEditable := true;
            MonthlyIncomeEditable := true;
        end
    end;

    local procedure SelfRecruitedControl()
    begin
        /*
            IF "Self Recruited"=TRUE THEN BEGIN
             RecruitedByEditable:=FALSE;
             RecruiterNameEditable:=FALSE;
             RecruiterRelationShipEditable:=FALSE;
             END ELSE
            IF "Self Recruited"<>TRUE THEN BEGIN
             RecruitedByEditable:=TRUE;
             RecruiterNameEditable:=TRUE;
             RecruiterRelationShipEditable:=TRUE;
             END;
             */

    end;


    procedure FnSendReceivedApplicationSMS()
    begin

        GenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
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
        SMSMessage."Batch No" := "No.";
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := BOSAACC;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBAPP';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member your application has been received and going through approval,'
        + ' ' + CompInfo.Name + ' ' + GenSetUp."Customer Care No";
        SMSMessage."Telephone No" := "Mobile Phone No";
        if "Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;


    procedure FnSendRegistrationSMS()
    begin

        GenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
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
        SMSMessage."Batch No" := "No.";
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := BOSAACC;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBREG';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member you have been registered successfully, your Membership No is '
        + BOSAACC + ' Name ' + Name + ' ' + CompInfo.Name + ' ' + GenSetUp."Customer Care No";
        SMSMessage."Telephone No" := "Mobile Phone No";
        if "Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure UpdateViewLogEntries()
    begin
        /*ViewLog.INIT;
        ViewLog."Entry No.":=ViewLog."Entry No."+1;
        ViewLog."User ID":=USERID;
        ViewLog."Table No.":=51516364;
        ViewLog."Table Caption":='Members Register';
        ViewLog.Date:=TODAY;
        ViewLog.Time:=TIME;
        */

    end;

    local procedure FnCheckfieldrestriction()
    begin
        if ("Account Category" = "account category"::Single) then begin
            //CALCFIELDS(Picture,Signature);
            TestField(Name);
            TestField("ID No.");
            TestField("Mobile Phone No");
            //TESTFIELD("Employer Code");
            //TESTFIELD("Personal No");
            TestField("Monthly Contribution");
            TestField("Member's Residence");
            TestField(Gender);
            TestField("Employment Info");
            TestField("Address 2");

            //TESTFIELD("Copy of Current Payslip");
            //TESTFIELD("Member Registration Fee Receiv");
            TestField("Customer Posting Group");
            TestField("Global Dimension 1 Code");
            //TESTFIELD("Global Dimension 2 Code");
            //TESTFIELD("Contact Person");
            //TESTFIELD("Contact Person Phone");
            //IF Picture=0 OR Signature=0 THEN
            //ERROR(Insert )
        end else

            if ("Account Category" = "account category"::Group) or ("Account Category" = "account category"::Corporate) then begin
                TestField(Name);
                TestField("Registration No");
                TestField("Copy of KRA Pin");
                TestField("Member Registration Fee Receiv");
                ///TESTFIELD("Account Category");
                TestField("Customer Posting Group");
                TestField("Global Dimension 1 Code");
                TestField("Global Dimension 2 Code");
                //TESTFIELD("Copy of constitution");
                TestField("Contact Person");
                TestField("Contact Person Phone");

            end;
    end;

    local procedure FnSendReceivedApplicationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    var
        Memb: Record "Membership Applications";
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        SMTPSetup.Get();

        Memb.Reset;
        Memb.SetRange(Memb."No.", ApplicationNo);
        if Memb.Find('-') then begin
            if Email = '' then begin
                // ERROR ('Email Address Missing for Member Application number' +'-'+ Memb."No.");
            end;
            if Memb."E-Mail (Personal)" <> '' then
                SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Email, 'Membership Application', '', true);
            SMTPMail.AppendBody(StrSubstNo(WelcomeMessage, Memb.Name, IDNo, UserId));
            SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AddAttachment(FileName, Attachment);
            SMTPMail.Send;
        end;
    end;

    local procedure FnSendRegistrationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    var
        Memb: Record "Membership Applications";
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        SMTPSetup.Get();

        Memb.Reset;
        Memb.SetRange(Memb."No.", ApplicationNo);
        if Memb.Find('-') then begin
            if Email = '' then begin
                //  ERROR ('Email Address Missing for Member Application number' +'-'+ Memb."No.");
            end;
            if Memb."E-Mail (Personal)" <> '' then
                SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Email, 'Membership Registration', '', true);
            SMTPMail.AppendBody(StrSubstNo(RegistrationMessage, Memb.Name, BOSAACC, UserId));
            SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AddAttachment(FileName, Attachment);
            SMTPMail.Send;
        end;
    end;

    local procedure FnUpdateMemberSubAccounts()
    begin
        Saccosetup.Get();

        //SHARE CAPITAL
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '601');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", "ID No.");
            if ObjMembers.FindSet then begin
                if "Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(HQ)");
                    Saccosetup."Share Capital Account No(HQ)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(NAIV)");
                    Saccosetup."Share Capital Account No(NAIV)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(NKR)");
                    Saccosetup."Share Capital Account No(NKR)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(ELD)");
                    Saccosetup."Share Capital Account No(ELD)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(MSA)");
                    Saccosetup."Share Capital Account No(MSA)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;
        //END SHARE CAPITAL

        //DEPOSITS CONTRIBUTION
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '602');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", "ID No.");
            if ObjMembers.FindSet then begin
                if "Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
                    Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
                    Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
                    Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
                    Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
                    Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

        //CORPORATE DEPOSITS CONTRIBUTION
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '603');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", "ID No.");
            if ObjMembers.FindSet then begin
                if "Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
                    Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
                    Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
                    Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
                    Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
                    Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

        //FOSA SHARES CONTRIBUTION
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '605');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", "ID No.");
            if ObjMembers.FindSet then begin
                if "Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
                    Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
                    Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
                    Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
                    Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
                    Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

        //FOSA SHARES CONTRIBUTION
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '607');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", "ID No.");
            if ObjMembers.FindSet then begin
                if "Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
                    Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
                    Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
                    Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
                    Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
                    Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

        //BENEVOLENT FUND

        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '606');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", "ID No.");
            if ObjMembers.FindSet then begin
                if "Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(HQ)");
                    Saccosetup."BenFund Account No(HQ)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;

                end;
                if "Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(NAIV)");
                    Saccosetup."BenFund Account No(NAIV)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(NKR)");
                    Saccosetup."BenFund Account No(NKR)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(ELD)");
                    Saccosetup."BenFund Account No(ELD)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;


                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(MSA)");
                    Saccosetup."BenFund Account No(MSA)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

    end;
}

