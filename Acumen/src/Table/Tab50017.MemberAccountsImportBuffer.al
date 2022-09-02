#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50017 "Member Accounts Import Buffer"
{

    fields
    {
        field(1;"Member No";Code[50])
        {
        }
        field(2;"Member Name";Code[50])
        {
        }
        field(3;"Group ID";Code[60])
        {
        }
        field(4;"Branch Code";Code[60])
        {
        }
        field(5;"Postal Address";Code[60])
        {
        }
        field(6;"Postal Code";Code[50])
        {
        }
        field(7;City;Code[100])
        {
        }
        field(8;Residence;Code[100])
        {
        }
        field(9;Village;Code[100])
        {
        }
        field(10;Location;Code[100])
        {
        }
        field(11;"Sub-Location";Code[100])
        {
        }
        field(12;District;Code[50])
        {
        }
        field(13;"Date Of Birth";Date)
        {
        }
        field(14;"Mobile No";Code[30])
        {
        }
        field(15;"Phone No";Code[30])
        {
        }
        field(16;Email;Text[150])
        {
        }
        field(17;"Email Indemnified";Boolean)
        {
        }
        field(18;"ID No";Code[30])
        {
        }
        field(19;"ID Type";Option)
        {
            OptionCaption = 'National ID Card,Passport Card,Aliens Card,Birth Certificate,Company Reg. No,Driving License,Not Applicable';
            OptionMembers = "National ID Card","Passport Card","Aliens Card","Birth Certificate","Company Reg. No","Driving License","Not Applicable";
        }
        field(20;"ID Date of Issue";Date)
        {
        }
        field(21;"KRA Pin";Code[50])
        {
        }
        field(22;"Marital Status";Option)
        {
            OptionCaption = ' ,Single,Married,Divorced,Widowed,Separated';
            OptionMembers = " ",Single,Married,Divorced,Widowed,Separated;
        }
        field(23;Gender;Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(24;"Literacy Lever";Code[30])
        {
        }
        field(25;Occupation;Code[50])
        {
        }
        field(26;"Registration Date";Date)
        {
        }
        field(27;"Created By";Code[30])
        {
        }
        field(28;"Modified By";Code[30])
        {
        }
        field(29;"Modified On";Date)
        {
        }
        field(30;"Supervised By";Code[30])
        {
        }
        field(31;"Supervised On";Date)
        {
        }
        field(32;"Introduced By";Code[30])
        {
        }
        field(33;"Account Status";Option)
        {
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New;
        }
    }

    keys
    {
        key(Key1;"Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

