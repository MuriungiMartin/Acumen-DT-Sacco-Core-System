#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516054 "Politicaly Exposed Indi Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Politically Exposed Persons";"Politically Exposed Persons")
            {
                XmlName = 'table';
                fieldelement(A;"Politically Exposed Persons".Code)
                {
                }
                fieldelement(B;"Politically Exposed Persons".Name)
                {
                }
                fieldelement(C;"Politically Exposed Persons"."County Code")
                {
                }
                fieldelement(D;"Politically Exposed Persons"."County Name")
                {
                }
                fieldelement(E;"Politically Exposed Persons"."Position Runing For")
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

