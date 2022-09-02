#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516036 "Export Data Sheet"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Data Sheet Lines";"Data Sheet Lines")
            {
                AutoReplace = true;
                RequestFilterFields = Employer;
                XmlName = 'ChequeImport';
                fieldelement(PayrollNo;"Data Sheet Lines"."Payroll No")
                {
                }
                fieldelement(Name;"Data Sheet Lines".Name)
                {
                }
                fieldelement(Amount;"Data Sheet Lines".Amount)
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

