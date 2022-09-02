#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516934 "Product Risk Rating"
{

    fields
    {
        field(1;"Product Category";Option)
        {
            OptionCaption = 'Electronic Payment,Accounts,Cards,Others';
            OptionMembers = "Electronic Payment",Accounts,Cards,Others;
        }
        field(2;"Product Type";Option)
        {
            OptionCaption = 'International Wire Transfers,Local Wire Transfers,Mobile Transfers,None of the Above,Fixed/Call Deposit Accounts,FOSA(KSA,Imara, MJA,Heritage),Account with Sealed Safe deposit,Account with  Open Safe Deposit,All Loan Accounts,BOSA, Ufalme,ATM Debit,Credit,Both,None,Non-face to face channels,Unsolicited Account Origination e.g. Walk-Ins,Cheque book,Others';
            OptionMembers = "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        }
        field(3;"Inherent Risk Rating";Option)
        {
            OptionCaption = 'Low,Medium,High';
            OptionMembers = Low,Medium,High;
        }
        field(4;"Risk Score";Decimal)
        {
        }
        field(5;"Product Type Code";Code[50])
        {
        }
        field(6;"Code";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Product Category","Product Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

