#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516468 "Cue Sacco Roles"
{

    fields
    {
        field(1;"Primary Key";Code[10])
        {
        }
        field(2;"Application Loans";Integer)
        {
            CalcFormula = count("Loans Register" where ("Loan Status"=const(Application),
                                                        Posted=const(false)));
            FieldClass = FlowField;
        }
        field(3;"Appraisal Loans";Integer)
        {
            CalcFormula = count("Loans Register" where ("Loan Status"=const(Appraisal),
                                                        Posted=const(false)));
            FieldClass = FlowField;
        }
        field(4;"Approved Loans";Integer)
        {
            CalcFormula = count("Loans Register" where ("Loan Status"=const(Approved),
                                                        Posted=const(false)));
            FieldClass = FlowField;
        }
        field(5;"Rejected Loans";Integer)
        {
            CalcFormula = count("Loans Register" where ("Approval Status"=const(Rejected),
                                                        Posted=const(false)));
            FieldClass = FlowField;
        }
        field(6;"Pending Account Opening";Integer)
        {
            CalcFormula = count("Membership Applications" where (Status=const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(7;"Approved Accounts Opening";Integer)
        {
            CalcFormula = count("Membership Applications" where (Status=const(Approved)));
            FieldClass = FlowField;
        }
        field(8;"Pending Loan Batches";Integer)
        {
            CalcFormula = count("Loan Disburesment-Batching" where (Status=const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(9;"Approved Loan Batches";Integer)
        {
            CalcFormula = count("Loan Disburesment-Batching" where (Status=const(Approved),
                                                                    Posted=filter(false)));
            FieldClass = FlowField;
        }
        field(10;"Pending Payment Voucher";Integer)
        {
            FieldClass = Normal;
        }
        field(11;"Approved Payment Voucher";Integer)
        {
        }
        field(12;"Pending Petty Cash";Integer)
        {
        }
        field(13;"Approved  Petty Cash";Integer)
        {
            FieldClass = Normal;
        }
        field(14;"Open Account Opening";Integer)
        {
            CalcFormula = count("Membership Applications" where (Status=const(Open)));
            FieldClass = FlowField;
        }
        field(20;"Date Filter";Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21;"Date Filter2";Date)
        {
            Caption = 'Date Filter2';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(22;"Open Member Applications";Integer)
        {
            CalcFormula = count("Membership Applications" where (Status=const(Open)));
            FieldClass = FlowField;
        }
        field(23;"Pending Member Applications";Integer)
        {
            CalcFormula = count("Membership Applications" where (Status=const("Pending Approval")));
            FieldClass = FlowField;
        }
        field(24;"Rejected Member Applications";Integer)
        {
            CalcFormula = count("Membership Applications" where (Status=const(Rejected)));
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

