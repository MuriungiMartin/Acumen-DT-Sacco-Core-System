#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516494 "Loan Partial Disburesments"
{

    fields
    {
        field(1;"Loan No.";Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2;"Member No";Code[20])
        {
            CalcFormula = lookup("Loans Register"."Client Code" where ("Loan  No."=field("Loan No.")));
            FieldClass = FlowField;
        }
        field(3;"Member Name";Text[50])
        {
            CalcFormula = lookup("Loans Register"."Client Name" where ("Loan  No."=field("Loan No.")));
            FieldClass = FlowField;
        }
        field(4;"Loan Product";Code[20])
        {
            CalcFormula = lookup("Loans Register"."Loan Product Type" where ("Loan  No."=field("Loan No.")));
            FieldClass = FlowField;
        }
        field(5;"Amount to Be Disbursed";Decimal)
        {

            trigger OnValidate()
            begin
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.","Loan No.");
                if Loans.Find('-') then begin
                "Amount Due":=Loans."Approved Amount"-"Amount to Be Disbursed";
                end;
            end;
        }
        field(6;"Amount Due";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Loan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Loans: Record "Loans Register";
}

