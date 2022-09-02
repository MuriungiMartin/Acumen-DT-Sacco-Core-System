#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516012 "Import E Loan Salaries"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("E-Loan Salary Buffer";"E-Loan Salary Buffer")
            {
                XmlName = 'Paybill';
                fieldelement(A;"E-Loan Salary Buffer"."Account No")
                {
                }
                fieldelement(B;"E-Loan Salary Buffer"."Account Name")
                {
                }
                fieldelement(C;"E-Loan Salary Buffer".Amount)
                {
                }
                fieldelement(D;"E-Loan Salary Buffer"."Salary Processing Date")
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

