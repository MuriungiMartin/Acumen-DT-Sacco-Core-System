tableextension 50028 "GenBatchTExt" extends "Gen. Journal Batch"
{
    fields
    {
        // Add changes to table fields here

        field(68005; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(68006; "Total Scheduled amount"; Decimal)
        {
            CalcFormula = sum("Gen. Journal Line".Amount where("Journal Template Name" = field("Journal Template Name"),
                                                                "Journal Batch Name" = field(Name)));
            FieldClass = FlowField;
        }
        field(68007; "Batch Document No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(68008; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }

    }

    var
        myInt: Integer;
}