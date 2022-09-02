#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516005 "Import Fosa Accounts"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Vendor;Vendor)
            {
                AutoReplace = true;
                XmlName = 'Paybill';
                fieldelement(A;Vendor."No.")
                {
                }
                fieldelement(B;Vendor."BOSA Account No")
                {
                }
                fieldelement(c;Vendor.Name)
                {
                }
                fieldelement(D;Vendor."Account Type")
                {
                }
                fieldelement(F;Vendor."Phone No.")
                {
                }
                fieldelement(G;Vendor."Creditor Type")
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

