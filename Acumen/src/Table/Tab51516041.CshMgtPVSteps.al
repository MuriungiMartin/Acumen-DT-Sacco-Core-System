#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516041 "CshMgt PV Steps"
{
    DrillDownPageID = UnknownPage55913;
    LookupPageID = UnknownPage55913;

    fields
    {
        field(1;"Code";Code[20])
        {
            Description = 'Stores the code of the status in the database';
        }
        field(2;Description;Text[30])
        {
            Description = 'Stores the description of the status in the database';
        }
        field(3;Users;Integer)
        {
            CalcFormula = count("CshMgt PV Steps Users" where (Code=field(Code)));
            Description = 'Stores the number of user for the steps';
            FieldClass = FlowField;
        }
        field(67;"Pay Mode";Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Letter of Credit","Custom 3","Custom 4","Custom 5";
        }
        field(68;"Default Account";Code[20])
        {
            Description = 'Stores the default account in the database';
            TableRelation = "Bank Account"."No.";
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
}

