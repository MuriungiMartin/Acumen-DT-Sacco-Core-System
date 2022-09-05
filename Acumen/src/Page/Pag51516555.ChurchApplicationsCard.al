#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516555 "Church Applications Card"
{
    DeleteAllowed = false;
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
                    OptionCaption = 'Single,Joint,Corporate,Group,Parish,Church,Church Department';

                    trigger OnValidate()
                    begin
                        Joint2DetailsVisible := false;

                        if "Account Category" = "account category"::Joint then begin
                            Joint2DetailsVisible := true;
                        end;
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = AddressEditable;
                }
                field("Postal Code"; "Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = PostCodeEditable;
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
                field("No of Members"; "No of Members")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = MobileEditable;
                    ShowMandatory = true;
                }
                field("Signing Instructions"; "Signing Instructions")
                {
                    ApplicationArea = Basic;
                }
                field("Need a Cheque book"; "Need a Cheque book")
                {
                    ApplicationArea = Basic;
                }
                field("Self Recruited"; "Self Recruited")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        SelfRecruitedControl();
                    end;
                }
                field("Recruited By"; "Recruited By")
                {
                    ApplicationArea = Basic;
                    Editable = RecruitedByEditable;
                }
                field("Recruiter Name"; "Recruiter Name")
                {
                    ApplicationArea = Basic;
                    Editable = RecruiterNameEditable;
                }
                field("Relationship With Recruiter"; "Relationship With Recruiter")
                {
                    ApplicationArea = Basic;
                    Editable = RecruiterRelationShipEditable;
                }
                field("Application Category"; "Application Category")
                {
                    ApplicationArea = Basic;
                    Editable = AppCategoryEditable;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = RegistrationDateEditable;
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
                    ShowMandatory = true;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Communication/Location Info")
            {
                Caption = 'Communication/Location Info';
                field("Office Telephone No."; "Office Telephone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Office Extension"; "Office Extension")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail (Personal)"; "E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = EmailEdiatble;
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
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Select Products")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Products";
                    RunPageLink = "Membership Applicaton No" = field("No."),
                                  Names = field(Name);
                }
                separator(Action6)
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
                        DocumentType := Documenttype::"Account Opening";
                        ApprovalEntries.Setfilters(Database::"Membership Applications", DocumentType, "No.");
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
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
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



                        if ("Account Category" = "account category"::Single) then begin
                            TestField(Name);
                            //TESTFIELD("ID No.");
                            TestField("Mobile Phone No");
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

                            if ("Account Category" = "account category"::Parish) or ("Account Category" = "account category"::Church) or ("Account Category" = "account category"::"Church Department") then begin
                                TestField(Name);
                                TestField("Contact Person");
                                TestField("Contact Person Phone");
                                TestField("Customer Posting Group");
                                TestField("Global Dimension 1 Code");
                                TestField("Global Dimension 2 Code");
                                TestField("Contact Person Phone");

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

                        /*IF ApprovalsMgmt.OnCancelStandingOrderApprovalRequest(Rec) THEN
                          ApprovalsMgmt.OnSendPaymentDocForApproval(Rec);*/


                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit WorkflowIntegration;
                    begin
                        /*
                        Doc_Type:=Doc_Type::"Account Opening";
                        Table_id:="Membership Applications";
                        
                        IF Approvalmgt.CancelApproval(Table_id,"No.",Doc_Type,Status)THEN;
                        
                        
                        IF Approvalmgt.CancelAccOpeninApprovalRequest(Rec,TRUE,TRUE) THEN;
                                                      */

                    end;
                }
                separator(Action2)
                {
                    Caption = '       -';
                }
                action("Create Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Accountn';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('This application has not been approved');


                        if Confirm('Are you sure you want to create account application?', false) = true then begin

                            //BOSA Only-------------------------------------------------------------
                            if Products = Products::"BOSA Account" then begin
                                if Cust."Customer Posting Group" <> 'PLAZA' then
                                    if "ID No." <> '' then begin
                                        Cust.Reset;
                                        Cust.SetRange(Cust."ID No.", "ID No.");
                                        Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                                        if Cust.Find('-') then begin
                                            if (Cust."No." <> "No.") and ("Account Category" = "account category"::Single) then
                                                Error('Member has already been created');
                                        end;
                                    end;
                                Saccosetup.Get();
                                NewMembNo := Saccosetup.BosaNumber;
                                //IF UPPERCASE("Sent for Approval By")=UPPERCASE(USERID) THEN
                                //.ERROR('Operation denied');

                                //Create BOSA account
                                Cust."No." := Format(NewMembNo);
                                Cust.Name := Name;
                                Cust.Address := Address;
                                Cust."Post Code" := "Postal Code";
                                Cust.County := City;
                                Cust."Phone No." := "Phone No.";
                                Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Cust."Customer Posting Group" := "Customer Posting Group";
                                Cust."Registration Date" := Today;
                                Cust."Mobile Phone No" := "Mobile Phone No";
                                Cust.Status := Cust.Status::Active;
                                Cust."Employer Code" := "Employer Code";
                                Cust."Date of Birth" := "Date of Birth";
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

                                CalcFields(Signature, Picture);
                                //PictureExists:=Picture.HASVALUE;
                                //SignatureExists:=Signature.HASVALUE;
                                //IF (PictureExists=TRUE) AND (SignatureExists=TRUE) THEN BEGIN
                                Cust.Piccture := Picture;
                                Cust.Signature := Signature;
                                //END ELSE
                                //ERROR('Kindly upload a Picture and signature');

                                Cust."Monthly Contribution" := "Monthly Contribution";
                                Cust."Contact Person" := "Contact Person";
                                Cust."Contact Person Phone" := "Contact Person Phone";
                                Cust."ContactPerson Relation" := "ContactPerson Relation";
                                Cust."Recruited By" := "Recruited By";
                                Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                                Cust."Village/Residence" := "Village/Residence";
                                Cust.Insert(true);
                                //Cust.VALIDATE(Cust."ID No.");

                                //CLEAR(Picture);
                                //CLEAR(Signature);
                                //MODIFY;
                                Saccosetup.BosaNumber := IncStr(NewMembNo);
                                Saccosetup.Modify;
                                BOSAACC := Cust."No.";

                            end;
                            //END of BOSA Only-------------------------------------------------------------------

                            //BOSA +CURRENT----------------------------------------------------------------------
                            if Products = Products::"BOSA+Current Account" then begin
                                if Cust."Customer Posting Group" <> 'PLAZA' then
                                    if "ID No." <> '' then begin
                                        Cust.Reset;
                                        Cust.SetRange(Cust."ID No.", "ID No.");
                                        Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                                        if Cust.Find('-') then begin
                                            if (Cust."No." <> "No.") and ("Account Category" = "account category"::Single) then
                                                Error('Member has already been created');
                                        end;
                                    end;
                                Saccosetup.Get();
                                NewMembNo := Saccosetup.BosaNumber;
                                //IF UPPERCASE("Sent for Approval By")=UPPERCASE(USERID) THEN
                                //.ERROR('Operation denied');

                                //Create BOSA account
                                Cust."No." := Format(NewMembNo);
                                Cust.Name := Name;
                                Cust.Address := Address;
                                Cust."Post Code" := "Postal Code";
                                Cust.County := City;
                                Cust."Phone No." := "Phone No.";
                                Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Cust."Customer Posting Group" := "Customer Posting Group";
                                Cust."Registration Date" := Today;
                                Cust."Mobile Phone No" := "Mobile Phone No";
                                Cust.Status := Cust.Status::Active;
                                Cust."Employer Code" := "Employer Code";
                                Cust."Date of Birth" := "Date of Birth";
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

                                CalcFields(Signature, Picture);
                                //PictureExists:=Picture.HASVALUE;
                                //SignatureExists:=Signature.HASVALUE;
                                //IF (PictureExists=TRUE) AND (SignatureExists=TRUE) THEN BEGIN
                                Cust.Piccture := Picture;
                                Cust.Signature := Signature;
                                //END ELSE
                                //ERROR('Kindly upload a Picture and signature');

                                Cust."Monthly Contribution" := "Monthly Contribution";
                                Cust."Contact Person" := "Contact Person";
                                Cust."Contact Person Phone" := "Contact Person Phone";
                                Cust."ContactPerson Relation" := "ContactPerson Relation";
                                Cust."Recruited By" := "Recruited By";
                                Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                                Cust."Village/Residence" := "Village/Residence";
                                Cust.Insert(true);
                                //Cust.VALIDATE(Cust."ID No.");

                                //CLEAR(Picture);
                                //CLEAR(Signature);
                                //MODIFY;
                                Saccosetup.BosaNumber := IncStr(NewMembNo);
                                Saccosetup.Modify;
                                BOSAACC := Cust."No.";

                                //END;

                                //Current Account Starts Here-----------------------------------------------------
                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, 'CURRENT');
                                if AccoutTypes.Find('-') then begin
                                    AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes.Branch + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                end;

                                //Create FOSA account
                                Accounts.Init;
                                Accounts."No." := AcctNo;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts.Name := Name;
                                Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                Accounts."Personal No." := "Payroll No";
                                Accounts."ID No." := "ID No.";
                                Accounts."Mobile Phone No" := "Mobile Phone No";
                                Accounts."Registration Date" := "Registration Date";
                                Accounts."Post Code" := "Postal Code";
                                Accounts.County := City;
                                Accounts."BOSA Account No" := Cust."No.";
                                Accounts.Piccture := Picture;
                                Accounts.Signature := Signature;
                                Accounts."Passport No." := "Passport No.";
                                Accounts."Employer Code" := "Employer Code";
                                Accounts.Status := Accounts.Status::New;
                                Accounts."Account Type" := 'CURRENT';
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts."Global Dimension 1 Code" := 'FOSA';
                                Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Accounts.Address := Address;
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
                                //Accounts."Home Page":="Home Page";
                                //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                //Accounts."Signing Instructions":="Signing Instructions";
                                //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                //Accounts."FD Maturity Date":="FD Maturity Date";
                                //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                //Accounts."Departments Code":="Departments Code";
                                //Accounts."Sections Code":="Sections Code";
                                Accounts.Insert;


                                Accounts.Reset;
                                if Accounts.Get(AcctNo) then begin
                                    Accounts.Validate(Accounts.Name);
                                    Accounts.Validate(Accounts."Account Type");
                                    Accounts.Validate(Accounts."Global Dimension 1 Code");
                                    Accounts.Validate(Accounts."Global Dimension 2 Code");
                                    Accounts.Modify;

                                    AccoutTypes.Reset;
                                    AccoutTypes.SetRange(AccoutTypes.Code, 'CURRENT');
                                    if AccoutTypes.Find('-') then begin
                                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                        AccoutTypes.Modify;
                                    end;

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
                                        NextOfKin.Init;
                                        NextOfKin."Account No" := BOSAACC;
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
                                        //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                        AccountSign.Insert;
                                    until AccountSignApp.Next = 0;
                                end;
                            end;
                            //End Current Account-------------------------------------------------------
                            //End of BOSA+Current-------------------------------------------------------


                            //BOSA +SMART SAVER----------------------------------------------------------------------
                            if Products = Products::"BOSA+Smart Saver" then begin
                                if Cust."Customer Posting Group" <> 'PLAZA' then
                                    if "ID No." <> '' then begin
                                        Cust.Reset;
                                        Cust.SetRange(Cust."ID No.", "ID No.");
                                        Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                                        if Cust.Find('-') then begin
                                            if (Cust."No." <> "No.") and ("Account Category" = "account category"::Single) then
                                                Error('Member has already been created');
                                        end;
                                    end;
                                Saccosetup.Get();
                                NewMembNo := Saccosetup.BosaNumber;
                                //IF UPPERCASE("Sent for Approval By")=UPPERCASE(USERID) THEN
                                //.ERROR('Operation denied');

                                //Create BOSA account
                                Cust."No." := Format(NewMembNo);
                                Cust.Name := Name;
                                Cust.Address := Address;
                                Cust."Post Code" := "Postal Code";
                                Cust.County := City;
                                Cust."Phone No." := "Phone No.";
                                Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Cust."Customer Posting Group" := "Customer Posting Group";
                                Cust."Registration Date" := Today;
                                Cust."Mobile Phone No" := "Mobile Phone No";
                                Cust.Status := Cust.Status::Active;
                                Cust."Employer Code" := "Employer Code";
                                Cust."Date of Birth" := "Date of Birth";
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

                                CalcFields(Signature, Picture);
                                //PictureExists:=Picture.HASVALUE;
                                //SignatureExists:=Signature.HASVALUE;
                                //IF (PictureExists=TRUE) AND (SignatureExists=TRUE) THEN BEGIN
                                Cust.Piccture := Picture;
                                Cust.Signature := Signature;
                                //END ELSE
                                //ERROR('Kindly upload a Picture and signature');

                                Cust."Monthly Contribution" := "Monthly Contribution";
                                Cust."Contact Person" := "Contact Person";
                                Cust."Contact Person Phone" := "Contact Person Phone";
                                Cust."ContactPerson Relation" := "ContactPerson Relation";
                                Cust."Recruited By" := "Recruited By";
                                Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                                Cust."Village/Residence" := "Village/Residence";
                                Cust.Insert(true);
                                //Cust.VALIDATE(Cust."ID No.");

                                //CLEAR(Picture);
                                //CLEAR(Signature);
                                //MODIFY;
                                Saccosetup.BosaNumber := IncStr(NewMembNo);
                                Saccosetup.Modify;
                                BOSAACC := Cust."No.";

                                //END;

                                //Smart Saver Account Starts Here-----------------------------------------------------
                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, 'SMART');
                                if AccoutTypes.Find('-') then begin
                                    AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes.Branch + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                end;

                                //Create FOSA account
                                Accounts.Init;
                                Accounts."No." := AcctNo;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts.Name := Name;
                                Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                Accounts."Personal No." := "Payroll No";
                                Accounts."ID No." := "ID No.";
                                Accounts."Mobile Phone No" := "Mobile Phone No";
                                Accounts."Registration Date" := "Registration Date";
                                Accounts."Post Code" := "Postal Code";
                                Accounts.County := City;
                                Accounts."BOSA Account No" := Cust."No.";
                                Accounts.Piccture := Picture;
                                Accounts.Signature := Signature;
                                Accounts."Passport No." := "Passport No.";
                                Accounts."Employer Code" := "Employer Code";
                                Accounts.Status := Accounts.Status::New;
                                Accounts."Account Type" := 'SMART';
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts."Global Dimension 1 Code" := 'FOSA';
                                Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Accounts.Address := Address;
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
                                //Accounts."Home Page":="Home Page";
                                //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                //Accounts."Signing Instructions":="Signing Instructions";
                                //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                //Accounts."FD Maturity Date":="FD Maturity Date";
                                //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                //Accounts."Departments Code":="Departments Code";
                                //Accounts."Sections Code":="Sections Code";
                                Accounts.Insert;


                                Accounts.Reset;
                                if Accounts.Get(AcctNo) then begin
                                    Accounts.Validate(Accounts.Name);
                                    Accounts.Validate(Accounts."Account Type");
                                    Accounts.Validate(Accounts."Global Dimension 1 Code");
                                    Accounts.Validate(Accounts."Global Dimension 2 Code");
                                    Accounts.Modify;

                                    AccoutTypes.Reset;
                                    AccoutTypes.SetRange(AccoutTypes.Code, 'SMART');
                                    if AccoutTypes.Find('-') then begin
                                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                        AccoutTypes.Modify;
                                    end;

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
                                        NextOfKin.Init;
                                        NextOfKin."Account No" := BOSAACC;
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
                                        //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                        AccountSign.Insert;
                                    until AccountSignApp.Next = 0;
                                end;
                            end;
                            //End Smart Saver Account-------------------------------------------------------
                            //End of BOSA+Smart Saver-------------------------------------------------------

                            //BOSA +Fixed----------------------------------------------------------------------
                            if Products = Products::"BOSA+Fixed Deposit" then begin
                                if Cust."Customer Posting Group" <> 'PLAZA' then
                                    if "ID No." <> '' then begin
                                        Cust.Reset;
                                        Cust.SetRange(Cust."ID No.", "ID No.");
                                        Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                                        if Cust.Find('-') then begin
                                            if (Cust."No." <> "No.") and ("Account Category" = "account category"::Single) then
                                                Error('Member has already been created');
                                        end;
                                    end;
                                Saccosetup.Get();
                                NewMembNo := Saccosetup.BosaNumber;
                                //IF UPPERCASE("Sent for Approval By")=UPPERCASE(USERID) THEN
                                //.ERROR('Operation denied');

                                //Create BOSA account
                                Cust."No." := Format(NewMembNo);
                                Cust.Name := Name;
                                Cust.Address := Address;
                                Cust."Post Code" := "Postal Code";
                                Cust.County := City;
                                Cust."Phone No." := "Phone No.";
                                Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Cust."Customer Posting Group" := "Customer Posting Group";
                                Cust."Registration Date" := Today;
                                Cust."Mobile Phone No" := "Mobile Phone No";
                                Cust.Status := Cust.Status::Active;
                                Cust."Employer Code" := "Employer Code";
                                Cust."Date of Birth" := "Date of Birth";
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

                                CalcFields(Signature, Picture);
                                //PictureExists:=Picture.HASVALUE;
                                //SignatureExists:=Signature.HASVALUE;
                                //IF (PictureExists=TRUE) AND (SignatureExists=TRUE) THEN BEGIN
                                Cust.Piccture := Picture;
                                Cust.Signature := Signature;
                                //END ELSE
                                //ERROR('Kindly upload a Picture and signature');

                                Cust."Monthly Contribution" := "Monthly Contribution";
                                Cust."Contact Person" := "Contact Person";
                                Cust."Contact Person Phone" := "Contact Person Phone";
                                Cust."ContactPerson Relation" := "ContactPerson Relation";
                                Cust."Recruited By" := "Recruited By";
                                Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                                Cust."Village/Residence" := "Village/Residence";
                                Cust.Insert(true);
                                //Cust.VALIDATE(Cust."ID No.");

                                //CLEAR(Picture);
                                //CLEAR(Signature);
                                //MODIFY;
                                Saccosetup.BosaNumber := IncStr(NewMembNo);
                                Saccosetup.Modify;
                                BOSAACC := Cust."No.";

                                //END;

                                //FIXED Account Starts Here-----------------------------------------------------
                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, 'FIXED');
                                if AccoutTypes.Find('-') then begin
                                    AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes.Branch + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                end;

                                //Create Fixed account
                                Accounts.Init;
                                Accounts."No." := AcctNo;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts.Name := Name;
                                Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                Accounts."Personal No." := "Payroll No";
                                Accounts."ID No." := "ID No.";
                                Accounts."Mobile Phone No" := "Mobile Phone No";
                                Accounts."Registration Date" := "Registration Date";
                                Accounts."Post Code" := "Postal Code";
                                Accounts.County := City;
                                Accounts."BOSA Account No" := Cust."No.";
                                Accounts.Piccture := Picture;
                                Accounts.Signature := Signature;
                                Accounts."Passport No." := "Passport No.";
                                Accounts."Employer Code" := "Employer Code";
                                Accounts.Status := Accounts.Status::New;
                                Accounts."Account Type" := 'FIXED';
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts."Global Dimension 1 Code" := 'FOSA';
                                Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Accounts.Address := Address;
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
                                //Accounts."Home Page":="Home Page";
                                //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                //Accounts."Signing Instructions":="Signing Instructions";
                                //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                //Accounts."FD Maturity Date":="FD Maturity Date";
                                //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                //Accounts."Departments Code":="Departments Code";
                                //Accounts."Sections Code":="Sections Code";
                                Accounts.Insert;


                                Accounts.Reset;
                                if Accounts.Get(AcctNo) then begin
                                    Accounts.Validate(Accounts.Name);
                                    Accounts.Validate(Accounts."Account Type");
                                    Accounts.Validate(Accounts."Global Dimension 1 Code");
                                    Accounts.Validate(Accounts."Global Dimension 2 Code");
                                    Accounts.Modify;

                                    AccoutTypes.Reset;
                                    AccoutTypes.SetRange(AccoutTypes.Code, 'FIXED');
                                    if AccoutTypes.Find('-') then begin
                                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                        AccoutTypes.Modify;
                                    end;

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
                                        NextOfKin.Init;
                                        NextOfKin."Account No" := BOSAACC;
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
                                        //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                        AccountSign.Insert;
                                    until AccountSignApp.Next = 0;
                                end;
                            end;
                            //End Fixed Deposit Account-------------------------------------------------------
                            //End of BOSA+Fixed---------------------------------------------------------------


                            //BOSA +CURRENT----------------------------------------------------------------------
                            if Products = Products::"Current Only" then begin
                                //Current Account Starts Here-----------------------------------------------------
                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, 'CURRENT');
                                if AccoutTypes.Find('-') then begin
                                    AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes.Branch + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                end;

                                //Create FOSA account
                                Accounts.Init;
                                Accounts."No." := AcctNo;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts.Name := Name;
                                Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                Accounts."Personal No." := "Payroll No";
                                Accounts."ID No." := "ID No.";
                                Accounts."Mobile Phone No" := "Mobile Phone No";
                                Accounts."Registration Date" := "Registration Date";
                                Accounts."Post Code" := "Postal Code";
                                Accounts.County := City;
                                Accounts."BOSA Account No" := Cust."No.";
                                Accounts.Piccture := Picture;
                                Accounts.Signature := Signature;
                                Accounts."Passport No." := "Passport No.";
                                Accounts."Employer Code" := "Employer Code";
                                Accounts.Status := Accounts.Status::New;
                                Accounts."Account Type" := 'CURRENT';
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts."Global Dimension 1 Code" := 'FOSA';
                                Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Accounts.Address := Address;
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
                                //Accounts."Home Page":="Home Page";
                                //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                //Accounts."Signing Instructions":="Signing Instructions";
                                //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                //Accounts."FD Maturity Date":="FD Maturity Date";
                                //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                //Accounts."Departments Code":="Departments Code";
                                //Accounts."Sections Code":="Sections Code";
                                Accounts.Insert;


                                Accounts.Reset;
                                if Accounts.Get(AcctNo) then begin
                                    Accounts.Validate(Accounts.Name);
                                    Accounts.Validate(Accounts."Account Type");
                                    Accounts.Validate(Accounts."Global Dimension 1 Code");
                                    Accounts.Validate(Accounts."Global Dimension 2 Code");
                                    Accounts.Modify;

                                    AccoutTypes.Reset;
                                    AccoutTypes.SetRange(AccoutTypes.Code, 'CURRENT');
                                    if AccoutTypes.Find('-') then begin
                                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                        AccoutTypes.Modify;
                                    end;

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
                                        NextOfKin.Init;
                                        NextOfKin."Account No" := BOSAACC;
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
                                        //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                        AccountSign.Insert;
                                    until AccountSignApp.Next = 0;
                                end;
                            end;
                            //End Current Account Only-------------------------------------------------------

                            //Smart Saver Only ---------------------------------------------------------------
                            if Products = Products::"Smart Saver Only" then begin
                                //Smart Saver Account Starts Here-----------------------------------------------------
                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, 'SMART');
                                if AccoutTypes.Find('-') then begin
                                    AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes.Branch + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                end;

                                //Create FOSA account
                                Accounts.Init;
                                Accounts."No." := AcctNo;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts.Name := Name;
                                Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                Accounts."Personal No." := "Payroll No";
                                Accounts."ID No." := "ID No.";
                                Accounts."Mobile Phone No" := "Mobile Phone No";
                                Accounts."Registration Date" := "Registration Date";
                                Accounts."Post Code" := "Postal Code";
                                Accounts.County := City;
                                Accounts."BOSA Account No" := Cust."No.";
                                Accounts.Piccture := Picture;
                                Accounts.Signature := Signature;
                                Accounts."Passport No." := "Passport No.";
                                Accounts."Employer Code" := "Employer Code";
                                Accounts.Status := Accounts.Status::New;
                                Accounts."Account Type" := 'SMART';
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts."Global Dimension 1 Code" := 'FOSA';
                                Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Accounts.Address := Address;
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
                                //Accounts."Home Page":="Home Page";
                                //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                //Accounts."Signing Instructions":="Signing Instructions";
                                //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                //Accounts."FD Maturity Date":="FD Maturity Date";
                                //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                //Accounts."Departments Code":="Departments Code";
                                //Accounts."Sections Code":="Sections Code";
                                Accounts.Insert;


                                Accounts.Reset;
                                if Accounts.Get(AcctNo) then begin
                                    Accounts.Validate(Accounts.Name);
                                    Accounts.Validate(Accounts."Account Type");
                                    Accounts.Validate(Accounts."Global Dimension 1 Code");
                                    Accounts.Validate(Accounts."Global Dimension 2 Code");
                                    Accounts.Modify;

                                    AccoutTypes.Reset;
                                    AccoutTypes.SetRange(AccoutTypes.Code, 'SMART');
                                    if AccoutTypes.Find('-') then begin
                                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                        AccoutTypes.Modify;
                                    end;

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
                                        NextOfKin.Init;
                                        NextOfKin."Account No" := BOSAACC;
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
                                        //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                        AccountSign.Insert;
                                    until AccountSignApp.Next = 0;
                                end;
                            end;
                            //End Smart Saver Account Only-------------------------------------------------------



                            //Fixed Deposit Only ---------------------------------------------------------------
                            if Products = Products::"Fixed  Deposit Only" then begin
                                //Smart Saver Account Starts Here-----------------------------------------------------
                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, 'Fixed');
                                if AccoutTypes.Find('-') then begin
                                    AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes.Branch + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                end;

                                //Create FOSA account
                                Accounts.Init;
                                Accounts."No." := AcctNo;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts.Name := Name;
                                Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                Accounts."Personal No." := "Payroll No";
                                Accounts."ID No." := "ID No.";
                                Accounts."Mobile Phone No" := "Mobile Phone No";
                                Accounts."Registration Date" := "Registration Date";
                                Accounts."Post Code" := "Postal Code";
                                Accounts.County := City;
                                Accounts."BOSA Account No" := Cust."No.";
                                Accounts.Piccture := Picture;
                                Accounts.Signature := Signature;
                                Accounts."Passport No." := "Passport No.";
                                Accounts."Employer Code" := "Employer Code";
                                Accounts.Status := Accounts.Status::New;
                                Accounts."Account Type" := 'FIXED';
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts."Global Dimension 1 Code" := 'FOSA';
                                Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Accounts.Address := Address;
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
                                //Accounts."Home Page":="Home Page";
                                //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                //Accounts."Signing Instructions":="Signing Instructions";
                                //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                //Accounts."FD Maturity Date":="FD Maturity Date";
                                //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                //Accounts."Departments Code":="Departments Code";
                                //Accounts."Sections Code":="Sections Code";
                                Accounts.Insert;


                                Accounts.Reset;
                                if Accounts.Get(AcctNo) then begin
                                    Accounts.Validate(Accounts.Name);
                                    Accounts.Validate(Accounts."Account Type");
                                    Accounts.Validate(Accounts."Global Dimension 1 Code");
                                    Accounts.Validate(Accounts."Global Dimension 2 Code");
                                    Accounts.Modify;

                                    AccoutTypes.Reset;
                                    AccoutTypes.SetRange(AccoutTypes.Code, 'FIXED');
                                    if AccoutTypes.Find('-') then begin
                                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                        AccoutTypes.Modify;
                                    end;

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
                                        NextOfKin.Init;
                                        NextOfKin."Account No" := BOSAACC;
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
                                        //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                        AccountSign.Insert;
                                    until AccountSignApp.Next = 0;
                                end;
                            end;
                            //End FIXED Deposit Account Only-------------------------------------------------------

                            //Fixed Deposit +Current ---------------------------------------------------------------
                            if Products = Products::"Fixed+Current" then begin
                                //Fixed Deposit Account Starts Here-----------------------------------------------------
                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, 'FIXED');
                                if AccoutTypes.Find('-') then begin
                                    AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes.Branch + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                end;

                                //Create FOSA account
                                Accounts.Init;
                                Accounts."No." := AcctNo;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts.Name := Name;
                                Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                Accounts."Personal No." := "Payroll No";
                                Accounts."ID No." := "ID No.";
                                Accounts."Mobile Phone No" := "Mobile Phone No";
                                Accounts."Registration Date" := "Registration Date";
                                Accounts."Post Code" := "Postal Code";
                                Accounts.County := City;
                                Accounts."BOSA Account No" := Cust."No.";
                                Accounts.Piccture := Picture;
                                Accounts.Signature := Signature;
                                Accounts."Passport No." := "Passport No.";
                                Accounts."Employer Code" := "Employer Code";
                                Accounts.Status := Accounts.Status::New;
                                Accounts."Account Type" := 'FIXED';
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts."Global Dimension 1 Code" := 'FOSA';
                                Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Accounts.Address := Address;
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
                                //Accounts."Home Page":="Home Page";
                                //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                //Accounts."Signing Instructions":="Signing Instructions";
                                //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                //Accounts."FD Maturity Date":="FD Maturity Date";
                                //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                //Accounts."Departments Code":="Departments Code";
                                //Accounts."Sections Code":="Sections Code";
                                Accounts.Insert;


                                Accounts.Reset;
                                if Accounts.Get(AcctNo) then begin
                                    Accounts.Validate(Accounts.Name);
                                    Accounts.Validate(Accounts."Account Type");
                                    Accounts.Validate(Accounts."Global Dimension 1 Code");
                                    Accounts.Validate(Accounts."Global Dimension 2 Code");
                                    Accounts.Modify;

                                    AccoutTypes.Reset;
                                    AccoutTypes.SetRange(AccoutTypes.Code, 'FIXED');
                                    if AccoutTypes.Find('-') then begin
                                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                        AccoutTypes.Modify;
                                    end;

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
                                        NextOfKin.Init;
                                        NextOfKin."Account No" := BOSAACC;
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
                                        //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                        AccountSign.Insert;
                                    until AccountSignApp.Next = 0;
                                end;


                                //Current Account Starts Here-------------------------------------------------------
                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, 'CURRENT');
                                if AccoutTypes.Find('-') then begin
                                    AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes.Branch + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                end;

                                //Create FOSA account
                                Accounts.Init;
                                Accounts."No." := AcctNo;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts.Name := Name;
                                Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                Accounts."Personal No." := "Payroll No";
                                Accounts."ID No." := "ID No.";
                                Accounts."Mobile Phone No" := "Mobile Phone No";
                                Accounts."Registration Date" := "Registration Date";
                                Accounts."Post Code" := "Postal Code";
                                Accounts.County := City;
                                Accounts."BOSA Account No" := Cust."No.";
                                Accounts.Piccture := Picture;
                                Accounts.Signature := Signature;
                                Accounts."Passport No." := "Passport No.";
                                Accounts."Employer Code" := "Employer Code";
                                Accounts.Status := Accounts.Status::New;
                                Accounts."Account Type" := 'CURRENT';
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts."Global Dimension 1 Code" := 'FOSA';
                                Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Accounts.Address := Address;
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
                                //Accounts."Home Page":="Home Page";
                                //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                //Accounts."Signing Instructions":="Signing Instructions";
                                //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                //Accounts."FD Maturity Date":="FD Maturity Date";
                                //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                //Accounts."Departments Code":="Departments Code";
                                //Accounts."Sections Code":="Sections Code";
                                Accounts.Insert;


                                Accounts.Reset;
                                if Accounts.Get(AcctNo) then begin
                                    Accounts.Validate(Accounts.Name);
                                    Accounts.Validate(Accounts."Account Type");
                                    Accounts.Validate(Accounts."Global Dimension 1 Code");
                                    Accounts.Validate(Accounts."Global Dimension 2 Code");
                                    Accounts.Modify;

                                    AccoutTypes.Reset;
                                    AccoutTypes.SetRange(AccoutTypes.Code, 'CURRENT');
                                    if AccoutTypes.Find('-') then begin
                                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                        AccoutTypes.Modify;
                                    end;

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
                                        NextOfKin.Init;
                                        NextOfKin."Account No" := BOSAACC;
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
                                        //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                        AccountSign.Insert;
                                    until AccountSignApp.Next = 0;
                                end;
                            end;
                            //End Current Account-------------------------------------------------------
                            //End Current+Fixed----------------------------------------------------------

                            //Fixed Deposit +Smart Saver ---------------------------------------------------------------
                            if Products = Products::"Fixed+Smart Saver" then begin
                                //Fixed Deposit Account Starts Here-----------------------------------------------------
                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, 'FIXED');
                                if AccoutTypes.Find('-') then begin
                                    AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes.Branch + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                end;

                                //Create FOSA account
                                Accounts.Init;
                                Accounts."No." := AcctNo;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts.Name := Name;
                                Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                Accounts."Personal No." := "Payroll No";
                                Accounts."ID No." := "ID No.";
                                Accounts."Mobile Phone No" := "Mobile Phone No";
                                Accounts."Registration Date" := "Registration Date";
                                Accounts."Post Code" := "Postal Code";
                                Accounts.County := City;
                                Accounts."BOSA Account No" := Cust."No.";
                                Accounts.Piccture := Picture;
                                Accounts.Signature := Signature;
                                Accounts."Passport No." := "Passport No.";
                                Accounts."Employer Code" := "Employer Code";
                                Accounts.Status := Accounts.Status::New;
                                Accounts."Account Type" := 'FIXED';
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts."Global Dimension 1 Code" := 'FOSA';
                                Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Accounts.Address := Address;
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
                                //Accounts."Home Page":="Home Page";
                                //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                //Accounts."Signing Instructions":="Signing Instructions";
                                //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                //Accounts."FD Maturity Date":="FD Maturity Date";
                                //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                //Accounts."Departments Code":="Departments Code";
                                //Accounts."Sections Code":="Sections Code";
                                Accounts.Insert;


                                Accounts.Reset;
                                if Accounts.Get(AcctNo) then begin
                                    Accounts.Validate(Accounts.Name);
                                    Accounts.Validate(Accounts."Account Type");
                                    Accounts.Validate(Accounts."Global Dimension 1 Code");
                                    Accounts.Validate(Accounts."Global Dimension 2 Code");
                                    Accounts.Modify;

                                    AccoutTypes.Reset;
                                    AccoutTypes.SetRange(AccoutTypes.Code, 'FIXED');
                                    if AccoutTypes.Find('-') then begin
                                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                        AccoutTypes.Modify;
                                    end;

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
                                        NextOfKin.Init;
                                        NextOfKin."Account No" := BOSAACC;
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
                                        //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                        AccountSign.Insert;
                                    until AccountSignApp.Next = 0;
                                end;


                                //Smart Saver Account Starts Here-------------------------------------------------------
                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, 'SMART');
                                if AccoutTypes.Find('-') then begin
                                    AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes.Branch + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                end;

                                //Create FOSA account
                                Accounts.Init;
                                Accounts."No." := AcctNo;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts.Name := Name;
                                Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                Accounts."Personal No." := "Payroll No";
                                Accounts."ID No." := "ID No.";
                                Accounts."Mobile Phone No" := "Mobile Phone No";
                                Accounts."Registration Date" := "Registration Date";
                                Accounts."Post Code" := "Postal Code";
                                Accounts.County := City;
                                Accounts."BOSA Account No" := Cust."No.";
                                Accounts.Piccture := Picture;
                                Accounts.Signature := Signature;
                                Accounts."Passport No." := "Passport No.";
                                Accounts."Employer Code" := "Employer Code";
                                Accounts.Status := Accounts.Status::New;
                                Accounts."Account Type" := 'SMART';
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts."Global Dimension 1 Code" := 'FOSA';
                                Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Accounts.Address := Address;
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
                                //Accounts."Home Page":="Home Page";
                                //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                //Accounts."Signing Instructions":="Signing Instructions";
                                //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                //Accounts."FD Maturity Date":="FD Maturity Date";
                                //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                //Accounts."Departments Code":="Departments Code";
                                //Accounts."Sections Code":="Sections Code";
                                Accounts.Insert;


                                Accounts.Reset;
                                if Accounts.Get(AcctNo) then begin
                                    Accounts.Validate(Accounts.Name);
                                    Accounts.Validate(Accounts."Account Type");
                                    Accounts.Validate(Accounts."Global Dimension 1 Code");
                                    Accounts.Validate(Accounts."Global Dimension 2 Code");
                                    Accounts.Modify;

                                    AccoutTypes.Reset;
                                    AccoutTypes.SetRange(AccoutTypes.Code, 'SMART');
                                    if AccoutTypes.Find('-') then begin
                                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                        AccoutTypes.Modify;
                                    end;

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
                                        NextOfKin.Init;
                                        NextOfKin."Account No" := BOSAACC;
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
                                        //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                        AccountSign.Insert;
                                    until AccountSignApp.Next = 0;
                                end;
                            end;
                            //End Smart Saver Account-------------------------------------------------------
                            //End Smart Saver+Fixed----------------------------------------------------------

                            //Current +Smart Saver ---------------------------------------------------------------
                            if Products = Products::"Current+Smart Saver" then begin
                                //Smart Saver Account Starts Here-----------------------------------------------------
                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, 'CURRENT');
                                if AccoutTypes.Find('-') then begin
                                    AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes.Branch + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                end;

                                //Create FOSA account
                                Accounts.Init;
                                Accounts."No." := AcctNo;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts.Name := Name;
                                Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                Accounts."Personal No." := "Payroll No";
                                Accounts."ID No." := "ID No.";
                                Accounts."Mobile Phone No" := "Mobile Phone No";
                                Accounts."Registration Date" := "Registration Date";
                                Accounts."Post Code" := "Postal Code";
                                Accounts.County := City;
                                Accounts."BOSA Account No" := Cust."No.";
                                Accounts.Piccture := Picture;
                                Accounts.Signature := Signature;
                                Accounts."Passport No." := "Passport No.";
                                Accounts."Employer Code" := "Employer Code";
                                Accounts.Status := Accounts.Status::New;
                                Accounts."Account Type" := 'CURRENT';
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts."Global Dimension 1 Code" := 'FOSA';
                                Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Accounts.Address := Address;
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
                                //Accounts."Home Page":="Home Page";
                                //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                //Accounts."Signing Instructions":="Signing Instructions";
                                //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                //Accounts."FD Maturity Date":="FD Maturity Date";
                                //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                //Accounts."Departments Code":="Departments Code";
                                //Accounts."Sections Code":="Sections Code";
                                Accounts.Insert;


                                Accounts.Reset;
                                if Accounts.Get(AcctNo) then begin
                                    Accounts.Validate(Accounts.Name);
                                    Accounts.Validate(Accounts."Account Type");
                                    Accounts.Validate(Accounts."Global Dimension 1 Code");
                                    Accounts.Validate(Accounts."Global Dimension 2 Code");
                                    Accounts.Modify;

                                    AccoutTypes.Reset;
                                    AccoutTypes.SetRange(AccoutTypes.Code, 'CURRENT');
                                    if AccoutTypes.Find('-') then begin
                                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                        AccoutTypes.Modify;
                                    end;

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
                                        NextOfKin.Init;
                                        NextOfKin."Account No" := BOSAACC;
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
                                        //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                        AccountSign.Insert;
                                    until AccountSignApp.Next = 0;
                                end;


                                //Smart Saver Account Starts Here-------------------------------------------------------
                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, 'SMART');
                                if AccoutTypes.Find('-') then begin
                                    AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes.Branch + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                end;

                                //Create FOSA account
                                Accounts.Init;
                                Accounts."No." := AcctNo;
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts.Name := Name;
                                Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                Accounts."Personal No." := "Payroll No";
                                Accounts."ID No." := "ID No.";
                                Accounts."Mobile Phone No" := "Mobile Phone No";
                                Accounts."Registration Date" := "Registration Date";
                                Accounts."Post Code" := "Postal Code";
                                Accounts.County := City;
                                Accounts."BOSA Account No" := Cust."No.";
                                Accounts.Piccture := Picture;
                                Accounts.Signature := Signature;
                                Accounts."Passport No." := "Passport No.";
                                Accounts."Employer Code" := "Employer Code";
                                Accounts.Status := Accounts.Status::New;
                                Accounts."Account Type" := 'SMART';
                                Accounts."Date of Birth" := "Date of Birth";
                                Accounts."Global Dimension 1 Code" := 'FOSA';
                                Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Accounts.Address := Address;
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
                                //Accounts."Home Page":="Home Page";
                                //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                //Accounts."Signing Instructions":="Signing Instructions";
                                //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                //Accounts."FD Maturity Date":="FD Maturity Date";
                                //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                //Accounts."Departments Code":="Departments Code";
                                //Accounts."Sections Code":="Sections Code";
                                Accounts.Insert;


                                Accounts.Reset;
                                if Accounts.Get(AcctNo) then begin
                                    Accounts.Validate(Accounts.Name);
                                    Accounts.Validate(Accounts."Account Type");
                                    Accounts.Validate(Accounts."Global Dimension 1 Code");
                                    Accounts.Validate(Accounts."Global Dimension 2 Code");
                                    Accounts.Modify;

                                    AccoutTypes.Reset;
                                    AccoutTypes.SetRange(AccoutTypes.Code, 'SMART');
                                    if AccoutTypes.Find('-') then begin
                                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                        AccoutTypes.Modify;
                                    end;

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
                                        NextOfKin.Init;
                                        NextOfKin."Account No" := BOSAACC;
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
                                        //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                        AccountSign.Insert;
                                    until AccountSignApp.Next = 0;
                                end;
                            end;
                            //End Smart Saver Account-------------------------------------------------------
                            //End Smart Saver+Current----------------------------------------------------------


                            Cust.Reset;
                            if Cust.Get(BOSAACC) then begin
                                Cust.Validate(Cust.Name);
                                //Cust.VALIDATE(Accounts."Account Type");
                                Cust.Validate(Cust."Global Dimension 1 Code");
                                Cust.Validate(Cust."Global Dimension 2 Code");
                                Cust.Modify;
                            end;

                            /*
                            GenSetUp.GET();
                             Notification.CreateMessage('Dynamics NAV',GenSetUp."Sender Address","E-Mail (Personal)",'Member Acceptance Notification',
                                            'Member application '+ "No." + ' has been approved'
                                           + ' (Dynamics NAV ERP)',FALSE);
                             Notification.Send;
                            */

                            //"Converted By":=USERID;
                            Message('Account created successfully.');
                            Message('The Member Sacco no is %1', Cust."No.");
                            //END;
                            Status := Status::Approved;
                            "Approved By" := UserId;
                            Created := true;
                            "Created By" := UserId;
                            Modify;
                        end else
                            Error('Not approved');



                        //SMS MESSAGE
                        SMSMessage.Reset;
                        if SMSMessage.Find('+') then begin
                            iEntryNo := SMSMessage."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;

                        SMSMessage.Reset;
                        SMSMessage.Init;
                        SMSMessage."Entry No" := iEntryNo;
                        SMSMessage."Account No" := "No.";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'MEMBER';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Your membership application has been approved at DIMKES Sacco Ltd.' +
                                                  ' Your Membership No. is ' + "No.";
                        SMSMessage."Telephone No" := "Phone No.";
                        SMSMessage.Insert;


                        //Advice Employer
                        DataSheet.Init;
                        DataSheet."PF/Staff No" := "Payroll No";
                        DataSheet."Type of Deduction" := 'Shares/Deposits';
                        DataSheet."Remark/LoanNO" := 'ADJ FORM';
                        DataSheet.Name := Name;
                        DataSheet."ID NO." := "ID No.";
                        DataSheet."Amount ON" := "Monthly Contribution";
                        DataSheet."REF." := '2026';
                        DataSheet."New Balance" := 0;
                        DataSheet.Date := Today;
                        DataSheet."Amount OFF" := xRec."Monthly Contribution";
                        DataSheet.Employer := "Employer Code";
                        DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
                        //DataSheet."Sort Code":=PTEN;
                        DataSheet.Insert;

                    end;
                }
                action("Create Account ")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('This application has not been approved');


                        if Confirm('Are you sure you want to create account application?', false) = true then begin


                            ProductsApp.Reset;
                            ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                            if ProductsApp.Find('-') then begin
                                repeat


                                    //Back office Account***********************************************************************************************
                                    if ProductsApp."Product Source" = ProductsApp."product source"::BOSA then begin
                                        if Cust."Customer Posting Group" <> 'PLAZA' then
                                            if "ID No." <> '' then begin
                                                Cust.Reset;
                                                Cust.SetRange(Cust."ID No.", "ID No.");
                                                Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                                                if Cust.Find('-') then begin
                                                    if (Cust."No." <> "No.") and ("Account Category" = "account category"::Single) then
                                                        Error('Member has already been created');
                                                end;
                                            end;
                                        Saccosetup.Get();
                                        NewMembNo := Saccosetup.BosaNumber;
                                        //IF UPPERCASE("Sent for Approval By")=UPPERCASE(USERID) THEN
                                        //.ERROR('Operation denied');

                                        //Create BOSA account
                                        Cust."No." := Format(NewMembNo);
                                        Cust.Name := Name;
                                        Cust.Address := Address;
                                        Cust."Post Code" := "Postal Code";
                                        Cust.County := City;
                                        Cust."Phone No." := "Phone No.";
                                        Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                        Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                        Cust."Customer Posting Group" := "Customer Posting Group";
                                        Cust."Registration Date" := Today;
                                        Cust."Mobile Phone No" := "Mobile Phone No";
                                        Cust.Status := Cust.Status::Active;
                                        Cust."Employer Code" := "Employer Code";
                                        Cust."Date of Birth" := "Date of Birth";
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

                                        CalcFields(Signature, Picture);
                                        //PictureExists:=Picture.HASVALUE;
                                        //SignatureExists:=Signature.HASVALUE;
                                        //IF (PictureExists=TRUE) AND (SignatureExists=TRUE) THEN BEGIN
                                        Cust.Piccture := Picture;
                                        Cust.Signature := Signature;
                                        //END ELSE
                                        //ERROR('Kindly upload a Picture and signature');

                                        Cust."Monthly Contribution" := "Monthly Contribution";
                                        Cust."Contact Person" := "Contact Person";
                                        Cust."Contact Person Phone" := "Contact Person Phone";
                                        Cust."ContactPerson Relation" := "ContactPerson Relation";
                                        Cust."Recruited By" := "Recruited By";
                                        Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                                        Cust."Village/Residence" := "Village/Residence";
                                        Cust.Insert(true);
                                        //Cust.VALIDATE(Cust."ID No.");

                                        NextOfKinApp.Reset;
                                        NextOfKinApp.SetRange(NextOfKinApp."Account No", "No.");
                                        if NextOfKinApp.Find('-') then begin
                                            repeat
                                                NextOfKin.Init;
                                                NextOfKin."Account No" := BOSAACC;
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
                                                //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                                AccountSign.Insert;
                                            until AccountSignApp.Next = 0;
                                        end;

                                        //CLEAR(Picture);
                                        //CLEAR(Signature);
                                        //MODIFY;
                                        Saccosetup.BosaNumber := IncStr(NewMembNo);
                                        Saccosetup.Modify;
                                        BOSAACC := Cust."No.";
                                    end;
                                until ProductsApp.Next = 0;
                            end;
                        end;

                        //End Back Office Account*****************************************************************************

                        //Front Office Accounts*******************************************************************************
                        ProductsApp.Reset;
                        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                        if ProductsApp.Find('-') then begin
                            repeat

                                if ProductsApp."Product Source" = ProductsApp."product source"::FOSA then begin
                                    AccoutTypes.Reset;
                                    AccoutTypes.SetRange(AccoutTypes.Code, ProductsApp.Product);
                                    if AccoutTypes.Find('-') then begin
                                        AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes.Branch + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                    end;


                                    //Create FOSA account
                                    Accounts.Init;
                                    Accounts."No." := AcctNo;
                                    Accounts."Date of Birth" := "Date of Birth";
                                    Accounts.Name := Name;
                                    Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                    Accounts."Personal No." := "Payroll No";
                                    Accounts."ID No." := "ID No.";
                                    Accounts."Mobile Phone No" := "Mobile Phone No";
                                    Accounts."Registration Date" := "Registration Date";
                                    Accounts."Post Code" := "Postal Code";
                                    Accounts.County := City;
                                    Accounts."BOSA Account No" := Cust."No.";
                                    Accounts.Piccture := Picture;
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
                                    //Accounts."Home Page":="Home Page";
                                    //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                    //Accounts."Signing Instructions":="Signing Instructions";
                                    //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                    //Accounts."FD Maturity Date":="FD Maturity Date";
                                    //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                    //Accounts."Departments Code":="Departments Code";
                                    //Accounts."Sections Code":="Sections Code";

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

                                    //************End to Sort for Joint Accounts*************
                                    Accounts.Insert;


                                    Accounts.Reset;
                                    if Accounts.Get(AcctNo) then begin
                                        Accounts.Validate(Accounts.Name);
                                        Accounts.Validate(Accounts."Account Type");
                                        Accounts.Validate(Accounts."Global Dimension 1 Code");
                                        Accounts.Validate(Accounts."Global Dimension 2 Code");
                                        Accounts.Modify;

                                        AccoutTypes.Reset;
                                        AccoutTypes.SetRange(AccoutTypes.Code, ProductsApp.Product);
                                        if AccoutTypes.Find('-') then begin
                                            AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                            AccoutTypes.Modify;
                                        end;

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
                                            //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                            AccountSign.Insert;
                                        until AccountSignApp.Next = 0;
                                    end;
                                end;
                            until ProductsApp.Next = 0;
                        end;


                        Message('Account created successfully.');
                        Message('The Member Sacco no is %1', Cust."No.");
                        Message('The %1', Accounts."Account Type", 'is %1', Accounts."No.");
                        //End Front Office Accounts*******************************************************************************
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
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
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Responsibility Centre" := UserMgt.GetSalesFilter;
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
        Cust: Record Customer;
        Accounts: Record Vendor;
        AcctNo: Code[20];
        NextOfKinApp: Record "Member App Nominee";
        AccountSign: Record "Member Account Signatories";
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
        end;
    end;

    local procedure SelfRecruitedControl()
    begin

        if "Self Recruited" = true then begin
            RecruitedByEditable := false;
            RecruiterNameEditable := false;
            RecruiterRelationShipEditable := false;
        end else
            if "Self Recruited" <> true then begin
                RecruitedByEditable := true;
                RecruiterNameEditable := true;
                RecruiterRelationShipEditable := true;
            end;
    end;
}

