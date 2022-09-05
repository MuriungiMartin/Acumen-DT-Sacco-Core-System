#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516893 "MC Individual Page"
{
    Caption = 'Member Card';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = Customer;
    SourceTableView = where("Global Dimension 1 Code" = const('MICRO'),
                            "Group Account" = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Memebership No.';
                    Editable = false;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Micro Group Code"; "Micro Group Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        FosaName := '';

                        if "Micro Group Code" <> '' then begin
                            if Vend.Get("Micro Group Code") then begin
                                FosaName := Vend.Name;
                            end;
                        end;
                    end;
                }
                field(FosaName; FosaName)
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Account Name';
                    Editable = false;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        lblIDVisible := true;
                        lblDOBVisible := true;
                        lblRegNoVisible := false;
                        lblRegDateVisible := false;
                        lblGenderVisible := true;
                        txtGenderVisible := true;
                        lblMaritalVisible := true;
                        txtMaritalVisible := true;
                        if "Account Category" <> "account category"::Single then begin
                            lblIDVisible := false;
                            lblDOBVisible := false;
                            lblRegNoVisible := true;
                            lblRegDateVisible := true;
                            lblGenderVisible := false;
                            txtGenderVisible := false;
                            lblMaritalVisible := false;
                            txtMaritalVisible := false;

                        end;
                    end;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID Number';
                    Editable = false;
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code/City';
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer';
                    Editable = false;
                }
                field("Job Title"; "Job title")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Editable = false;
                }
                field(PIN; Pin)
                {
                    ApplicationArea = Basic;
                    Caption = 'PIN';
                    Editable = false;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(txtMarital; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Visible = txtMaritalVisible;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = true;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Signature)
                {
                    ApplicationArea = Basic;
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
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Overide Defaulters");
                        if StatusPermissions.Find('-') = false then
                            Error('You do not have permissions to change the account status.');
                    end;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Currect File Location"; "Currect File Location")
                {
                    ApplicationArea = Basic;
                }
                field("File Movement Remarks"; "File Movement Remarks")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Group Details")
            {
                Caption = 'Group Details';
                field("Group Code"; "Group Code")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Account"; "FOSA Account")
                {
                    ApplicationArea = Basic;
                }
                field("Group Account No"; "Group Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Business Loan Officer"; "Business Loan Officer")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Officer Name"; "Loan Officer Name")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Other Details")
            {
                Caption = 'Other Details';
                Editable = true;
                field("Contact Person"; "Contact Person")
                {
                    ApplicationArea = Basic;
                }
                field("Contact Person Phone"; "Contact Person Phone")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Village/Residence"; "Village/Residence")
                {
                    ApplicationArea = Basic;
                }
                field("Home Page"; "Home Page")
                {
                    ApplicationArea = Basic;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Physical Address';
                }
                field("Withdrawal Application Date"; "Withdrawal Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Date"; "Withdrawal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Fee"; "Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Status - Withdrawal App."; "Status - Withdrawal App.")
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Dividend Payment"; "Mode of Dividend Payment")
                {
                    ApplicationArea = Basic;
                }
                field("Recruited By"; "Recruited By")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account No."; "BOSA Account No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000020; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000019; "Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000016; "Member Signature-Uploaded")
            {
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Member")
            {
                Caption = '&Member';
                action("<Page Customer Ledger Entries>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    RunObject = Page "Member Ledger Entries";
                    RunPageLink = "Customer No." = field("FOSA Account");
                    RunPageView = sorting("Customer No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                }
                action("Bank Account")
                {
                    ApplicationArea = Basic;
                    Image = Card;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = field("No.");
                }
                action(Contacts)
                {
                    ApplicationArea = Basic;
                    Image = ContactPerson;

                    trigger OnAction()
                    begin
                        ShowContact;
                    end;
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    Visible = false;
                }
                action("Loans Guarantors")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guarantors';
                    Image = "Report";

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516226, true, false, Cust);
                    end;
                }
                action("Loans Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516225, true, false, Cust);
                    end;
                }
                action("BOSA Account Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Main Account';
                    Image = Card;
                    Promoted = true;
                    RunObject = Page "HR Disciplinary Cases";
                    RunPageLink = "No." = field("Last Deposit Contribution Date");
                    Visible = false;
                }
                action("Member Card Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516279, true, false, Cust);
                    end;
                }
                separator(Action1000000024)
                {
                }
                action("Fosa Card")
                {
                    ApplicationArea = Basic;
                    Image = Card;
                    Promoted = true;
                    RunObject = Page "HR Emp Transfer List";
                    RunPageLink = "No. Series" = field("Card No");
                }
                separator(Action1102755028)
                {
                }
            }
            group(ActionGroup1102755023)
            {
                action("Monthly Contributions")
                {
                    ApplicationArea = Basic;
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Sections List";
                    RunPageLink = "No." = field("No.");
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("No.");
                }
                separator(Action1102755021)
                {
                }
                group(ActionGroup1102755018)
                {
                }
                action("Detailed Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516886, true, false, Cust);
                    end;
                }
                separator(Action1102755011)
                {
                }
                action("Account-Closure_Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516250, true, false, Cust);
                    end;
                }
                action("Close Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Close Account';
                    Image = "Report";

                    trigger OnAction()
                    begin
                        if "Status - Withdrawal App." <> "status - withdrawal app."::Rejected then
                            Error('Withdrawal application must be approved before posting.');

                        if Confirm('Are you sure you want to recover the loans from the members shares?') = false then
                            exit;

                        GeneralSetup.Get(0);

                        //delete journal line
                        Gnljnline.Reset;
                        Gnljnline.SetRange("Journal Template Name", 'GENERAL');
                        Gnljnline.SetRange("Journal Batch Name", 'ACC CLOSED');
                        Gnljnline.DeleteAll;
                        //end of deletion

                        TotalRecovered := 0;

                        CalcFields("Outstanding Balance", "Accrued Interest", "Current Shares", "Insurance Fund", "FOSA Outstanding Balance",
                                   "FOSA Oustanding Interest", "Shares Retained");

                        if Status = Status::Deceased then
                            TotalAvailable := ("Current Shares") * -1
                        else
                            TotalAvailable := ("Insurance Fund" + "Current Shares") * -1;


                        if "Shares Retained" < -GeneralSetup."Retained Shares" then
                            Error('Please transfer 2000/= deposits to the member share capital account.');

                        if "Defaulted Loans Recovered" <> true then begin
                            if "Closing Deposit Balance" = 0 then
                                "Closing Deposit Balance" := "Current Shares" * -1;
                            if "Closing Loan Balance" = 0 then
                                "Closing Loan Balance" := "Outstanding Balance" + "FOSA Outstanding Balance";
                            if "Closing Insurance Balance" = 0 then
                                "Closing Insurance Balance" := "Insurance Fund" * -1;
                        end;
                        "Withdrawal Posted" := true;
                        Modify;

                        Loans.Reset;
                        Loans.SetRange(Loans."Client Code", "Micro Group Code");
                        Loans.SetRange(Loans.Source, Loans.Source::BOSA);
                        if Loans.Find('-') then begin
                            repeat
                                Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");

                                if Loans."Outstanding Balance" > 0 then
                                    TotalFOSALoan := TotalFOSALoan + Loans."Outstanding Balance";

                                if Loans."Oustanding Interest" > 0 then
                                    TotalFOSALoan := TotalFOSALoan + Loans."Oustanding Interest";

                            until Loans.Next = 0;
                        end;


                        TotalOustanding := ("Outstanding Balance" + "Accrued Interest" + TotalFOSALoan);



                        //Create MC Account
                        if (TotalOustanding + 1000 + ("Current Shares" + "Insurance Fund")) < 0 then begin
                            if Vend.Get('MC-' + "Personal No") = false then begin
                                TestField("Personal No");

                                Vend.Init;
                                Vend."No." := 'MC-' + "Personal No";
                                Vend.Name := Name;
                                Vend."Personal No." := "Personal No";
                                Vend."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                Vend."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                Vend."Vendor Posting Group" := 'MCREDITOR';
                                Vend.Insert(true);

                                Vend.Reset;
                                if Vend.Get('MC-' + "Personal No") then begin
                                    Vend.Validate(Vend.Name);
                                    Vend."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                    Vend."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                    Vend.Validate(Vend."Global Dimension 1 Code");
                                    Vend.Validate(Vend."Global Dimension 2 Code");
                                    Vend.Validate(Vend."Vendor Posting Group");
                                    Vend.Modify;
                                end;
                            end;
                        end;
                        //Create MC Account


                        //Recover Defaulter Loan first
                        TotalDefaulterR := 0;
                        value2 := TotalAvailable;
                        AvailableShares := TotalAvailable;

                        Loans.Reset;
                        Loans.SetRange(Loans."Client Code", "No.");
                        Loans.SetRange(Loans.Source, Loans.Source::" ");
                        Loans.SetRange(Loans."Loan Product Type", 'DFTL');
                        if Loans.Find('-') then begin
                            repeat
                                Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");

                                Value1 := Loans."Outstanding Balance" + Loans."Oustanding Interest";
                                if (Value1 <> 0) and (TotalAvailable > 0) then begin
                                    //Recover Interest
                                    if (Loans."Oustanding Interest" > 0) and (AvailableShares > 0) then begin
                                        Interest := 0;
                                        Interest := Loans."Oustanding Interest";

                                        if Interest > 0 then begin

                                            LineN := LineN + 10000;
                                            Gnljnline.Init;
                                            Gnljnline."Journal Template Name" := 'GENERAL';
                                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                                            Gnljnline."Line No." := LineN;
                                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                            Gnljnline."Account No." := "No.";
                                            Gnljnline.Validate(Gnljnline."Account No.");
                                            Gnljnline."Document No." := 'LR-' + "No.";
                                            Gnljnline."Posting Date" := Today;
                                            Gnljnline.Description := 'Interest Recovery from deposits';
                                            if AvailableShares < Interest then
                                                Gnljnline.Amount := -1 * AvailableShares
                                            else
                                                Gnljnline.Amount := -1 * Interest;

                                            Gnljnline.Validate(Gnljnline.Amount);
                                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Insurance Contribution";
                                            Gnljnline."Loan No" := Loans."Loan  No.";
                                            if Gnljnline.Amount <> 0 then
                                                Gnljnline.Insert;

                                            AvailableShares := AvailableShares - (Gnljnline.Amount * -1);
                                            TotalDefaulterR := TotalDefaulterR + (Gnljnline.Amount * -1);
                                            TotalRecovered := TotalRecovered + (Gnljnline.Amount * -1);
                                        end;
                                    end;




                                    //Recover Repayment
                                    if (Loans."Outstanding Balance" > 0) and (AvailableShares > 0) then begin
                                        LRepayment := 0;
                                        LRepayment := Loans."Outstanding Balance";

                                        if LRepayment > 0 then begin


                                            LineN := LineN + 10000;

                                            Gnljnline.Init;
                                            Gnljnline."Journal Template Name" := 'GENERAL';
                                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                                            Gnljnline."Line No." := LineN;
                                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                            Gnljnline."Account No." := "No.";
                                            Gnljnline.Validate(Gnljnline."Account No.");
                                            Gnljnline."Document No." := 'LR-' + "No.";
                                            Gnljnline."Posting Date" := Today;
                                            Gnljnline.Description := 'Loan Recovery from deposits';
                                            if AvailableShares < LRepayment then
                                                Gnljnline.Amount := AvailableShares * -1
                                            else
                                                Gnljnline.Amount := LRepayment * -1;

                                            Gnljnline.Validate(Gnljnline.Amount);
                                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                                            Gnljnline."Loan No" := Loans."Loan  No.";
                                            if Gnljnline.Amount <> 0 then
                                                Gnljnline.Insert;

                                            AvailableShares := AvailableShares - (Gnljnline.Amount * -1);
                                            TotalDefaulterR := TotalDefaulterR + (Gnljnline.Amount * -1);
                                            TotalRecovered := TotalRecovered + (Gnljnline.Amount * -1);

                                        end;

                                        Loans."Recovered Balance" := Loans."Outstanding Balance";
                                        Loans.Modify;

                                    end;
                                end;
                            until Loans.Next = 0;
                        end;

                        //Recover Defaulter Loan first



                        //Recover Interest without loan First
                        Loans.Reset;
                        Loans.SetRange(Loans."BOSA No", "No.");
                        if Loans.Find('-') then begin
                            repeat
                                Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                                //Recover Interest
                                if (Loans."Outstanding Balance" <= 0) and (Loans."Oustanding Interest" > 0) and (AvailableShares > 0) then begin
                                    Interest := 0;
                                    Interest := Loans."Oustanding Interest";

                                    if Interest > 0 then begin

                                        LineN := LineN + 10000;
                                        Gnljnline.Init;
                                        Gnljnline."Journal Template Name" := 'GENERAL';
                                        Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                                        Gnljnline."Line No." := LineN;
                                        Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                        Gnljnline."Account No." := "No.";
                                        Gnljnline.Validate(Gnljnline."Account No.");
                                        Gnljnline."Document No." := 'LR-' + "No.";
                                        Gnljnline."Posting Date" := Today;
                                        Gnljnline.Description := 'Interest Recovery from deposits';
                                        if AvailableShares < Interest then
                                            Gnljnline.Amount := -1 * AvailableShares
                                        else
                                            Gnljnline.Amount := -1 * Interest;

                                        Gnljnline.Validate(Gnljnline.Amount);
                                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Insurance Contribution";
                                        Gnljnline."Loan No" := Loans."Loan  No.";
                                        if Gnljnline.Amount <> 0 then
                                            Gnljnline.Insert;

                                        AvailableShares := AvailableShares - (Gnljnline.Amount * -1);
                                        TotalDefaulterR := TotalDefaulterR + (Gnljnline.Amount * -1);
                                        TotalRecovered := TotalRecovered + (Gnljnline.Amount * -1);
                                    end;
                                end;

                            until Loans.Next = 0;
                        end;

                        //Recover Interest without loan First



                        TotalOustanding := TotalOustanding - TotalRecovered;


                        Loans.Reset;
                        Loans.SetRange(Loans."Client Code", "No.");
                        Loans.SetRange(Loans.Source, Loans.Source::" ");
                        if Loans.Find('-') then begin
                            repeat
                                if Loans."Loan Product Type" <> 'DFTL' then begin

                                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");

                                    if (Loans."Outstanding Balance" > 0) and ((TotalAvailable - TotalDefaulterR) > 0) then begin

                                        AvailableShares := ROUND(((Loans."Outstanding Balance" + Loans."Oustanding Interest") / TotalOustanding)
                                                         * (TotalAvailable - TotalDefaulterR), 0.01);

                                        //Recover Interest
                                        if Loans."Oustanding Interest" > 0 then begin
                                            Interest := 0;
                                            Interest := Loans."Oustanding Interest";

                                            if Interest > 0 then begin

                                                LineN := LineN + 10000;
                                                Gnljnline.Init;
                                                Gnljnline."Journal Template Name" := 'GENERAL';
                                                Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                                                Gnljnline."Line No." := LineN;
                                                Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                                Gnljnline."Account No." := "No.";
                                                Gnljnline.Validate(Gnljnline."Account No.");
                                                Gnljnline."Document No." := 'LR-' + "No.";
                                                Gnljnline."Posting Date" := Today;
                                                Gnljnline.Description := 'Interest Recovery from deposits';
                                                if AvailableShares < Interest then
                                                    Gnljnline.Amount := -1 * AvailableShares
                                                else
                                                    Gnljnline.Amount := -1 * Interest;

                                                Gnljnline.Validate(Gnljnline.Amount);
                                                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Insurance Contribution";
                                                Gnljnline."Loan No" := Loans."Loan  No.";
                                                if Gnljnline.Amount <> 0 then
                                                    Gnljnline.Insert;

                                                AvailableShares := AvailableShares - (Gnljnline.Amount * -1);
                                                TotalRecovered := TotalRecovered + (Gnljnline.Amount * -1);
                                            end;
                                        end;




                                        //Recover Repayment
                                        if Loans."Outstanding Balance" > 0 then begin
                                            LRepayment := 0;
                                            LRepayment := Loans."Outstanding Balance";

                                            if LRepayment > 0 then begin


                                                LineN := LineN + 10000;

                                                Gnljnline.Init;
                                                Gnljnline."Journal Template Name" := 'GENERAL';
                                                Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                                                Gnljnline."Line No." := LineN;
                                                Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                                Gnljnline."Account No." := "No.";
                                                Gnljnline.Validate(Gnljnline."Account No.");
                                                Gnljnline."Document No." := 'LR-' + "No.";
                                                Gnljnline."Posting Date" := Today;
                                                Gnljnline.Description := 'Loan Recovery from deposits';
                                                if AvailableShares < LRepayment then
                                                    Gnljnline.Amount := AvailableShares * -1
                                                else
                                                    Gnljnline.Amount := LRepayment * -1;

                                                Gnljnline.Validate(Gnljnline.Amount);
                                                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                                                Gnljnline."Loan No" := Loans."Loan  No.";
                                                if Gnljnline.Amount <> 0 then
                                                    Gnljnline.Insert;

                                                AvailableShares := AvailableShares - (Gnljnline.Amount * -1);
                                                TotalRecovered := TotalRecovered + (Gnljnline.Amount * -1);

                                            end;

                                            Loans."Recovered Balance" := Loans."Outstanding Balance";
                                            Loans.Modify;

                                        end;
                                    end;
                                end;
                            until Loans.Next = 0;
                        end;

                        //Recover FOSA Loans
                        Loans.Reset;
                        Loans.SetRange(Loans."Client Code", "Micro Group Code");
                        Loans.SetRange(Loans.Source, Loans.Source::BOSA);
                        if Loans.Find('-') then begin
                            repeat
                                Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");

                                if (Loans."Outstanding Balance" > 0) and ((TotalAvailable - TotalDefaulterR) > 0) then begin
                                    AvailableShares := ROUND((Loans."Outstanding Balance" + Loans."Oustanding Interest") / (TotalOustanding)
                                                     * (TotalAvailable - TotalDefaulterR), 0.01);


                                    //Recover Interest
                                    if Loans."Oustanding Interest" > 0 then begin
                                        Interest := 0;
                                        Interest := Loans."Oustanding Interest";

                                        if Interest > 0 then begin

                                            LineN := LineN + 10000;

                                            Gnljnline.Init;
                                            Gnljnline."Journal Template Name" := 'GENERAL';
                                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                                            Gnljnline."Line No." := LineN;
                                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                            Gnljnline."Account No." := Loans."Client Code";
                                            Gnljnline.Validate(Gnljnline."Account No.");
                                            Gnljnline."Document No." := 'LR-' + "No.";
                                            Gnljnline."Posting Date" := Today;
                                            Gnljnline.Description := 'Interest Recovery from deposits';
                                            if AvailableShares < Interest then
                                                Gnljnline.Amount := -1 * AvailableShares
                                            else
                                                Gnljnline.Amount := -1 * Interest;

                                            Gnljnline.Validate(Gnljnline.Amount);
                                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Insurance Contribution";
                                            Gnljnline."Loan No" := Loans."Loan  No.";
                                            if Gnljnline.Amount <> 0 then
                                                Gnljnline.Insert;

                                            AvailableShares := AvailableShares - (Gnljnline.Amount * -1);
                                            TotalRecovered := TotalRecovered + (Gnljnline.Amount * -1);
                                        end;
                                    end;




                                    //Recover Repayment
                                    if Loans."Outstanding Balance" > 0 then begin
                                        LRepayment := 0;
                                        LRepayment := Loans."Outstanding Balance";

                                        if LRepayment > 0 then begin


                                            LineN := LineN + 10000;

                                            Gnljnline.Init;
                                            Gnljnline."Journal Template Name" := 'GENERAL';
                                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                                            Gnljnline."Line No." := LineN;
                                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                            Gnljnline."Account No." := Loans."Client Code";
                                            Gnljnline.Validate(Gnljnline."Account No.");
                                            Gnljnline."Document No." := 'LR-' + "No.";
                                            Gnljnline."Posting Date" := Today;
                                            Gnljnline.Description := 'Loan Recovery from deposits';
                                            if AvailableShares < LRepayment then
                                                Gnljnline.Amount := AvailableShares * -1
                                            else
                                                Gnljnline.Amount := LRepayment * -1;

                                            Gnljnline.Validate(Gnljnline.Amount);
                                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                                            Gnljnline."Loan No" := Loans."Loan  No.";
                                            if Gnljnline.Amount <> 0 then
                                                Gnljnline.Insert;

                                            AvailableShares := AvailableShares - (Gnljnline.Amount * -1);
                                            TotalRecovered := TotalRecovered + (Gnljnline.Amount * -1);

                                        end;

                                        Loans."Recovered Balance" := Loans."Outstanding Balance";
                                        Loans.Modify;

                                    end;
                                end;

                            until Loans.Next = 0;
                        end;


                        //Reduce Shares
                        LineN := LineN + 10000;

                        Gnljnline.Init;
                        Gnljnline."Journal Template Name" := 'GENERAL';
                        Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                        Gnljnline."Line No." := LineN;
                        Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                        Gnljnline."Account No." := "No.";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No." := 'LR-' + "No.";
                        Gnljnline."Posting Date" := Today;
                        Gnljnline.Description := 'Deposit Refundable';
                        if Status = Status::Deceased then
                            Gnljnline.Amount := TotalRecovered + GeneralSetup."Withdrawal Fee"
                        else
                            Gnljnline.Amount := TotalRecovered + "Insurance Fund" + GeneralSetup."Withdrawal Fee";
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::Loan;
                        if Gnljnline.Amount <> 0 then
                            Gnljnline.Insert;


                        //Reduce Insurance Contribution
                        if Status <> Status::Deceased then begin
                            LineN := LineN + 10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No." := "No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := 'LR-' + "No.";
                            Gnljnline."Posting Date" := Today;
                            Gnljnline.Description := 'Insurance Refundable';
                            Gnljnline.Amount := "Insurance Fund" * -1;
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"44";
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;
                        end;



                        //Insurance Retension
                        if Status = Status::Deceased then begin
                            GeneralSetup.TestField(GeneralSetup."Insurance Retension Account");

                            LineN := LineN + 10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No." := "No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := 'LR-' + "No.";
                            Gnljnline."Posting Date" := Today;
                            Gnljnline.Description := 'Insurance Retension';
                            Gnljnline.Amount := "Insurance Fund" * -1;
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"44";
                            Gnljnline."Bal. Account Type" := Gnljnline."bal. account type"::"G/L Account";
                            Gnljnline."Bal. Account No." := GeneralSetup."Insurance Retension Account";
                            Gnljnline.Validate(Gnljnline."Bal. Account No.");
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;
                        end;

                        //Shares Capital Retension
                        GeneralSetup.TestField(GeneralSetup."Shares Retension Account");

                        LineN := LineN + 10000;

                        Gnljnline.Init;
                        Gnljnline."Journal Template Name" := 'GENERAL';
                        Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                        Gnljnline."Line No." := LineN;
                        Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                        Gnljnline."Account No." := "No.";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No." := 'LR-' + "No.";
                        Gnljnline."Posting Date" := Today;
                        Gnljnline.Description := 'Shares Capital Retension';
                        Gnljnline.Amount := GeneralSetup."Retained Shares";
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Recovery Account";
                        Gnljnline."Bal. Account Type" := Gnljnline."bal. account type"::"G/L Account";
                        Gnljnline."Bal. Account No." := GeneralSetup."Shares Retension Account";
                        Gnljnline.Validate(Gnljnline."Bal. Account No.");
                        if Gnljnline.Amount <> 0 then
                            Gnljnline.Insert;


                        //Withdrawal Fee
                        if GeneralSetup."Withdrawal Fee" > 0 then begin

                            LineN := LineN + 10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No." := "No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := 'LR-' + "No.";
                            Gnljnline."Posting Date" := Today;
                            Gnljnline.Description := 'Withdrawal Fee';
                            Gnljnline.Amount := -GeneralSetup."Withdrawal Fee";
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                            Gnljnline.Validate(Gnljnline."Bal. Account No.");
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;

                        end;

                        //Transfer to MC Account
                        if ((TotalRecovered + 1000) + ("Current Shares" + "Insurance Fund")) < 0 then begin
                            LineN := LineN + 10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No." := "No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := 'LR-' + "No.";
                            Gnljnline."Posting Date" := Today;
                            Gnljnline.Description := 'Refundable Deposits to MC';
                            if Status = Status::Deceased then
                                Gnljnline.Amount := ((TotalRecovered + GeneralSetup."Withdrawal Fee") + ("Current Shares")) * -1
                            else
                                Gnljnline.Amount := ((TotalRecovered + "Insurance Fund" + GeneralSetup."Withdrawal Fee") + ("Current Shares")) * -1;
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::Loan;
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;

                            LineN := LineN + 10000;

                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Vendor;
                            Gnljnline."Account No." := 'MC-' + "Personal No";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := 'LR-' + "No.";
                            Gnljnline."Posting Date" := Today;
                            Gnljnline.Description := 'Refundable Deposits to MC';
                            if Status = Status::Deceased then
                                Gnljnline.Amount := ((TotalRecovered + GeneralSetup."Withdrawal Fee") + ("Current Shares"))
                            else
                                Gnljnline.Amount := ((TotalRecovered + "Insurance Fund" + GeneralSetup."Withdrawal Fee") + ("Current Shares"));
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::Loan;
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;

                            //Funeral Expenses
                            if Status = Status::Deceased then begin
                                GeneralSetup.TestField("Funeral Expenses Account");

                                LineN := LineN + 10000;

                                Gnljnline.Init;
                                Gnljnline."Journal Template Name" := 'GENERAL';
                                Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                                Gnljnline."Line No." := LineN;
                                Gnljnline."Account Type" := Gnljnline."bal. account type"::Vendor;
                                Gnljnline."Account No." := 'MC-' + "Personal No";
                                Gnljnline.Validate(Gnljnline."Account No.");
                                Gnljnline."Document No." := 'LR-' + "No.";
                                Gnljnline."External Document No." := "Personal No";
                                Gnljnline."Posting Date" := Today;
                                Gnljnline.Description := 'Funeral Expenses';
                                // Gnljnline.Amount:=-GeneralSetup."Funeral Expenses Amount";
                                Gnljnline.Validate(Gnljnline.Amount);
                                Gnljnline."Bal. Account Type" := Gnljnline."bal. account type"::"G/L Account";
                                Gnljnline."Bal. Account No." := GeneralSetup."Funeral Expenses Account";
                                if Gnljnline.Amount <> 0 then
                                    Gnljnline.Insert;

                            end;

                        end;


                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'ACC CLOSED');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                        end;




                        Message('Closure posted successfully.');
                    end;
                }
                separator(Action1000000005)
                {
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        FosaName := '';

        if "Micro Group Code" <> '' then begin
            if Vend.Get("Micro Group Code") then begin
                FosaName := Vend.Name;
            end;
        end;

        lblIDVisible := true;
        lblDOBVisible := true;
        lblRegNoVisible := false;
        lblRegDateVisible := false;
        lblGenderVisible := true;
        txtGenderVisible := true;
        lblMaritalVisible := true;
        txtMaritalVisible := true;

        if "Account Category" <> "account category"::Single then begin
            lblIDVisible := false;
            lblDOBVisible := false;
            lblRegNoVisible := true;
            lblRegDateVisible := true;
            lblGenderVisible := false;
            txtGenderVisible := false;
            lblMaritalVisible := false;
            txtMaritalVisible := false;

        end;
        OnAfterGetCurrRecord;
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
        txtMaritalVisible := true;
        lblMaritalVisible := true;
        txtGenderVisible := true;
        lblGenderVisible := true;
        lblRegDateVisible := true;
        lblRegNoVisible := true;
        lblDOBVisible := true;
        lblIDVisible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Customer Type" := "customer type"::Member;
        Status := Status::Active;
        "Customer Posting Group" := 'BOSA';
        "Registration Date" := Today;
        Advice := true;
        "Advice Type" := "advice type"::"New Member";
        if GeneralSetup.Get(0) then begin
            //"Insurance Contribution":=GeneralSetup."Welfare Contribution";
            "Registration Fee" := GeneralSetup."Registration Fee";

        end;
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin
        ActivateFields;
        /*
        IF NOT MapMgt.TestSetup THEN
          CurrForm.MapPoint.VISIBLE(FALSE);
        */

    end;

    var
        CustomizedCalEntry: Record "Customized Calendar Entry";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        CustomizedCalendar: Record "Customized Calendar Change";
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        PictureExists: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Vend: Record Vendor;
        Cust: Record Customer;
        LineNo: Integer;
        UsersID: Record User;
        GeneralSetup: Record "Sacco General Set-Up";
        Loans: Record "Loans Register";
        AvailableShares: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        TotalRecovered: Decimal;
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        LoansR: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        Accounts: Record Vendor;
        FosaName: Text[50];
        [InDataSet]
        lblIDVisible: Boolean;
        [InDataSet]
        lblDOBVisible: Boolean;
        [InDataSet]
        lblRegNoVisible: Boolean;
        [InDataSet]
        lblRegDateVisible: Boolean;
        [InDataSet]
        lblGenderVisible: Boolean;
        [InDataSet]
        txtGenderVisible: Boolean;
        [InDataSet]
        lblMaritalVisible: Boolean;
        [InDataSet]
        txtMaritalVisible: Boolean;
        AccNo: Code[20];
        Vendor: Record Vendor;
        TotalAvailable: Decimal;
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        TotalDefaulterR: Decimal;
        value2: Decimal;
        Value1: Decimal;
        RoundingDiff: Decimal;
        OldValueOfficer: Code[10];


    procedure ActivateFields()
    begin
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ActivateFields;
    end;
}

