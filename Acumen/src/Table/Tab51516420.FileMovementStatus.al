#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516420 "File Movement Status"
{

    fields
    {
        field(1; "User ID"; Code[30])
        {
            TableRelation = "User Setup";

            trigger OnValidate()
            var
                UserMgt: Codeunit UserManagementCUExt;
                User: Record User;
            begin
                UserMgt.ValidateUserName(User, User, "User ID");
            end;
        }
        field(2; "Section ID"; Integer)
        {
            NotBlank = false;
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));

            trigger OnValidate()
            begin
                approvalsetup.Reset;
                approvalsetup.SetRange(approvalsetup.Stage, "Section ID");
                if approvalsetup.Find('-') then begin
                    Description := approvalsetup.Description;

                end;
            end;
        }
        field(3; Description; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        approvalsetup: Record "Approvals Set Up";
}

