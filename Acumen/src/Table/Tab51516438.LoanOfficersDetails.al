#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516438 "Loan Officers Details"
{

    fields
    {
        field(1;"Code";Code[10])
        {
        }
        field(2;"Sales Code";Code[10])
        {
            TableRelation = if ("Sales Code Type"=const(Staff)) "HR Employees"
                            else if ("Sales Code Type"=const(Others)) "Member Register";

            trigger OnValidate()
            begin

                 Name:='';
                 if "Sales Code Type" in ["sales code type"::Staff,"sales code type"::Delegate,"sales code type"::"Board Member",
                 "sales code type"::"Direct Marketers","sales code type"::Others]   then

                case "Sales Code Type"  of
                "sales code type"::Staff:
                begin
                HR.Get("Sales Code Type");
                Name:=HR."First Name";
                end;

                "sales code type"::Delegate:
                  begin
                  Cust.Get("Sales Code Type");
                  Name:=Cust.Name;
                  end;

                "sales code type"::"Board Member":
                begin
                Cust.Get("Sales Code Type");
                Name:=Cust.Name;
                end;
                end;
            end;
        }
        field(3;Name;Code[10])
        {
        }
        field(4;"Sales Code Type";Option)
        {
            OptionCaption = ' ,Staff,Delegate,Board Member,Direct Marketers,Others';
            OptionMembers = " ",Staff,Delegate,"Board Member","Direct Marketers",Others;
        }
        field(5;"Savings Target";Decimal)
        {
        }
        field(6;"Membership Target";Decimal)
        {
        }
        field(7;"Disbursement Target";Decimal)
        {
        }
        field(8;"Payment Target";Decimal)
        {
        }
        field(9;"Exit Target";Code[10])
        {
        }
        field(10;Status;Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(11;Created;Boolean)
        {
            Editable = false;
        }
        field(12;"Account Type";Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'Staff,Customer,Vendor,Member,None';
            OptionMembers = Staff,Customer,Vendor,Member,"None";
        }
        field(13;"Account No.";Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type"=const(Staff)) "HR Employees"
                            else if ("Account Type"=const(Customer)) Customer
                            else if ("Account Type"=const(Member)) "Member Register"
                            else if ("Account Type"=const(Vendor)) Vendor;

            trigger OnValidate()
            begin


                "Account Name":='';

                if "Account Type" in ["account type"::Customer,"account type"::Vendor,"account type"::Member,"account type"::Staff] then

                case "Account Type" of

                  "account type"::Customer:
                    begin
                      Cust.Get("Account No.");
                      "Account Name":=Cust.Name;
                    end;

                //Member
                  "account type"::Member:
                    begin
                      Mem.Get("Account No.");
                      "Account Name":=Mem.Name;
                    end;

                  "account type"::Staff:
                    begin
                      HR.Get("Account No.");
                      "Account Name":=HR.FullName;
                    end;


                  "account type"::Vendor:
                    begin
                      Vend.Get("Account No.");
                      "Account Name":=Vend.Name;
                    end;
                end;
            end;
        }
        field(14;"Account Name";Text[30])
        {
            Editable = true;
        }
        field(15;"Currency Code";Code[10])
        {
        }
        field(16;Branch;Code[10])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(17;"Group Target";Code[10])
        {
        }
        field(18;"Staff Status";Option)
        {
            Editable = false;
            OptionCaption = 'Active,Resigned,Discharged,Retrenched,Pension,Disabled';
            OptionMembers = Active,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
        field(19;"No. of Loans";Code[20])
        {
        }
        field(20;"Member Target";Code[10])
        {
        }
    }

    keys
    {
        key(Key1;"Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Account Name")
        {
        }
    }

    var
        HR: Record "HR Employees";
        Custs: Record "Member Register";
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        Mem: Record "Member Register";
}

