#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516485 "Mobile tranfer approvals"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
        }
        field(3;"Signatory Name";Text[250])
        {
        }
        field(4;"Mobile No";Code[50])
        {
        }
        field(5;Status;Option)
        {
            OptionCaption = 'Pending,Approved,Declined';
            OptionMembers = Pending,Approved,Declined;
        }
        field(6;"Transaction No";Code[50])
        {
        }
        field(10;Token;Text[250])
        {
        }
        field(11;"Transaction Type";Option)
        {
            OptionCaption = 'Account Transfer, Mpesa Withrawal';
            OptionMembers = "Account Transfer"," Mpesa Withrawal";
        }
        field(12;"ID Number";Code[50])
        {
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

