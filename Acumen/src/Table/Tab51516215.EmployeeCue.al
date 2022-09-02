#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516215 "Employee Cue"
{
    Caption = 'Finance Cue';

    fields
    {
        field(1;"Primary Key";Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2;"Leaves Pending Approvals";Integer)
        {
            CalcFormula = count("HR Leave Application" where ("User ID"=filter('USER ID'),
                                                              Status=filter("Pending Approval")));
            Caption = 'Overdue Sales Documents';
            FieldClass = FlowField;
        }
        field(22;"New Incoming Documents";Integer)
        {
            CalcFormula = count("Incoming Document" where (Status=const(New)));
            Caption = 'New Incoming Documents';
            FieldClass = FlowField;
        }
        field(23;"Approved Incoming Documents";Integer)
        {
            CalcFormula = count("Incoming Document" where (Status=const(Released)));
            Caption = 'Approved Incoming Documents';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

