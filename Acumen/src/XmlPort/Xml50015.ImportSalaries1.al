#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50015 "Import Salaries1"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Salary Processing Lines";"Salary Processing Lines")
            {
                AutoReplace = true;
                XmlName = 'SalaryImport';
                fieldelement(Header;"Salary Processing Lines"."Salary Header No.")
                {
                }
                fieldelement(Staff_no;"Salary Processing Lines"."Staff No.")
                {
                }
                fieldelement(Amount;"Salary Processing Lines".Amount)
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

