#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516515 "Product Card Editable"
{
    Caption = 'Account Card';
    DeleteAllowed = true;
    Editable = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = Vendor;
    SourceTableView = where("Creditor Type"=const("FOSA Account"),
                            "Debtor Type"=const("FOSA Account"));

    layout
    {
        area(content)
        {
            group(AccountTab)
            {
                Caption = 'General Info';
                Editable = true;
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No.';

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                          CurrPage.Update;
                    end;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
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
                    Caption = 'ID No.';
                    Editable = true;
                }
                field("Passport No.";"Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Personal No.";"Personal No.")
                {
                    ApplicationArea = Basic;
                }
                field("Pension No";"Pension No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account No";"BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Mobile Phone No";"Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Employer Code";"Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Station/Sections";"Station/Sections")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Phone No.";"Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Date of Birth";"Date of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = true;
                }
                field(txtGender;Gender)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status";"Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Registration Date";"Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Uncleared Cheques";"Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Balance (LCY)";"Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Book Balance';
                    Enabled = false;
                    Visible = false;
                }
                field(AvailableBal;"Balance (LCY)"-("Uncleared Cheques"+"ATM Transactions"+"EFT Transactions"+MinBalance))
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawable Balance';
                    Editable = false;
                }
                field("Cheque Discounted";"Cheque Discounted")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Posting Group";"Vendor Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Reason For Blocking Account";"Reason For Blocking Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Blocked;Blocked)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        //TESTFIELD("Resons for Status Change");
                    end;
                }
                field("Account Frozen";"Account Frozen")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM No.";"ATM No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Acc. No";"Cheque Acc. No")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified";"Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Picture;Picture)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Signature;Signature)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Style = Standard;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        TestField("Resons for Status Change");
                        
                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User ID",UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Account Status");
                        if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the account status.');
                        
                        if "Account Type" = 'FIXED' then begin
                        if "Balance (LCY)" > 0 then begin
                        CalcFields("Last Interest Date");
                        
                        if "Call Deposit" = true then begin
                        if Status = Status::Closed then begin
                        if "Last Interest Date" < Today then
                        Error('Fixed deposit interest not UPDATED. Please update interest.');
                        end else begin
                        if "Last Interest Date" < "FD Maturity Date" then
                        Error('Fixed deposit interest not UPDATED. Please update interest.');
                        end;
                        end;
                        end;
                        end;
                        
                        if Status = Status::Active then begin
                        if Confirm('Are you sure you want to re-activate this account? This will recover re-activation fee.',false) = false then begin
                        Error('Re-activation terminated.');
                        end;
                        
                        Blocked:=Blocked::" ";
                        Modify;
                        
                        
                        
                        
                        
                        end;
                        
                        
                        //Account Closure
                        if Status = Status::Closed then begin
                        TestField("Closure Notice Date");
                        if Confirm('Are you sure you want to close this account? This will recover closure fee and any '
                        + 'interest earned before maturity will be forfeited.',false) = false then begin
                        Error('Closure terminated.');
                        end;
                        
                        
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
                        if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll;
                        
                        
                        
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code,"Account Type");
                        if AccountTypes.Find('-') then  begin
                        "Date Closed":=Today;
                        
                        //Closure charges
                        /*Charges.RESET;
                        IF CALCDATE(AccountTypes."Closure Notice Period","Closure Notice Date") > TODAY THEN
                        Charges.SETRANGE(Charges.Code,AccountTypes."Closing Prior Notice Charge") */
                        
                        Charges.Reset;
                        if CalcDate(AccountTypes."Closure Notice Period","Closure Notice Date") > Today then
                        Charges.SetRange(Charges.Code,AccountType."Closing Charge")
                        
                        else
                        Charges.SetRange(Charges.Code,AccountTypes."Closing Charge");
                        if Charges.Find('-') then begin
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-CL';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:=Charges.Description;
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=Charges."Charge Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":=Charges."GL Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        end;
                        //Closure charges
                        
                        
                        //Interest forfeited/Earned on maturity
                        CalcFields("Untranfered Interest");
                        if "Untranfered Interest" > 0 then begin
                        ForfeitInterest:=true;
                        //If FD - Check if matured
                        if AccountTypes."Fixed Deposit" = true then begin
                        if "FD Maturity Date" <= Today then
                        ForfeitInterest:=false;
                        if "Call Deposit" = true then
                        ForfeitInterest:=false;
                        
                        end;
                        
                        //PKK INGORE MATURITY
                        ForfeitInterest:=false;
                        //If FD - Check if matured
                        
                        if ForfeitInterest = true then begin
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-CL';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=AccountTypes."Interest Forfeited Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Interest Forfeited';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=-"Untranfered Interest";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":=AccountTypes."Interest Payable Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        InterestBuffer.Reset;
                        InterestBuffer.SetRange(InterestBuffer."Account No","No.");
                        if InterestBuffer.Find('-') then
                        InterestBuffer.ModifyAll(InterestBuffer.Transferred,true);
                        
                        
                        end else begin
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-CL';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        if AccountTypes."Fixed Deposit" = true then
                        GenJournalLine."Account No.":="Savings Account No."
                        else
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Interest Earned';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=-"Untranfered Interest";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":=AccountTypes."Interest Payable Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        InterestBuffer.Reset;
                        InterestBuffer.SetRange(InterestBuffer."Account No","No.");
                        if InterestBuffer.Find('-') then
                        InterestBuffer.ModifyAll(InterestBuffer.Transferred,true);
                        
                        
                        
                        end;
                        
                        
                        //Transfer Balance if Fixed Deposit
                        if AccountTypes."Fixed Deposit" = true then begin
                        CalcFields("Balance (LCY)");
                        
                        TestField("Savings Account No.");
                        
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-CL';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="Savings Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='FD Balance Tranfers';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        if "Amount to Transfer" <> 0 then
                        GenJournalLine.Amount:=-"Amount to Transfer"
                        else
                        GenJournalLine.Amount:=-"Balance (LCY)";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-CL';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='FD Balance Tranfers';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        if "Amount to Transfer" <> 0 then
                        GenJournalLine.Amount:="Amount to Transfer"
                        else
                        GenJournalLine.Amount:="Balance (LCY)";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        
                        end;
                        
                        //Transfer Balance if Fixed Deposit
                        
                        
                        end;
                        
                        //Interest forfeited/Earned on maturity
                        /*
                        //Post New
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        END;
                        //Post New
                        */
                        
                        Message('Funds transfered successfully to main account and account closed.');
                        
                        
                        
                        
                        end;
                        end;
                        
                        
                        //Account Closure

                    end;
                }
                field("Closure Notice Date";"Closure Notice Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Resons for Status Change";"Resons for Status Change")
                {
                    ApplicationArea = Basic;
                }
                field("Signing Instructions";"Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field("Interest Earned";"Interest Earned")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Allowable Cheque Discounting %";"Allowable Cheque Discounting %")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Processing";"Salary Processing")
                {
                    ApplicationArea = Basic;
                }
                field("Assigned System ID";"Assigned System ID")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Account";"Staff Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group(AccountTab1)
            {
                Caption = 'Communication Info';
                Editable = true;
                field(Address;Address)
                {
                    ApplicationArea = Basic;
                }
                field("Post Code";"Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code/City';
                }
                field(City;City)
                {
                    ApplicationArea = Basic;
                }
                field("Address 2";"Address 2")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail";"E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Home Page";"Home Page")
                {
                    ApplicationArea = Basic;
                }
                field(Contact;Contact)
                {
                    ApplicationArea = Basic;
                }
                field("ContacPerson Phone";"ContacPerson Phone")
                {
                    ApplicationArea = Basic;
                }
                field("ContactPerson Occupation";"ContactPerson Occupation")
                {
                    ApplicationArea = Basic;
                }
                field(CodeDelete;CodeDelete)
                {
                    ApplicationArea = Basic;
                }
                field("Home Address";"Home Address")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Fixed Deposit Details")
            {
                Caption = 'Fixed Deposit Details';
                field("Fixed Deposit Type";"Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field(regdate;"Registration Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Registration Date';
                    Editable = false;
                }
                field("FD Duration";"FD Duration")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Enabled = true;
                }
                field("FD Maturity Date";"FD Maturity Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Maturity Date';
                    Editable = true;
                }
                field("Date Renewed";"Date Renewed")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Status";"Fixed Deposit Status")
                {
                    ApplicationArea = Basic;
                }
                field("FDR Deposit Status Type";"FDR Deposit Status Type")
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate";"Interest rate")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Account No.";"Savings Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Amount to Transfer";"Amount to Transfer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount to Transfer';
                }
                field("Transfer Amount to Savings";"Transfer Amount to Savings")
                {
                    ApplicationArea = Basic;
                }
            }
            group("ATM Details")
            {
                Caption = 'ATM Details';
                field("ATM No.B";"ATM No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Transactions";"ATM Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Atm card ready";"Atm card ready")
                {
                    ApplicationArea = Basic;
                    Caption = 'ATM Card Ready For Collection';
                }
                field("ATM Issued";"ATM Issued")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Self Picked";"ATM Self Picked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector Name";"ATM Collector Name")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector's ID";"ATM Collector's ID")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector's Mobile";"ATM Collector's Mobile")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000034;"FOSA Statistics FactBox")
            {
                SubPageLink = "No."=field("No.");
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
                    RunPageLink = "Vendor No."=field("No.");
                    RunPageView = sorting("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name"=const(Vendor),
                                  "No."=field("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID"=const(23),
                                  "No."=field("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                separator(Action108)
                {
                }
                action("Account Agent Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Mandate';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Agent Account Signatory list";
                    RunPageLink = "Account No"=field("No.");
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
                        "Date Renewed":="FD Maturity Date";
                        end else
                        "Date Renewed":=Today;
                        Validate("Date Renewed");
                        Modify;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
                        if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll;



                        LineNo:=LineNo+10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-RN';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        if "Don't Transfer to Savings" = false then
                        GenJournalLine."Account No.":="Savings Account No."
                        else
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Interest Earned';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=-"Untranfered Interest";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":=AccountTypes."Interest Payable Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        InterestBuffer.Reset;
                        InterestBuffer.SetRange(InterestBuffer."Account No","No.");
                        if InterestBuffer.Find('-') then
                        InterestBuffer.ModifyAll(InterestBuffer.Transferred,true);


                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
                        if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJournalLine);
                        end;




                        Message('Fixed deposit renewed successfully');
                        end;
                        end;
                    end;
                }
                separator(Action1102760068)
                {
                }
                separator(Action1102760082)
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
                    RunPageLink = "No."=field("BOSA Account No");
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
                        Cust.SetRange(Cust."No.","BOSA Account No");
                        if Cust.Find('-') then
                        Report.Run(51516360,true,true,Cust);
                    end;
                }
                action("FOSA Loans")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    RunObject = Page "Loans Sub-Page List";
                    RunPageLink = "Account No"=field("No.");
                }
                action("Close Account")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                         if Confirm('Are you sure you want to Close this Account?',false)=true then begin
                         if "Balance (LCY)"-("Uncleared Cheques"+"ATM Transactions"+"EFT Transactions"+MinBalance+UnclearedLoan)<0 then
                         Error('This Member does not enough Savings to recover Withdrawal Fee')
                        else
                            LineN:=LineN+10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."account type"::Vendor;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Amount:=500;
                            Gnljnline.Description:='Account Closure Fee';
                            Gnljnline.Validate(Gnljnline.Amount);
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;

                            LineN:=LineN+10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::"G/L Account";
                            Gnljnline."Bal. Account No.":='105113';
                            Gnljnline.Validate(Gnljnline."Bal. Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Amount:=-500;
                            Gnljnline.Description:='Account Closure Fee';
                            Gnljnline.Validate(Gnljnline.Amount);
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;


                        end;
                    end;
                }
                separator(Action1102760142)
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
            }
            group(ActionGroup1102755009)
            {
                action(" Account Nominee Details")
                {
                    ApplicationArea = Basic;
                    Caption = ' Account Nominee Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FOSA Account  NOK Details";
                    RunPageLink = "Account No"=field("No.");
                }
                separator(Action1102755005)
                {
                }
                action("Transfer FD Amnt from Savings")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        
                        //Transfer Balance if Fixed Deposit
                        
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code,"Account Type");
                        if AccountTypes.Find('-') then  begin
                        //IF AccountTypes."Fixed Deposit" <> TRUE THEN BEGIN
                        if Vend.Get("Savings Account No.") then begin
                        if Confirm('Are you sure you want to effect the transfer from the savings account',false) = false then
                        exit else
                        
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
                        if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll;
                        
                        Vend.Reset;
                        if Vend.Find('-') then
                        Vend.CalcFields(Vend."Balance (LCY)");
                        //IF (Vend."Balance (LCY)" - 500) < "Fixed Deposit Amount" THEN
                        //ERROR('Savings account does not have enough money to facilate the requested trasfer.');
                        //MESSAGE('Katabaka ene!');
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-OP';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="Savings Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='FD Balance Tranfers';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        //GenJournalLine.Amount:="Fixed Deposit Amount";
                        GenJournalLine.Amount:="Amount to Transfer";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                         //MESSAGE('The FDR amount is %1 ',"Fixed Deposit Amount");
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-OP';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='FD Balance Tranfers';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        //GenJournalLine.Amount:=-"Fixed Deposit Amount";
                        GenJournalLine.Amount:=-"Amount to Transfer";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
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
                        AccountTypes.SetRange(AccountTypes.Code,"Account Type");
                        if AccountTypes.Find('-') then  begin
                        if AccountTypes."Fixed Deposit" = true then begin
                        if Vend.Get("No.") then begin
                        if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account',false) = false then
                        exit;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
                        if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll;

                        Vend.CalcFields(Vend."Balance (LCY)");
                        if (Vend."Balance (LCY)") < "Transfer Amount to Savings" then
                        Error('Fixed Deposit account does not have enough money to facilate the requested trasfer.');

                        LineNo:=LineNo+10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-OP';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='FD Balance Tranfers';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:="Transfer Amount to Savings";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        LineNo:=LineNo+10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-OP';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="Savings Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='FD Balance Tranfers';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=-"Transfer Amount to Savings";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        end;
                        end;
                        end;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
                        if GenJournalLine.Find('-') then begin
                        repeat
                        //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        until GenJournalLine.Next = 0;
                        end;


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
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
                        if Confirm('Are you sure you want to renew the fixed deposit.',false) = false then
                        exit;

                        TestField("FD Maturity Date");
                        if FDType.Get("Fixed Deposit Type") then begin
                        "FD Maturity Date":=CalcDate(FDType.Duration,"FD Maturity Date");
                        "Date Renewed":=Today;
                        "FDR Deposit Status Type":="fdr deposit status type"::New;
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
                        AccountTypes.SetRange(AccountTypes.Code,"Account Type");
                        if AccountTypes.Find('-') then  begin
                        if AccountTypes."Fixed Deposit" = true then begin
                        if Vend.Get("No.") then begin
                        if Confirm('Are you sure you want to Terminate this Fixed Deposit Contract?',false) = false then
                        exit;
                        
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
                        if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll;
                        
                        Vend.CalcFields(Vend."Balance (LCY)");
                        if (Vend."Balance (LCY)") < "Transfer Amount to Savings" then
                        Error('Fixed Deposit account does not have enough money to facilate the requested trasfer.');
                        
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-OP';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='FD Termination Tranfer';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:="Balance (LCY)";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-OP';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="Savings Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='FD Termination Tranfer';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=-"Balance (LCY)";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        end;
                        end;
                        end;
                        
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
                        if GenJournalLine.Find('-') then begin
                        repeat
                        //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        until GenJournalLine.Next = 0;
                        end;
                        
                        
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
                        GenJournalLine.DeleteAll;
                        
                        Message('Amount transfered successfully back to the savings Account.');
                        "FDR Deposit Status Type":="fdr deposit status type"::Renewed;
                        
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
                        Vend.SetRange(Vend."No.","No.");
                        if Vend.Find('-') then
                        Report.Run(51516476,true,false,Vend)
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
                    RunPageLink = "No."=field("No."),
                                  "Global Dimension 1 Filter"=field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter"=field("Global Dimension 2 Filter");
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

                        if Confirm('Are you sure you want to charge statement fee? This will recover statement fee.',false) = false then
                        exit;

                        CalcFields("Balance (LCY)","ATM Transactions");
                        if ("Balance (LCY)"-"ATM Transactions")<=0 then
                        Error('This Account does not have sufficient funds');


                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code,"Account Type");
                        if AccountTypes.Find('-') then  begin

                        //Closure charges
                        Charges.Reset;
                        Charges.SetRange(Charges.Code,AccountTypes."Statement Charge");
                        if Charges.Find('-') then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
                        if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll;

                        LineNo:=LineNo+10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-STM';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:=Charges.Description;
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=Charges."Charge Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":=Charges."GL Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;


                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
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

                        if "Account Type"='SPECIAL' then
                        Error('You cannot recover Class B Shares from this account');

                        if "Shares Recovered"=true then
                        Error('Class B shares already recovered');

                        if Confirm('Are you sure you want to recover Class B shares? This will recover Class B shares.',false) = false then
                        exit;


                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code,"Account Type");
                        if AccountTypes.Find('-') then  begin

                        // charges
                        Charges.Reset;
                        Charges.SetRange(Charges.Code,AccountTypes."FOSA Shares");
                        if Charges.Find('-') then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
                        if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll;

                        CalcFields("Balance (LCY)","ATM Transactions");
                        if ("Balance (LCY)"-"ATM Transactions") <= Charges."Charge Amount" then
                        Error('This Account does not have sufficient funds');

                        LineNo:=LineNo+10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-FSH';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:=Charges.Description;
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=Charges."Charge Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":=Charges."GL Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;


                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
                        if GenJournalLine.Find('-') then begin
                        //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        end;

                        //Post New


                        end;
                        //Closure charges

                        end;

                        "Shares Recovered":=true;
                        "ClassB Shares":= -Charges."Charge Amount";
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

                        if Confirm('Are you sure you want to post the ATM Charges fee?')=false then
                        exit;


                        CalcFields("Balance (LCY)","ATM Transactions");
                        if ("Balance (LCY)"-"ATM Transactions")<=0 then
                        Error('This Account does not have sufficient funds');


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
                        GenJournalLine.DeleteAll;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine."Document No.":="Card No.";
                        GenJournalLine.Description:='Sacco Link Card Charges: '+ "Card No.";
                        GenJournalLine.Amount:=550;
                        GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <>0 then
                        GenJournalLine.Insert;


                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No.":='BNK000001';
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine."Document No.":="Card No.";
                        GenJournalLine.Description:='Sacco Link Card Charges: No.'+ "Card No.";
                        GenJournalLine.Amount:=-500;
                        GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <>0 then
                        GenJournalLine.Insert;

                        //Comms to Commissions account
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":='4-11-000310';
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine."Document No.":="Card No.";
                        GenJournalLine.Description:='Sacco Link Card Charges' + 'No.'+ "Card No.";
                        GenJournalLine.Amount:=-50;
                        GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <>0 then
                        GenJournalLine.Insert;



                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
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
                        if Confirm('Are you sure you want to post the ATM Charges fee?')=false then
                        exit;


                        CalcFields("Balance (LCY)","ATM Transactions");
                        if ("Balance (LCY)"-"ATM Transactions")<=0 then
                        Error('This Account does not have sufficient funds');


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
                        GenJournalLine.DeleteAll;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine."Document No.":="Card No.";
                        GenJournalLine.Description:='Sacco Link Card Charges: '+ "Card No.";
                        GenJournalLine.Amount:=600;
                        GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <>0 then
                        GenJournalLine.Insert;


                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No.":='BNK000001';
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine."Document No.":="Card No.";
                        GenJournalLine.Description:='Sacco Link Card Charges: No.'+ "Card No.";
                        GenJournalLine.Amount:=-500;
                        GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <>0 then
                        GenJournalLine.Insert;

                        //Comms to Commissions account
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":='4-11-000310';
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine."Document No.":="Card No.";
                        GenJournalLine.Description:='Sacco Link Card Charges' + 'No.'+ "Card No.";
                        GenJournalLine.Amount:=-100;
                        GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <>0 then
                        GenJournalLine.Insert;



                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
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

                        if Confirm('Are you sure you want to charge Pass book fee? This will recover passbook fee.',false) = false then
                        exit;

                        CalcFields("Balance (LCY)","ATM Transactions");
                        if ("Balance (LCY)"-"ATM Transactions")<=0 then
                        Error('This Account does not have sufficient funds');


                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code,"Account Type");
                        if AccountTypes.Find('-') then  begin

                        //Closure charges
                        Charges.Reset;
                        Charges.SetRange(Charges.Code,AccountTypes."Statement Charge");
                        if Charges.Find('-') then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
                        if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll;

                        LineNo:=LineNo+10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-STM';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:=Charges.Description;
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=Charges."Charge Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":=Charges."GL Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;


                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
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
                    RunObject = Page "FOSA Account Signatories Card";
                    RunPageLink = "Account No"=field("No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        
        //Hide balances for hidden accounts
        /*IF CurrForm.UnclearedCh.VISIBLE=FALSE THEN BEGIN
        CurrForm.BookBal.VISIBLE:=TRUE;
        CurrForm.UnclearedCh.VISIBLE:=TRUE;
        CurrForm.AvalBal.VISIBLE:=TRUE;
        CurrForm.Statement.VISIBLE:=TRUE;
        CurrForm.Account.VISIBLE:=TRUE;
        END;
        
        
        IF Hide = TRUE THEN BEGIN
        IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID."Show Hiden" = FALSE THEN BEGIN
        CurrForm.BookBal.VISIBLE:=FALSE;
        CurrForm.UnclearedCh.VISIBLE:=FALSE;
        CurrForm.AvalBal.VISIBLE:=FALSE;
        CurrForm.Statement.VISIBLE:=FALSE;
        CurrForm.Account.VISIBLE:=FALSE;
        END;
        END;
        END;
        //Hide balances for hidden accounts
          */
        MinBalance:=0;
        if AccountType.Get("Account Type") then
        MinBalance:=AccountType."Minimum Balance";
        
        /*CurrForm.lblID.VISIBLE := TRUE;
        CurrForm.lblDOB.VISIBLE := TRUE;
        CurrForm.lblRegNo.VISIBLE := FALSE;
        CurrForm.lblRegDate.VISIBLE := FALSE;
        CurrForm.lblGender.VISIBLE := TRUE;
        CurrForm.txtGender.VISIBLE := TRUE;
        IF "Account Category" <> "Account Category"::Single THEN BEGIN
        CurrForm.lblID.VISIBLE := FALSE;
        CurrForm.lblDOB.VISIBLE := FALSE;
        CurrForm.lblRegNo.VISIBLE := TRUE;
        CurrForm.lblRegDate.VISIBLE := TRUE;
        CurrForm.lblGender.VISIBLE := FALSE;
        CurrForm.txtGender.VISIBLE := FALSE;
        END;*/
        OnAfterGetCurrRecord;
        
        Statuschange.Reset;
        Statuschange.SetRange(Statuschange."User ID",UserId);
        Statuschange.SetRange(Statuschange."Function",Statuschange."function"::"Account Status");
        if not Statuschange.Find('-')then
        CurrPage.Editable:=false
        else
        CurrPage.Editable:=true;
        
        CalcFields(NetDis);
        UnclearedLoan:=NetDis;
        //MESSAGE('Uncleared loan is %1',UnclearedLoan);

    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Find(Which);
        CurrPage.Editable := RecordFound or (GetFilter("No.") = '');
        exit(RecordFound);
    end;

    trigger OnInit()
    begin
        if "Assigned System ID"<>'' then begin
        UsersRec.Reset;
        UsersRec.SetRange(UsersRec."User Name",UserId);
        if UsersRec.Find('-') then begin
        if (UsersRec."View Special Accounts"=false) and (UserId<>"Assigned System ID") then
          Error ('You dont have permissions to view this account, Contact your system administrator! ')
        end;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Creditor Type":="creditor type"::"FOSA Account";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        ActivateFields;
        /*
        IF NOT MapMgt.TestSetup THEN
          CurrForm.MapPoint.VISIBLE(FALSE);
        */
        
        
        //Filter based on branch
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Global Dimension 2 Code",UsersID.Branch);
        END;*/
        //Filter based on branch

    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        PictureExists: Boolean;
        AccountTypes: Record "Account Types-Saving Products";
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        ForfeitInterest: Boolean;
        InterestBuffer: Record "Interest Buffer";
        FDType: Record "Fixed Deposit Type";
        Vend: Record Vendor;
        Cust: Record "Member Register";
        LineNo: Integer;
        UsersID: Record User;
        DActivity: Code[20];
        DBranch: Code[20];
        MinBalance: Decimal;
        OBalance: Decimal;
        OInterest: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loan GuarantorsFOSA";
        Loans: Record "Loans Register";
        DefaulterType: Code[20];
        LastWithdrawalDate: Date;
        AccountType: Record "Account Types-Saving Products";
        ReplCharge: Decimal;
        Acc: Record Vendor;
        SearchAcc: Code[10];
        Searchfee: Decimal;
        Statuschange: Record "Status Change Permision";
        UnclearedLoan: Decimal;
        LineN: Integer;
        UsersRec: Record User;


    procedure ActivateFields()
    begin
        //CurrForm.Contact.EDITABLE("Primary Contact No." = '');
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ActivateFields;
    end;
}

