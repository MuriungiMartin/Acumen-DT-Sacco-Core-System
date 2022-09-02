#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516375 "Loan Repayment Schedule"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Editable = false;
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2; "Member No."; Code[20])
        {
            Editable = false;
        }
        field(3; "Loan Category"; Code[20])
        {
        }
        field(8; "Closed Date"; Date)
        {
        }
        field(9; "Loan Amount"; Decimal)
        {
        }
        field(14; "Interest Rate"; Decimal)
        {
        }
        field(15; "Monthly Repayment"; Decimal)
        {
        }
        field(17; "Member Name"; Text[30])
        {
        }
        field(21; "Monthly Interest"; Decimal)
        {
        }
        field(25; "Amount Repayed"; Decimal)
        {
            FieldClass = Normal;
        }
        field(26; "Repayment Date"; Date)
        {
        }
        field(27; "Principal Repayment"; Decimal)
        {
        }
        field(28; Paid; Boolean)
        {
        }
        field(29; "Remaining Debt"; Decimal)
        {
            Editable = false;
        }
        field(30; "Instalment No"; Integer)
        {
        }
        field(45; "Actual Loan Repayment Date"; Date)
        {
        }
        field(46; "Repayment Code"; Code[20])
        {
        }
        field(47; "Group Code"; Code[20])
        {
        }
        field(48; "Loan Application No"; Code[20])
        {
        }
        field(49; "Actual Principal Paid"; Decimal)
        {
        }
        field(50; "Actual Interest Paid"; Decimal)
        {
        }
        field(51; "Actual Installment Paid"; Decimal)
        {
        }
        field(52; "Schedule Principle"; Decimal)
        {
        }
        field(53; "Loan Balance"; Decimal)
        {
        }
        field(54; "Monthly Insurance"; Decimal)
        {
        }
        field(55; "Close Schedule"; Boolean)
        {
        }
        field(56; "Reschedule No"; Integer)
        {
        }
        field(57; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("Member No."),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment")));
            FieldClass = FlowField;
        }
        field(58; Reschedule; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Member No.", "Reschedule No", "Instalment No")
        {
            Clustered = true;
            SumIndexFields = "Monthly Interest", "Principal Repayment", "Monthly Repayment";
        }
        key(Key2; "Member No.")
        {
        }
        key(Key3; Paid)
        {
        }
        key(Key4; "Loan No.", "Member No.", Paid)
        {
        }
        key(Key5; "Loan Category")
        {
        }
        key(Key6; "Loan No.", "Member No.", Paid, "Loan Category")
        {
        }
    }

    fieldgroups
    {
    }

    var
        NoSeriesMngnt: Codeunit NoSeriesManagement;
        SACCOMember: Record Customer;
        LoanCategory: Record "Loan Products Setup";
}

