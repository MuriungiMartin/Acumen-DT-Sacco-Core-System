#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516339 "Membership App card 2"
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
                    Editable = AccountCategoryEditable;
                    OptionCaption = 'Individual,Joint';

                    trigger OnValidate()
                    begin
                        Joint2DetailsVisible := false;
                        Joint3DetailsVisible := false;
                        if "Account Category" = "account category"::Joint then begin
                            Joint2DetailsVisible := true;
                            Joint3DetailsVisible := true;
                        end;
                    end;
                }
                field("Joint Account Name"; "Joint Account Name")
                {
                    ApplicationArea = Basic;
                    Visible = Joint2DetailsVisible;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Name := "First Name";
                    end;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Name := "First Name" + ' ' + "Middle Name";
                    end;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Name := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
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
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = MobileEditable;
                    ShowMandatory = true;
                }
                field("Secondary Mobile No"; "Secondary Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = SecondaryMobileEditable;
                }
                field("E-Mail (Personal)"; "E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = EmailEdiatble;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = DOBEditable;
                    ShowMandatory = true;
                }
                field(Age; Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = PassportEditable;
                }
                field("KRA PIN"; "KRA PIN")
                {
                    ApplicationArea = Basic;
                }
                field("Members Parish"; "Members Parish")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Zone';
                    Editable = MemberParishEditable;
                    ShowMandatory = true;
                }
                field("Parish Name"; "Parish Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Zone Name';
                    Editable = false;
                }
                field("Member Share Class"; "Member Share Class")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    Editable = GenderEditable;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = MaritalstatusEditable;
                }
                field("How Did you know of DIMKES"; "How Did you know of DIMKES")
                {
                    ApplicationArea = Basic;
                    Caption = 'How Did you know about Ollin?';
                    Editable = KnowDimkesEditable;

                    trigger OnValidate()
                    begin
                        if ("How Did you know of DIMKES" = "how did you know of dimkes"::"Another Member") or ("How Did you know of DIMKES" = "how did you know of dimkes"::Staff) then
                            "Self Recruited" := false;
                        Validate("Self Recruited");
                    end;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Category"; "Application Category")
                {
                    ApplicationArea = Basic;
                    Editable = AppCategoryEditable;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Editable = MonthlyContributionEdit;
                    ShowMandatory = true;
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
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerCodeEditable;
                    ShowMandatory = true;
                }
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = EmployedEditable;
                }
            }
            group("Employment Info")
            {
                Caption = 'Employment Info';
                field(Control1000000004; "Employment Info")
                {
                    ApplicationArea = Basic;
                    Editable = EmploymentInfoEditable;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if "Employment Info" = "employment info"::Employed then begin
                            EmployerCodeEditable := true;
                            DepartmentEditable := true;
                            TermsofEmploymentEditable := true;
                            ContractingEditable := false;
                            EmployedEditable := false;
                            OccupationEditable := false

                        end else
                            if "Employment Info" = "employment info"::Contracting then begin
                                ContractingEditable := true;
                                EmployerCodeEditable := false;
                                DepartmentEditable := false;
                                TermsofEmploymentEditable := false;
                                OccupationEditable := false;
                            end else
                                if "Employment Info" = "employment info"::Others then begin
                                    OthersEditable := true;
                                    ContractingEditable := false;
                                    EmployerCodeEditable := false;
                                    DepartmentEditable := false;
                                    TermsofEmploymentEditable := false;
                                    OccupationEditable := false
                                end else
                                    if "Employment Info" = "employment info"::UnEmployed then begin
                                        OccupationEditable := true;
                                        EmployerCodeEditable := false;
                                        DepartmentEditable := false;
                                        TermsofEmploymentEditable := false;
                                        ContractingEditable := false;
                                        EmployedEditable := false

                                    end;
                    end;
                }
                field(Department; Department)
                {
                    ApplicationArea = Basic;
                    Caption = 'WorkStation';
                    Editable = DepartmentEditable;
                }
                field("Terms of Employment"; "Terms of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = TermsofEmploymentEditable;
                    ShowMandatory = true;
                }
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = OccupationEditable;
                }
                field("Contracting Details"; "Contracting Details")
                {
                    ApplicationArea = Basic;
                    Editable = ContractingEditable;
                }
                field("Others Details"; "Others Details")
                {
                    ApplicationArea = Basic;
                    Editable = OthersEditable;
                }
            }
            group(Joint2Details)
            {
                Caption = 'Joint2Details';
                Visible = Joint2DetailsVisible;
                field("First Name2"; "First Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 2" := "First Name2";
                    end;
                }
                field("Middle Name2"; "Middle Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 2" := "First Name2" + ' ' + "Middle Name2";
                    end;
                }
                field("Last Name2"; "Last Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 2" := "First Name2" + ' ' + "Middle Name2" + ' ' + "Last Name2";
                    end;
                }
                field("Name 2"; "Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Payroll/Staff No2"; "Payroll/Staff No2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }
                field(Address3; Address3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                }
                field("Postal Code 2"; "Postal Code 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 2"; "Town 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Mobile No. 3"; "Mobile No. 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth2"; "Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                }
                field("ID No.2"; "ID No.2")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 2"; "Passport 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                }
                field("Member Parish 2"; "Member Parish 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    ShowMandatory = true;
                }
                field("Member Parish Name 2"; "Member Parish Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                }
                field(Gender2; Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                }
                field("Marital Status2"; "Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                }
                field("Home Postal Code2"; "Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                }
                field("Home Town2"; "Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                }
                field("Employer Code2"; "Employer Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                }
                field("Employer Name2"; "Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal2)"; "E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail (Personal)';
                }
                field("Picture 2"; "Picture 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                }
                field("Signature  2"; "Signature  2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                }
            }
            group(Joint3Details)
            {
                Visible = Joint3DetailsVisible;
                field("First Name3"; "First Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Name';

                    trigger OnValidate()
                    begin
                        "Name 3" := "First Name3";
                    end;
                }
                field("Middle Name 3"; "Middle Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';

                    trigger OnValidate()
                    begin
                        "Name 3" := "First Name3" + ' ' + "Middle Name 3";
                    end;
                }
                field("Last Name3"; "Last Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';

                    trigger OnValidate()
                    begin
                        "Name 3" := "First Name3" + ' ' + "Middle Name 3" + ' ' + "Last Name3";
                    end;
                }
                field("Name 3"; "Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Payroll/Staff No3"; "Payroll/Staff No3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll/Staff No';
                }
                field(Address4; Address4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                }
                field("Postal Code 3"; "Postal Code 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 3"; "Town 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Mobile No. 4"; "Mobile No. 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth3"; "Date of Birth3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    ShowMandatory = true;
                }
                field("ID No.3"; "ID No.3")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 3"; "Passport 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                }
                field("Member Parish 3"; "Member Parish 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    ShowMandatory = true;
                }
                field("Member Parish Name 3"; "Member Parish Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                }
                field(Gender3; Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                }
                field("Marital Status3"; "Marital Status3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                }
                field("Home Postal Code3"; "Home Postal Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                }
                field("Home Town3"; "Home Town3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                }
                field("Employer Code3"; "Employer Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                }
                field("Employer Name3"; "Employer Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal3)"; "E-Mail (Personal3)")
                {
                    ApplicationArea = Basic;
                }
                field("Picture 3"; "Picture 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                }
                field("Signature  3"; "Signature  3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
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
                action("Select Products")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Products";
                    RunPageLink = "Membership Applicaton No" = field("No."),
                                  Names = field(Name);
                }
                action("Nominee Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nominee Details';
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

                        //-------------------Check ID Or Passport---------------------------------------
                        if ("ID No." = '') and ("Passport No." = '') then
                            Error('You Must Specify Either ID or Passport No for the Applicant');
                        //-------------------Check ID Or Passport---------------------------------------


                        if ("Account Category" = "account category"::Single) then begin
                            CalcFields(Picture, Signature);
                            TestField(Name);
                            TestField("ID No.");
                            TestField("Mobile Phone No");
                            TestField("Employer Code");
                            //TESTFIELD("Personal No");
                            //TESTFIELD("Received 1 Copy Of ID");
                            //TESTFIELD("Copy of Current Payslip");
                            //TESTFIELD("Member Registration Fee Receiv");
                            //TESTFIELD("Member's Residence");
                            TestField("Customer Posting Group");
                            TestField("Global Dimension 1 Code");
                            TestField("Global Dimension 2 Code");
                            //TESTFIELD("Contact Person");
                            //TESTFIELD("Contact Person Phone");
                            //TESTFIELD("KRA PIN");
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

                        //OR ("Account Category"="Account Category"::Joint)

                        if ("Account Category" = "account category"::Single) then begin
                            NOkApp.Reset;
                            NOkApp.SetRange(NOkApp."Account No", "No.");
                            if NOkApp.Find('-') = false then begin
                                Error('Please Insert Next 0f kin Information');
                            end;
                        end;

                        if ("Account Category" = "account category"::Group) or ("Account Category" = "account category"::Corporate) then begin
                            AccountSignApp.Reset;
                            AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
                            if AccountSignApp.Find('-') = false then begin
                                Error('Please insert Account Signatories');
                            end;
                        end;
                        //Check if there is any product Selected
                        ProductsApp.Reset;
                        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                        if ProductsApp.Find('-') = false then begin
                            Error('Please Select Products to be Openned');
                        end;



                        if Status <> Status::Open then
                            Error(Text001);

                        //End allocate batch number
                        Doc_Type := Doc_type::"Account Opening";
                        Table_id := Database::"Membership Applications";
                        //IF Approvalmgt.SendApproval(Table_id,"No.",Doc_Type,Status)THEN;

                        /*IF ApprovalsMgmt.OnCancelStandingOrderApprovalRequest(Rec) THEN
                          ApprovalsMgmt.OnSendPaymentDocForApproval(Rec);*/

                        Status := Status::"Pending Approval";
                        Modify;

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


                        if Confirm('Are you sure you want to cancel this approval request', false) = true then begin
                            Status := Status::Open;
                            Modify;
                        end;

                    end;
                }
                separator(Action2)
                {
                    Caption = '       -';
                }
                action("Create Account ")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('This application has not been approved');
                        TestField("Global Dimension 2 Code");
                        //TESTFIELD("Personal No");
                        TestField("Employer Code");

                        if Confirm('Are you sure you want to create account application?', false) = true then begin


                            ProductsApp.Reset;
                            ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                            if ProductsApp.Find('-') then begin
                                repeat


                                    //Back office Account***********************************************************************************************
                                    if ProductsApp."Product Source" = ProductsApp."product source"::BOSA then begin
                                        if Cust."Customer Posting Group" <> 'PLAZA' then
                                            /*IF "ID No."<>'' THEN BEGIN
                                            Cust.RESET;
                                            Cust.SETRANGE(Cust."ID No.","ID No.");
                                            Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                                            IF Cust.FIND('-') THEN BEGIN
                                            //IF (Cust."No." <> "No.") AND ("Account Category"="Account Category"::Single) THEN
                                               ERROR('Member has already been created');
                                            END;
                                            END;*/
                        Saccosetup.Get();
                                        //Cust.RESET;
                                        //Cust.SETRANGE(Cust."No.",MembApp."No.");
                                        //IF Cust.FIND('-') THEN BEGIN
                                        NewMembNo := "Global Dimension 2 Code" + "Employer Code" + Saccosetup.BosaNumber;

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
                                        Cust."Member's Residence" := "Member's Residence";
                                        Cust."Personal No" := Saccosetup.BosaNumber;

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
                                        Cust."Member Parish 2" := "Member Parish 2";
                                        Cust."Member Parish Name 2" := "Member Parish Name 2";


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
                                        Saccosetup.BosaNumber := IncStr(Saccosetup.BosaNumber);
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
                                        AcctNo := "Global Dimension 2 Code" + '-' + "Employer Code" + '-' + AccoutTypes."Product Code" + '-' + AccoutTypes."Last No Used"
                                        // AcctNo:=AccoutTypes."Account No Prefix"+'-' + AccoutTypes.Branch +'-' + AccoutTypes."Product Code" +'-'+AccoutTypes."Last No Used"
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
                                    Accounts."Member Parish 2" := "Member Parish 2";
                                    Accounts."Member Parish Name 2" := "Member Parish Name 2";
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
                                    Accounts."Joint Account Name" := "First Name" + ' &' + "First Name2" + ' &' + "First Name3" + 'JA';

                                    //************End to Sort for Joint Accounts*************
                                    Accounts.Insert;


                                    Accounts.Reset;
                                    if Accounts.Get(AcctNo) then begin
                                        Accounts.Validate(Accounts.Name);
                                        Accounts.Validate(Accounts."Account Type");
                                        //Accounts.VALIDATE(Accounts."Global Dimension 1 Code");
                                        //Accounts.VALIDATE(Accounts."Global Dimension 2 Code");
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
                        //MESSAGE('The %1',Accounts."Account Type",'is %1',Accounts."No.");
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
        //"Self Recruited":=TRUE;
        if "Account Category" <> "account category"::Joint then begin
            Joint2DetailsVisible := false;
            Joint3DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;
        Joint3DetailsVisible := true;




        if "Employment Info" = "employment info"::Employed then begin
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false

        end else
            if "Employment Info" = "employment info"::Contracting then begin
                ContractingEditable := true;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
            end else
                if "Employment Info" = "employment info"::Others then begin
                    OthersEditable := true;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false
                end else
                    if "Employment Info" = "employment info"::UnEmployed then begin
                        OccupationEditable := true;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false

                    end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //ERROR('Cannot be deleted');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Responsibility Centre" := UserMgt.GetSalesFilter;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserMgt: Codeunit "User Management";
    begin
        GenSetUp.Get();
        "Monthly Contribution" := GenSetUp."Monthly Share Contributions";
        //"Self Recruited":=TRUE;


        if "Account Category" <> "account category"::Joint then begin
            Joint2DetailsVisible := false;
            Joint3DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;
        Joint3DetailsVisible := true;
        "Others Details" := 'Self'
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
        AccountSign: Record "FOSA Account Sign. Details";
        AccountSignApp: Record "Member Account Signatories";
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
        EmployerNameEditable: Boolean;
        DepartmentEditable: Boolean;
        TermsofEmploymentEditable: Boolean;
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
        ProductEditable: Boolean;
        SecondaryMobileEditable: Boolean;
        AccountCategoryEditable: Boolean;
        OfficeTelephoneEditable: Boolean;
        OfficeExtensionEditable: Boolean;
        MemberParishEditable: Boolean;
        KnowDimkesEditable: Boolean;
        CountyEditable: Boolean;
        DistrictEditable: Boolean;
        LocationEditable: Boolean;
        SubLocationEditable: Boolean;
        EmploymentInfoEditable: Boolean;
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
        UsersRec: Record User;
        Joint3DetailsVisible: Boolean;
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
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
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
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
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
            ProductEditable := true;
            SecondaryMobileEditable := true;
            AccountCategoryEditable := true;
            OfficeTelephoneEditable := true;
            OfficeExtensionEditable := true;
            CountyEditable := true;
            DistrictEditable := true;
            LocationEditable := true;
            SubLocationEditable := true;
            EmploymentInfoEditable := true;
            MemberParishEditable := true;
            KnowDimkesEditable := true;
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
        end
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


    procedure SendSMS()
    begin

        GenSetUp.Get;
        CompInfo.Get;

        //IF GenSetUp."S_Mobile Income Bulk"=TRUE THEN BEGIN      //Thomas to work on it
        /*
        
        //SMS MESSAGE
        SMSMessage.RESET;
        IF SMSMessage.FIND('+') THEN BEGIN
        iEntryNo:=SMSMessage."Entry No";
        iEntryNo:=iEntryNo+1;
        END
        ELSE BEGIN
        iEntryNo:=1;
        END;
        
        
        SMSMessage.INIT;
        SMSMessage."Entry No":=iEntryNo;
        SMSMessage."Batch No":="No.";
        SMSMessage."Document No":='';
        SMSMessage."Account No":=BOSAACC;
        SMSMessage."Date Entered":=TODAY;
        SMSMessage."Time Entered":=TIME;
        SMSMessage.Source:='MEMBAPP';
        SMSMessage."Entered By":=USERID;
        SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
        SMSMessage."SMS Message":='Dear Member you have been registered successfully, your Membership No is '
        + BOSAACC+' Name '+Name+' ' +CompInfo.Name+' '+GenSetUp."Customer Care No";
        SMSMessage."Telephone No":="Mobile Phone No";
        IF "Mobile Phone No"<>'' THEN
        SMSMessage.INSERT;
        
        END;
        */

    end;
}

