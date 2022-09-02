#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516469 "Cue Sacco Roles Fosa"
{

    fields
    {
        field(1;"Primary Key";Code[10])
        {
        }
        field(2;"Application Loans";Integer)
        {
            FieldClass = FlowField;
        }
        field(3;"Appraisal Loans";Integer)
        {
            FieldClass = FlowField;
        }
        field(4;"Approved Loans";Integer)
        {
            FieldClass = FlowField;
        }
        field(5;"Rejected Loans";Integer)
        {
            FieldClass = FlowField;
        }
        field(6;"Pending Account Opening";Integer)
        {
            FieldClass = FlowField;
        }
        field(7;"Approved Accounts Opening";Integer)
        {
            FieldClass = FlowField;
        }
        field(8;"Pending Loan Batches";Integer)
        {
            FieldClass = FlowField;
        }
        field(9;"Approved Loan Batches";Integer)
        {
            FieldClass = FlowField;
        }
        field(10;"Pending Payment Voucher";Integer)
        {
            Enabled = false;
            FieldClass = FlowField;
        }
        field(11;"Approved Payment Voucher";Integer)
        {
            Enabled = false;
            FieldClass = FlowField;
        }
        field(12;"Pending Petty Cash";Integer)
        {
            Enabled = false;
            FieldClass = FlowField;
        }
        field(13;"Approved  Petty Cash";Integer)
        {
            Enabled = false;
            FieldClass = FlowField;
        }
        field(14;"Open Account Opening";Integer)
        {
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
        field(22;"Pending Standing Orders";Integer)
        {
            FieldClass = FlowField;
        }
        field(23;"Approved Standing Orders";Integer)
        {
            FieldClass = FlowField;
        }
        field(24;"Unbanked Cheques";Integer)
        {
            FieldClass = FlowField;
        }
        field(25;"Uncreated Approved Accounts";Integer)
        {
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

