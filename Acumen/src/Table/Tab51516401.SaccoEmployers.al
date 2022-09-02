#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516401 "Sacco Employers"
{
    DrillDownPageID = "Employer list";
    LookupPageID = "Employer list";

    fields
    {
        field(1;"Code";Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                  //Description:=  cust.Name;
                  //MODIFY;
            end;
        }
        field(2;Description;Text[50])
        {
        }
        field(3;"Repayment Method";Option)
        {
            OptionMembers = " ",Amortised,"Reducing Balance","Straight Line",Constants;
        }
        field(4;"Check Off";Boolean)
        {
        }
        field(5;"No. of Members";Integer)
        {
            CalcFormula = count("Member Register" where (Status=filter(Active|Dormant|"Re-instated"|Termination|Resigned),
                                                         "Employer Code"=field(Code),
                                                         "Customer Posting Group"=const('MEMBER')));
            FieldClass = FlowField;
        }
        field(6;Male;Integer)
        {
            CalcFormula = count("Member Register" where (Status=filter(Active|Dormant|"Re-instated"|Termination|Resigned),
                                                         "Employer Code"=field(Code),
                                                         "Customer Posting Group"=const('MEMBER'),
                                                         Gender=const(" ")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7;Female;Integer)
        {
            CalcFormula = count("Member Register" where (Status=filter(Active|Dormant|"Re-instated"|Termination|Resigned),
                                                         "Employer Code"=field(Code),
                                                         "Customer Posting Group"=const('MEMBER'),
                                                         Gender=const(Male)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8;"Vote Code";Code[20])
        {
        }
        field(9;"Can Guarantee Loan";Boolean)
        {
        }
        field(10;"Active Members";Integer)
        {
            CalcFormula = count("Member Register" where (Status=filter(Active),
                                                         "Employer Code"=field(Code),
                                                         "Customer Posting Group"=const('MEMBER')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11;"Dormant Members";Integer)
        {
            CalcFormula = count("Member Register" where (Status=filter(Dormant),
                                                         "Employer Code"=field(Code),
                                                         "Customer Posting Group"=const('MEMBER')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12;Withdrawn;Integer)
        {
            CalcFormula = count("Member Register" where (Status=filter(Withdrawal),
                                                         "Employer Code"=field(Code),
                                                         "Customer Posting Group"=const('MEMBER')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13;Deceased;Integer)
        {
            CalcFormula = count("Member Register" where (Status=filter(Deceased),
                                                         "Employer Code"=field(Code),
                                                         "Customer Posting Group"=const('MEMBER')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14;"Join Date";Date)
        {
        }
    }

    keys
    {
        key(Key1;"Code",Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Code",Description)
        {
        }
    }

    var
        cust: Record Customer;
}

