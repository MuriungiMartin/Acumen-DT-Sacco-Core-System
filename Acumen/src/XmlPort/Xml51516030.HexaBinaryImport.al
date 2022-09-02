#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516030 "Hexa Binary Import"
{
    Format = VariableText;

    schema
    {
        textelement(aa)
        {
            XmlName = 'HexaBinary';
            tableelement(SaccoLinkCharges;SaccoLinkCharges)
            {
                XmlName = 'HexaBinary';
                fieldelement(Header;"Hexa Binary".Field1)
                {
                }
                fieldelement(No;"Hexa Binary".Field2)
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

