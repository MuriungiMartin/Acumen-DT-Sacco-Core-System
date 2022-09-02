#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516373 "Loan Appraisal Salary Details"
{
    DrillDownPageID = "Loan Appraisal Salary Details";
    LookupPageID = "Loan Appraisal Salary Details";

    fields
    {
        field(1;"Client Code";Code[20])
        {
        }
        field(2;"Code";Code[20])
        {
            NotBlank = true;
            TableRelation = "Appraisal Salary Set-up";

            trigger OnValidate()
            begin
                if "SalarySet-up".Get(Code) then begin
                Description:="SalarySet-up".Description;
                Type:="SalarySet-up".Type;

                end;

                if "SalarySet-up".Get(Code) then begin
                if "SalarySet-up"."Statutory(%)"<>0 then begin
                if Code='001' then
                Amount:="SalarySet-up"."Statutory(%)"*  Amount;

                end;
                end;
            end;
        }
        field(3;Description;Text[30])
        {
        }
        field(4;Type;Option)
        {
            OptionCaption = ' ,Earnings,Deductions';
            OptionMembers = " ",Earnings,Deductions;
        }
        field(5;Amount;Decimal)
        {
        }
        field(6;"Loan No";Code[20])
        {
            TableRelation = "Loans Register";
        }
    }

    keys
    {
        key(Key1;"Loan No","Client Code","Code")
        {
            Clustered = true;
        }
        key(Key2;"Code","Client Code",Type)
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        "SalarySet-up": Record "Appraisal Salary Set-up";
        Loans: Record "Loans Register";
        Grosspay: Decimal;
}

