#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50006 "Banks list"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Bank Account";"Bank Account")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(Mobile_No;"Bank Account"."No.")
                {
                }
                fieldelement(a;"Bank Account".Name)
                {
                }
                fieldelement(cc;"Bank Account"."Bank Acc. Posting Group")
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

