#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516396 "Appraisal Salary Set-up"
{
    DrillDownPageID = "Appraisal Salary Setup List";
    LookupPageID = "Appraisal Salary Setup List";

    fields
    {
        field(1;"Code";Code[20])
        {
            NotBlank = true;
        }
        field(2;Description;Text[30])
        {
        }
        field(3;Type;Option)
        {
            OptionCaption = ' ,Earnings,Deductions';
            OptionMembers = " ",Earnings,Deductions;
        }
        field(4;"Statutory Ded";Boolean)
        {

            trigger OnValidate()
            begin
                //"AppraisalSDetails`".RESET;
                //"AppraisalSDetails`".SETRANGE("AppraisalSDetails`".Code,)
                //AppraisalSDetails.Statutory:="Statutory Ded";
            end;
        }
        field(5;"Statutory Amount";Decimal)
        {
        }
        field(6;"Statutory(%)";Decimal)
        {
        }
        field(7;"Long Term Deductions";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        AppraisalSDetails: Record "Loan Appraisal Salary Details";
}

