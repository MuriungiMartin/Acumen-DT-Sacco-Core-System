#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516176 "HR Job Responsiblities"
{
    // DrillDownPageID = UnknownPage55564;
    // LookupPageID = UnknownPage55564;

    fields
    {
        field(2; "Job ID"; Code[50])
        {
            TableRelation = "HR Jobss"."Job ID";
        }
        field(3; "Responsibility Description"; Text[250])
        {
        }
        field(4; Remarks; Text[150])
        {
        }
        field(5; "Responsibility Code"; Code[20])
        {

            trigger OnValidate()
            begin
                HRAppEvalArea.Reset;
                HRAppEvalArea.SetRange(HRAppEvalArea."Assign To", "Responsibility Code");
                if HRAppEvalArea.Find('-') then begin
                    "Responsibility Description" := HRAppEvalArea.Code;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Job ID", "Responsibility Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HRAppEvalArea: Record "HR Appraisal Eval Areas";
}

