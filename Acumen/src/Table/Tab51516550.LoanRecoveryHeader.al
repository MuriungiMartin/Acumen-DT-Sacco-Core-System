#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516550 "Loan Recovery Header"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loan Recovery Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = "Member Register"."No." where(Status = const(Active));

            trigger OnValidate()
            begin
                Clear("Loan to Attach");
                Clear("Deposits Aportioned");
                Clear("Current Shares");
                Clear("Net Share Capital");
                Clear("Total Outstanding Loans");
                Clear("Loan Liabilities");
                Clear("Total Interest Due Recovered");
                Clear("Loan Distributed to Guarantors");
                Clear("Member Name");
                Clear("FOSA Account No");
                "Global Dimension 2 Code" := SFactory.FnGetUserBranch();
                if Cust.Get("Member No") then begin
                    Cust.CalcFields(Cust."Current Shares", "Shares Retained");
                    "Member Name" := Cust.Name;
                    //"FOSA Account No":=Cust."FOSA Account No.";
                    "Personal No" := Cust."Personal No";

                    "Current Shares" := Cust."Current Shares";

                    "Free Shares" := "Current Shares" - SFactory.FnGetMemberLiability(Cust."No.");
                    if "Free Shares" < 0 then "Free Shares" := 0;

                    LoanDetails.Reset;
                    LoanDetails.SetRange(LoanDetails."Guarantor Number", "Member No");
                    if LoanDetails.Find('-') then begin
                        LoanDetails."Guarantors Free Shares" := (LoanGuarantors."Deposits variance");

                        if "Loan Liabilities" > 0 then begin
                            "Recovery Difference" := "Free Shares" - "Loan Liabilities";
                            if "Loan Liabilities" < 1 then
                                "Recovery Difference" := 0;
                        end;
                    end;

                    //Clear Existing Lines
                    LoanDetails.Reset;
                    LoanDetails.SetRange(LoanDetails."Document No", "Document No");
                    if LoanDetails.FindSet(true) then begin
                        LoanDetails.DeleteAll;
                    end;
                    FnCalculateTotalOutstandingLoans();
                    FnCalculateTotalOutstandingInterest();

                end;

                //VALIDATE("Loan to Attach");
            end;
        }
        field(3; "Member Name"; Code[30])
        {
        }
        field(4; "Application Date"; Date)
        {
        }
        field(7; "Created By"; Code[20])
        {
        }
        field(8; "No. Series"; Code[20])
        {
        }
        field(9; "FOSA Account No"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(12; Posted; Boolean)
        {
        }
        field(13; "Posting Date"; Date)
        {
        }
        field(14; "Posted By"; Code[20])
        {
        }
        field(15; "Personal No"; Code[100])
        {
        }
        field(16; "Recovery Type"; Option)
        {
            OptionCaption = ',Recover From Loanee Deposits,Attach Defaulted Loans to Guarantors';
            OptionMembers = " ","Recover From Loanee Deposits","Attach Defaulted Loans to Guarantors";

            trigger OnValidate()
            var
                LoanDetails: Record "Loan Member Loans";
            begin
            end;
        }
        field(17; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(18; "Current Shares"; Decimal)
        {
        }
        field(19; "Loan Liabilities"; Decimal)
        {
        }
        field(20; "Loan to Attach"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"),
                                                                "Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            var
                TotalInterestDue: Decimal;
                TotalThirdParty: Decimal;
                RunBal: Decimal;
            begin
                TotalInterestDue := 0;
                TotalThirdParty := 0;
                "Total Interest Due Recovered" := 0;
                "Total Thirdparty Loans" := 0;
                TotalDepositsDeducted := 0;
                //RunBal:=ROUND("Free Shares",0.1,'=');
                LoanRec.Reset;
                LoanRec.SetRange(LoanRec."BOSA No", "Member No");
                LoanRec.SetRange(LoanRec."Loan  No.", "Loan to Attach");
                if LoanRec.Find('-') then begin
                    LoanRec.CalcFields(LoanRec."Outstanding Balance", LoanRec."Oustanding Interest");
                    if (LoanRec."Outstanding Balance" > 0) or (LoanRec."Oustanding Interest" > 0) then begin
                        "Loan Liabilities" := ROUND(LoanRec."Outstanding Balance");
                        TotalInterestDue := LoanRec."Oustanding Interest";
                        //"Total Interest Due Recovered":=TotalInterestDue;
                    end;

                end;
                //RunBal:=RunBal-TotalInterestDue;
                //RunBal:=FnCalculateTotalThirdpartyLoans(RunBal);
                //RunBal:=FnCalculateMobileLoan(RunBal);

                TotalDepositsDeducted := "Total Interest Due Recovered";//+"Total Thirdparty Loans"+"Mobile Loan";
                DepositsBalance := "Free Shares" - TotalDepositsDeducted;
                if DepositsBalance < 0 then
                    DepositsBalance := 0;
                FnCalculateLoanPrincipalAportionment("Loan Liabilities", DepositsBalance);
                "Loan Distributed to Guarantors" := "Loan Liabilities" - "Deposits Aportioned";
                LoanDetails.Reset;
                LoanDetails.SetRange("Loan No.", "Loan to Attach");
                LoanDetails.DeleteAll;
            end;
        }
        field(21; "Committed Shares"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("Member No")));
            FieldClass = FlowField;
        }
        field(22; "Free Shares"; Decimal)
        {
        }
        field(23; "Recovery Difference"; Decimal)
        {
        }
        field(24; "Interest Repayment"; Decimal)
        {
        }
        field(25; "Principal Repayment"; Decimal)
        {
        }
        field(26; "Loan No"; Code[40])
        {
            NotBlank = true;
            TableRelation = "Loans Guarantee Details"."Loan No";
        }
        field(27; "Amont Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Loan No" = field("Loan to Attach")));
            FieldClass = FlowField;
        }
        field(28; "Guarantor Number"; Code[50])
        {
        }
        field(29; "Repayment Start Date"; Date)
        {
        }
        field(30; "Loan Disbursement Date"; Date)
        {

            trigger OnValidate()
            begin
                "Issued Date" := "Loan Disbursement Date";
                GenSetUp.Get;
                currYear := Date2dmy(Today, 3);
                StartDate := 0D;
                EndDate := 0D;
                Month := Date2dmy("Loan Disbursement Date", 2);
                DAY := Date2dmy("Loan Disbursement Date", 1);
                StartDate := Dmy2date(1, Month, currYear);
                if Month = 12 then begin
                    Month := 0;
                    currYear := currYear + 1;
                end;
                EndDate := Dmy2date(1, Month + 1, currYear) - 1;
                if DAY <= 15 then begin
                    "Repayment Start Date" := CalcDate('CM', "Loan Disbursement Date");
                end else begin
                    "Repayment Start Date" := CalcDate('CM', CalcDate('CM+1M', "Loan Disbursement Date"));
                end;
                "Expected Date of Completion" := CalcDate(Format(Installments) + 'M', "Loan Disbursement Date");
            end;
        }
        field(31; "Loans Generated"; Boolean)
        {
        }
        field(32; "Issued Date"; Date)
        {
        }
        field(33; "Expected Date of Completion"; Date)
        {
        }
        field(34; "Total Interest Due Recovered"; Decimal)
        {
        }
        field(35; "Total Thirdparty Loans"; Decimal)
        {
        }
        field(36; "Deposits Aportioned"; Decimal)
        {
        }
        field(37; "Loan Distributed to Guarantors"; Decimal)
        {
        }
        field(38; "Mobile Loan"; Decimal)
        {
        }
        field(39; "Total Outstanding Loans"; Decimal)
        {
        }
        field(40; "Guarantor Allocation Type"; Option)
        {
            OptionCaption = ' ,Equally Liable,Proportionately Liable';
            OptionMembers = " ","Equally Liable","Proportionately Liable";
        }
        field(41; "Net Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Loan Recovery Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Loan Recovery Nos.", xRec."No. Series", 0D, "Document No", "No. Series");
        end;
        "Global Dimension 1 Code" := 'BOSA';
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record "Member Register";
        LoanDetails: Record "Loan Member Loans";
        LoanRec: Record "Loans Register";
        LoanGuarantors: Record "Loans Guarantee Details";
        GenSetUp: Record "Sacco General Set-Up";
        currYear: Integer;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        DAY: Integer;
        Installments: Integer;
        TotalDepositsDeducted: Decimal;
        DepositsBalance: Decimal;
        SFactory: Codeunit "SURESTEP Factory.";
        TotalShareCapital: Decimal;

    local procedure FnCalculateTotalInterestDue(Loans: Record "Loans Register") InterestDue: Decimal
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
    begin
        ObjRepaymentSchedule.Reset;
        ObjRepaymentSchedule.SetRange("Loan No.", Loans."Loan  No.");
        ObjRepaymentSchedule.SetFilter("Repayment Date", '<=%1', "Loan Disbursement Date");
        if ObjRepaymentSchedule.Find('-') then
            "Loan Age" := ObjRepaymentSchedule.Count;
        Loans.CalcFields("Outstanding Balance", "Interest Paid");

        InterestDue := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age")) / 2 - Abs(Loans."Interest Paid");
        if (Date2dmy("Loan Disbursement Date", 1) > 15) then begin
            InterestDue := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age" + 1)) / 2 - Abs(Loans."Interest Paid");
        end;
        if InterestDue <= 0 then
            exit(0);
        //MESSAGE('Approved=%1 Loan Age=%2 OBalance=%3 InterestPaid=%4 InterestDue=%5',Loans."Approved Amount","Loan Age",Loans."Outstanding Balance",Loans."Interest Paid",InterestDue);
        exit(InterestDue);
    end;

    local procedure FnCalculateTotalThirdpartyLoans(RunningBal: Decimal): Decimal
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
        ObjLoans: Record "Loans Register";
        RecAmount: Decimal;
    begin
        RecAmount := 0;
        if RunningBal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", "Member No");
            ObjLoans.SetRange("Loan Product Type", 'TRUSTEE');
            ObjLoans.SetRange(Posted, true);
            if ObjLoans.Find('-') then begin
                repeat
                    if RunningBal > 0 then begin
                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                        if ObjLoans."Outstanding Balance" > 0 then begin
                            RecAmount := ObjLoans."Outstanding Balance" + RecAmount;
                            RunningBal := RunningBal - ObjLoans."Outstanding Balance";
                        end;
                    end;
                until ObjLoans.Next = 0;
            end;
            "Total Thirdparty Loans" := RecAmount;
            exit(RunningBal);
        end;
    end;

    local procedure FnCalculateMobileLoan(RunningBal: Decimal): Decimal
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
        ObjLoans: Record "Loans Register";
        RecAmount: Decimal;
    begin
        RecAmount := 0;
        if RunningBal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange("BOSA No", "Member No");
            ObjLoans.SetRange(Posted, true);
            ObjLoans.SetRange("Loan Product Type", 'SUKUMA');
            if ObjLoans.Find('-') then begin
                repeat
                    if RunningBal > 0 then begin
                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                        if ObjLoans."Outstanding Balance" > 0 then begin
                            RecAmount := ObjLoans."Outstanding Balance" + RecAmount;
                            RunningBal := RunningBal - ObjLoans."Outstanding Balance";
                        end;
                    end;
                until ObjLoans.Next = 0;
            end;
            "Mobile Loan" := RecAmount;
            exit(RunningBal);
        end;
    end;

    local procedure FnCalculateLoanPrincipalAportionment(LoanAmount: Decimal; DepositsBalance: Decimal)
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
        ObjLoans: Record "Loans Register";
        RecAmount: Decimal;
    begin
        RecAmount := 0;
        ObjLoans.Reset;
        ObjLoans.SetRange("BOSA No", "Member No");
        ObjLoans.SetRange(Posted, true);
        if ObjLoans.Find('-') then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                if ObjLoans."Outstanding Balance" > 0 then begin
                    RecAmount := ObjLoans."Outstanding Balance" + RecAmount;
                end;
            until ObjLoans.Next = 0;
        end;
        "Deposits Aportioned" := ROUND((LoanAmount / RecAmount) * DepositsBalance, 0.1, '=');
    end;

    local procedure FnCalculateTotalOutstandingLoans()
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
        ObjLoans: Record "Loans Register";
        RecAmount: Decimal;
    begin
        RecAmount := 0;
        ObjLoans.Reset;
        ObjLoans.SetRange("BOSA No", "Member No");
        ObjLoans.SetRange(Posted, true);
        if ObjLoans.Find('-') then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                if ObjLoans."Outstanding Balance" > 0 then begin
                    RecAmount := ObjLoans."Outstanding Balance" + RecAmount;
                end;
            until ObjLoans.Next = 0;
        end;

        "Total Outstanding Loans" := RecAmount;
    end;

    local procedure FnCalculateTotalOutstandingInterest()
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
        ObjLoans: Record "Loans Register";
        RecAmount: Decimal;
    begin
        RecAmount := 0;
        ObjLoans.Reset;
        ObjLoans.SetRange("BOSA No", "Member No");
        ObjLoans.SetRange(Posted, true);
        if ObjLoans.Find('-') then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                if ObjLoans."Oustanding Interest" > 0 then begin
                    RecAmount := ObjLoans."Oustanding Interest" + RecAmount;
                end;
            until ObjLoans.Next = 0;
        end;
        "Total Interest Due Recovered" := RecAmount;
        Modify;
    end;
}

