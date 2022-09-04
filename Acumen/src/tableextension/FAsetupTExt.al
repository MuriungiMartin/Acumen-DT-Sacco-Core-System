tableextension 50194 FasetupExt extends "FA Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "FA Transfer Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
    }

    var
        myInt: Integer;
}