#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516284 "HR Training Attendees"
{

    fields
    {
        field(1;"Application No";Code[10])
        {
        }
        field(2;"Emp No";Code[10])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.","Emp No");
                if HREmp.Find('-') then begin
                 "Emp Name":=HREmp."First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";
                 "E-mail Address":=HREmp."E-Mail";
                 "Cell Phone Number":=HREmp."Cellular Phone Number";
                 "Job Tittle":=HREmp."Job Title";
                end;
            end;
        }
        field(3;"Emp Name";Text[90])
        {
            Editable = false;
        }
        field(4;"E-mail Address";Text[60])
        {
            Editable = false;
            ExtendedDatatype = None;
        }
        field(5;"Cell Phone Number";Text[50])
        {
            Editable = false;
            ExtendedDatatype = None;
        }
        field(6;"Job Tittle";Text[50])
        {
            Editable = false;
        }
        field(7;"Line No";Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1;"Application No","Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record "HR Employees";
}

