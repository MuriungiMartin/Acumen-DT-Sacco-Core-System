tableextension 50022 "SMtpSetupEXT" extends "SMTP Mail Setup"
{
    fields
    {
        // Add changes to table fields here
        field(51516001; "Path to Save Report"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(51516002; "Email Sender Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51516003; "Email Sender Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}