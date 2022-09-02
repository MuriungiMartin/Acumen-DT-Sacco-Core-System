#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516180 "HR Job Occupations"
{

    fields
    {
        field(2;"Employee No.";Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                                HREmp.Get("Employee No.");

                                CalcFields("First Name");
                                CalcFields("Middle Name");
                                CalcFields("Last Name");
                                Email:=HREmp."E-Mail";
                                "Date of Join":=  HREmp."Date Of Joining the Company";
                                HREmp."Job Title":="Job Id";
                                HREmp.Validate(HREmp."Job Title");
                                HREmp.Modify;
            end;
        }
        field(3;"First Name";Text[30])
        {
            CalcFormula = lookup("HR Employees"."First Name" where ("No."=field("Employee No.")));
            FieldClass = FlowField;
        }
        field(4;"Middle Name";Text[30])
        {
            CalcFormula = lookup("HR Employees"."Middle Name" where ("No."=field("Employee No.")));
            FieldClass = FlowField;
        }
        field(5;"Last Name";Text[30])
        {
            CalcFormula = lookup("HR Employees"."Last Name" where ("No."=field("Employee No.")));
            FieldClass = FlowField;
        }
        field(6;Extension;Text[30])
        {
            FieldClass = Normal;
        }
        field(7;Email;Text[30])
        {
            FieldClass = Normal;
        }
        field(8;"Date of Join";Date)
        {
            FieldClass = Normal;
        }
        field(9;Department;Code[20])
        {
            FieldClass = Normal;
        }
        field(55;"Job Desc";Text[50])
        {
            CalcFormula = lookup(Table55622.Field2 where (Field1=field("Job Id")));
            FieldClass = FlowField;
        }
        field(56;"Job Id";Code[100])
        {
            TableRelation = "Vendor Invoice Disc."."Service Charge";
        }
    }

    keys
    {
        key(Key1;"Job Id","Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record "HR Employees";
        HRJobs: Record test;
}

