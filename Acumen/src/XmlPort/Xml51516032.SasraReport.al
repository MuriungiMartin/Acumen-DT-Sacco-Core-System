#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516032 "Sasra Report"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Acc. Schedule Line";"Acc. Schedule Line")
            {
                XmlName = 'Paybill';
                fieldelement(No;"Acc. Schedule Line"."Schedule Name")
                {
                }
                fieldelement(Mobile_No;"Acc. Schedule Line"."Line No.")
                {
                }
                fieldelement(a;"Acc. Schedule Line"."Row No.")
                {
                }
                fieldelement(r;"Acc. Schedule Line".Description)
                {
                }
                fieldelement(e;"Acc. Schedule Line"."Totaling Type")
                {
                }
                fieldelement(y;"Acc. Schedule Line".Show)
                {
                }
                fieldelement(t;"Acc. Schedule Line".Totaling)
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

