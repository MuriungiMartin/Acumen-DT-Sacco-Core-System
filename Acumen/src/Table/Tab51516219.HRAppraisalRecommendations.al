#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516219 "HR Appraisal Recommendations"
{

    fields
    {
        field(1;"Line No";Integer)
        {
            AutoIncrement = true;
        }
        field(2;"Appraisal No";Code[30])
        {
            TableRelation = "HR Appraisal Header"."Appraisal No";
        }
        field(3;"Appraisal Period";Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code where (Type=filter("Appraisal Period"),
                                                           "Current Appraisal Period"=const(true));
        }
        field(4;"Employee No";Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Employees";
        }
        field(5;Sections;Option)
        {
            OptionCaption = 'Objectives,Core Responsibilities/Duties,Last year''s goals,Things learnt From Training,Value Added From Training,Attendance&Punctuality,Communication,Cooperation,Internal/External Clients,Initiative,Planning & Organization,Quality,Team Work,Sales Skills,Leadership,Performance Coaching';
            OptionMembers = Objectives,"Core Responsibilities/Duties","Last year's goals","Things learnt From Training","Value Added From Training","Attendance&Punctuality",Communication,Cooperation,"Internal/External Clients",Initiative,"Planning & Organization",Quality,"Team Work","Sales Skills",Leadership,"Performance Coaching";
        }
        field(6;"Perfomance Goals and Targets";Text[250])
        {
        }
        field(10;test;Code[10])
        {
        }
    }

    keys
    {
        key(Key1;"Line No","Appraisal No","Appraisal Period","Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HRLookupValues: Record "HR Lookup Values";
        TotalScore: Integer;
        HRAppEvaluationAreas: Record "HR Appraisal Eval Areas";
}

