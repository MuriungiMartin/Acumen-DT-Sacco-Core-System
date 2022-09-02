#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516385 "Loan Applicaton Charges"
{

    fields
    {
        field(1;"Loan No";Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2;Description;Text[30])
        {
        }
        field(3;Amount;Decimal)
        {
        }
        field(4;"Code";Code[20])
        {
            TableRelation = "HR Employee Kin".Relationship;
        }
        field(5;"Use Perc";Boolean)
        {
        }
        field(6;"Perc (%)";Decimal)
        {

            trigger OnValidate()
            begin
                if "Use Perc" = true then begin
                if Loans.Get("Loan No") then
                Amount:=Loans."Approved Amount"*"Perc (%)"*0.01;
                end else
                Error('Only applicable for charges where percentage is applicable.');
            end;
        }
        field(7;"G/L Account";Code[20])
        {
        }
        field(8;"Paid Before Disb.";Boolean)
        {
        }
        field(9;"Loan Type";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Loan No",Description)
        {
            Clustered = true;
        }
        key(Key2;"Loan No","G/L Account")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Loans: Record "Loans Register";
}

