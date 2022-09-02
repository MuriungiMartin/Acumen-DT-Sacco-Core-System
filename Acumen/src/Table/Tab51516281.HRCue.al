#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516281 "HR Cue"
{
    Caption = 'HR Cue';

    fields
    {
        field(1;"Primary Key";Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2;"Overdue Sales Documents";Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where ("Document Type"=filter(Invoice|"Credit Memo"),
                                                            "Due Date"=field("Overdue Date Filter"),
                                                            Open=const(true)));
            Caption = 'Overdue Sales Documents';
            FieldClass = FlowField;
        }
        field(3;"Purchase Invoices Due Today";Integer)
        {
            CalcFormula = count("Vendor Ledger Entry" where ("Document Type"=filter(Invoice|"Credit Memo"),
                                                             "Due Date"=field("Due Date Filter"),
                                                             Open=const(true)));
            Caption = 'Purchase Invoices Due Today';
            FieldClass = FlowField;
        }
        field(4;"POs Pending Approval";Integer)
        {
            CalcFormula = count("Purchase Header" where ("Document Type"=const(Order),
                                                         Status=filter("Pending Approval")));
            Caption = 'POs Pending Approval';
            FieldClass = FlowField;
        }
        field(5;"SOs Pending Approval";Integer)
        {
            CalcFormula = count("Sales Header" where ("Document Type"=const(Order),
                                                      Status=filter("Pending Approval")));
            Caption = 'SOs Pending Approval';
            FieldClass = FlowField;
        }
        field(6;"Approved Sales Orders";Integer)
        {
            CalcFormula = count("Sales Header" where ("Document Type"=const(Order),
                                                      Status=filter(Released|"Pending Prepayment")));
            Caption = 'Approved Sales Orders';
            FieldClass = FlowField;
        }
        field(7;"Approved Purchase Orders";Integer)
        {
            CalcFormula = count("Purchase Header" where ("Document Type"=const(Order),
                                                         Status=filter(Released|"Pending Prepayment")));
            Caption = 'Approved Purchase Orders';
            FieldClass = FlowField;
        }
        field(8;"Vendors - Payment on Hold";Integer)
        {
            CalcFormula = count(Vendor where (Blocked=filter(Payment)));
            Caption = 'Vendors - Payment on Hold';
            FieldClass = FlowField;
        }
        field(9;"Purchase Return Orders";Integer)
        {
            CalcFormula = count("Purchase Header" where ("Document Type"=const("Return Order")));
            Caption = 'Purchase Return Orders';
            FieldClass = FlowField;
        }
        field(10;"Sales Return Orders - All";Integer)
        {
            CalcFormula = count("Sales Header" where ("Document Type"=const("Return Order")));
            Caption = 'Sales Return Orders - All';
            FieldClass = FlowField;
        }
        field(11;"Employee -Active";Integer)
        {
            CalcFormula = count("HR Employees" where (Status=filter(Active)));
            Caption = 'Customers - Blocked';
            FieldClass = FlowField;
        }
        field(20;"Due Date Filter";Date)
        {
            Caption = 'Due Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21;"Overdue Date Filter";Date)
        {
            Caption = 'Overdue Date Filter';
            FieldClass = FlowFilter;
        }
        field(22;"New Incoming Documents";Integer)
        {
            CalcFormula = count("Incoming Document" where (Status=const(New)));
            Caption = 'New Incoming Documents';
            FieldClass = FlowField;
        }
        field(23;"Approved Incoming Documents";Integer)
        {
            Caption = 'Approved Incoming Documents';
            FieldClass = Normal;
        }
        field(24;"Leaves To be Approved";Integer)
        {
        }
        field(25;"Employee Requisitions";Integer)
        {
            CalcFormula = count("HR Employee Requisitions");
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

