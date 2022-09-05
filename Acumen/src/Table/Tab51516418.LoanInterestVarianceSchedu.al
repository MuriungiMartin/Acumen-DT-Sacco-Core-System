#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516418 "Loan Interest Variance Schedu"
{

    fields
    {
        field(1; "Loan No."; Code[40])
        {
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Customer."No.";
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
    }

    keys
    {
        key(Key1; "Loan No.")
        {
            Clustered = true;
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

