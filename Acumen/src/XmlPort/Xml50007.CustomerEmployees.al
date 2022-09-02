#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50007 "Customer Employees"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Customer;Customer)
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(Mobile_No;Customer."No.")
                {
                }
                fieldelement(a;Customer.Name)
                {
                }
                fieldelement(cc;Customer."Customer Posting Group")
                {
                }
                fieldelement(aaa;Customer."Gen. Bus. Posting Group")
                {
                }
                fieldelement(azs;Customer."VAT Bus. Posting Group")
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

