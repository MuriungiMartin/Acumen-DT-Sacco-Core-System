#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516909 "Safe Custody Custodians"
{
    DrillDownPageID = "Safe Custody Custodians";
    LookupPageID = "Safe Custody Custodians";

    fields
    {
        field(1;"User ID";Code[100])
        {
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                UserManagement: Codeunit "User Management";
            begin
                UserManagement.LookupUserID("User ID");
            end;

            trigger OnValidate()
            var
                UserManagement: Codeunit "User Management";
            begin
                /*ObjUser.RESET;
                ObjUser.SETRANGE(ObjUser."User Security ID","User ID");
                IF ObjUser.FINDSET THEN BEGIN
                  "User Name":=ObjUser."User Name";
                  END;
                */
                
                UserManagement.ValidateUserID("User ID");

            end;
        }
        field(3;"Permision Type";Option)
        {
            OptionCaption = 'Custodian';
            OptionMembers = Custodian;
        }
        field(4;"Custodian Of";Option)
        {
            OptionCaption = ' ,Treasury,Safe Custody';
            OptionMembers = " ",Treasury,"Safe Custody";
        }
    }

    keys
    {
        key(Key1;"User ID","Permision Type","Custodian Of")
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

