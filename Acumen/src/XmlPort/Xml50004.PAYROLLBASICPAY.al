#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50004 "PAYROLL BASIC PAY"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Payroll Employee.";"Payroll Employee.")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(Mobile_No;"Payroll Employee."."No.")
                {
                }
                fieldelement(a;"Payroll Employee."."Basic Pay")
                {
                }
                fieldelement(CC;"Payroll Employee."."Payment Mode")
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

