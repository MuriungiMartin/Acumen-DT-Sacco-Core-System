#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516252 "HR Notice Board Attachments"
{

    fields
    {
        field(1;"Document No.";Code[50])
        {
            NotBlank = true;
            TableRelation = "HR Notice Board"."No.";
        }
        field(2;"Document Description";Text[200])
        {
            NotBlank = true;
        }
        field(3;"Document Link";Text[200])
        {
        }
        field(6;"Attachment No.";Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(7;"Language Code (Default)";Code[10])
        {
            TableRelation = Language;
        }
        field(8;Attachment;Option)
        {
            Editable = false;
            OptionMembers = No,Yes;
        }
    }

    keys
    {
        key(Key1;"Document No.","Document Description")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DocLink: Record "HR Notice Board Attachments";
        NoticeBoard: Record "HR Notice Board";


    procedure PlaceFilter(prompt: Boolean;DocumentNo: Code[10]): Boolean
    begin
        if prompt then begin
        SetFilter("Document No.",DocumentNo);
        end;
    end;
}

