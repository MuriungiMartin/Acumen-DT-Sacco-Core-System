#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50003 "PAYROLL EMPS 2017"
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
                fieldelement(Mobile_No;"Payroll Employee."."No.")
                {
                }
                fieldelement(a;"Payroll Employee.".Firstname)
                {
                }
                fieldelement(b;"Payroll Employee.".Surname)
                {
                }
                fieldelement(c;"Payroll Employee.".Lastname)
                {
                }
                fieldelement(d;"Payroll Employee."."National ID No")
                {
                }
                fieldelement(dB;"Payroll Employee.".Department)
                {
                }
                fieldelement(e;"Payroll Employee."."Global Dimension 2")
                {
                }
                fieldelement(g;"Payroll Employee."."Employee Email")
                {
                }
                fieldelement(f;"Payroll Employee."."Bank Account No")
                {
                }
                fieldelement(h;"Payroll Employee."."Bank Name")
                {
                }
                fieldelement(QQ;"Payroll Employee."."Branch Name")
                {
                }
                fieldelement(WW;"Payroll Employee."."Sacco Membership No.")
                {
                }
                fieldelement(EE;"Payroll Employee."."Joining Date")
                {
                }
                fieldelement(RR;"Payroll Employee."."Job Group")
                {
                }
                fieldelement(TT;"Payroll Employee."."PIN No")
                {
                }
                fieldelement(YYUU;"Payroll Employee."."NSSF No")
                {
                }
                fieldelement(II;"Payroll Employee."."NHIF No")
                {
                }
                fieldelement(OO;"Payroll Employee."."Pays PAYE")
                {
                }
                fieldelement(PP;"Payroll Employee."."Pays NSSF")
                {
                }
                fieldelement(SS;"Payroll Employee."."Pays NHIF")
                {
                }
                fieldelement(DD;"Payroll Employee."."Posting Group")
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

