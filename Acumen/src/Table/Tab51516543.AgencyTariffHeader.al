#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516543 "Agency Tariff Header"
{

    fields
    {
        field(1;"Code";Code[20])
        {
            Description = 'Agent Tariff Code';
        }
        field(2;"Trans Type";Option)
        {
            Description = 'Transaction Type';
            OptionCaption = ',Registration,Withdrawal,Deposit,LoanRepayment,Transfer,Sharedeposit,Schoolfeespayment,Balance,Ministatment,Paybill,Memberactivation,MemberRegistration';
            OptionMembers = ,Registration,Withdrawal,Deposit,LoanRepayment,Transfer,Sharedeposit,Schoolfeespayment,Balance,Ministatment,Paybill,Memberactivation,MemberRegistration;
        }
        field(3;Description;Text[200])
        {
            Description = 'Description';
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

