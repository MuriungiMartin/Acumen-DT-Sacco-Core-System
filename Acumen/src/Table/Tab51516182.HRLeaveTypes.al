#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516182 "HR Leave Types"
{
    LookupPageID = "HR Leave Types";

    fields
    {
        field(1;"Code";Code[40])
        {
            NotBlank = true;
        }
        field(2;Description;Text[200])
        {
        }
        field(3;Days;Decimal)
        {
        }
        field(4;"Acrue Days";Boolean)
        {
        }
        field(5;"Unlimited Days";Boolean)
        {
        }
        field(6;Gender;Option)
        {
            OptionCaption = 'Both,Male,Female';
            OptionMembers = Both,Male,Female;
        }
        field(7;Balance;Option)
        {
            OptionCaption = 'Ignore,Carry Forward,Convert to Cash';
            OptionMembers = Ignore,"Carry Forward","Convert to Cash";
        }
        field(8;"Inclusive of Holidays";Boolean)
        {
        }
        field(9;"Inclusive of Saturday";Boolean)
        {
        }
        field(10;"Inclusive of Sunday";Boolean)
        {
        }
        field(11;"Off/Holidays Days Leave";Boolean)
        {
        }
        field(12;"Max Carry Forward Days";Decimal)
        {
        }
        field(13;"Inclusive of Non Working Days";Boolean)
        {
        }
        field(14;"Date Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(15;"Carry Forward Allowed";Boolean)
        {
        }
        field(16;"Fixed Days";Boolean)
        {
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

