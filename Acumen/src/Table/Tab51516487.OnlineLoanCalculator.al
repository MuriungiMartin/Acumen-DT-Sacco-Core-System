#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516487 "Online Loan Calculator"
{

    fields
    {
        field(1;"User ID";Code[20])
        {
            TableRelation = "Online Users"."User Name" where ("User Name"=field("User ID"));
        }
        field(2;Month;Integer)
        {
        }
        field(3;"Principle Amount";Text[30])
        {
        }
        field(4;"Loan Repayment";Text[30])
        {
        }
        field(5;Interest;Text[30])
        {
        }
        field(6;"Total Deduction";Text[30])
        {
        }
        field(7;"Loan Balance";Text[30])
        {
        }
        field(8;Period;Text[100])
        {
        }
    }

    keys
    {
        key(Key1;Month,"User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

