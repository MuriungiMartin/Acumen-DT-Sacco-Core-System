tableextension 50032 "CompanyinfoExt" extends "Company Information"
{
    fields
    {
        // Add changes to table fields here
        field(8001; Letter_Head; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(8002; Motto; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}