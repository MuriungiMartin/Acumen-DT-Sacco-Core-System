#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516056 "Import BD Trainees"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("CRM Traineees";"CRM Traineees")
            {
                XmlName = 'table';
                fieldelement(A;"CRM Traineees"."Training Code")
                {
                }
                fieldelement(B;"CRM Traineees"."Member No")
                {
                }
                fieldelement(C;"CRM Traineees"."Member ID No")
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

