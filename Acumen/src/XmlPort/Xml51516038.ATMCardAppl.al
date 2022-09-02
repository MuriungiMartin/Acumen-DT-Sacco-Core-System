#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516038 "ATM Card Appl"
{
    Format = VariableText;

    schema
    {
        textelement(ATMCardAppl)
        {
            tableelement("ATM Card Applications";"ATM Card Applications")
            {
                XmlName = 'ATMCardApp';
                fieldelement(A;"ATM Card Applications"."Account No")
                {
                }
                fieldelement(B;"ATM Card Applications"."Account Name")
                {
                }
                fieldelement(C;"ATM Card Applications"."Request Type")
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

    var
        ObjATMApp: Record "ATM Card Applications";
}

