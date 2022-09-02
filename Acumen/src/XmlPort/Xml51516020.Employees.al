#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516020 "Employees"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Payroll Employee.";"Payroll Employee.")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(No;"Payroll Employee."."No.")
                {
                }
                fieldelement(Mobile_No;"Payroll Employee."."Sacco Membership No.")
                {
                }
                fieldelement(a;"Payroll Employee.".Surname)
                {
                }
                fieldelement(r;"Payroll Employee.".Lastname)
                {
                }
                fieldelement(e;"Payroll Employee.".Firstname)
                {
                }
                fieldelement(r;"Payroll Employee."."National ID No")
                {
                }
                fieldelement(t;"Payroll Employee."."Employee Email")
                {
                }
                fieldelement(y;"Payroll Employee."."PIN No")
                {
                }
                fieldelement(u;"Payroll Employee."."NHIF No")
                {
                }
                fieldelement(i;"Payroll Employee."."NSSF No")
                {
                }
                fieldelement(o;"Payroll Employee."."Bank Account No")
                {
                }
                fieldelement(p;"Payroll Employee."."Posting Group")
                {
                }
                fieldelement(s;"Payroll Employee."."Pays PAYE")
                {
                }
                fieldelement(z;"Payroll Employee."."Pays NSSF")
                {
                }
                fieldelement(q;"Payroll Employee."."Pays NHIF")
                {
                }
                fieldelement(xx;"Payroll Employee."."Bank Name")
                {
                }
                fieldelement(YZ;"Payroll Employee."."Payment Mode")
                {
                }
                fieldelement(ssss;"Payroll Employee."."Joining Date")
                {
                }
                fieldelement(dcf;"Payroll Employee."."Basic Pay")
                {
                }
                fieldelement(wse;"Payroll Employee."."Basic Pay(LCY)")
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

