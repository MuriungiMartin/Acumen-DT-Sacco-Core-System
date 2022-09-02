#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516486 "Online Access Group Priveleges"
{

    fields
    {
        field(1;Dashboard;Boolean)
        {
        }
        field(2;Inbox;Boolean)
        {
        }
        field(3;"Loan Calculator";Boolean)
        {
        }
        field(4;"Loan Application";Boolean)
        {
        }
        field(5;"Loan Status Trail";Boolean)
        {
        }
        field(6;"Contact Us";Boolean)
        {
        }
        field(7;"Group Name";Text[100])
        {
        }
        field(8;"Manage Users";Boolean)
        {
        }
        field(9;"Change Password";Boolean)
        {
        }
        field(10;"Lock System";Boolean)
        {
        }
        field(11;"Personal Info";Boolean)
        {
        }
        field(12;"My Loans Statement";Boolean)
        {
        }
        field(13;"My Guarantors Statement";Boolean)
        {
        }
        field(14;"Loans Guaranteed Statement";Boolean)
        {
        }
        field(15;"Deposits_Shares Statement";Boolean)
        {
        }
        field(16;"Loans Repayment Statement";Boolean)
        {
        }
        field(17;"Investment Statement";Boolean)
        {
        }
        field(18;"Shares Capital Statement";Boolean)
        {
        }
        field(19;"Combined Statement";Boolean)
        {
        }
        field(20;EntryNo;Integer)
        {
            AutoIncrement = true;
        }
        field(21;Fosa_Statement;Boolean)
        {
        }
        field(22;Inter_Account_Transfer;Boolean)
        {
        }
        field(23;ManageOnlineApplication;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

