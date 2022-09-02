#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50008 "General journals Importation"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Gen. Journal Line";"Gen. Journal Line")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(Mobile_No;"Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(a;"Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(cc;"Gen. Journal Line"."Line No.")
                {
                }
                fieldelement(aaa;"Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(zx;"Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(xs;"Gen. Journal Line"."Account Type")
                {
                }
                fieldelement(x;"Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(d;"Gen. Journal Line".Description)
                {
                }
                fieldelement(x;"Gen. Journal Line".Amount)
                {
                }
                fieldelement(f;"Gen. Journal Line"."Depreciation Book Code")
                {
                }
                fieldelement(x;"Gen. Journal Line"."FA Posting Type")
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

