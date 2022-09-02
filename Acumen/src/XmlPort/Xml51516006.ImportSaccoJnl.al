#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516006 "Import Sacco Jnl"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Gen. Journal Line";"Gen. Journal Line")
            {
                XmlName = 'Paybill';
                fieldelement(A;"Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(B;"Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(C;"Gen. Journal Line"."Line No.")
                {
                }
                fieldelement(E;"Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(D;"Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(G;"Gen. Journal Line"."Transaction Type")
                {
                }
                fieldelement(H;"Gen. Journal Line"."Account Type")
                {
                }
                fieldelement(I;"Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(K;"Gen. Journal Line".Amount)
                {
                }
                fieldelement(J;"Gen. Journal Line".Description)
                {
                }
                fieldelement(m;"Gen. Journal Line"."Bal. Account Type")
                {
                }
                fieldelement(k;"Gen. Journal Line"."Bal. Account No.")
                {
                }
                fieldelement(N;"Gen. Journal Line"."Loan No")
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

