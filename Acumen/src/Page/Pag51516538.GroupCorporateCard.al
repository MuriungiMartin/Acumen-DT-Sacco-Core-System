#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516538 "Group/Corporate Card"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Vendor;
    SourceTableView = where("Account Category" = filter(Corporate | Group));

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
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Joint2DetailsVisible := false;

                        if "Account Category" = "account category"::Joint then begin
                            Joint2DetailsVisible := true;
                        end;
                    end;
                }
                field("Name of the Group/Corporate"; "Name of the Group/Corporate")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = AddressEditable;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = Basic;
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
                }
                field("No of Members"; "No of Members")
                {
                    ApplicationArea = Basic;
                }
                field("Group/Corporate Trade"; "Group/Corporate Trade")
                {
                    ApplicationArea = Basic;
                }
                field("Certificate No"; "Certificate No")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = MobileEditable;
                    ShowMandatory = true;
                }
                field("Self Recruited"; "Self Recruited")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        //  SelfRecruitedControl();
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
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = RegistrationDateEditable;
                }
                field("Vendor Posting Group"; "Vendor Posting Group")
                {
                    ApplicationArea = Basic;
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
            group("Referee Details")
            {
                field("Referee Member No"; "Referee Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Referee Name"; "Referee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Referee ID No"; "Referee ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Referee Mobile Phone No"; "Referee Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Communication/Location Info")
            {
                Caption = 'Communication/Location Info';
                field("Office Telephone No."; "Office Telephone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Extension No."; "Extension No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Office Extension';
                }
                field("Email Indemnified"; "Email Indemnified")
                {
                    ApplicationArea = Basic;
                }
                field("Send E-Statements"; "Send E-Statements")
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
                }
                field("Contact Person Phone"; "Contact Person Phone")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPPhoneEditable;
                }
                field("ContactPerson Relation"; "ContactPerson Relation")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPRelationEditable;
                }
            }
        }
        area(factboxes)
        {
            part(Control9; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Account)
            {
                Caption = 'Account';
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = field("No.");
                    RunPageView = sorting("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Vendor),
                                  "No." = field("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(23),
                                  "No." = field("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                separator(Action1000000069)
                {
                }
                action("Re-new Fixed Deposit")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-new Fixed Deposit';
                    Image = "Report";

                    trigger OnAction()
                    begin

                        if AccountTypes.Get("Account Type") then begin
                            if AccountTypes."Fixed Deposit" = true then begin
                                if "Call Deposit" = false then begin
                                    TestField("Fixed Duration");
                                    TestField("FD Maturity Date");
                                    if "FD Maturity Date" > Today then
                                        Error('Fixed deposit has not matured.');

                                end;

                                if "Don't Transfer to Savings" = false then
                                    TestField("Savings Account No.");

                                CalcFields("Last Interest Date");

                                if "Call Deposit" = true then begin
                                    if "Last Interest Date" < Today then
                                        Error('Fixed deposit interest not UPDATED. Please update interest.');
                                end else begin
                                    if "Last Interest Date" < "FD Maturity Date" then
                                        Error('Fixed deposit interest not UPDATED. Please update interest.');
                                end;




                                if Confirm('Are you sure you want to renew this Fixed deposit. Interest will be transfered accordingly?') = false then
                                    exit;


                                CalcFields("Untranfered Interest");

                                if "Call Deposit" = false then begin
                                    "Date Renewed" := "FD Maturity Date";
                                end else
                                    "Date Renewed" := Today;
                                Validate("Date Renewed");
                                Modify;

                                GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;



                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := "No." + '-RN';
                                GenJournalLine."External Document No." := "No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                if "Don't Transfer to Savings" = false then
                                    GenJournalLine."Account No." := "Savings Account No."
                                else
                                    GenJournalLine."Account No." := "No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest Earned';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -"Untranfered Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                InterestBuffer.Reset;
                                InterestBuffer.SetRange(InterestBuffer."Account No", "No.");
                                if InterestBuffer.Find('-') then
                                    InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);


                                //Post
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                end;




                                Message('Fixed deposit renewed successfully');
                            end;
                        end;
                    end;
                }
                separator(Action1000000067)
                {
                }
                separator(Action1000000066)
                {
                }
                action("<Page Member Page - BOSA>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Page';
                    Image = Planning;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = New;
                    RunObject = Page "Member Account Card";
                    RunPageLink = "No." = field("BOSA Account No");
                }
                action("<Action11027600800>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Statements';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,TRUE,Cust)
                        */

                    end;
                }
                action("BOSA Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "BOSA Account No");
                        if Cust.Find('-') then
                            Report.Run(51516360, true, true, Cust);
                    end;
                }
                action("FOSA Loans")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    RunObject = Page "Loans Sub-Page List";
                    RunPageLink = "Account No" = field("No."),
                                  Source = filter(BOSA);
                }
                action("Close Account")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Close this Account?', false) = true then begin
                            if "Balance (LCY)" - ("Uncleared Cheques" + "ATM Transactions" + "EFT Transactions" + MinBalance + UnclearedLoan) < 0 then
                                Error('This Member does not enough Savings to recover Withdrawal Fee')
                            else
                                LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."account type"::Vendor;
                            Gnljnline."Account No." := "No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := 'LR-' + "No.";
                            Gnljnline."Posting Date" := Today;
                            Gnljnline.Amount := 500;
                            Gnljnline.Description := 'Account Closure Fee';
                            Gnljnline.Validate(Gnljnline.Amount);
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;

                            LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."bal. account type"::"G/L Account";
                            Gnljnline."Bal. Account No." := '105113';
                            Gnljnline.Validate(Gnljnline."Bal. Account No.");
                            Gnljnline."Document No." := 'LR-' + "No.";
                            Gnljnline."Posting Date" := Today;
                            Gnljnline.Amount := -500;
                            Gnljnline.Description := 'Account Closure Fee';
                            Gnljnline.Validate(Gnljnline.Amount);
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;


                        end;
                    end;
                }
                separator(Action1000000060)
                {
                }
                action("<Action110276013300>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Update FDR Interest';
                    Image = "Report";

                    trigger OnAction()
                    begin
                        if "Account Type" <> 'FIXED' then
                            Error('Only applicable for Fixed Deposit accounts.');

                        CalcFields("Last Interest Date");

                        if "Last Interest Date" >= Today then
                            Error('Interest Up to date.');

                        //IF CONFIRM('Are you sure you want to update the Fixed deposit interest.?') = FALSE THEN
                        //EXIT;

                        /*
                        Vend.RESET;
                        Vend.SETRANGE(Vend."No.","No.");
                        IF Vend.FIND('-') THEN
                        REPORT.RUN(,TRUE,TRUE,Vend)
                        */

                    end;
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FOSA Account Signatories Card";
                    RunPageLink = "Account No" = field("No.");
                }
            }
            group(ActionGroup1000000058)
            {
                action(" Account Nominee Details")
                {
                    ApplicationArea = Basic;
                    Caption = ' Account Nominee Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FOSA Account  NOK Details";
                    RunPageLink = "Account No" = field("No.");
                }
                separator(Action1000000056)
                {
                }
                action("Transfer FD Amnt from Savings")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        //Transfer Balance if Fixed Deposit

                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, "Account Type");
                        if AccountTypes.Find('-') then begin
                            //IF AccountTypes."Fixed Deposit" <> TRUE THEN BEGIN
                            if Vend.Get("Savings Account No.") then begin
                                if Confirm('Are you sure you want to effect the transfer from the savings account', false) = false then
                                    exit else
                                    GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                Vend.Reset;
                                if Vend.Find('-') then
                                    Vend.CalcFields(Vend."Balance (LCY)");
                                //IF (Vend."Balance (LCY)" - 500) < "Fixed Deposit Amount" THEN
                                //ERROR('Savings account does not have enough money to facilate the requested trasfer.');
                                //MESSAGE('Katabaka ene!');
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := "No." + '-OP';
                                GenJournalLine."External Document No." := "No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := "Savings Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'FD Balance Tranfers';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                //GenJournalLine.Amount:="Fixed Deposit Amount";
                                GenJournalLine.Amount := "Amount to Transfer";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //MESSAGE('The FDR amount is %1 ',"Fixed Deposit Amount");
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := "No." + '-OP';
                                GenJournalLine."External Document No." := "No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := "No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'FD Balance Tranfers';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                //GenJournalLine.Amount:=-"Fixed Deposit Amount";
                                GenJournalLine.Amount := -"Amount to Transfer";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //END;
                            end;
                        end;
                        /*
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        REPEAT
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",GenJournalLine);
                        UNTIL GenJournalLine.NEXT = 0;
                        END;
                        */


                        /*//Post New
                        
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        END;
                        
                        //Post New
                        */

                        /*
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                        GenJournalLine.DELETEALL;
                        
                           */
                        //Transfer Balance if Fixed Deposit

                    end;
                }
                action("Transfer FD Amount to Savings")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        //Transfer Balance if Fixed Deposit

                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, "Account Type");
                        if AccountTypes.Find('-') then begin
                            if AccountTypes."Fixed Deposit" = true then begin
                                if Vend.Get("No.") then begin
                                    if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account', false) = false then
                                        exit;

                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                    if GenJournalLine.Find('-') then
                                        GenJournalLine.DeleteAll;

                                    Vend.CalcFields(Vend."Balance (LCY)");
                                    if (Vend."Balance (LCY)") < "Transfer Amount to Savings" then
                                        Error('Fixed Deposit account does not have enough money to facilate the requested trasfer.');

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := "No." + '-OP';
                                    GenJournalLine."External Document No." := "No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := "No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'FD Balance Tranfers';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := "Transfer Amount to Savings";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := "No." + '-OP';
                                    GenJournalLine."External Document No." := "No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := "Savings Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'FD Balance Tranfers';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := -"Transfer Amount to Savings";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                end;
                            end;
                        end;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            repeat
                            //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        Message('Amount transfered successfully.');
                    end;
                }
                action("Renew Fixed deposit")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        if AccountTypes.Get("Account Type") then begin
                            if AccountTypes."Fixed Deposit" = true then begin
                                if Confirm('Are you sure you want to renew the fixed deposit.', false) = false then
                                    exit;

                                TestField("FD Maturity Date");
                                if FDType.Get("Fixed Deposit Type") then begin
                                    "FD Maturity Date" := CalcDate(FDType.Duration, "FD Maturity Date");
                                    "Date Renewed" := Today;
                                    "FDR Deposit Status Type" := "fdr deposit status type"::New;
                                    Modify;

                                    Message('Fixed deposit renewed successfully');
                                end;
                            end;
                        end;
                    end;
                }
                action("Terminate Fixed Deposit")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        //Transfer Balance if Fixed Deposit

                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, "Account Type");
                        if AccountTypes.Find('-') then begin
                            if AccountTypes."Fixed Deposit" = true then begin
                                if Vend.Get("No.") then begin
                                    if Confirm('Are you sure you want to Terminate this Fixed Deposit Contract?', false) = false then
                                        exit;

                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                    if GenJournalLine.Find('-') then
                                        GenJournalLine.DeleteAll;

                                    Vend.CalcFields(Vend."Balance (LCY)");
                                    if (Vend."Balance (LCY)") < "Transfer Amount to Savings" then
                                        Error('Fixed Deposit account does not have enough money to facilate the requested trasfer.');

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := "No." + '-OP';
                                    GenJournalLine."External Document No." := "No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := "No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'FD Termination Tranfer';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := "Balance (LCY)";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := "No." + '-OP';
                                    GenJournalLine."External Document No." := "No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := "Savings Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'FD Termination Tranfer';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := -"Balance (LCY)";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                end;
                            end;
                        end;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            repeat
                            //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        Message('Amount transfered successfully back to the savings Account.');
                        "FDR Deposit Status Type" := "fdr deposit status type"::Renewed;

                        /*
                       //Renew Fixed deposit - OnAction()

                       IF AccountTypes.GET("Account Type") THEN BEGIN
                       IF AccountTypes."Fixed Deposit" = TRUE THEN BEGIN
                       IF CONFIRM('Are you sure you want to renew the fixed deposit.',FALSE) = FALSE THEN
                       EXIT;

                       TESTFIELD("FD Maturity Date");
                       IF FDType.GET("Fixed Deposit Type") THEN BEGIN
                       "FD Maturity Date":=CALCDATE(FDType.Duration,"FD Maturity Date");
                       "Date Renewed":=TODAY;
                       "FDR Deposit Status Type":="FDR Deposit Status Type"::Renewed;
                       MODIFY;

                       MESSAGE('Fixed deposit renewed successfully');
                       END;
                       END;
                       END;
                         */

                    end;
                }
                action("Page Vendor Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        Vend.Reset;
                        Vend.SetRange(Vend."No.", "No.");
                        if Vend.Find('-') then
                            Report.Run(51516476, true, false, Vend)
                    end;
                }
                action("Page Vendor Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = field("No."),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                }
                action("Charge Fosa Statement")
                {
                    ApplicationArea = Basic;
                    Image = PostApplication;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to charge statement fee? This will recover statement fee.', false) = false then
                            exit;

                        CalcFields("Balance (LCY)", "ATM Transactions");
                        if ("Balance (LCY)" - "ATM Transactions") <= 0 then
                            Error('This Account does not have sufficient funds');


                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, "Account Type");
                        if AccountTypes.Find('-') then begin

                            //Closure charges
                            Charges.Reset;
                            Charges.SetRange(Charges.Code, AccountTypes."Statement Charge");
                            if Charges.Find('-') then begin
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := "No." + '-STM';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := "No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := Charges.Description;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Charges."Charge Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := Charges."GL Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Post New
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then begin
                                    //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                                end;

                                //Post New


                            end;
                            //Closure charges

                        end;
                    end;
                }
                action("Recover Class B Shares")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Image = PostApplication;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin

                        if "Account Type" = 'SPECIAL' then
                            Error('You cannot recover Class B Shares from this account');

                        if "Shares Recovered" = true then
                            Error('Class B shares already recovered');

                        if Confirm('Are you sure you want to recover Class B shares? This will recover Class B shares.', false) = false then
                            exit;


                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, "Account Type");
                        if AccountTypes.Find('-') then begin

                            // charges
                            Charges.Reset;
                            Charges.SetRange(Charges.Code, AccountTypes."FOSA Shares");
                            if Charges.Find('-') then begin
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                CalcFields("Balance (LCY)", "ATM Transactions");
                                if ("Balance (LCY)" - "ATM Transactions") <= Charges."Charge Amount" then
                                    Error('This Account does not have sufficient funds');

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := "No." + '-FSH';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := "No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := Charges.Description;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Charges."Charge Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := Charges."GL Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Post New
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then begin
                                    //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                                end;

                                //Post New


                            end;
                            //Closure charges

                        end;

                        "Shares Recovered" := true;
                        "ClassB Shares" := -Charges."Charge Amount";
                        Modify;
                    end;
                }
                action("Charge ATM Card Placement")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Image = PostApplication;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to post the ATM Charges fee?') = false then
                            exit;


                        CalcFields("Balance (LCY)", "ATM Transactions");
                        if ("Balance (LCY)" - "ATM Transactions") <= 0 then
                            Error('This Account does not have sufficient funds');


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := "No.";
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." := "Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges: ' + "Card No.";
                        GenJournalLine.Amount := 550;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No." := 'BNK000001';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." := "Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges: No.' + "Card No.";
                        GenJournalLine.Amount := -500;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Comms to Commissions account
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := '4-11-000310';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." := "Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges' + 'No.' + "Card No.";
                        GenJournalLine.Amount := -50;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;



                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        end;
                        //Post New
                    end;
                }
                action("Charge ATM Card Replacement")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Image = PostApplication;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to post the ATM Charges fee?') = false then
                            exit;


                        CalcFields("Balance (LCY)", "ATM Transactions");
                        if ("Balance (LCY)" - "ATM Transactions") <= 0 then
                            Error('This Account does not have sufficient funds');


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := "No.";
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." := "Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges: ' + "Card No.";
                        GenJournalLine.Amount := 600;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No." := 'BNK000001';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." := "Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges: No.' + "Card No.";
                        GenJournalLine.Amount := -500;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Comms to Commissions account
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := '4-11-000310';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." := "Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges' + 'No.' + "Card No.";
                        GenJournalLine.Amount := -100;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;



                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        end;
                        //Post New
                    end;
                }
                action("Charge Pass Book")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Image = PostApplication;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to charge Pass book fee? This will recover passbook fee.', false) = false then
                            exit;

                        CalcFields("Balance (LCY)", "ATM Transactions");
                        if ("Balance (LCY)" - "ATM Transactions") <= 0 then
                            Error('This Account does not have sufficient funds');


                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, "Account Type");
                        if AccountTypes.Find('-') then begin

                            //Closure charges
                            Charges.Reset;
                            Charges.SetRange(Charges.Code, AccountTypes."Statement Charge");
                            if Charges.Find('-') then begin
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := "No." + '-STM';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := "No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := Charges.Description;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Charges."Charge Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := Charges."GL Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Post New
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then begin
                                    //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                                end;

                                //Post New


                            end;
                            //Closure charges

                        end;
                    end;
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Products Signatories";
                    RunPageLink = "Account No" = field("No.");
                }
            }
        }
    }

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
        //"Responsibility Centre" := UserMgt.GetSalesFilter;
    end;

    trigger OnOpenPage()
    begin

        /*IF UserMgt.GetSalesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Centre",UserMgt.GetSalesFilter);
          FILTERGROUP(0);
        END;
        */

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
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        InterestBuffer: Record "Interest Buffer";
        MinBalance: Decimal;
        UnclearedLoan: Decimal;
        LineN: Integer;
        Gnljnline: Record "Gen. Journal Line";
        Vend: Record Vendor;
        FDType: Record "Fixed Deposit Type";
        Charges: Record Charges;
}

