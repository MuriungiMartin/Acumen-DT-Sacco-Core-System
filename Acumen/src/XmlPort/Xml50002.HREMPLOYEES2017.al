#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50002 "HR EMPLOYEES 2017"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("HR Employees";"HR Employees")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(Mobile_No;"HR Employees"."No.")
                {
                }
                fieldelement(a;"HR Employees"."First Name")
                {
                }
                fieldelement(b;"HR Employees"."Middle Name")
                {
                }
                fieldelement(c;"HR Employees"."Last Name")
                {
                }
                fieldelement(d;"HR Employees"."Postal Address")
                {
                }
                fieldelement(dd;"HR Employees"."ID Number")
                {
                }
                fieldelement(e;"HR Employees".Office)
                {
                }
                fieldelement(f;"HR Employees"."Global Dimension 2 Code")
                {
                }
                fieldelement(g;"HR Employees"."E-Mail")
                {
                }
                fieldelement(h;"HR Employees"."Company E-Mail")
                {
                }
                fieldelement(i;"HR Employees".Gender)
                {
                }
                fieldelement(j;"HR Employees"."Bank Account Number")
                {
                }
                fieldelement(k;"HR Employees"."Main Bank")
                {
                }
                fieldelement(AA;"HR Employees"."Branch Bank")
                {
                }
                fieldelement(SS;"HR Employees"."Date Of Birth")
                {
                }
                fieldelement(DD;"HR Employees"."Date Of Join")
                {
                }
                fieldelement(FF;"HR Employees"."Job Title")
                {
                }
                fieldelement(GG;"HR Employees"."PIN No.")
                {
                }
                fieldelement(HH;"HR Employees"."NSSF No.")
                {
                }
                fieldelement(JJ;"HR Employees"."NHIF No.")
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

