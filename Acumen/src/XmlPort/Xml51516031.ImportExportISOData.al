#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516031 "Import/Export ISO Data"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Data Sheet Header"; "Data Sheet Header")
            {
                XmlName = 'tbl';
                // fieldelement(a;"ISO-Defined Data Elements".Code)
                // {
                // }
                // fieldelement(b;"ISO-Defined Data Elements"."Period Month")
                // {
                // }
                // fieldelement(c;"ISO-Defined Data Elements"."Period Code")
                // {
                // }
                // fieldelement(d;"ISO-Defined Data Elements"."User ID")
                // {
                // }
                // fieldelement(e;"ISO-Defined Data Elements"."Total Schedule Amount")
                // {
                // }
                // fieldelement(f;"ISO-Defined Data Elements"."Total Schedule Amount P")
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

