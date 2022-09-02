#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516651 "Data Sheet Header-Dist"
{
    PageType = Card;
    SourceTable = "Data Sheet Header-Dist";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cut Off Date"; "Cut Off Date")
                {
                    ApplicationArea = Basic;
                }
                field("Period Code"; "Period Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Schedule Amount P"; "Total Schedule Amount P")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Schedule Principal';
                    Editable = false;
                    Visible = false;
                }
                field("Total Schedule Amount I"; "Total Schedule Amount I")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Scheduled Interest';
                    Editable = false;
                    Visible = false;
                }
                field("Total Schedule Amount D"; "Total Schedule Amount D")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Schedule Deposits';
                    Editable = false;
                    Visible = false;
                }
                field("Total Chumbefu"; "Total Chumbefu")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Total Capital Reserve"; "Total Capital Reserve")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("FOSA Contribution"; "FOSA Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Total Members"; "Total Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Total Schedule Amount"; "Total Schedule Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                    Visible = false;
                }
            }
            group(Control14)
            {
            }
            part(Control13; "Data Sheet Lines-Dist")
            {
                SubPageLink = "Data Sheet Header" = field(Code);
            }
            part(Control22; "Accrued Interest Lines")
            {
                SubPageLink = "Employer Code" = field("Employer Code");
            }
        }
        area(factboxes)
        {
            part(Control25; "Data Sheet FactBox")
            {
                SubPageLink = Code = field(Code);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Clear Lines")
            {
                ApplicationArea = Basic;
                Image = ClearLog;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
            }
            action("Accrue Interest")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Process Loan Monthly Interest";
            }
            action("Post Interest")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'General');
                    GenJournalLine.SetRange("Journal Batch Name", 'INT DUE');
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        Message('Interest batch Posted Successfully!');
                    end;
                end;
            }
            action("Load Lines")
            {
                ApplicationArea = Basic;
                Caption = 'Load Lines(F10)';
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'F10';

                trigger OnAction()
                begin
                    TestField("Employer Code");
                    ObjDataSheet.Reset;
                    ObjDataSheet.SetRange("Data Sheet Header", Code);
                    if ObjDataSheet.Find('-') then
                        ObjDataSheet.DeleteAll;
                    FnLoadMembers();
                end;
            }
            action("Export Data")
            {
                ApplicationArea = Basic;
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = XMLport "Export Data Sheet";
            }
            action("Export Advice")
            {
                ApplicationArea = Basic;
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjDataSheet.Reset;
                    ObjDataSheet.SetRange(ObjDataSheet."Data Sheet Header", Rec.Code);
                    if ObjDataSheet.Find('-') then begin
                        Report.Run(51516620, true, false, ObjDataSheet);
                    end;
                end;
            }
        }
    }

    var
        ObjDataSheet: Record "Data Sheet Lines-Dist";
        ObjMembers: Record "Member Register";
        SFactory: Codeunit "SURESTEP Factory.";
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        gensetup: Record "Sacco General Set-Up";
        ObjLoans: Record "Loans Register";
        loantype: Record "Loan Products Setup";

    local procedure FnClearLines()
    begin
    end;

    local procedure FnLoadMembers()
    begin
        TotalCount := 0;
        ObjMembers.Reset;
        //ObjMembers.SETRANGE(ObjMembers."No.",'00759');
        ObjMembers.SetRange("Employer Code", "Employer Code");
        ObjMembers.SetFilter("Date Filter", '..' + Format("Cut Off Date"));
        ObjMembers.SetFilter(Status, '%1', ObjMembers.Status::Active);
        if ObjMembers.Find('-') then begin
            Window.Open('@1@');
            TotalCount := ObjMembers.Count;
            repeat
                if ObjMembers."Personal No" <> '' then begin
                    FnUpdateProgressBar();
                    //fosa shares

                    ObjMembers.CalcFields(ObjMembers."Current Shares");
                    if ObjMembers."FOSA Contribution" > 0 then begin
                        ObjDataSheet.Init;
                        ObjDataSheet."Transaction Date" := "Cut Off Date";
                        ObjDataSheet."Data Sheet Header" := Code;
                        ObjDataSheet."Payroll No" := ObjMembers."Personal No";
                        ObjDataSheet."Member No" := ObjMembers."No.";
                        ObjDataSheet.Name := ObjMembers.Name;
                        ObjDataSheet.Amount := ObjMembers."FOSA Contribution";
                        ObjDataSheet.Employer := ObjMembers."Employer Code";
                        ObjDataSheet."Transaction Type" := ObjDataSheet."transaction type"::"FOSA Account";
                        ObjDataSheet."Special Code" := '110';
                        ObjDataSheet."Entry No" := ObjDataSheet."Entry No" + 200;
                        ObjDataSheet."Deduction type" := ObjDataSheet."deduction type"::Deduction;
                        ObjDataSheet.Insert;
                    end;
                    //deposit contribution
                    if ObjMembers."Monthly Contribution" > 0 then begin
                        ObjDataSheet.Init;
                        ObjDataSheet."Data Sheet Header" := Code;
                        ObjDataSheet."Payroll No" := ObjMembers."Personal No";
                        ObjDataSheet."Member No" := ObjMembers."No.";
                        ObjDataSheet.Name := ObjMembers.Name;
                        ObjDataSheet.Amount := ObjMembers."Monthly Contribution";
                        ObjDataSheet.Employer := ObjMembers."Employer Code";
                        ObjDataSheet."Transaction Type" := ObjDataSheet."transaction type"::"Deposit Contribution";
                        ObjDataSheet."Special Code" := '165';
                        ObjDataSheet."Entry No" := ObjDataSheet."Entry No" + 200;
                        ObjDataSheet."Deduction type" := ObjDataSheet."deduction type"::Deduction;
                        ObjDataSheet.Insert;
                    end;

                    //deposit contribution balance
                    if ObjMembers."Monthly Contribution" > 0 then begin
                        ObjDataSheet.Init;
                        ObjDataSheet."Data Sheet Header" := Code;
                        ObjDataSheet."Payroll No" := ObjMembers."Personal No";
                        ObjDataSheet."Member No" := ObjMembers."No.";
                        ObjDataSheet.Name := ObjMembers.Name;
                        ObjDataSheet.Amount := ObjMembers."Current Shares";
                        ObjDataSheet.Employer := ObjMembers."Employer Code";
                        ObjDataSheet."Transaction Type" := ObjDataSheet."transaction type"::"Deposit Contribution";
                        ObjDataSheet."Special Code" := '625';
                        ObjDataSheet."Entry No" := ObjDataSheet."Entry No" + 200;
                        ObjDataSheet."Deduction type" := ObjDataSheet."deduction type"::Balance;
                        ObjDataSheet.Insert;
                    end;

                    //benevolent fund
                    ObjDataSheet.Init;
                    ObjDataSheet."Data Sheet Header" := Code;
                    ObjDataSheet."Payroll No" := ObjMembers."Personal No";
                    ObjDataSheet."Member No" := ObjMembers."No.";
                    ObjDataSheet.Name := ObjMembers.Name;
                    ObjDataSheet.Amount := 200;
                    ObjDataSheet.Employer := ObjMembers."Employer Code";
                    ObjDataSheet."Transaction Type" := ObjDataSheet."transaction type"::"Benevolent Fund";
                    ObjDataSheet."Special Code" := '140';
                    ObjDataSheet."Entry No" := ObjDataSheet."Entry No" + 200;
                    ObjDataSheet."Deduction type" := ObjDataSheet."deduction type"::Deduction;
                    ObjDataSheet.Insert;

                    //Capital Reserve
                    ObjDataSheet.Init;
                    ObjDataSheet."Data Sheet Header" := Code;
                    ObjDataSheet."Payroll No" := ObjMembers."Personal No";
                    ObjDataSheet."Member No" := ObjMembers."No.";
                    ObjDataSheet.Name := ObjMembers.Name;
                    ObjDataSheet.Amount := 100;
                    ObjDataSheet.Employer := ObjMembers."Employer Code";
                    ObjDataSheet."Transaction Type" := ObjDataSheet."transaction type"::"Capital Reserve";
                    ObjDataSheet."Special Code" := '337';
                    ObjDataSheet."Entry No" := ObjDataSheet."Entry No" + 200;
                    ObjDataSheet."Deduction type" := ObjDataSheet."deduction type"::Deduction;
                    ObjDataSheet.Insert;

                    //sharecapital
                    ObjMembers.CalcFields(ObjMembers."Shares Retained");
                    gensetup.Get();
                    if ObjMembers."Shares Retained" < 41500 then begin
                        if (41500 - ObjMembers."Shares Retained") > 500 then
                            ObjDataSheet.Init;
                        ObjDataSheet."Data Sheet Header" := Code;
                        ObjDataSheet."Payroll No" := ObjMembers."Personal No";
                        ObjDataSheet."Member No" := ObjMembers."No.";
                        ObjDataSheet.Name := ObjMembers.Name;
                        ObjDataSheet.Amount := 500;
                        ObjDataSheet.Employer := ObjMembers."Employer Code";
                        ObjDataSheet."Transaction Type" := ObjDataSheet."transaction type"::"Share Capital";
                        ObjDataSheet."Special Code" := '229';
                        ObjDataSheet."Entry No" := ObjDataSheet."Entry No" + 200;
                        ObjDataSheet."Deduction type" := ObjDataSheet."deduction type"::Deduction;
                        ObjDataSheet.Insert;

                    end;

                    ObjMembers.CalcFields(ObjMembers."Shares Retained");
                    gensetup.Get();

                    ObjDataSheet.Init;
                    ObjDataSheet."Data Sheet Header" := Code;
                    ObjDataSheet."Payroll No" := ObjMembers."Personal No";
                    ObjDataSheet."Member No" := ObjMembers."No.";
                    ObjDataSheet.Name := ObjMembers.Name;
                    ObjDataSheet.Amount := ObjMembers."Shares Retained";
                    ObjDataSheet.Employer := ObjMembers."Employer Code";
                    ObjDataSheet."Transaction Type" := ObjDataSheet."transaction type"::"Share Capital";
                    ObjDataSheet."Special Code" := '629';
                    ObjDataSheet."Entry No" := ObjDataSheet."Entry No" + 200;
                    ObjDataSheet."Deduction type" := ObjDataSheet."deduction type"::Balance;
                    ObjDataSheet.Insert;



                    //loans
                    ObjLoans.Reset;
                    ObjLoans.SetRange(ObjLoans."Client Code", ObjMembers."No.");
                    ObjLoans.SetRange(ObjLoans.Posted, true);
                    ObjLoans.SetFilter(ObjLoans."Date filter", '..' + Format("Cut Off Date"));
                    ObjLoans.SetFilter(ObjLoans."Repayment Start Date", '..%1', CalcDate('CM', "Cut Off Date"));
                    if ObjLoans.FindSet(true) then begin
                        repeat
                            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Oustanding Interest");

                            //principle
                            if (ObjLoans."Outstanding Balance" > 0) then begin
                                if (ObjLoans."Outstanding Balance" > ROUND((ObjLoans."Approved Amount" / ObjLoans.Installments), 0.05, '=')) then
                                    ObjDataSheet.Amount := ROUND((ObjLoans."Approved Amount" / ObjLoans.Installments), 0.05, '=')
                                else
                                    ObjDataSheet.Amount := ObjLoans."Outstanding Balance";
                                ObjDataSheet.Init;
                                ObjDataSheet."Data Sheet Header" := Code;
                                ObjDataSheet."Payroll No" := ObjMembers."Personal No";
                                ObjDataSheet."Member No" := ObjMembers."No.";
                                ObjDataSheet.Name := ObjMembers.Name;
                                ObjDataSheet."Outstanding Balance" := ObjLoans."Outstanding Balance";
                                ObjDataSheet."Expected Principal Balance" := FnCalculateTotalExpectedBalance(ObjMembers."No.");
                                //ObjDataSheet."Principal Amount":=FnCalculateTotalRepayments(ObjMembers."No.");
                                ObjDataSheet."Principal Amount" := ROUND((ObjLoans."Approved Amount" / ObjLoans.Installments), 0.05, '=');
                                ObjDataSheet.Amount := ObjDataSheet."Principal Amount";
                                ObjDataSheet.Employer := ObjMembers."Employer Code";
                                ObjDataSheet."Transaction Type" := ObjDataSheet."transaction type"::"Loan Repayment";
                                ObjDataSheet."Loan Product Type" := ObjLoans."Loan Product Type";
                                ObjDataSheet."Entry No" := ObjDataSheet."Entry No" + 1;
                                ObjDataSheet.Installments := ObjLoans.Installments;
                                ObjDataSheet."Deduction type" := ObjDataSheet."deduction type"::Deduction;
                                loantype.Reset;
                                loantype.SetRange(loantype.Code, ObjLoans."Loan Product Type");
                                if loantype.Find('-') then
                                    ObjDataSheet."Special Code" := loantype."Special Code Principle";
                                ObjDataSheet.Insert;

                                ObjDataSheet.Init;
                                ObjDataSheet."Data Sheet Header" := Code;
                                ObjDataSheet."Payroll No" := ObjMembers."Personal No";
                                ObjDataSheet."Member No" := ObjMembers."No.";
                                ObjDataSheet.Name := ObjMembers.Name;
                                ObjDataSheet."Outstanding Balance" := ObjLoans."Outstanding Balance";
                                ObjDataSheet."Expected Principal Balance" := FnCalculateTotalExpectedBalance(ObjMembers."No.");
                                //ObjDataSheet."Principal Amount":=FnCalculateTotalRepayments(ObjMembers."No.");
                                ObjDataSheet."Principal Amount" := ROUND((ObjLoans."Approved Amount" / ObjLoans.Installments), 0.05, '=');
                                ObjDataSheet.Amount := ObjDataSheet."Outstanding Balance";
                                ObjDataSheet.Employer := ObjMembers."Employer Code";
                                ObjDataSheet."Transaction Type" := ObjDataSheet."transaction type"::"Loan Repayment";
                                ObjDataSheet."Loan Product Type" := ObjLoans."Loan Product Type";
                                ObjDataSheet.Installments := ObjLoans.Installments;
                                ObjDataSheet."Deduction type" := ObjDataSheet."deduction type"::Balance;
                                loantype.Reset;
                                loantype.SetRange(loantype.Code, ObjLoans."Loan Product Type");
                                if loantype.Find('-') then
                                    ObjDataSheet."Special Code" := loantype."Special Code Balance";
                                ObjDataSheet."Entry No" := ObjDataSheet."Entry No" + 100;
                                ObjDataSheet.Insert;
                            end;

                            //interest
                            if (ObjLoans."Oustanding Interest" > 0) then begin
                                ObjDataSheet.Amount := ObjLoans."Oustanding Interest";
                                ObjDataSheet.Init;
                                ObjDataSheet."Data Sheet Header" := Code;
                                ObjDataSheet."Payroll No" := ObjMembers."Personal No";
                                ObjDataSheet."Member No" := ObjMembers."No.";
                                ObjDataSheet.Name := ObjMembers.Name;
                                ObjDataSheet."Outstanding Balance" := ObjLoans."Outstanding Balance";
                                ObjDataSheet."Expected Principal Balance" := FnCalculateTotalExpectedBalance(ObjMembers."No.");
                                //ObjDataSheet."Principal Amount":=FnCalculateTotalRepayments(ObjMembers."No.");
                                ObjDataSheet."Principal Amount" := ROUND((ObjLoans."Approved Amount" / ObjLoans.Installments), 0.05, '=');
                                ;
                                ObjDataSheet.Amount := ObjLoans."Oustanding Interest";
                                ObjDataSheet.Employer := ObjMembers."Employer Code";
                                ObjDataSheet."Transaction Type" := ObjDataSheet."transaction type"::"Interest Paid";
                                ObjDataSheet."Loan Product Type" := ObjLoans."Loan Product Type";
                                ObjDataSheet.Installments := ObjLoans.Installments;
                                ObjDataSheet."Entry No" := ObjDataSheet."Entry No" + 200;
                                ObjDataSheet."Deduction type" := ObjDataSheet."deduction type"::Balance;
                                loantype.Reset;
                                loantype.SetRange(loantype.Code, ObjLoans."Loan Product Type");
                                if loantype.Find('-') then
                                    ObjDataSheet."Special Code" := loantype."Special Code Interest";
                                //MESSAGE('Outstanding Int %1 special Code%2',ObjLoans."Oustanding Interest",loantype."Special Code Interest");
                                if (loantype."Special Code Interest" <> '') then
                                    ObjDataSheet.Insert;
                            end;
                        until ObjLoans.Next = 0;
                    end;
                end;
            until ObjMembers.Next = 0;
        end;
        Window.Close;
        Message('Checkoff Advice successfully Generated');
    end;

    local procedure FnCalculateTotalRepayments(MemberNo: Code[100]): Decimal
    var
        ObjLoansRegister: Record "Loans Register";
        TotalLoanRepaymentAmount: Decimal;
        AmountToAdd: Decimal;
        ExpectedBalanceAmount: Decimal;
    begin
        TotalLoanRepaymentAmount := 0;
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange("Client Code", MemberNo);
        ObjLoansRegister.SetRange("Recovery Mode", ObjLoansRegister."recovery mode"::Checkoff);
        ObjLoansRegister.SetFilter("Repayment Start Date", '<=%1', "Cut Off Date");
        ObjLoansRegister.SetFilter("Date filter", '..' + Format("Cut Off Date"));
        if ObjLoansRegister.Find('-') then begin
            repeat
                ObjLoansRegister.CalcFields("Outstanding Balance");
                if ObjLoansRegister."Outstanding Balance" > 0 then begin
                    ExpectedBalanceAmount := SFactory.FnGetScheduledExpectedBalance(ObjLoansRegister."Loan  No.", CalcDate('<CM>', "Cut Off Date"));
                    AmountToAdd := FnAmountToAdd(ObjLoansRegister."Outstanding Balance", ExpectedBalanceAmount, ObjLoansRegister."Loan Principle Repayment", ObjLoansRegister."Client Code");
                    TotalLoanRepaymentAmount := TotalLoanRepaymentAmount + AmountToAdd;
                end;
            until ObjLoansRegister.Next = 0;
        end;
        exit(TotalLoanRepaymentAmount);
    end;

    local procedure FnAmountToAdd(OutstandingAmount: Decimal; ExpectedBalAmount: Decimal; PrincipalRepAmount: Decimal; MNO: Code[100]): Decimal
    var
        AmountToReturn: Decimal;
    begin
        AmountToReturn := PrincipalRepAmount;
        if OutstandingAmount < AmountToReturn then
            AmountToReturn := OutstandingAmount;

        if ((OutstandingAmount > PrincipalRepAmount) and (OutstandingAmount > 0)) then begin
            AmountToReturn := PrincipalRepAmount;
            //IF ((ExpectedBalAmount < (OutstandingAmount-PrincipalRepAmount)) AND (ExpectedBalAmount >=0)) THEN
            //AmountToReturn:=OutstandingAmount-ExpectedBalAmount;

            //IF ExpectedBalAmount > (OutstandingAmount-PrincipalRepAmount) THEN
            // AmountToReturn:=OutstandingAmount-ExpectedBalAmount;
        end;
        exit(AmountToReturn);
    end;

    local procedure FnUpdateProgressBar()
    begin
        Percentage := (ROUND(Counter / TotalCount * 10000, 1));
        Counter := Counter + 1;
        Window.Update(1, Percentage);
    end;

    local procedure FnCalculateTotalExpectedBalance(MemberNo: Code[100]): Decimal
    var
        ObjLoansRegister: Record "Loans Register";
        TotalLoanRepaymentAmount: Decimal;
        AmountToAdd: Decimal;
        ExpectedBalanceAmount: Decimal;
    begin
        TotalLoanRepaymentAmount := 0;
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange("Client Code", MemberNo);
        ObjLoansRegister.SetFilter("Date filter", '..' + Format("Cut Off Date"));
        if ObjLoansRegister.Find('-') then begin
            repeat
                ObjLoansRegister.CalcFields("Outstanding Balance");
                if ObjLoansRegister."Outstanding Balance" > 0 then begin
                    ExpectedBalanceAmount := SFactory.FnGetScheduledExpectedBalance(ObjLoansRegister."Loan  No.", CalcDate('<CM>', "Cut Off Date"));
                    TotalLoanRepaymentAmount := TotalLoanRepaymentAmount + ExpectedBalanceAmount;
                end;
            until ObjLoansRegister.Next = 0;
        end;
        exit(TotalLoanRepaymentAmount);
    end;
}

