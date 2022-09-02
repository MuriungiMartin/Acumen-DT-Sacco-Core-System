#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516500 "Cheques Register"
{

    fields
    {
        field(1;"Cheque No.";Code[10])
        {
        }
        field(2;"Account No.";Code[20])
        {
        }
        field(3;Status;Option)
        {
            OptionCaption = 'Pending,Approved,Cancelled,stopped,Dishonoured';
            OptionMembers = Pending,Approved,Cancelled,stopped,Dishonoured;
        }
        field(4;"Approval Date";Date)
        {
        }
        field(5;"Application No.";Code[10])
        {
        }
        field(6;"Cancelled/Stopped By";Code[50])
        {
        }
    }

    keys
    {
        key(Key1;"Cheque No.","Account No.","Application No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

