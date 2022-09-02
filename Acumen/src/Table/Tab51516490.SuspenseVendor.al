#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516490 "Suspense Vendor"
{

    fields
    {
        field(1;No;Code[20])
        {
        }
        field(2;Name;Text[50])
        {
        }
        field(3;Address;Text[30])
        {
        }
        field(4;"Address 2";Text[30])
        {
        }
        field(5;"Post Code";Code[20])
        {
        }
        field(6;City;Text[30])
        {
        }
        field(7;"Phone No.";Code[20])
        {
        }
        field(8;Activity;Code[20])
        {
        }
        field(9;Branch;Code[20])
        {
        }
        field(10;"Vendor Posting Group";Code[20])
        {
        }
        field(11;Blocked;Option)
        {
            OptionCaption = ' ,All,Payment';
            OptionMembers = " ",All,Payment;
        }
        field(12;Balance;Decimal)
        {
        }
        field(13;"Balance(LCY)";Decimal)
        {
        }
        field(14;County;Code[20])
        {
        }
        field(15;"E-mail";Text[60])
        {
        }
        field(16;"Creditor Type";Option)
        {
            OptionCaption = ' ,Account';
            OptionMembers = " ",Account;
        }
        field(17;"Staff No";Code[20])
        {
        }
        field(18;"ID No.";Code[20])
        {
        }
        field(19;"FD Status";Option)
        {
            OptionCaption = ' ,Active,Matured,Closed,Not Matured';
            OptionMembers = " ",Active,Matured,Closed,"Not Matured";
        }
        field(20;"Mobile No";Code[20])
        {
        }
        field(21;"Marital Status";Option)
        {
            OptionCaption = ' ,Single,Married,Devorced,Widower';
            OptionMembers = " ",Single,Married,Devorced,Widower;
        }
        field(22;"Reg Date";Date)
        {
        }
        field(23;"Bosa Account No.";Code[30])
        {
        }
        field(24;"Company Code";Code[20])
        {
        }
        field(25;Status;Option)
        {
            OptionCaption = 'Active,Frozen,Closed,Archived,New,Dormant,Deceased';
            OptionMembers = Active,Frozen,Closed,Archived,New,Dormant,Deceased;
        }
        field(26;"Account  type";Code[20])
        {
        }
        field(27;"Account Category";Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Branch,Project';
            OptionMembers = Single,Joint,Corporate,Group,Branch,Project;
        }
        field(28;"Date odf Birth";Date)
        {
        }
        field(29;"Atm no";Code[50])
        {
        }
        field(30;"Home address";Code[20])
        {
        }
        field(31;Location;Code[10])
        {
        }
        field(32;"Sub Location";Text[30])
        {
        }
        field(33;District;Code[20])
        {
        }
        field(34;"FD Type";Code[10])
        {
        }
        field(35;"FD Maturity Date";Date)
        {
        }
        field(36;"Saving Account No";Code[30])
        {
        }
        field(37;"Salary Processing";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

