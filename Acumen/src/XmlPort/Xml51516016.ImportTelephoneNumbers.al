#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516016 "Import Telephone Numbers"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Bulk SMS Header";"Bulk SMS Header")
            {
                XmlName = 'Paybill';
                fieldelement(A;"Bulk SMS Header".No)
                {
                }
                fieldelement(B;"Bulk SMS Header"."Date Entered")
                {
                }
                fieldelement(C;"Bulk SMS Header"."Time Entered")
                {
                }
                fieldelement(D;"Bulk SMS Header"."Entered By")
                {
                }
                fieldelement(E;"Bulk SMS Header"."SMS Type")
                {
                }
                fieldelement(xxc;"Bulk SMS Header"."SMS Status")
                {
                }
                fieldelement(vgb;"Bulk SMS Header"."Status Date")
                {
                }
                fieldelement(FG;"Bulk SMS Header"."Status Time")
                {
                }
                fieldelement(I;"Bulk SMS Header"."Status By")
                {
                }
                fieldelement(J;"Bulk SMS Header".Message)
                {
                }
                fieldelement(XXX;"Bulk SMS Header"."No. Series")
                {
                }
                fieldelement(cc;"Bulk SMS Header"."Use Line Message")
                {
                }
                fieldelement(vv;"Bulk SMS Header".Status)
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

