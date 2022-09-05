#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516360 "Membership Application List"
{
    ApplicationArea = Basic;
    CardPageID = "Membership Application Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";
    SourceTableView = where("Incomplete Application" = filter(false),
                            "Account Category" = filter(Single | Joint),
                            "Others Details" = filter(<> 'Self'));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = Basic;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Member Arch Dioces"; "Member Arch Dioces")
                {
                    ApplicationArea = Basic;
                }
                field("Member Dioces"; "Member Dioces")
                {
                    ApplicationArea = Basic;
                }
                field("Member County"; "Member County")
                {
                    ApplicationArea = Basic;
                }
                field("Salesperson Name"; "Salesperson Name")
                {
                    ApplicationArea = Basic;
                }
                field("Sales Code"; "Sales Code")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Search Name"; "Search Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Assigned No."; "Assigned No.")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Centre"; "Responsibility Centre")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll No"; "Payroll No")
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
                field("Account Type"; "Account Category")
                {
                    ApplicationArea = Basic;
                }
                field(Created; Created)
                {
                    ApplicationArea = Basic;
                }
                field("Recruited By"; "Recruited By")
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
                action("Nominee Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nominee Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Nominee Detail";
                    RunPageLink = Name = const('name');
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
                }
                separator(Action1102755012)
                {
                    Caption = '-';
                }
                action("Create Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Account';
                    Enabled = EnableCreateMember;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('This application has not been approved');
                        TestField("Global Dimension 2 Code");
                        //TESTFIELD("Personal No");
                        //TESTFIELD("Employer Code");
                        TestField("Monthly Contribution");

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
                                        if Cust."Account Category" = Cust."account category"::Joint then
                                            Cust."Joint Account Name" := "First Name" + '& ' + "First Name2" + '& ' + "First Name3" + 'JA';
                                        Cust."Account Category" := "Account Category";
                                        Cust.County := County;

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
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                            GenJournalLine."Account No." := Cust."No.";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Posting Date" := Today;
                                            GenJournalLine."External Document No." := 'REGFEE/' + Format("Payroll No");
                                            GenJournalLine.Description := 'Membership Registration Fee';
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                                            GenJournalLine.Amount := GenSetUp."BOSA Registration Fee Amount";
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                            GenJournalLine."Bal. Account No." := GenSetUp."BOSA Registration Fee Account";
                                            //GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
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
                                        //End Charge Registration Fee
                                    end;
                                until ProductsApp.Next = 0;
                            end;
                        end;

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
                                        AcctNo := AccountTypes."Account No Prefix" + '-' + NewMembNo + '-' + AccountTypes."Product Code";
                                    end;

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
                                    Accounts."Member Parish 2" := "Member Parish 2";
                                    Accounts."Member Parish Name 2" := "Member Parish Name 2";
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
                                    GenJournalLine.Amount := GenSetUp."BOSA Registration Fee Amount";
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

                        //Send Email********************************
                        if GenSetUp."Send Membership Reg SMS" = true then begin
                            SFactory.FnSendSMS('MEMBERAPP', 'You member Registration has been completed', BOSAACC, "Mobile Phone No");
                        end;

                        //Send Email********************************
                        if GenSetUp."Send Membership Reg Email" = true then begin
                            FnSendRegistrationEmail("No.", "E-Mail (Personal)", "ID No.");
                        end;
                    end;
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
                        Approvalmgt: Codeunit WorkflowIntegration;
                    begin
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
                                Error('Please Insert Next 0f kin Information');
                            end;
                        end;


                        //****************Check if there is any product Selected***************
                        ProductsApp.Reset;
                        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                        if ProductsApp.Find('-') = false then begin
                            Error('Please Select Products to be Openned');
                        end;



                        if ApprovalsMgmt.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendMembershipApplicationForApproval(Rec);

                        //Application Send SMS*********************************
                        if GenSetUp."Send Membership App SMS" = true then begin
                            SFactory.FnSendSMS('MEMBERAPP', 'Dear Member your application has been received and going through approval', BOSAACC, "Mobile Phone No");
                        end;

                        //Application Send Email********************************
                        if GenSetUp."Send Membership App Email" = true then begin
                            FnSendReceivedApplicationEmail("No.", "E-Mail (Personal)", "ID No.");
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
                        Status := Status::Open;
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
                        DocumentType := Documenttype::MembershipApplication;
                        ApprovalEntries.Setfilters(Database::"Membership Applications", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
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
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        Cust: Record Customer;
        Accounts: Record Vendor;
        AcctNo: Code[20];
        NextOfKinApp: Record "Member App Nominee";
        NextofKinFOSA: Record "Members Nominee";
        AccountSign: Record "Member Account Signatories";
        AccountSignApp: Record "Member App Signatories";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "Member App Nominee";
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        AccountTypes: Record "Account Types-Saving Products";
        DivAcctNo: Code[20];
        SignatureExists: Boolean;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening";
        NOkApp: Record "Member App Nominee";
        ProductsApp: Record "Membership Reg. Products Appli";
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        SFactory: Codeunit "SURESTEP Factory.";
        WelcomeMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Chuna Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>CHUNA SACCO LTD</b></p>';
        RegistrationMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to  Chuna Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership registration has been successfully processed</p><p style="font-family:Verdana,Arial;font-size:9pt">Your membership number is <b>%2</b></p><br>Regards<p>%3</p><p><b>CHUNA SACCO LTD</b></p>';
        Saccosetup: Record "Sacco No. Series";
        NewMembNo: Code[100];
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        EnableCreateMember: Boolean;

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
                Error('Email Address Missing for Member Application number' + '-' + Memb."No.");
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
            SMTPMail.AppendBody(StrSubstNo(RegistrationMessage, Memb.Name, BOSAACC, UserId));
            SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AddAttachment(FileName, Attachment);
            SMTPMail.Send;
        end;
    end;
}

