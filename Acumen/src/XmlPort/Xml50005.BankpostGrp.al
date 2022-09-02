#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50005 "Bank post Grp"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Bank Account Posting Group";"Bank Account Posting Group")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(Mobile_No;"Bank Account Posting Group".Code)
                {
                }
                fieldelement(a;"Bank Account Posting Group"."G/L Bank Account No.")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

