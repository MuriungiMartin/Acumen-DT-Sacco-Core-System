#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50009 "New Vendor Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Vendor;Vendor)
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(Mobile_No;Vendor."No.")
                {
                }
                fieldelement(a;Vendor.Name)
                {
                }
                fieldelement(cc;Vendor."Vendor Posting Group")
                {
                }
                fieldelement(aaa;Vendor."Gen. Bus. Posting Group")
                {
                }
                fieldelement(zx;Vendor."VAT Bus. Posting Group")
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

