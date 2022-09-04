#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516186 "HR Lookup Values"
{
    LookupPageID = "HR Lookup Values List";

    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = 'Religion,Language,Medical Scheme,Location,Contract Type,Qualification Type,Stages,Scores,Institution,Appraisal Type,Appraisal Period,Urgency,Succession,Security,Disciplinary Case Rating,Disciplinary Case,Disciplinary Action,Next of Kin,Country,Grade,Checklist Item,Appraisal Sub Category,Appraisal Group Item,Transport Type,Grievance Cause,Grievance Outcome,Appraiser Recommendation';
            OptionMembers = Religion,Language,"Medical Scheme",Location,"Contract Type","Qualification Type",Stages,Scores,Institution,"Appraisal Type","Appraisal Period",Urgency,Succession,Security,"Disciplinary Case Rating","Disciplinary Case","Disciplinary Action","Next of Kin",Country,Grade,"Checklist Item","Appraisal Sub Category","Appraisal Group Item","Transport Type","Grievance Cause","Grievance Outcome","Appraiser Recom";
        }
        field(2; "Code"; Code[70])
        {
        }
        field(3; Description; Text[80])
        {
        }
        field(4; Remarks; Text[250])
        {
        }
        field(5; "Notice Period"; Date)
        {
        }
        field(6; Closed; Boolean)
        {

            trigger OnValidate()
            begin
                "Last Date Modified" := Today;
            end;
        }
        field(7; "Contract Length"; Integer)
        {
        }
        field(8; "Current Appraisal Period"; Boolean)
        {
        }
        field(9; "Disciplinary Case Rating"; Text[30])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Disciplinary Case Rating"));
        }
        field(10; "Disciplinary Action"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Disciplinary Action"));
        }
        field(14; From; Date)
        {
        }
        field(15; "To"; Date)
        {
        }
        field(16; Score; Decimal)
        {
        }
        field(17; "Basic Salary"; Decimal)
        {
        }
        field(18; "To be cleared by"; Code[10])
        {
            TableRelation = "HR Lookup Values".Remarks;
        }
        field(19; "Last Date Modified"; Date)
        {
        }
        field(20; "Supervisor Only"; Boolean)
        {
        }
        field(21; "Appraisal Stage"; Option)
        {
            OptionMembers = "Target Setting",FirstQuarter,SecondQuarter,ThirdQuarter,EndYearEvaluation;
        }
        field(22; "Previous Appraisal Code"; Code[70])
        {
        }
    }

    keys
    {
        key(Key1; Type, "Code", Description)
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Type = Type::"Appraisal Period" then begin
            HrLookupValues.Reset;
            HrLookupValues.SetRange(HrLookupValues.Type, HrLookupValues.Type::"Appraisal Period");
            HrLookupValues.SetRange(HrLookupValues.Closed, false);
            if HrLookupValues.FindFirst then
                Error('Close the Appraisal Period %1', HrLookupValues.Code);
        end
    end;

    var
        HrLookupValues: Record "HR Lookup Values";
}

