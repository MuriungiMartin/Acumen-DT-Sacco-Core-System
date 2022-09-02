#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516050 "Bank Statement Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Bank Statement Buffer";"Bank Statement Buffer")
            {
                XmlName = 'table';
                fieldelement(LineNo;"Bank Statement Buffer".LineNo)
                {
                }
                fieldelement(RefNo;"Bank Statement Buffer"."Ref No")
                {
                }
                fieldelement(Date;"Bank Statement Buffer".Date)
                {
                }
                fieldelement(Desc;"Bank Statement Buffer".Description)
                {
                }
                fieldelement(Amount;"Bank Statement Buffer".Amount)
                {
                }
                fieldelement(Bank;"Bank Statement Buffer".Bank)
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

