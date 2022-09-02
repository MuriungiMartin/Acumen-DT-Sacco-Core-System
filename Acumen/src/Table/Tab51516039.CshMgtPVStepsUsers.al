#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516039 "CshMgt PV Steps Users"
{
    DrillDownPageID = UnknownPage56044;
    LookupPageID = UnknownPage56044;

    fields
    {
        field(1;"Code";Code[20])
        {
            Description = 'Stores the code reference to the step in the database';
            TableRelation = "CshMgt PV Steps".Code;
        }
        field(2;Description;Text[30])
        {
            Description = 'Stores the description of teh step in the database';
        }
        field(3;UserID;Code[20])
        {

            trigger OnLookup()
            begin
                LoginMgt.LookupUserID(UserID);

                Validate(UserID);
            end;

            trigger OnValidate()
            begin
                LoginMgt.ValidateUserID(UserID);
                with User do begin
                  Reset;
                  Get(Rec.UserID);
                  Rec."User name":=User."User Name";
                end;
            end;
        }
        field(4;"User name";Text[30])
        {
        }
        field(5;Email;Text[30])
        {
        }
        field(6;"Email Alert ?";Boolean)
        {
        }
        field(7;"No.";Boolean)
        {
        }
        field(8;Date;Boolean)
        {
        }
        field(9;"Global Dimension 1 Code";Boolean)
        {
            CaptionClass = '1,2,1';
        }
        field(10;"Global Dimension 2 Code";Boolean)
        {
            CaptionClass = '1,2,2';
        }
        field(11;"Paying Bank Account";Boolean)
        {
        }
        field(12;"Payment To";Boolean)
        {
        }
        field(13;"On Behalf Of";Boolean)
        {
        }
        field(14;PVLines;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Code",UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LoginMgt: Codeunit "User Management";
        User: Record User;
}

