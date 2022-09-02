#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516204 "HR Exit Interview Checklist"
{

    fields
    {
        field(1;"Exit Interview No";Code[10])
        {
            TableRelation = "HR Employee Exit Interviews"."Exit Interview No";
        }
        field(2;"Clearance Date";Date)
        {
            Editable = false;
        }
        field(3;"CheckList Item";Text[80])
        {
            TableRelation = "HR Lookup Values".Code where (Type=const("Checklist Item"));
        }
        field(4;Cleared;Boolean)
        {

            trigger OnValidate()
            begin
                "Cleared By":=UserId;


                if Cleared then
                "Clearance Date":=Today
                else
                "Clearance Date":=0D;
            end;
        }
        field(9;"Cleared By";Code[20])
        {
        }
        field(11;"Line No";Integer)
        {
            AutoIncrement = false;
        }
        field(12;"Employee No";Code[50])
        {
            TableRelation = "HR Employees"."No.";
        }
    }

    keys
    {
        key(Key1;"Exit Interview No","Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

