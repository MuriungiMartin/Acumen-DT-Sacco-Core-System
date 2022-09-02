#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516015 "Import Loan Nos"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Product Deposit>Loan Analysis";"Product Deposit>Loan Analysis")
            {
                XmlName = 'Paybill';
                fieldelement(A;"Product Deposit>Loan Analysis"."Product Code")
                {
                }
                fieldelement(B;"Product Deposit>Loan Analysis"."Deposit Multiplier")
                {
                }
                fieldelement(C;"Product Deposit>Loan Analysis"."Minimum Deposit")
                {
                }
                fieldelement(D;"Product Deposit>Loan Analysis"."Minimum Share Capital")
                {
                }
                fieldelement(E;"Product Deposit>Loan Analysis"."Minimum No of Membership Month")
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

