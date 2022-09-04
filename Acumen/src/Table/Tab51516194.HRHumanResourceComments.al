#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516194 "HR Human Resource Comments"
{

    fields
    {
        field(1; "Table Name"; Option)
        {
            OptionMembers = Employee,Relative,"Relation Management","Correspondence History",Images,"Absence and Holiday","Cost to Company","Pay History","Bank Details",Maternity,"SAQA Training History","Absence Information","Incident Report","Emp History","Medical History","Career History",Appraisal,Disciplinary,"Exit Interviews",Grievances,"Existing Qualifications","Proffesional Membership","Education Assistance","Learning Intervention","NOSA or other Training","Company Skills Plan","Development Plan","Skills Plan","Emp Salary",Unions;
        }
        field(2; "No."; Code[20])
        {
            // TableRelation = if ("Table Name"=const(Employee)) Table55681.Field1
            //                 else if ("Table Name"=const(Relative)) Table55689.Field1
            //                 else if ("Table Name"=const("Relation Management")) Table55692.Field1
            //                 else if ("Table Name"=const("Correspondence History")) Table55695.Field1
            //                 else if ("Table Name"=const(Images)) Table51516262.Field1
            //                 else if ("Table Name"=const("Absence and Holiday")) "HR Absence and Holiday"."Employee No."
            //                 else if ("Table Name"=const("Cost to Company")) Table55702.Field1
            //                 else if ("Table Name"=const("Bank Details")) Table55703.Field1
            //                 else if ("Table Name"=const(Maternity)) Table55706.Field1
            //                 else if ("Table Name"=const("SAQA Training History")) Table55707.Field1
            //                 else if ("Table Name"=const("Absence Information")) Table55716.Field1;
        }
        field(3; "Table Line No."; Integer)
        {
        }
        field(4; "Key Date"; Date)
        {
        }
        field(6; "Line No."; Integer)
        {
        }
        field(7; Date; Date)
        {
        }
        field(8; "Code"; Code[10])
        {
        }
        field(9; Comment; Text[80])
        {
        }
        field(10; User; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Table Name", "Table Line No.")
        {
            Clustered = true;
        }
        // key(Key2;'')
        // {
        //     Enabled = false;
        // }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lRec_UserTable: Record User;
    begin

        lRec_UserTable.Get(UserId);
        User := lRec_UserTable."Full Name";
        Date := WorkDate;
    end;

    trigger OnModify()
    var
        lRec_UserTable: Record User;
    begin

        lRec_UserTable.Get(UserId);
        User := lRec_UserTable."Full Name";
        Date := WorkDate;
    end;


    procedure SetUpNewLine()
    var
        HumanResCommentLine: Record "HR Human Resource Comments";
    begin
        HumanResCommentLine := Rec;
        HumanResCommentLine.SetRecfilter;
        HumanResCommentLine.SetRange("Line No.");
        if not HumanResCommentLine.Find('-') then
            Date := WorkDate;
    end;
}

