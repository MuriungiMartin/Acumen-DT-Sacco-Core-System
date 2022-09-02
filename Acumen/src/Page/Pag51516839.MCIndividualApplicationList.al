#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516839 "MC Individual Application List"
{
    // TESTFIELD(Picture);
    // TESTFIELD(Signature);
    // TESTFIELD("No. Series");
    // //TESTFIELD("Employer Code");
    // TESTFIELD("ID No.");
    // TESTFIELD("Phone No.");
    // TESTFIELD("Mobile Phone No");
    // TESTFIELD("Payroll/Staff No");
    // //TESTFIELD("E-Mail (Personal)");
    // TESTFIELD("Customer Posting Group");
    // TESTFIELD("Global Dimension 1 Code");
    // TESTFIELD("Global Dimension 2 Code");
    // 
    // 
    // IF Status<>Status::Open THEN
    // ERROR(Text001);
    // 
    // 
    // {NextOfKinApp.RESET;
    // NextOfKinApp.SETRANGE(NextOfKinApp."Account No","No.");
    // IF NextOfKinApp.FIND('-')=FALSE THEN
    // ERROR(text002);
    // }
    // 
    // //End allocate batch number
    // //IF Approvalmgt.SendAccOpeningRequest(Rec) THEN;

    ApplicationArea = Basic;
    CardPageID = "MC Individual Application Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";
    SourceTableView = where("Account Category"=filter(<>Group),
                            "Group Account"=const(false),
                            "Customer Posting Group"=const('MICRO'),
                            Source=const(Micro));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("Search Name";"Search Name")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Centre";"Responsibility Centre")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Type";"Customer Type")
                {
                    ApplicationArea = Basic;
                }
                field(Gender;Gender)
                {
                    ApplicationArea = Basic;
                }
                field(Category;Category)
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No";"Bank Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name";"Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code";"Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account No.";"BOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Membership No.';
                }
                field("Recruited By";"Recruited By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category";"Account Category")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No";"Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Marital Status";"Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Contribution";"Monthly Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code";"Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth";"Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail (Personal)";"E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                }
                field(Source;Source)
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
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        
                        /*DocumentType:=DocumentType::"Account Opening";
                        ApprovalEntries.Setfilters(DATABASE::"Member Application",DocumentType,"No.");
                        ApprovalEntries.RUN;
                        */

                    end;
                }
                separator(Action1102755004)
                {
                    Caption = '       -';
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
                        /*IF Status<>Status::Approved THEN
                        ERROR('This application has not been approved');
                        
                        
                        IF CONFIRM('Are you sure you want to create account application?',FALSE)=TRUE THEN BEGIN
                        
                        IF "ID No."<>'' THEN BEGIN
                        Cust.RESET;
                        Cust.SETRANGE(Cust."ID No.","ID No.");
                        Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                        IF Cust.FIND('-') THEN BEGIN
                        IF Cust."No." <> "No." THEN
                           ERROR('Member has already been created');
                        END;
                        END;
                        
                        //Create BOSA account
                        Cust."No.":='';
                        Cust.Name:=UPPERCASE(Name);
                        Cust.Address:=Address;
                        Cust."Post Code":="Post Code";
                        Cust.City:=City;
                        Cust.County:=City;
                        Cust."Country/Region Code":="Country/Region Code";
                        Cust."Force No.":="Force No.";
                        Cust."Phone No.":="Phone No.";
                        Cust."Global Dimension 1 Code":="Global Dimension 1 Code" ;
                        Cust."Global Dimension 2 Code":="Global Dimension 2 Code";
                        Cust."Customer Posting Group":="Customer Posting Group";
                        Cust."Registration Date":=TODAY;//"Registration Date"; Registration date must be the day the application is converted to a member and not day of capture*****cyrus
                        Cust.Status:=Cust.Status::Active;
                        Cust."Employer Code":="Employer Code";
                        Cust."Date of Birth":="Date of Birth";
                        Cust."Station/Department":="Station/Department";
                        Cust."E-Mail":="E-Mail (Personal)";
                        Cust.Location:=Location;
                        //**
                        Cust."Office Branch":="Office Branch";
                        Cust.Department:=Department;
                        Cust.Occupation:=Occupation;
                        Cust.Designation:=Designation;
                        Cust."Bank Code":="Bank Code";
                        Cust."Bank Branch Code":="Bank Name";
                        Cust."Bank Account No.":="Bank Account No";
                        //**
                        Cust."Sub-Location":="Sub-Location";
                        Cust.District:=District;
                        Cust."Payroll/Staff No":="Payroll/Staff No";
                        Cust."ID No.":="ID No.";
                        Cust."Passport No.":="Passport No.";
                        Cust."Business Loan Officer":="Salesperson Code";
                        Cust."Mobile Phone No":="Mobile Phone No";
                        Cust."Marital Status":="Marital Status";
                        Cust."Customer Type":=Cust."Customer Type"::Member;
                        Cust.Gender:=Gender;
                        
                        //CALCFIELDS(Signature,Picture);
                        
                        Cust."Monthly Contribution":="Monthly Contribution";
                        Cust."Contact Person":="Contact Person";
                        Cust."Contact Person Phone":="Contact Person Phone";
                        Cust."ContactPerson Relation":="ContactPerson Relation";
                        Cust."Recruited By":="Recruited By";
                        Cust."Business Loan Officer":="Salesperson Code";
                        Cust."ContactPerson Occupation":="ContactPerson Occupation";
                        Cust."Village/Residence":="Village/Residence";
                        Cust.INSERT(TRUE);
                        //Cust.VALIDATE(Cust."ID No.");
                        
                        //CLEAR(Picture);
                        //CLEAR(Signature);
                        //MODIFY;
                        
                        
                        ImageData."ID NO":="ID No.";
                        ImageData.Picture:=Picture;
                        ImageData.Signature:=Signature;
                        ImageData.INSERT(TRUE);
                        
                        BOSAACC:=Cust."No.";
                        
                        {
                        AcctNo:='001208'+BOSAACC;
                        //Create FOSA account
                        Accounts.INIT;
                        Accounts."No.":=AcctNo;
                        Accounts."Date of Birth":="Date of Birth";
                        Accounts.Name:=Name;
                        Accounts."Creditor Type":=Accounts."Creditor Type"::Account;
                        Accounts."Staff No":="Payroll/Staff No";
                        Accounts."ID No.":="ID No.";
                        Accounts."Mobile Phone No":="Mobile Phone No";
                        Accounts."Registration Date":="Registration Date";
                        Accounts."Post Code":="Post Code";
                        Accounts.County:=City;
                        Accounts."BOSA Account No":=Cust."No.";
                        Accounts.Picture:=Picture;
                        Accounts.Signature:=Signature;
                        Accounts."Passport No.":="Passport No.";
                        Accounts."Company Code":="Employer Code";
                        Accounts.Status:=Accounts.Status::New;
                        Accounts."Account Type":='SAVINGS';
                        Accounts."Date of Birth":="Date of Birth";
                        Accounts."Global Dimension 1 Code":='FOSA';
                        Accounts."Global Dimension 2 Code":="Global Dimension 2 Code";
                        Accounts.Address:=Address;
                        Accounts."Address 2":="Address 2";
                        Accounts."Phone No.":="Phone No.";
                        Accounts."Registration Date":=TODAY;
                        Accounts.Status:=Accounts.Status::Active;
                        Accounts.Section:=Section;
                        Accounts."Home Address":="Home Address";
                        Accounts.District:=District;
                        Accounts.Location:=Location;
                        Accounts."Sub-Location":="Sub-Location";
                        Accounts."Registration Date":=TODAY;
                        Accounts."Monthly Contribution" := "Monthly Contribution";
                        Accounts."E-Mail":="E-Mail (Personal)";
                        //Accounts."Home Page":="Home Page";
                        //Accounts."Savings Account No.":="Savings Account No.";
                        //Accounts."Signing Instructions":="Signing Instructions";
                        //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                        //Accounts."FD Maturity Date":="FD Maturity Date";
                        //Accounts."Electrol Zone Code":="Electrol Zone Code";
                        //Accounts."Departments Code":="Departments Code";
                        //Accounts."Sections Code":="Sections Code";
                        Accounts.INSERT;
                        
                        
                        Accounts.RESET;
                        IF Accounts.GET(AcctNo) THEN BEGIN
                        Accounts.VALIDATE(Accounts.Name);
                        Accounts.VALIDATE(Accounts."Account Type");
                        Accounts.VALIDATE(Accounts."Global Dimension 1 Code");
                        Accounts.VALIDATE(Accounts."Global Dimension 2 Code");
                        Accounts.MODIFY;
                        
                        //Update BOSA with FOSA Account
                        IF Cust.GET(BOSAACC) THEN BEGIN
                        Cust."FOSA Account":=AcctNo;
                        Cust.MODIFY;
                        END;
                        END;
                        }
                        
                        NextOfKinApp.RESET;
                        NextOfKinApp.SETRANGE(NextOfKinApp."Account No","No.");
                        IF NextOfKinApp.FIND('-') THEN BEGIN
                         REPEAT
                          NextOfKin.INIT;
                          NextOfKin."Account No":=BOSAACC;
                          NextOfKin.Name:=NextOfKinApp.Name;
                          NextOfKin.Relationship:=NextOfKinApp.Relationship;
                          NextOfKin.Beneficiary:=NextOfKinApp.Beneficiary;
                          NextOfKin."Date of Birth":=NextOfKinApp."Date of Birth";
                          NextOfKin.Address:=NextOfKinApp.Address;
                          NextOfKin.Telephone:=NextOfKinApp.Telephone;
                          NextOfKin.Fax:=NextOfKinApp.Fax;
                          NextOfKin.Email:=NextOfKinApp.Email;
                          NextOfKin."ID No.":=NextOfKinApp."ID No.";
                          NextOfKin."%Allocation":=NextOfKinApp."%Allocation";
                          NextOfKin.INSERT;
                         UNTIL NextOfKinApp.NEXT = 0;
                        END;
                        
                        AccountSignApp.RESET;
                        AccountSignApp.SETRANGE(AccountSignApp."Account No","No.");
                        IF AccountSignApp.FIND('-') THEN BEGIN
                         REPEAT
                          AccountSign.INIT;
                          AccountSign."Account No":=AcctNo;
                          AccountSign.Names:=AccountSignApp.Names;
                          AccountSign."Date Of Birth":=AccountSignApp."Date Of Birth";
                          AccountSign."Staff/Payroll":=AccountSignApp."Staff/Payroll";
                          AccountSign."ID No.":=AccountSignApp."ID No.";
                          AccountSign.Signatory:=AccountSignApp.Signatory;
                          AccountSign."Must Sign":=AccountSignApp."Must Sign";
                          AccountSign."Must be Present":=AccountSignApp."Must be Present";
                          AccountSign.Picture:=AccountSignApp.Picture;
                          AccountSign.Signature:=AccountSignApp.Signature;
                          AccountSign."Expiry Date":=AccountSignApp."Expiry Date";
                          //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                          AccountSign.INSERT;
                         UNTIL AccountSignApp.NEXT = 0;
                        END;
                        
                        Cust.RESET;
                        IF Cust.GET(BOSAACC) THEN BEGIN
                        Cust.VALIDATE(Cust.Name);
                        //Cust.VALIDATE(Accounts."Account Type");
                        Cust.VALIDATE(Cust."Global Dimension 1 Code");
                        Cust.VALIDATE(Cust."Global Dimension 2 Code");
                        Cust.MODIFY;
                        END;
                        
                        {
                        GenSetUp.GET();
                         Notification.CreateMessage('Dynamics NAV',GenSetUp."Sender Address","E-Mail (Personal)",'Member Acceptance Notification',
                                        'Member application '+ "No." + ' has been approved'
                                       + ' (Dynamics NAV ERP)',FALSE);
                         Notification.Send;
                        }
                        
                        //"Converted By":=USERID;
                        MESSAGE('Account created successfully.');
                        //END;
                        Status:=Status::Approved;
                        "Created By":=USERID;
                        MODIFY;
                        
                        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Send SMS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        
                        
                           //ERROR('Sms Message');
                           //SMS MESSAGE
                          AccountSignatoriesApp.RESET;
                          AccountSignatoriesApp.SETRANGE(AccountSignatoriesApp."Account No","No.");
                          IF AccountSignatoriesApp.FIND('-') THEN BEGIN
                        
                          AccountSignatoriesApp.RESET;
                          AccountSignatoriesApp.SETRANGE(AccountSignatoriesApp."Account No","No.");
                          AccountSignatoriesApp.SETRANGE(AccountSignatoriesApp."Send SMS",FALSE);
                          IF AccountSignatoriesApp.FIND('-') THEN BEGIN
                           REPEAT
                        
                             //MESSAGE('Send sms to '+AccountSignatoriesApp."Account No");
                        
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
                            SMSMessage."Account No":="Payroll/Staff No";
                            SMSMessage."Date Entered":=TODAY;
                            SMSMessage."Time Entered":=TIME;
                            SMSMessage.Source:='MEMBERACCOUNT';
                            SMSMessage."Entered By":=USERID;
                            SMSMessage."System Created Entry":=TRUE;
                            SMSMessage."Document No":="No.";
                            SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
                            SMSMessage."SMS Message":=Name+' has been succesfuly created. MWALIMU SACCCO';
                            SMSMessage."Telephone No":=AccountSignatoriesApp."Mobile Phone No.";
                            SMSMessage.INSERT;
                        
                            AccountSignatoriesApp."Send SMS":=TRUE;
                            AccountSignatoriesApp.MODIFY;
                        
                             UNTIL AccountSignatoriesApp.NEXT=0;
                            END;
                         END;
                        
                        
                        
                        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        // SEND SMS
                        
                        
                        
                        
                        END ELSE
                        ERROR('Not approved');
                        */

                    end;
                }
            }
        }
    }

    var
        text002: label 'Kinldy specify the next of kin';
}

