#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516014 "Import Journals"
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
                fieldelement(DS;"Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(B;"Gen. Journal Line"."Line No.")
                {
                }
                fieldelement(C;"Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(D;"Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(E;"Gen. Journal Line"."Transaction Type")
                {
                }
                fieldelement(F;"Gen. Journal Line"."Account Type")
                {
                }
                fieldelement(G;"Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(H;"Gen. Journal Line".Description)
                {
                }
                fieldelement(J;"Gen. Journal Line".Amount)
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

