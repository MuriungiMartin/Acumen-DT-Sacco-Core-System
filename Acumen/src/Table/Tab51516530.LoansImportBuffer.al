#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516530 "Loans Import Buffer"
{

    fields
    {
        field(1;"Member No";Code[20])
        {
        }
        field(2;"Member Name";Code[80])
        {
        }
        field(3;"Group ID";Code[50])
        {
        }
        field(4;"Branch Code";Code[20])
        {
        }
        field(5;"Branch Name";Code[50])
        {
        }
        field(6;Address;Code[50])
        {
        }
        field(7;"Postal Code";Code[30])
        {
        }
        field(8;City;Code[30])
        {
        }
        field(9;"Member Residence";Code[50])
        {
        }
        field(10;Village;Code[50])
        {
        }
        field(11;Location;Code[50])
        {
        }
        field(12;"Sub Location";Code[50])
        {
        }
        field(13;District;Code[50])
        {
        }
        field(14;"Date Of Birth";Date)
        {
        }
        field(15;"Mobile No";Code[30])
        {
        }
        field(16;"Phone No";Code[30])
        {
        }
        field(17;Email;Text[60])
        {
        }
        field(18;"Email Idemnified";Boolean)
        {
        }
        field(19;"ID No";Code[50])
        {
        }
        field(20;"ID Type";Code[50])
        {
        }
        field(21;"ID Date of Issue";Date)
        {
        }
        field(22;"KRA Pin";Code[30])
        {
        }
        field(23;"Marital Status";Option)
        {
            OptionCaption = 'Single,Married,Divorsed,Widowed';
            OptionMembers = Single,Married,Divorsed,Widowed;
        }
        field(24;Gender;Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(25;"Literacy Level";Option)
        {
            OptionCaption = ' ,College / Polytechnic,No Formal Education,Primary,Secondary,University';
            OptionMembers = " ","College / Polytechnic","No Formal Education",Primary,Secondary,University;
        }
        field(26;Occupation;Code[50])
        {
        }
        field(27;"Registration Date";Date)
        {
        }
        field(28;"Created By";Code[20])
        {
        }
        field(29;"Created On";Date)
        {
        }
        field(30;"Modified By";Code[20])
        {
        }
        field(31;"Modified On";Date)
        {
        }
        field(32;"Supervised By";Code[20])
        {
        }
        field(33;"Supervised On";Date)
        {
        }
        field(34;Referee;Code[30])
        {
        }
        field(35;"Member Status";Option)
        {
            OptionMembers = Active,Dormant;
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

