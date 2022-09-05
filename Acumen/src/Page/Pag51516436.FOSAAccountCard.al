#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516436 "FOSA Account Card"
{
    Caption = 'Account Card';
    Editable = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = Vendor;
    SourceTableView = where("Creditor Type" = const("FOSA Account"),
                            "Debtor Type" = const("FOSA Account"));

    layout
    {
        area(content)
        {
            group(AccountTab)
            {
                Caption = 'General Info';
                Editable = true;
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No.';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field("Joint Account Name"; "Joint Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member class"; "Member class")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Personal No."; "Personal No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("BOSA Account No"; "BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Recruited By"; "Recruited By")
                {
                    ApplicationArea = Basic;
                }
                field("Station/Sections"; "Station/Sections")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                }
                field(txtGender; Gender)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Uncleared Cheques"; "Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Balance (LCY)"; "Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Book Balance';
                    Enabled = false;
                    Visible = false;
                }
                field(AvailableBal; "Balance (LCY)" - (("Uncleared Cheques" - "Cheque Discounted Amount") + "ATM Transactions" + "EFT Transactions" + MinBalance + "Mobile Transactions") + "Cheque Discounted")
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawable Balance';
                    Editable = false;
                }
                field("Cheque Discounted"; "Cheque Discounted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Comission On Cheque Discount"; "Comission On Cheque Discount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Vendor Posting Group"; "Vendor Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Additional;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Reason For Blocking Account"; "Reason For Blocking Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        //TESTFIELD("Resons for Status Change");
                    end;
                }
                field("Account Frozen"; "Account Frozen")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM No."; "ATM No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Acc. No"; "Cheque Acc. No")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Picture; Piccture)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Signature; Signature)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Standard;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        TestField("Resons for Status Change");

                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Account Status");
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
                            if Confirm('Are you sure you want to re-activate this account? This will recover re-activation fee.', false) = false then begin
                                Error('Re-activation terminated.');
                            end;

                            Blocked := Blocked::" ";
                            Modify;





                        end;


                        //Account Closure
                        if Status = Status::Closed then begin
                            TestField("Closure Notice Date");
                            if Confirm('Are you sure you want to close this account? This will recover closure fee and any '
                            + 'interest earned before maturity will be forfeited.', false) = false then begin
                                Error('Closure terminated.');
                            end;


                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                            if GenJournalLine.Find('-') then
                                GenJournalLine.DeleteAll;



                            AccountTypes.Reset;
                            AccountTypes.SetRange(AccountTypes.Code, "Account Type");
                            if AccountTypes.Find('-') then begin
                                "Date Closed" := Today;

                                //Closure charges
                                /*Charges.RESET;
                                IF CALCDATE(AccountTypes."Closure Notice Period","Closure Notice Date") > TODAY THEN
                                Charges.SETRANGE(Charges.Code,AccountTypes."Closing Prior Notice Charge") */

                                Charges.Reset;
                                if CalcDate(AccountTypes."Closure Notice Period", "Closure Notice Date") > Today then
                                    Charges.SetRange(Charges.Code, AccountType."Closing Charge")

                                else
                                    Charges.SetRange(Charges.Code, AccountTypes."Closing Charge");
                                if Charges.Find('-') then begin
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := "No." + '-CL';
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

                                end;
                                //Closure charges


                                //Interest forfeited/Earned on maturity
                                CalcFields("Untranfered Interest");
                                if "Untranfered Interest" > 0 then begin
                                    ForfeitInterest := true;
                                    //If FD - Check if matured
                                    if AccountTypes."Fixed Deposit" = true then begin
                                        if "FD Maturity Date" <= Today then
                                            ForfeitInterest := false;
                                        if "Call Deposit" = true then
                                            ForfeitInterest := false;

                                    end;

                                    //PKK INGORE MATURITY
                                    ForfeitInterest := false;
                                    //If FD - Check if matured

                                    if ForfeitInterest = true then begin
                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := "No." + '-CL';
                                        GenJournalLine."External Document No." := "No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                        GenJournalLine."Account No." := AccountTypes."Interest Forfeited Account";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Interest Forfeited';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := -"Untranfered Interest";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        InterestBuffer.Reset;
                                        InterestBuffer.SetRange(InterestBuffer."Account No", "No.");
                                        if InterestBuffer.Find('-') then
                                            InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);


                                    end else begin
                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := "No." + '-CL';
                                        GenJournalLine."External Document No." := "No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        if AccountTypes."Fixed Deposit" = true then
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



                                    end;


                                    //Transfer Balance if Fixed Deposit
                                    if AccountTypes."Fixed Deposit" = true then begin
                                        CalcFields("Balance (LCY)");

                                        TestField("Savings Account No.");

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := "No." + '-CL';
                                        GenJournalLine."External Document No." := "No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := "Savings Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'FD Balance Tranfers';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        if "Amount to Transfer" <> 0 then
                                            GenJournalLine.Amount := -"Amount to Transfer"
                                        else
                                            GenJournalLine.Amount := -"Balance (LCY)";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := "No." + '-CL';
                                        GenJournalLine."External Document No." := "No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := "No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'FD Balance Tranfers';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        if "Amount to Transfer" <> 0 then
                                            GenJournalLine.Amount := "Amount to Transfer"
                                        else
                                            GenJournalLine.Amount := "Balance (LCY)";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        if GenJournalLine.Amount <> 0 then
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
                field("Staff Account"; "Staff Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closure Notice Date"; "Closure Notice Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Resons for Status Change"; "Resons for Status Change")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Signing Instructions"; "Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field("Interest Earned"; "Interest Earned")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Untranfered Interest"; "Untranfered Interest")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Allowable Cheque Discounting %"; "Allowable Cheque Discounting %")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Additional;
                }
                field("S-Mobile No"; "S-Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mobile Transactions"; "Mobile Transactions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("E-Loan Qualification Amount"; "E-Loan Qualification Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Reason for Freezing Account"; "Reason for Freezing Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Account Frozen By"; "Account Frozen By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Account Special Instructions"; "Account Special Instructions")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("No Of Signatories"; "No Of Signatories")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(AccountTab1)
            {
                Caption = 'Communication Info';
                Editable = true;
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code/City';
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Home Page"; "Home Page")
                {
                    ApplicationArea = Basic;
                }
                field(Contact; Contact)
                {
                    ApplicationArea = Basic;
                }
                field("ContacPerson Phone"; "ContacPerson Phone")
                {
                    ApplicationArea = Basic;
                }
                field("ContactPerson Occupation"; "ContactPerson Occupation")
                {
                    ApplicationArea = Basic;
                }
                field(CodeDelete; CodeDelete)
                {
                    ApplicationArea = Basic;
                }
                field("Home Address"; "Home Address")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Joint2Details)
            {
                Caption = 'Joint2Details';
                Visible = Joint2DetailsVisible;
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
                    Editable = false;
                }
                field("Address3-Joint"; "Address3-Joint")
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = false;
                }
                field("Postal Code 2"; "Postal Code 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 2"; "Town 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. 3"; "Mobile No. 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                }
                field("Date of Birth2"; "Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                }
                field("ID No.2"; "ID No.2")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                }
                field("Passport 2"; "Passport 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 2"; "Member Parish 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    Editable = false;
                }
                field("Member Parish Name 2"; "Member Parish Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                    Editable = false;
                }
                field(Gender2; Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status2"; "Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code2"; "Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town2"; "Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code2"; "Employer Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name2"; "Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal2)"; "E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail (Personal)';
                    Editable = false;
                }
                field("Picture 2"; "Picture 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                    Editable = false;
                }
                field("Signature  2"; "Signature  2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                    Editable = false;
                }
            }
            group(Joint3Details)
            {
                Visible = Joint3DetailsVisible;
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
                    Editable = false;
                }
                field(Address4; Address4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = false;
                }
                field("Postal Code 3"; "Postal Code 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 3"; "Town 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. 4"; "Mobile No. 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Date of Birth3"; "Date of Birth3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("ID No.3"; "ID No.3")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Passport 3"; "Passport 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 3"; "Member Parish 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Member Parish Name 3"; "Member Parish Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                    Editable = false;
                }
                field(Gender3; Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status3"; "Marital Status3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code3"; "Home Postal Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town3"; "Home Town3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code3"; "Employer Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name3"; "Employer Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal3)"; "E-Mail (Personal3)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Picture 3"; "Picture 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                    Editable = false;
                }
                field("Signature  3"; "Signature  3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                    Editable = false;
                }
            }
            group("Term Deposit Details")
            {
                Caption = 'Term Deposit Details';
                field("Fixed Deposit Type"; "Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Term Deposit Type';
                    Editable = false;
                    Visible = true;
                }
                field("Fixed Deposit Start Date"; "Fixed Deposit Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fixed Duration"; "Fixed Duration")
                {
                    ApplicationArea = Basic;
                    Caption = 'Term Duration';
                    Editable = false;
                }
                field("Amount to Transfer"; "Amount to Transfer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount to Transfer from Current';
                    Editable = false;
                }
                field("Fixed Deposit Certificate No."; "Fixed Deposit Certificate No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Interest On Term Dep"; "Expected Interest On Term Dep")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Interest Earned';
                    Editable = false;
                }
                field("FD Maturity Date"; "FD Maturity Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Maturity Date';
                    Editable = false;
                }
                field("Fixed Deposit Status"; "Fixed Deposit Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Term Deposit Status';
                    Editable = false;
                }
                field("Term Deposit Status Type"; "FDR Deposit Status Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Term Deposit Status Type';
                    Editable = false;
                }
                field("On Term Deposit Maturity"; "On Term Deposit Maturity")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest rate"; "Interest rate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Savings Account No."; "Savings Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Account No.';
                    Editable = false;
                }
                field("Transfer Amount to Savings"; "Transfer Amount to Savings")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transfer Amount to Current';
                    Editable = false;
                }
                field("Last Interest Earned Date"; "Last Interest Earned Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Previous Term Deposit Details")
            {
                Caption = 'Previous Term Deposit Details';
                field("Prevous Fixed Deposit Type"; "Prevous Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Deposit Type';
                    Editable = false;
                }
                field("Prevous FD Start Date"; "Prevous FD Start Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Deposit Start Date';
                    Editable = false;
                }
                field("Prevous Fixed Duration"; "Prevous Fixed Duration")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Deposit Duration';
                    Editable = false;
                }
                field("Prevous Expected Int On FD"; "Prevous Expected Int On FD")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Int On Fixed Deposit';
                    Editable = false;
                }
                field("Prevous FD Maturity Date"; "Prevous FD Maturity Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Maturity Date';
                    Editable = false;
                }
                field("Prevous FD Deposit Status Type"; "Prevous FD Deposit Status Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Deposit Status Type';
                    Editable = false;
                }
                field("Prevous Interest Rate FD"; "Prevous Interest Rate FD")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Rate Fixed Deposit';
                    Editable = false;
                }
                field("Date Renewed"; "Date Renewed")
                {
                    ApplicationArea = Basic;
                }
            }
            group("ATM Details")
            {
                Caption = 'ATM Details';
                field("ATM No.B"; "ATM No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Withdrawal Limit"; "ATM Withdrawal Limit")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Transactions"; "ATM Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Atm card ready"; "Atm card ready")
                {
                    ApplicationArea = Basic;
                    Caption = 'ATM Card Ready For Collection';
                }
                field("FDR Deposit Status Type"; "ATM Issued")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Self Picked"; "ATM Self Picked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector Name"; "ATM Collector Name")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector's ID"; "ATM Collector's ID")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector's Mobile"; "ATM Collector's Mobile")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bulk Withdrawal Application")
            {
                Caption = 'Bulk Withdrawal Application';
                field("Bulk Withdrawal Appl Done"; "Bulk Withdrawal Appl Done")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Appl. Done';
                    Editable = false;
                }
                field("Bulk Withdrawal Appl Date"; "Bulk Withdrawal Appl Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Appl. Date';
                    Editable = false;
                }
                field("Bulk Withdrawal App Date For W"; "Bulk Withdrawal App Date For W")
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawal Date';
                }
                field("Bulk Withdrawal Appl Amount"; "Bulk Withdrawal Appl Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Appl. Amount';
                    Editable = false;
                }
                field("Bulk Withdrawal Fee"; "Bulk Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Fee';
                    Editable = false;
                }
                field("Bulk Withdrawal App Done By"; "Bulk Withdrawal App Done By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Appl. Captured By';
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000034; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
            part(Control16; "Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No." = field("BOSA Account No");
            }
            part(Control1000000116; "Vendor Picture-Uploaded")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000115; "Vendor Signature-Uploaded")
            {
                ApplicationArea = All;
                Caption = 'Signature';
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
                action("ATM Cards Linked")
                {
                    ApplicationArea = Basic;
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "ATM Card Nos Buffer";
                    RunPageLink = "Account No" = field("No.");
                }
                separator(Action108)
                {
                }
                action("Re-new Fixed Deposit")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-new Fixed Deposit';
                    Image = "Report";
                    Visible = false;

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
                            Report.Run(51516354, true, true, Cust);
                    end;
                }
                action("Loan Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "BOSA Account No");
                        if Cust.Find('-') then
                            Report.Run(51516531, true, true, Cust);
                    end;
                }
                action("FOSA Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'All Loans';
                    Promoted = true;
                    RunObject = Page "Loans Sub-Page List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Reactivate Acciount")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /* IF CONFIRM('Are you sure you want to Close this Account?',FALSE)=TRUE THEN BEGIN
                         IF "Balance (LCY)"-("Uncleared Cheques"+"ATM Transactions"+"EFT Transactions"+MinBalance+UnclearedLoan)<0 THEN
                         ERROR('This Member does not enough Savings to recover Withdrawal Fee')
                        ELSE
                            LineN:=LineN+10000;
                            Gnljnline.INIT;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."Account Type"::Vendor;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.VALIDATE(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=TODAY;
                            Gnljnline.Amount:=500;
                            Gnljnline.Description:='Account Closure Fee';
                            Gnljnline.VALIDATE(Gnljnline.Amount);
                            IF Gnljnline.Amount<>0 THEN
                            Gnljnline.INSERT;
                        
                            LineN:=LineN+10000;
                            Gnljnline.INIT;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::"G/L Account";
                            Gnljnline."Bal. Account No.":='105113';
                            Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=TODAY;
                            Gnljnline.Amount:=-500;
                            Gnljnline.Description:='Account Closure Fee';
                            Gnljnline.VALIDATE(Gnljnline.Amount);
                            IF Gnljnline.Amount<>0 THEN
                            Gnljnline.INSERT;
                        
                        
                        END;*/
                        if Confirm('Are you sure you want to Reactivate This Account?', true) = false then
                            exit;
                        Status := Status::Active;
                        Modify;

                    end;
                }
                action("Freeze Acciount")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Freeze This Account?', true) = false then
                            exit;

                        FreezeandActiveate.Reset;
                        FreezeandActiveate.SetCurrentkey(FreezeandActiveate."Entry No.");
                        if FreezeandActiveate.FindLast then begin
                            Entry := FreezeandActiveate."Entry No." + 1;
                        end;

                        FreezeandActiveate.Init;
                        FreezeandActiveate.user := UserId;
                        FreezeandActiveate."Entry No." := Entry;
                        FreezeandActiveate.Name := Name;
                        FreezeandActiveate.Date := Today;
                        FreezeandActiveate."Member No." := "No.";
                        FreezeandActiveate.Insert;
                        Page.Run(51516732, FreezeandActiveate);




                        /* IF CONFIRM('Are you sure you want to Close this Account?',FALSE)=TRUE THEN BEGIN
                         IF "Balance (LCY)"-("Uncleared Cheques"+"ATM Transactions"+"EFT Transactions"+MinBalance+UnclearedLoan)<0 THEN
                         ERROR('This Member does not enough Savings to recover Withdrawal Fee')
                        ELSE
                            LineN:=LineN+10000;
                            Gnljnline.INIT;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."Account Type"::Vendor;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.VALIDATE(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=TODAY;
                            Gnljnline.Amount:=500;
                            Gnljnline.Description:='Account Closure Fee';
                            Gnljnline.VALIDATE(Gnljnline.Amount);
                            IF Gnljnline.Amount<>0 THEN
                            Gnljnline.INSERT;
                        
                            LineN:=LineN+10000;
                            Gnljnline.INIT;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::"G/L Account";
                            Gnljnline."Bal. Account No.":='105113';
                            Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=TODAY;
                            Gnljnline.Amount:=-500;
                            Gnljnline.Description:='Account Closure Fee';
                            Gnljnline.VALIDATE(Gnljnline.Amount);
                            IF Gnljnline.Amount<>0 THEN
                            Gnljnline.INSERT;
                        
                        
                        END;*/

                        Status := Status::Frozen;
                        Modify;

                    end;
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
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Products Signatories Details";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Agent Details")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Agent Account Signatory list";
                    RunPageLink = "Account No" = field("No.");
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
                    RunPageLink = "Account No" = field("No.");
                }
                separator(Action1102755005)
                {
                }
                action("Transfer Term Amnt from Current")
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
                                if Confirm('Are you sure you want to effect the transfer from the Current account', false) = true then
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
                                GenJournalLine."Document No." := "No.";
                                GenJournalLine."External Document No." := "No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := "Savings Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Term Balance Tranfers';
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
                                GenJournalLine."Document No." := "No.";
                                GenJournalLine."External Document No." := "No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := "No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Term Balance Tranfers';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                //GenJournalLine.Amount:=-"Fixed Deposit Amount";
                                GenJournalLine.Amount := -"Amount to Transfer";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //END;
                            end;
                        end;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            repeat
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;



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
                action("Transfer Term Amount to Current")
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
                                    if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account', false) = true then
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
                                    GenJournalLine."Document No." := "No.";
                                    GenJournalLine."External Document No." := "No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := "No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Term Balance Tranfers';
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
                                    GenJournalLine."Document No." := "No.";
                                    GenJournalLine."External Document No." := "No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := "Savings Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Term Balance Tranfers';
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
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;

                        /*
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                        GenJournalLine.DELETEALL;
                        */
                        Message('Amount transfered successfully.');

                    end;
                }
                action("Renew Term deposit")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        if AccountTypes.Get("Account Type") then begin
                            if AccountTypes."Fixed Deposit" = true then begin
                                if Confirm('Are you sure you want to renew the fixed deposit.', false) = false then
                                    exit;




                                "Prevous Fixed Deposit Type" := "Fixed Deposit Type";
                                "Prevous FD Deposit Status Type" := "FDR Deposit Status Type";
                                "Prevous FD Maturity Date" := "FD Maturity Date";
                                "Prevous FD Start Date" := "Fixed Deposit Start Date";
                                "Prevous Fixed Duration" := "Fixed Duration";
                                "Prevous Interest Rate FD" := "Interest rate";
                                "Prevous Expected Int On FD" := "Expected Interest On Term Dep";
                                "Date Renewed" := Today;


                                "Fixed Deposit Type" := '';
                                //"Fixed Duration":=0D;
                                "FDR Deposit Status Type" := "fdr deposit status type"::New;
                                "FD Maturity Date" := 0D;
                                "Fixed Deposit Start Date" := 0D;
                                "Expected Interest On Term Dep" := 0;
                                "Interest rate" := 0;
                                "Amount to Transfer" := 0;
                                "Transfer Amount to Savings" := 0;
                                "Fixed Deposit Status" := "fixed deposit status"::" ";
                                //"FDR Deposit Status Type":="FDR Deposit Status Type"::"";

                                InterestBuffer.Reset;
                                InterestBuffer.SetRange(InterestBuffer."Account No", "No.");
                                if InterestBuffer.Find('-') then begin
                                    InterestBuffer.DeleteAll;
                                end;



                                "FDR Deposit Status Type" := "fdr deposit status type"::New;
                                Modify;

                                Message('Fixed deposit renewed successfully');
                            end;
                        end;
                        //END;
                    end;
                }
                action("Terminate Term Deposit")
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

                                    Vend.CalcFields(Vend."Balance (LCY)", "Interest Earned");
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
                                    GenJournalLine.Amount := "Balance (LCY)";//+("Interest Earned"-("Interest Earned"*(GenSetup."Withholding Tax (%)"/100)));
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
                                    GenJournalLine.Amount := -"Balance (LCY)";//+("Interest Earned"-("Interest Earned"*(GenSetup."Withholding Tax (%)"/100)));
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    LineNo := LineNo + 10000;

                                    /*IF AccountType.GET("Account Type") THEN BEGIN

                                    GenJournalLine.INIT;
                                    GenJournalLine."Journal Template Name":='PURCHASES';
                                    GenJournalLine."Line No.":=LineNo;
                                    GenJournalLine."Journal Batch Name":='FTRANS';
                                    GenJournalLine."Document No.":="No."+'-OP';
                                    GenJournalLine."External Document No.":="No.";
                                    GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                                    GenJournalLine."Account No.":="No.";
                                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date":=TODAY;
                                    GenJournalLine.Description:='FD Termination Charge';
                                    GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount:=("Interest Earned"-("Interest Earned"*(GenSetup."Withholding Tax (%)"/100)))*(AccountType."Term terminatination fee"/100);
                                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                    GenJournalLine."Bal. Account No.":=AccountType."Term Termination Account";
                                    IF GenJournalLine.Amount<>0 THEN
                                    GenJournalLine.INSERT;
                                    END;*/
                                end;
                            end;
                        end;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            repeat
                                //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        Message('Amount transfered successfully back to the Current Account.');
                        "FDR Deposit Status Type" := "fdr deposit status type"::Terminated;

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
                action("Break Call")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", "No.");
                        if Vend.Find('-') then
                            Report.Run(51516465, true, false, Vend)
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
                        if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                            if UserSetup.Get(UserId) then begin
                                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                            end;

                        end;
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", "No.");
                        if Vend.Find('-') then
                            Report.Run(51516890, true, false, Vend)

                        //REPORT.RUN(51516476,TRUE,FALSE,Vend)
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
                                GenJournalLine."Document No." := "BOSA Account No" + '-STM';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := "No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Statemnt Charge'; //Charges.Description;
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
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                    //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);

                                    Message('Charge Posted Successfully')
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
                    RunObject = Page "FOSA Account Signatories Card";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Charge Fosa Card Replacement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        if Confirm('This process will recover FOSA card replacement Fee.Continue?', false) = false then
                            exit;

                        CalcFields("Balance (LCY)", "ATM Transactions");
                        if ("Balance (LCY)" - "ATM Transactions") <= 0 then
                            Error('This Account does not have sufficient funds');


                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, "Account Type");
                        if AccountTypes.Find('-') then begin

                            Charges.Reset;
                            Charges.SetRange(Charges.Code, 'FCARD');
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
                                GenJournalLine."Document No." := "No." + 'CARD';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := "No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'FOSA card fee';
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
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                    Message('Charge Posted Successfully')
                                end;
                                //Post New
                            end;
                            //Closure charge
                        end;
                    end;
                }
                action("Create Member Account")
                {
                    ApplicationArea = Basic;
                    Image = CalculateWarehouseAdjustment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."ID No.", "ID No.");
                        Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                        if Cust.Find('-') then begin
                            //IF (Cust."No." <> "No.") AND ("Account Category"="Account Category"::Single) THEN
                            Error('There already exists a member');
                        end;


                        Saccosetup.Get();
                        NewMembNo := Saccosetup.BosaNumber;

                        //Create BOSA account
                        Cust."No." := Format(NewMembNo);
                        Cust.Name := Name;
                        Cust.Address := Address;
                        Cust."Post Code" := "Post Code";
                        Cust.County := City;
                        Cust."Phone No." := "Mobile Phone No";
                        Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        Cust."Customer Posting Group" := 'MEMBER';
                        Cust."Account Category" := "account category"::Single;
                        Cust."Registration Date" := Today;
                        Cust."Mobile Phone No" := "Mobile Phone No";
                        Cust.Status := Cust.Status::Active;
                        Cust."Employer Code" := "Employer Code";
                        Cust."Date of Birth" := "Date of Birth";
                        Cust.Piccture := Picture;
                        Cust.Signature := Signature;
                        //Cust."Station/Department":="Station/Department";
                        Cust."E-Mail" := "E-Mail";
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
                        //Cust."Member Share Class":="Member Share Class";
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
                        //Cust."Joint Account Name":="First Name"+'& '+"First Name2"+'& '+"First Name3"+'JA';
                        //Cust."Account Category":="Account Category";

                        //****************************End to Sort Joint

                        //**
                        //Cust."Office Branch":="Office Branch";
                        //Cust.Department:=Department;
                        //Cust.Occupation:=Occupation;
                        //Cust.Designation:=Designation;
                        //Cust."Bank Code":="Bank Code";
                        //Cust."Bank Branch Code":="Bank Name";
                        //Cust."Bank Account No.":="Bank Account No";
                        //**
                        Cust."Sub-Location" := "Sub-Location";
                        Cust.District := District;
                        Cust."Personal No" := "Personal No.";
                        Cust."ID No." := "ID No.";
                        Cust."Mobile Phone No" := "Mobile Phone No";
                        Cust."Marital Status" := "Marital Status";
                        Cust."Customer Type" := Cust."customer type"::Member;
                        Cust.Gender := Gender;

                        //CALCFIELDS(Signature,Picture);
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
                        //Cust."Village/Residence":="Village/Residence";
                        Cust.Insert(true);


                        Message('Back Office Account Created Successfully. The Member Number is now' + NewMembNo);


                        Saccosetup.BosaNumber := IncStr(NewMembNo);
                        Saccosetup.Modify;
                    end;
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
        MinBalance := 0;
        if AccountType.Get("Account Type") then
            MinBalance := AccountType."Minimum Balance";

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
        Statuschange.SetRange(Statuschange."User ID", UserId);
        Statuschange.SetRange(Statuschange."Function", Statuschange."function"::"Account Status");
        if not Statuschange.Find('-') then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;

        CalcFields(NetDis);
        UnclearedLoan := NetDis;

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;
        if "Account Category" = "account category"::Joint then begin
            Joint2DetailsVisible := true;
            Joint3DetailsVisible := true;
        end;


        if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
            if UserSetup.Get(UserId) then begin
                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
            end;

        end;

    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Find(Which);
        CurrPage.Editable := RecordFound or (GetFilter("No.") = '');
        exit(RecordFound);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Creditor Type" := "creditor type"::"FOSA Account";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        ActivateFields;


        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;
        if "Account Category" = "account category"::Joint then begin
            Joint2DetailsVisible := true;
            Joint3DetailsVisible := true;
        end;
    end;

    var
        ReasonFreeze: Text;
        Entry: Integer;
        FreezeandActiveate: Record "Freeze and Activeate";
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
        Cust: Record Customer;
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
        Joint2DetailsVisible: Boolean;
        Joint3DetailsVisible: Boolean;
        GenSetup: Record "Sacco General Set-Up";
        UserSetup: Record "User Setup";
        Saccosetup: Record "Sacco No. Series";
        NewMembNo: Code[30];
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        FieldStyleI: Text;


    procedure ActivateFields()
    begin
        //CurrForm.Contact.EDITABLE("Primary Contact No." = '');
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ActivateFields;
    end;

    local procedure SetFieldStyle()
    begin
        FieldStyleI := '';

        if "Account Special Instructions" <> '' then
            FieldStyleI := 'Attention';
    end;
}

