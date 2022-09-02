#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516094 "Mobile Loans"
{

    fields
    {
        field(1;"Document No";Code[20])
        {
        }
        field(2;"Document Date";Date)
        {
        }
        field(3;"Loan Amount";Decimal)
        {
        }
        field(4;"Batch No";Code[20])
        {
        }
        field(5;"Date Entered";Date)
        {
        }
        field(6;"Time Entered";Time)
        {
        }
        field(7;"Entered By";Code[20])
        {
        }
        field(8;"Sent To Server";Option)
        {
            OptionMembers = No,Yes;
        }
        field(9;"Date Sent To Server";Date)
        {
        }
        field(10;"Time Sent To Server";Time)
        {
        }
        field(11;"Account No";Code[20])
        {
        }
        field(12;"Member No";Code[20])
        {
        }
        field(13;"Telephone No";Code[20])
        {
        }
        field(14;"Corporate No";Code[10])
        {
        }
        field(15;"Delivery Center";Code[10])
        {
        }
        field(16;"Customer Name";Text[150])
        {
        }
        field(17;Purpose;Text[250])
        {
            CalcFormula = lookup("Imprest Header".Purpose where ("No."=field("Document No")));
            FieldClass = FlowField;
        }
        field(18;"MPESA Doc No.";Code[30])
        {
        }
        field(19;Comments;Text[250])
        {
        }
        field(20;Status;Option)
        {
            OptionCaption = 'Pending,Completed,Failed,Waiting';
            OptionMembers = Pending,Completed,Failed,Waiting;
        }
        field(21;"Entry No";Integer)
        {
            AutoIncrement = true;
        }
        field(22;"Ist Notification";Boolean)
        {
        }
        field(23;"2nd Notification";Boolean)
        {
        }
        field(24;"3rd Notification";Boolean)
        {
        }
        field(25;"Penalty Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26;"4th Notification";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27;"5th Notification";Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR('You cannot delete M-KAHAWA transactions.');
    end;

    var
        ObjCustomers: Record Customer;
}

