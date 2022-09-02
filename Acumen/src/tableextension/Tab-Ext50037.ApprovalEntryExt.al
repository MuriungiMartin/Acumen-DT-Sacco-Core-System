tableextension 50037 "ApprovalEntryExt" extends "Approval Entry"
{
    fields
    {
        // Add changes to table fields here
        field(33; "First Modified By User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "First Modified On"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}