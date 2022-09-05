#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516025 "Import FOSA Charges"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Images Buffer"; "Images Buffer")
            {
                XmlName = 'ChequeImport';
                // fieldelement(No;"Member Import Buffer".No)
                // {
                // }
                // fieldelement(Date;"Member Import Buffer"."FOSA No")
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

