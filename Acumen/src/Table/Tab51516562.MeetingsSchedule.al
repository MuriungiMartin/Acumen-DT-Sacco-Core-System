#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516562 "Meetings Schedule"
{
    DrillDownPageID = "Meetings Schedule";
    LookupPageID = "Meetings Schedule";

    fields
    {
        field(1;"Lead No";Code[20])
        {
        }
        field(2;"Meeting Date";Date)
        {

            trigger OnValidate()
            begin
                ObjUser.Reset;
                ObjUser.SetRange(ObjUser."User Name",UserId);
                if ObjUser.FindSet then begin
                  "User to Notify":=UserId;
                  "User Email":=ObjUser."Contact Email";
                  end;
            end;
        }
        field(3;"Meeting Place";Code[30])
        {
        }
        field(4;"Meeting Status";Option)
        {
            OptionCaption = 'Due,Done,Postphoned';
            OptionMembers = Due,Done,Postphoned;
        }
        field(5;"Meeting Outcome(Brief)";Text[50])
        {
        }
        field(6;"User to Notify";Code[20])
        {
        }
        field(7;"User Email";Text[50])
        {
        }
    }

    keys
    {
        key(Key1;"Lead No","Meeting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjUser: Record User;
}

