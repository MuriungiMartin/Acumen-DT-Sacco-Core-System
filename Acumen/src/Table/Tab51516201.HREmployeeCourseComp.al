#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516201 "HR Employee Course Comp."
{

    fields
    {
        field(1;"Employee No.";Code[20])
        {

            trigger OnValidate()
            begin
                      OK:= Employee.Get("Employee No.");
                      if OK then begin
                      // "Employee First Name":= Employee."Known As";
                       "Employee Last Name":= Employee."Last Name";
                      end;
            end;
        }
        field(2;"Product Name";Code[30])
        {
        }
        field(3;"Date Acredited";Date)
        {
        }
        field(4;"Apply To Employee";Boolean)
        {
        }
        field(5;"Employee First Name";Text[30])
        {
        }
        field(6;"Employee Last Name";Text[30])
        {
        }
        field(7;"Product Description";Text[170])
        {
        }
        field(8;"Class Code";Text[30])
        {
        }
        field(9;Department;Code[10])
        {
        }
        field(10;Office;Code[10])
        {
        }
    }

    keys
    {
        key(Key1;"Employee No.","Product Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
              OK:= Employee.Get("Employee No.");
              if OK then begin
              // "Employee First Name":= Employee."Known As";
               "Employee Last Name":= Employee."Last Name";
              end;
    end;

    var
        Employee: Record "HR Employees";
        OK: Boolean;
}

