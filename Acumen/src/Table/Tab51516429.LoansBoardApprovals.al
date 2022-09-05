#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516429 "Loans Board Approvals"
{

    fields
    {
        field(1; "Loan No."; Code[13])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Committee Member No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where(colleges = const('1'));
        }
        field(3; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Approved,Rejected';
            OptionMembers = "  ",Approved,Rejected;
        }
        field(4; Comments; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Action Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

