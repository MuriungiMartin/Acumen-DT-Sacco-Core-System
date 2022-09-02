#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50000 "FIXED ASSETS 2017"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Fixed Asset";"Fixed Asset")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(Mobile_No;"Fixed Asset"."No.")
                {
                }
                fieldelement(aa;"Fixed Asset".Description)
                {
                }
                fieldelement(a;"Fixed Asset"."FA Posting Group")
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

