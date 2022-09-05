#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516372 "Loans Guarantee Details"
{
    DrillDownPageID = "Loans Guarantee Details";
    LookupPageID = "Loans Guarantee Details";

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2; "Member No"; Code[20])
        {
            NotBlank = false;
            TableRelation = Customer."No." where(Status = filter(Active | "Re-instated"));

            trigger OnValidate()
            begin
                Cust.SetRange(Cust."No.", "Member No");
                if Cust.FindSet then begin
                    if Cust.Status <> Cust.Status::Active then begin
                        Error('Only Active Members can guarantee Loans');
                    end;
                end;
                //********************************************************cj

                LoanApp.SetRange(LoanApp."Client Code", "Member No");

                if LoanApp.FindSet then begin
                    LoanApp.CalcFields("Outstanding Balance");
                    if LoanApp."Outstanding Balance" > 0 then begin
                        if (LoanApp."Loans Category" = LoanApp."loans category"::Substandard) or (LoanApp."Loans Category" = LoanApp."loans category"::Doubtful) or
                          (LoanApp."Loans Category" = LoanApp."loans category"::Loss) then begin
                            Error('The Guarantor has an Arrears cannot guarantee Loan');
                        end;
                    end;
                end;
                LoanApp.SetRange(LoanApp."Client Code", "Member No");
                if LoanApp.Find('-') then begin
                    if LoanApp."Board Member" = true then begin
                        Error('Guarantor is a Board/supervisory or staff,cannot guarantee Loan');
                    end;
                end;
                //****************************************************************************************

                ObjWithApp.Reset;
                ObjWithApp.SetRange(ObjWithApp."Member No.", "Member No");
                if ObjWithApp.FindSet = true then begin
                    Error('The Member has a pending Withdrawal Application');
                end;

                MemberCust.Reset;
                MemberCust.SetRange(MemberCust."No.", "Member No");
                if MemberCust.Find('-') then begin
                    if MemberCust.Status = MemberCust.Status::Defaulter then
                        Error('THE MEMBER  IS  A  DEFAULTER');
                end;


                LnGuarantor.Reset;
                LnGuarantor.SetRange(LnGuarantor."Loan  No.", "Loan No");
                if LnGuarantor.Find('-') then begin
                    if LnGuarantor."Client Code" = "Member No" then begin

                        "Self Guarantee" := true;
                        //MODIFY;
                    end;
                end;
                LoanGuarantors.SetRange(LoanGuarantors."Self Guarantee", true);
                LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No");
                SelfGuaranteedA := 0;
                Date := Today;

                LoanApps.Reset;
                LoanApps.SetRange(LoanApps."Client Code", "Member No");
                LoanApps.SetRange(LoanApps."Loan Product Type", 'DEFAULTER');
                LoanApps.SetRange(LoanApps.Posted, true);
                if LoanApps.Find('-') then begin
                    repeat
                        LoanApps.CalcFields(LoanApps."Outstanding Balance");
                    until LoanApps.Next = 0;
                end;


                MemberCust.Reset;
                MemberCust.SetRange(MemberCust."No.", "Member No");
                if MemberCust.Find('-') then begin

                    MemberCust.CalcFields(MemberCust.TLoansGuaranteed, MemberCust."Current Savings");
                    "Shares *3" := (MemberCust."Current Savings");
                    "TotalLoan Guaranteed" := MemberCust.TLoansGuaranteed;
                end;
                /*IF "TotalLoan Guaranteed">4 THEN BEGIN
                  ERROR('Member can only guarantee a maximum of %1 loans',4);
                  END;*/
                if Cust.Get("Member No") then begin
                    Cust.CalcFields(Cust."Outstanding Balance", Cust."Current Shares", Cust.TLoansGuaranteed);
                    Name := Cust.Name;
                    "Staff/Payroll No." := Cust."Personal No";
                    "Loan Balance" := Cust."Outstanding Balance";
                    Shares := Cust."Current Shares" * 1;
                    "Amont Guaranteed" := Shares;
                    "TotalLoan Guaranteed" := Cust.TLoansGuaranteed;
                    "Free Shares" := (Shares * 3) - "TotalLoan Guaranteed";
                end;

                if "Total Loans Guaranteed" > GenSetUp."Maximum No of Guarantees" then
                    Error('This member has guaranteed more than %1 loans therefore cannot guarantee any more loans', GenSetUp."Maximum No of Guarantees");

                if "Shares *3" < 1 then
                    Error('Member Must have Deposit Contribution');


            end;
        }
        field(3; Name; Text[200])
        {
            Editable = false;
        }
        field(4; "Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(5; Shares; Decimal)
        {
            Editable = false;
        }
        field(6; "No Of Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("Member No"),
                                                                 "Outstanding Balance" = filter(> 1)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Substituted; Boolean)
        {

            trigger OnValidate()
            begin
                TestField("Substituted Guarantor");
            end;
        }
        field(8; Date; Date)
        {
        }
        field(9; "Shares Recovery"; Boolean)
        {
        }
        field(10; "New Upload"; Boolean)
        {
        }
        field(11; "Amont Guaranteed"; Decimal)
        {

            trigger OnValidate()
            begin
                SharesVariance := 0;
                LoanGuarantors.Reset;
                LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No");
                if LoanGuarantors.Find('-') then begin

                    repeat
                        LoanGuarantors.CalcFields(LoanGuarantors."Outstanding Balance");
                        if LoanGuarantors."Outstanding Balance" > 0 then begin
                            Totals := Totals + LoanGuarantors."Amont Guaranteed";
                        end;
                    until LoanGuarantors.Next = 0;
                end;
                "Free Shares" := (Shares * 3) - "TotalLoan Guaranteed";
            end;
        }
        field(12; "Staff/Payroll No."; Code[20])
        {

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."Personal No", "Staff/Payroll No.");
                if Cust.Find('-') then begin
                    "Member No" := Cust."No.";
                    Validate("Member No");
                end
                else
                    "Member No" := '';//ERROR('Record not found.')
            end;
        }
        field(13; "Account No."; Code[20])
        {
        }
        field(14; "Self Guarantee"; Boolean)
        {
        }
        field(15; "ID No."; Code[70])
        {
        }
        field(16; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(17; "Total Loans Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Loan No" = field("Loan No"),
                                                                                  Substituted = const(false),
                                                                                  "Self Guarantee" = const(false)));
            FieldClass = FlowField;
        }
        field(18; "Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Total Loans Guaranteed" := "Outstanding Balance";
                Modify;
            end;
        }
        field(19; "Guarantor Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("Member No"),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment")));
            FieldClass = FlowField;
        }
        field(20; "Employer Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(21; "Employer Name"; Text[100])
        {
        }
        field(22; "Substituted Guarantor"; Code[80])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                GenSetUp.Get();
                if LoansG > GenSetUp."Maximum No of Guarantees" then begin
                    Error('Member has guaranteed more than maximum active loans and  can not Guarantee any other Loans');
                    "Member No" := '';
                    "Staff/Payroll No." := '';
                    Name := '';
                    "Loan Balance" := 0;
                    Date := 0D;
                    exit;
                end;


                Loans.Reset;
                Loans.SetRange(Loans."Client Code", "Member No");
                if Loans.Find('-') then begin
                    if LoanGuarantors."Self Guarantee" = true then
                        Error('This Member has Self Guaranteed and Can not Guarantee another Loan');
                end;
            end;
        }
        field(23; "Loanees  No"; Code[30])
        {
            CalcFormula = lookup("Loans Register"."Client Code" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(24; "Loanees  Name"; Text[80])
        {
            CalcFormula = lookup("Loans Register"."Client Name" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(25; "Loan Product"; Code[20])
        {
            CalcFormula = lookup("Loans Register"."Loan Product Type" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(26; "Entry No."; Integer)
        {
        }
        field(27; "Loan Application Date"; Date)
        {
            CalcFormula = lookup("Loans Register"."Application Date" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(28; "Free Shares"; Decimal)
        {
        }
        field(29; "Line No"; Integer)
        {
        }
        field(30; "Member Cell"; Code[10])
        {
        }
        field(31; "Share capital"; Decimal)
        {
        }
        field(32; "TotalLoan Guaranteed"; Decimal)
        {
            Description = '`';
        }
        field(33; Totals; Decimal)
        {
        }
        field(34; "Shares *3"; Decimal)
        {
        }
        field(35; "Deposits variance"; Decimal)
        {
        }
        field(36; "Defaulter Loan Installments"; Code[10])
        {
        }
        field(37; "Defaulter Loan Repayment"; Decimal)
        {
        }
        field(38; "Exempt Defaulter Loan"; Boolean)
        {
        }
        field(39; "Additional Defaulter Amount"; Decimal)
        {
        }
        field(40; "Total Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Loan Balance" where("Loan No" = field("Loan No"),
                                                                              Substituted = filter(false)));
            Description = '//>Sum total guaranteed amount for each loan';
            FieldClass = FlowField;
        }
        field(69161; "Total Committed Shares"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("Member No")));
            FieldClass = FlowField;
        }
        field(69162; "Oustanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("Member No"),
                                                                  "Transaction Type" = filter("Interest Paid"),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(69163; "Guar Sub Doc No."; Code[20])
        {
        }
        field(69164; "Committed Shares"; Decimal)
        {
        }
        field(69165; "Substituted Guarantor Name"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Loan No", "Staff/Payroll No.", "Member No", "Entry No.")
        {
        }
        key(Key2; "Loan No", "Member No")
        {
            Clustered = true;
            SumIndexFields = Shares;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        LoanGuarantors: Record "Loans Guarantee Details";
        Loans: Record "Loans Register";
        LoansR: Record "Loans Register";
        LoansG: Integer;
        GenSetUp: Record "Sacco General Set-Up";
        SelfGuaranteedA: Decimal;
        StatusPermissions: Record "Status Change Permision";
        Employer: Record "Sacco Employers";
        loanG: Record "Loans Guarantee Details";
        CustomerRecord: Record Customer;
        MemberSaccoAge: Date;
        ComittedShares: Decimal;
        LoanApp: Record "Loans Register";
        DefaultInfo: Text;
        ok: Boolean;
        SharesVariance: Decimal;
        MemberCust: Record Customer;
        LnGuarantor: Record "Loans Register";
        LoanApps: Record "Loans Register";
        Text0001: label 'This Member has an Outstanding Defaulter Loan which has never been serviced';
        freeshares: Decimal;
        loanrec: Record "Loans Guarantee Details";
        ObjWithApp: Record "Membership Exit";

    local procedure UPDATEG()
    begin
    end;
}

