#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516561 "BOSA Accounts No Buffer"
{

    fields
    {
        field(1;"Account No";Code[20])
        {
        }
        field(2;"Transaction Type";Option)
        {
            OptionCaption = ' ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares';
            OptionMembers = " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        }
        field(3;"Member No";Code[20])
        {
        }
        field(4;"Account Name";Code[50])
        {
        }
        field(5;"ID No";Code[20])
        {
        }
        field(6;"Account Type";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Account No","Transaction Type","Member No","Account Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Account No","Member No","Account Name","ID No","Account Type")
        {
        }
    }
}

