#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516004 "Import Checkoff Lines(Block)"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Checkoff Lines-Distributed";"Checkoff Lines-Distributed")
            {
                XmlName = 'Paybill';
                fieldelement(entry;"Checkoff Lines-Distributed"."Entry No")
                {
                }
                fieldelement(hdno;"Checkoff Lines-Distributed"."Receipt Header No")
                {
                }
                fieldelement(mno;"Checkoff Lines-Distributed"."Member No.")
                {
                }
                fieldelement(da;"Checkoff Lines-Distributed"."Deposit Amount")
                {
                }
                fieldelement(fa;"Checkoff Lines-Distributed"."Fosa Amount")
                {
                }
                fieldelement(lpt;"Checkoff Lines-Distributed"."Loan Product Type")
                {
                }
                fieldelement(pa;"Checkoff Lines-Distributed"."Principal Amount")
                {
                }
                fieldelement(ia;"Checkoff Lines-Distributed"."Interest Amount")
                {
                }
                fieldelement(sa;"Checkoff Lines-Distributed"."Shares Amount")
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

