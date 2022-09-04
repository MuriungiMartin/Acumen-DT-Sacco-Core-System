#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516171 "HR 360 Appraisal Eval Areas"
{
    // DrillDownPageID = UnknownPage55666;
    // LookupPageID = UnknownPage55666;

    fields
    {
        field(1;"Line No.";Integer)
        {
            AutoIncrement = true;
        }
        field(2;"Categorize As";Option)
        {
            OptionCaption = ' ,Employee''s Subordinates,Employee''s Peers,External Sources,Job Specific,Self Evaluation';
            OptionMembers = " ","Employee's Subordinates","Employee's Peers","External Sources","Job Specific","Self Evaluation";
        }
        field(3;"Code";Code[20])
        {
        }
        field(4;Description;Text[100])
        {
        }
        field(5;"Appraisal Period";Code[20])
        {
            TableRelation = "HR Lookup Values".Code where (Type=const("Appraisal Type"),
                                                           Closed=const(false));
        }
    }

    keys
    {
        key(Key1;"Line No.","Categorize As")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

