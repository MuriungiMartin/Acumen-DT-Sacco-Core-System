#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516055 "Loan Purpose"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Tranch Disburesment Details"; "Tranch Disburesment Details")
            {
                XmlName = 'table';
                // fieldelement(A;"Loan Stages"."Loan No")
                // {
                // }
                // fieldelement(B;"Loan Stages"."Client Code")
                // {
                // }
                // fieldelement(C;"Loan Stages"."Client Name")
                // {
                // }
                // fieldelement(D;"Loan Stages"."Loan Product Type")
                // {
                // }
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

