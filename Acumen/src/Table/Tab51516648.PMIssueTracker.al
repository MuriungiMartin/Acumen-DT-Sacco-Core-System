#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516648 "PM Issue Tracker"
{

    fields
    {
        field(1;"Module Code";Code[100])
        {
            TableRelation = "PM Modules".Code;
        }
        field(2;"UAT Item";Text[250])
        {
        }
        field(3;"USER ID";Code[100])
        {

            trigger OnLookup()
            begin
                //UserMgt.LookupUserID("USER ID");
            end;

            trigger OnValidate()
            begin
                //UserMgt.ValidateUserID("USER ID");
            end;
        }
        field(4;"Assigned to";Code[100])
        {
        }
        field(5;"surestep status";Option)
        {
            OptionCaption = ' ,New,WIP,Resolved,Rejected';
            OptionMembers = " ",New,WIP,Resolved,Rejected;

            trigger OnValidate()
            begin
                /*CLEAR("Date Resolved SS");
                IF "Customer Status"="Customer Status"::Resolved THEN
                  "Date Resolved SS":=TODAY;
                */

            end;
        }
        field(6;"Customer Status";Option)
        {
            OptionCaption = ' ,New,WIP,Resolved,Rejected';
            OptionMembers = " ",New,WIP,Resolved,Rejected;

            trigger OnValidate()
            begin
                /*CLEAR("Date Resolved");
                IF "Customer Status"="Customer Status"::Resolved
                  THEN "Date Resolved":=TODAY;
                */

            end;
        }
        field(7;"Date Raised";Date)
        {
        }
        field(8;"Date Resolved";Date)
        {
        }
        field(9;"Entry No";Integer)
        {
            AutoIncrement = true;
        }
        field(10;"Surestep Comments";Text[250])
        {
        }
        field(11;"User Comments";Text[250])
        {
        }
        field(12;Rating;Option)
        {
            OptionCaption = ' ,Normal,Critical,Desired';
            OptionMembers = " ",Normal,Critical,Desired;
        }
        field(13;"UAT Level";Option)
        {
            OptionCaption = ' ,UAT1,UAT2,POST GOLIVE,SUPPORT';
            OptionMembers = " ",UAT1,UAT2,"POST GOLIVE",SUPPORT;
        }
        field(14;"Date Resolved SS";Date)
        {
        }
        field(15;Posted;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Module Code","Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //IF "USER ID" <> USERID THEN
        //  ERROR('You cannot modify a record that belongs to another user!');
    end;

    trigger OnInsert()
    begin
        Validate("Entry No");
        "Date Raised":=Today;
        "USER ID":=UserId;
        "Assigned to":='CYRUS';
        "UAT Level":="uat level"::UAT2;
        "surestep status":="surestep status"::WIP;
        "Customer Status":="customer status"::WIP;
    end;

    trigger OnModify()
    begin
        //IF "USER ID" <> USERID THEN
        //  ERROR('You cannot modify a record that belongs to another user!');
    end;

    trigger OnRename()
    begin
        //IF "USER ID" <> USERID THEN
        //  ERROR('You cannot modify a record that belongs to another user!');
    end;

    var
        UserMgt: Codeunit "User Management";
        entrynumber: Integer;
}

