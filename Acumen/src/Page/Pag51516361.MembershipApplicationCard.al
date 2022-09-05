#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516361 "Membership Application Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            group("Joint Name")
            {
                Caption = 'Joint Name';
                Visible = Joint3DetailsVisible;
                field("Joint Account Name"; "Joint Account Name")
                {
                    ApplicationArea = Basic;
                    Visible = Joint2DetailsVisible;
                }
            }
            group("General Info")
            {
                Caption = 'General Info';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'No.';
                    Editable = false;
                }
                field("Assigned No."; "Assigned No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
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
                        if "Account Category" = "account category"::Single then begin
                            Joint2DetailsVisible := false;
                            Joint3DetailsVisible := false;
                        end;
                    end;
                }
                field("Member class"; "Member class")
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic;
                    Editable = FirstNameEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Name := "First Name";
                    end;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = MiddleNameEditable;
                    ShowMandatory = false;

                    trigger OnValidate()
                    begin
                        Name := "First Name" + ' ' + "Middle Name";
                    end;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = Basic;
                    Editable = LastNameEditable;
                    ShowMandatory = true;

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
                field("Payroll No"; "Payroll No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No.';
                    Editable = PayrollNoEditable;
                    ShowMandatory = false;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Editable = AddressEditable;
                    ShowMandatory = false;
                }
                field("Postal Code"; "Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = PostCodeEditable;
                    ShowMandatory = false;
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
                field(County; County)
                {
                    ApplicationArea = Basic;
                    Editable = CountryEditable;
                    Visible = false;
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
                    Editable = KRAPinEditable;
                    ShowMandatory = true;
                }
                field("Member Share Class"; "Member Share Class")
                {
                    ApplicationArea = Basic;
                    Editable = ShareClassEditable;
                    ShowMandatory = true;
                    Visible = false;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    Editable = GenderEditable;
                    OptionCaption = ' ,Male,Female';
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = MaritalstatusEditable;
                }
                field("How Did you know of DIMKES"; "How Did you know of DIMKES")
                {
                    ApplicationArea = Basic;
                    Caption = 'How Did you know About Us';
                    Editable = MaritalstatusEditable;
                    Visible = false;
                }
                field("Recruited By"; "Recruited By")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    TableRelation = "Salesperson/Purchaser".Code;
                }
                field("Recruiter Name"; "Recruiter Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    TableRelation = "Salesperson/Purchaser".Name;
                    Visible = false;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Editable = true;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field(Signature; Signature)
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Signing Instruction"; "Signing Instruction")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Home Page"; "Home Page")
                {
                    ApplicationArea = Basic;
                }
                field("Home Country"; "Home Country")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Home Postal Code2"; "Home Postal Code2")
                {
                    ApplicationArea = Basic;
                }
                field("Home Town"; "Home Town")
                {
                    ApplicationArea = Basic;
                }
                field("Home Postal Code"; "Home Postal Code")
                {
                    ApplicationArea = Basic;
                }
                field("Home Address"; "Home Address")
                {
                    ApplicationArea = Basic;
                }
                field("Member Arch Dioces"; "Member Arch Dioces")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Member Dioces"; "Member Dioces")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Member County"; "Member County")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Members Parish"; "Members Parish")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Monthly Contribution"; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyContributionEdit;
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'ACTIVITY CODE';
                    Editable = true;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'BRANCH CODE';
                    ShowMandatory = true;
                }
                field("Member's Residence"; "Member's Residence")
                {
                    ApplicationArea = Basic;
                    Editable = MemberResidenceEditable;
                }
            }
            group("Employment Info")
            {
                Caption = 'Employment Info';
                field(Control1000000004; "Employment Info")
                {
                    ApplicationArea = Basic;
                    Editable = EmploymentInfoEditable;

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
                field(Department; Department)
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch';
                    Editable = DepartmentEditable;
                }
                field("Terms of Employment"; "Terms of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = TermsofEmploymentEditable;
                    ShowMandatory = true;
                }
                field(Section; Section)
                {
                    ApplicationArea = Basic;
                    Caption = 'Department';
                }
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = OccupationEditable;
                }
                field("Others Details"; "Others Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Business Location';
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
                field(Gender2; Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    ShowMandatory = true;
                }
                field("Marital Status2"; "Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
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
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 3" := "First Name3";
                    end;
                }
                field("Middle Name 3"; "Middle Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 3" := "First Name3" + ' ' + "Middle Name 3";
                    end;
                }
                field("Last Name3"; "Last Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';
                    ShowMandatory = true;

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
                    ShowMandatory = true;
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
                field(Gender3; Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    ShowMandatory = true;
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
        area(factboxes)
        {
            part(Control8; "Member Picture-App")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                Editable = MobileEditable;
                Enabled = MobileEditable;
                SubPageLink = "No." = field("No.");
            }
            part(Control10; "Member Signature-App")
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
                action("Select Products")
                {
                    ApplicationArea = Basic;
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Products";
                    RunPageLink = "Membership Applicaton No" = field("No.");
                    Visible = true;
                }
                action("Next of Kin Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
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
                    PromotedOnly = true;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");
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
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin

                        FnCheckfieldrestriction();

                        GenSetUp.Get();


                        //Check of Member Already Exists
                        if "ID No." <> '' then begin
                            Cust.Reset;
                            Cust.SetRange(Cust."ID No.", "ID No.");
                            Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                            if Cust.Find('-') then begin
                                if (Cust."No." <> "No.") and ("Account Category" = "account category"::Single) and (Cust.Status = Cust.Status::Active) then
                                    Error('Member has already been created');
                            end;
                        end;


                        //****************Check Next of Kin Info***************
                        if ("Account Category" = "account category"::Single) then begin
                            NOkApp.Reset;
                            NOkApp.SetRange(NOkApp."Account No", "No.");
                            if NOkApp.Find('-') = false then begin
                                Error('Please Insert Next of kin Information');
                            end;
                        end;


                        //****************Check if there is any product Selected***************
                        ProductsApp.Reset;
                        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                        if ProductsApp.Find('-') = false then begin
                            Message('Member has been assigned default products');
                            MembApp.FnCreateDefaultSavingsProductsNew();
                        end;



                        if ApprovalsMgmt.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendMembershipApplicationForApproval(Rec);

                        //Application Send SMS*********************************
                        if GenSetUp."Send Membership App SMS" = true then begin
                            FnSendReceivedApplicationSMS();
                        end;

                        //Application Send Email********************************
                        if GenSetUp."Send Membership App Email" = true then begin
                            //FnSendReceivedApplicationEmail("No.","E-Mail (Personal)","ID No.");
                        end;
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
                        Approvalmgt: Codeunit WorkflowIntegration;
                    begin
                        if Confirm('Are you sure you want to cancel this approval request', false) = true then
                            ApprovalsMgmt.OnCancelMembershipApplicationApprovalRequest(Rec);
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
                separator(Action2)
                {
                    Caption = '       -';
                }
                action("Create Account ")
                {
                    ApplicationArea = Basic;
                    Enabled = true;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('This application has not been approved');
                        TestField("Global Dimension 2 Code");
                        //TESTFIELD("Payroll No");
                        //TESTFIELD("Employer Code");
                        //TESTFIELD("Monthly Contribution");
                        //TESTFIELD(Status:=Status::Approved);
                        if Confirm('Are you sure you want to create account application?', false) = true then begin


                            ProductsApp.Reset;
                            ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                            if ProductsApp.Find('-') then begin
                                repeat


                                    //Back office Account***********************************************************************************************
                                    if ProductsApp."Product Source" = ProductsApp."product source"::BOSA then begin
                                        if "ID No." <> '' then begin
                                            Cust.Reset;
                                            Cust.SetRange(Cust."ID No.", "ID No.");
                                            Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                                            if Cust.Find('-') then begin
                                                Error('Member has already been created');
                                            end;
                                        end;
                                        Saccosetup.Get();
                                        NewMembNo := Saccosetup.BosaNumber;

                                        //Create BOSA account
                                        Cust."No." := Format(NewMembNo);
                                        if "Account Category" = "account category"::Joint then begin
                                            Cust.Name := "Joint Account Name";
                                        end else begin
                                            Cust.Name := Name;
                                        end;
                                        Cust."Name 2" := "Middle Name";
                                        Cust."Name 3" := "Middle Name 3";
                                        Cust."Joint Account Name" := "Joint Account Name";
                                        Cust."Application Date" := "Registration Date";
                                        Cust.Address := Address;
                                        Cust."Post Code" := "Postal Code";
                                        Cust.County := "Member County";
                                        Cust.Dioces := "Member Dioces";
                                        Cust."Arch Dioces" := "Member Arch Dioces";
                                        Cust.Picture := Picture;
                                        Cust.Signature := Signature;
                                        Cust."Member class" := "Member class";
                                        Cust.County := County;
                                        Cust."Parish Name" := "Parish Name";
                                        Cust."Phone No." := "Mobile Phone No";
                                        Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                        Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                        Cust."Customer Posting Group" := "Customer Posting Group";
                                        Cust."Registration Date" := Today;
                                        Cust."Mobile Phone No" := "Mobile Phone No";
                                        Cust.Status := Cust.Status::Active;
                                        Cust."Station/Section" := "Station/Department";
                                        Cust."Employer Code" := "Employer Code";
                                        Cust."Terms Of Employment" := "Terms of Employment";
                                        if ObjEmployer.Get("Employer Code") then
                                            Cust."Employer Name" := ObjEmployer.Description;
                                        Cust.Occupation := Occupation;
                                        Cust."Date of Birth" := "Date of Birth";
                                        Cust.Picture := Picture;
                                        Cust.Signature := Signature;
                                        Cust."Station/Department" := Section;
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
                                        Cust.County := County;

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
                                        Cust."Member class" := "Member class";

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
                                                AccountSign.Insert;
                                            until AccountSignApp.Next = 0;
                                        end;

                                        //CLEAR(Picture);
                                        //CLEAR(Signature);
                                        //MODIFY;
                                        Saccosetup.BosaNumber := IncStr(NewMembNo);
                                        Saccosetup.Modify;
                                        BOSAACC := Cust."No.";

                                        GenJournalLine.Reset;
                                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                        GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                        GenJournalLine.DeleteAll;



                                        GenSetUp.Get();
                                        //Charge Registration Fee
                                        if GenSetUp."Charge BOSA Registration Fee" = true then begin

                                            LineNo := LineNo + 10000;

                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'GENERAL';
                                            GenJournalLine."Journal Batch Name" := 'REGFee';
                                            GenJournalLine."Document No." := "No.";
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                            GenJournalLine."Account No." := Cust."No.";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Posting Date" := Today;
                                            GenJournalLine."External Document No." := 'REGFEE/' + Format("Payroll No");
                                            GenJournalLine.Description := 'Membership Registration Fee';
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";
                                            // GenJournalLine.Amount:=GenSetUp."BOSA Registration Fee Amount";
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Shortcut Dimension 1 Code" := GenJournalLine."Shortcut Dimension 1 Code";
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                            GenJournalLine."Bal. Account No." := GenSetUp."BOSA Registration Fee Account";
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;

                                            GenJournalLine.Reset;
                                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                            GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                            if GenJournalLine.Find('-') then begin
                                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                            end;
                                        end;
                                    end;
                                until ProductsApp.Next = 0;
                            end;
                        end;
                        /////COMMISION
                        /* LineNo:=LineNo+10000;
                        
                          GenJournalLine.INIT;
                          GenJournalLine."Journal Template Name":='GENERAL';
                          GenJournalLine."Journal Batch Name":='Commission';
                          GenJournalLine."Document No.":="No.";
                          GenJournalLine."Line No.":=LineNo;
                          GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                          GenJournalLine."Account No.":="Recruited By";
                          GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                          GenJournalLine."Posting Date":=TODAY;
                          GenJournalLine."External Document No.":='Commission'+FORMAT("Payroll No");
                          GenJournalLine.Description:='Membership Registration COMMISION';
                          GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Commission;
                          GenJournalLine.Amount:=GenSetUp."BOSA Registration Fee Amount";
                          GenJournalLine.VALIDATE(GenJournalLine.Amount);
                          GenJournalLine."Shortcut Dimension 1 Code":=GenJournalLine."Shortcut Dimension 1 Code";
                          GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                          GenJournalLine."Bal. Account No.":=GenSetUp."BOSA Registration Fee Account";
                          GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                          GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                          IF GenJournalLine.Amount<>0 THEN
                          GenJournalLine.INSERT;
                        
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                        GenJournalLine.SETRANGE("Journal Batch Name",'Commission');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
                        END;*/
                        //END;
                        //END;
                        //UNTIL ProductsApp.NEXT=0;
                        //END;
                        //END;

                        ////END COMMISION
                        //End Back Office Account*****************************************************************************

                        //Front Office Accounts*******************************************************************************
                        ProductsApp.Reset;
                        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::FOSA);
                        if ProductsApp.Find('-') then begin
                            repeat

                                if ProductsApp."Product Source" = ProductsApp."product source"::FOSA then begin
                                    AccountTypes.Reset;
                                    AccountTypes.SetRange(AccountTypes.Code, ProductsApp.Product);
                                    if AccountTypes.Find('-') then begin
                                        //FOSA A/C FORMAT =PREFIX-MEMBERNO-PRODUCTCODE
                                        AcctNo := AccountTypes."Account No Prefix" + AccountTypes."Product Code" + CopyStr(NewMembNo, 1, 4);// +'-'+AccountTypes.Branch;
                                                                                                                                            // //   IF "Account Category"="Account Category"::Joint THEN
                                                                                                                                            // //      AcctNo:='02-'+ NewMembNo +'-'+AccountTypes."Product Code";
                                    end;//

                                    Accounts.Reset;
                                    Accounts.SetRange(Accounts."ID No.", "ID No.");
                                    Accounts.SetRange(Accounts."Account Type", ProductsApp.Product);
                                    if Accounts.FindSet then begin
                                        Error('The Member has an existing %1', Accounts."Account Type");
                                    end;

                                    //Create FOSA account
                                    Accounts.Init;
                                    Accounts."No." := AcctNo;
                                    Accounts."Date of Birth" := "Date of Birth";
                                    if "Account Category" = "account category"::Joint then begin
                                        Accounts.Name := "Joint Account Name";
                                    end else begin
                                        Accounts.Name := Name;

                                    end;
                                    Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                                    Accounts."Personal No." := "Payroll No";
                                    Accounts."ID No." := "ID No.";
                                    Accounts."Signing Instructions" := "Signing Instruction";
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
                                    Accounts."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                    Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                    Accounts."Member class" := "Member class";
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
                                    Accounts."Member class" := "Member class";
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
                                    if Cust."Account Category" = Cust."account category"::Joint then
                                        Accounts."Joint Account Name" := "Joint Account Name";
                                    "First Name"+' '+"First Name2";


                                    Accounts."Name 3" := "Name 3";
                                    Accounts."Address3-Joint" := Address4;
                                    Accounts."Postal Code 3" := "Postal Code 3";
                                    Accounts."Home Postal Code3" := "Home Postal Code3";
                                    Accounts."Home Town3" := "Home Town3";
                                    Accounts."ID No.3" := "ID No.3";
                                    Accounts."Passport 3" := "Passport 3";
                                    Accounts.Gender3 := Gender3;
                                    Accounts."Member class" := "Member class";
                                    Accounts."Marital Status3" := "Marital Status3";
                                    Accounts."E-Mail (Personal3)" := "E-Mail (Personal3)";
                                    Accounts."Employer Code3" := "Employer Code3";
                                    Accounts."Employer Name3" := "Employer Name3";
                                    Accounts."Picture 3" := "Picture 3";
                                    Accounts."Signature  3" := "Signature  3";
                                    Accounts."Member Parish Name 3" := "Member Parish Name 3";
                                    Accounts."Member Parish Name 3" := "Member Parish Name 3";
                                    if Cust."Account Category" = Cust."account category"::Joint then
                                        Accounts."Joint Account Name" := "First Name" + ' &' + "First Name2" + ' &' + "First Name3" + ' JA';

                                    //************End to Sort for Joint Accounts*************
                                    Accounts.Insert;


                                    Accounts.Reset;
                                    if Accounts.Get(AcctNo) then begin
                                        Accounts.Validate(Accounts.Name);
                                        Accounts.Validate(Accounts."Account Type");
                                        Accounts.Modify;

                                        AccountTypes.Reset;
                                        AccountTypes.SetRange(AccountTypes.Code, ProductsApp.Product);
                                        if AccountTypes.Find('-') then begin
                                            AccountTypes."Last No Used" := IncStr(AccountTypes."Last No Used");
                                            AccountTypes.Modify;
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
                                            AccountSign.Insert;
                                        until AccountSignApp.Next = 0;
                                    end;
                                end;
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
                                    // GenJournalLine.Amount:=GenSetUp."BOSA Registration Fee Amount";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := GenSetUp."FOSA Registration Fee Account";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;



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
                            SFactory.FnSendSMS('MEMBERAPP', 'Dear Member you have been registered succesfully,your membership No is' + Cust."No." + ',Name:' + Cust.Name + '', BOSAACC, "Mobile Phone No");
                        end;

                        //Send Email********************************
                        if GenSetUp."Send Membership Reg Email" = true then begin
                            FnSendRegistrationEmail("No.", "E-Mail (Personal)", "ID No.");
                        end;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        UpdateControls();
        EnableCreateMember := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if ((Rec.Status = Status::Approved) and (Rec."Assigned No." = '')) then
            EnableCreateMember := true;

    end;

    trigger OnAfterGetRecord()
    begin
        /*Joint2DetailsVisible:=FALSE;
        Joint3DetailsVisible:=FALSE;
        
        //"Self Recruited":=TRUE;
        IF "Account Category"<>"Account Category"::Joint THEN BEGIN
        Joint2DetailsVisible:=FALSE;
        Joint3DetailsVisible:=FALSE;
        END ELSE
        Joint2DetailsVisible:=TRUE;
        Joint3DetailsVisible:=TRUE;*/

        GenSetUp.Get();
        "Monthly Contribution" := GenSetUp."Min. Contribution";


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

    trigger OnInit()
    begin
        GenSetUp.Get();
        "Customer Posting Group" := GenSetUp."Default Customer Posting Group";
        "Global Dimension 2 Code" := 'BOSA';
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Responsibility Centre" := UserMgt.GetSalesFilter;
        ObJMemberApplication.Reset;
        ObJMemberApplication.SetRange(ObJMemberApplication.Created, false);
        ObJMemberApplication.SetRange(ObJMemberApplication."Created By", UserId);
        if ObJMemberApplication.Find('-') then begin
            if ObJMemberApplication."ID No." = '' then begin
                if ObJMemberApplication.Count > 1 then begin
                    if Confirm('There are still some Unused Application Nos. Continue?', false) = false then begin
                        Error('There are still some Unused Application Nos. Please utilise them first');
                    end;
                end;
            end;
        end;
        ObJMemberApplication.FnCreateDefaultSavingsProducts();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        ObJMemberApplication.FnCreateDefaultSavingsProducts();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserMgt: Codeunit "User Management";
    begin
        GenSetUp.Get();
        "Monthly Contribution" := GenSetUp."Monthly Share Contributions";
        "Customer Posting Group" := GenSetUp."Default Customer Posting Group";
        "Global Dimension 2 Code" := 'BOSA';

        //"Self Recruited":=TRUE;





        if "Account Category" <> "account category"::Joint then begin
            Joint2DetailsVisible := false;
            Joint3DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;
        Joint3DetailsVisible := true;
        ObJMemberApplication.FnCreateDefaultSavingsProducts();
    end;

    trigger OnOpenPage()
    begin

        if UserMgt.GetSalesFilter <> '' then begin
            FilterGroup(2);
            SetRange("Responsibility Centre", UserMgt.GetSalesFilter);
            FilterGroup(0);
        end;

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;

        if "Account Category" = "account category"::Joint then begin
            Joint2DetailsVisible := true;
            Joint3DetailsVisible := true;
        end;
        if "Account Category" = "account category"::Single then begin
            Joint2DetailsVisible := false;
            Joint3DetailsVisible := false;
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
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FirstNameEditable: Boolean;
        MiddleNameEditable: Boolean;
        LastNameEditable: Boolean;
        PayrollNoEditable: Boolean;
        MemberResidenceEditable: Boolean;
        ShareClassEditable: Boolean;
        KRAPinEditable: Boolean;
        ViewLog: Record "View Log Entry";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        WelcomeMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Chuna Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>CHUNA SACCO LTD</b></p>';
        RegistrationMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Chuna Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership registration has been successfully processed</p><p style="font-family:Verdana,Arial;font-size:9pt">Your membership number is <b>%2</b></p><br>Regards<p>%3</p><p><b>CHUNA SACCO LTD</b></p>';
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        SFactory: Codeunit "SURESTEP Factory.";
        ObJMemberApplication: Record "Membership Applications";
        ObjEmployer: Record "Sacco Employers";


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
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
            //NextOfKinEditable:=FALSE;
            //EnableCreateMember:=TRUE;
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
            PictureEditable := true;
            SignatureEditable := true;
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
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
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
            FirstNameEditable := true;
            MiddleNameEditable := true;
            LastNameEditable := true;
            PayrollNoEditable := true;
            MemberResidenceEditable := true;
            ShareClassEditable := true;
            KRAPinEditable := true;
            RecruitedByEditable := true;
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
        ViewLog.Init;
        ViewLog."Entry No." := ViewLog."Entry No." + 1;
        ViewLog."User ID" := UserId;
        ViewLog."Table No." := 51516364;
        ViewLog."Table Caption" := 'Members Register';
        ViewLog.Date := Today;
        ViewLog.Time := Time;
    end;

    local procedure FnCheckfieldrestriction()
    begin
        if ("Account Category" = "account category"::Single) then begin
            //CALCFIELDS(Picture,Signature);
            TestField(Name);
            TestField("ID No.");
            TestField("Mobile Phone No");
            // TESTFIELD("Employer Code");
            //TESTFIELD("Payroll No");
            //TESTFIELD("Monthly Contribution");
            TestField("KRA PIN");
            //TESTFIELD("Copy of Current Payslip");
            //TESTFIELD("Member Registration Fee Receiv");
            //TESTFIELD("Member's Residence");
            TestField("Customer Posting Group");
            TestField("Global Dimension 1 Code");
            TestField("Global Dimension 2 Code");
            //TESTFIELD("Contact Person");
            //TESTFIELD("Contact Person Phone");
            //IF Picture=0 OR Signature=0 THEN
            //ERROR(Insert )
            TestField(Picture);
            TestField(Signature);
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
                Error('Email Address Missing for Member Application number' + '-' + Memb."No.");
            end;
            if Memb."E-Mail (Personal)" <> '' then
                SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Email, 'Membership Registration', '', true);
            SMTPMail.AppendBody(StrSubstNo(RegistrationMessage, Memb.Name, BOSAACC, "Sales Code"));
            SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AddAttachment(FileName, Attachment);
            SMTPMail.Send;
        end;
    end;
}

