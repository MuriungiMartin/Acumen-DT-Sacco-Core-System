#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516639 "Data Sheet Header"
{
    PageType = Card;
    SourceTable = "Data Sheet Header";

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
            part(Control13; "Data Sheet Lines")
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
            action("Loan Lines")
            {
                ApplicationArea = Basic;
                Caption = 'Loan Lines(F10)';
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
        }
    }

    var
        ObjDataSheet: Record "Data Sheet Lines";
        ObjMembers: Record "Member Register";
        SFactory: Codeunit "SURESTEP Factory.";
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;
        GenJournalLine: Record "Gen. Journal Line";

    local procedure FnClearLines()
    begin
    end;

    local procedure FnLoadMembers()
    begin
        TotalCount := 0;
        ObjMembers.Reset;
        ObjMembers.SetRange("Employer Code", "Employer Code");
        ObjMembers.SetFilter("Date Filter", '..' + Format("Cut Off Date"));
        ObjMembers.SetFilter(Status, '%1', ObjMembers.Status::Active);
        if ObjMembers.Find('-') then begin
            Window.Open('@1@');
            TotalCount := ObjMembers.Count;
            repeat
                FnUpdateProgressBar();
                ObjMembers.CalcFields("Outstanding Balance", "Outstanding Interest", "Current Shares");
                ObjDataSheet.Reset;
                ObjDataSheet.SetRange("Payroll No", ObjMembers."Personal No");
                if not ObjDataSheet.Find('-') then begin
                    if ObjMembers."Monthly Contribution" > 0 then begin
                        ObjDataSheet.Init;
                        ObjDataSheet."Data Sheet Header" := Code;
                        ObjDataSheet."Payroll No" := ObjMembers."Personal No";
                        ObjDataSheet."Member No" := ObjMembers."No.";
                        ObjDataSheet.Name := ObjMembers.Name;
                        if ObjMembers."Outstanding Balance" > 1 then
                            ObjDataSheet."Outstanding Balance" := ObjMembers."Outstanding Balance";
                        if ObjMembers."Outstanding Interest" > 0 then
                            ObjDataSheet."Outstanding Interest" := ObjMembers."Outstanding Interest";
                        ObjDataSheet."Deposit Contribution" := ObjMembers."Monthly Contribution";
                        ObjDataSheet."FOSA Contribution" := ObjMembers."FOSA Contribution";
                        ObjDataSheet."Expected Principal Balance" := FnCalculateTotalExpectedBalance(ObjMembers."No.");
                        ObjDataSheet."Principal Amount" := FnCalculateTotalRepayments(ObjMembers."No.");
                        ObjDataSheet."Benevolent Contribution" := 200;
                        ObjDataSheet."Capital Reserve" := 100;
                        ObjDataSheet.Amount := ROUND((ObjDataSheet."Principal Amount" + ObjDataSheet."Outstanding Interest" + ObjDataSheet."Deposit Contribution" + ObjDataSheet."FOSA Contribution" + 300), 1, '=');
                        ObjDataSheet.Employer := ObjMembers."Employer Code";
                        ObjDataSheet.Insert;
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

