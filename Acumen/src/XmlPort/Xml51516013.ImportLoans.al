#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516013 "Import Loans"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Loans Import Buffer";"Loans Import Buffer")
            {
                AutoReplace = true;
                XmlName = 'Paybill';
                fieldelement(A;"Loans Import Buffer"."Member No")
                {
                }
                fieldelement(DS;"Loans Import Buffer"."Member Name")
                {
                }
                fieldelement(B;"Loans Import Buffer"."Group ID")
                {
                }
                fieldelement(C;"Loans Import Buffer"."Branch Code")
                {
                }
                fieldelement(D;"Loans Import Buffer"."Branch Name")
                {
                }
                fieldelement(E;"Loans Import Buffer".Address)
                {
                }
                fieldelement(F;"Loans Import Buffer"."Postal Code")
                {
                }
                fieldelement(G;"Loans Import Buffer".City)
                {
                }
                fieldelement(GGGG;"Loans Import Buffer"."Modified By")
                {
                }
                fieldelement(SS;"Loans Import Buffer"."Member Residence")
                {
                }
                fieldelement(I;"Loans Import Buffer".Village)
                {
                }
                fieldelement(J;"Loans Import Buffer".Location)
                {
                }
                fieldelement(K;"Loans Import Buffer"."Sub Location")
                {
                }
                fieldelement(L;"Loans Import Buffer".District)
                {
                }
                fieldelement(xx;"Loans Import Buffer"."Mobile No")
                {
                }
                fieldelement(dd;"Loans Import Buffer"."Phone No")
                {
                }
                fieldelement(ee;"Loans Import Buffer".Email)
                {
                }
                fieldelement(ff;"Loans Import Buffer"."Email Idemnified")
                {
                }
                fieldelement(gg;"Loans Import Buffer"."ID No")
                {
                }
                fieldelement(hh;"Loans Import Buffer"."ID Type")
                {
                }
                fieldelement(ii;"Loans Import Buffer"."ID Date of Issue")
                {
                }
                fieldelement(jj;"Loans Import Buffer"."KRA Pin")
                {
                }
                fieldelement(kk;"Loans Import Buffer"."Marital Status")
                {
                }
                fieldelement(ll;"Loans Import Buffer".Gender)
                {
                }
                fieldelement(mm;"Loans Import Buffer"."Literacy Level")
                {
                }
                fieldelement(nn;"Loans Import Buffer".Occupation)
                {
                }
                fieldelement(oo;"Loans Import Buffer"."Registration Date")
                {
                }
                fieldelement(ppp;"Loans Import Buffer"."Created By")
                {
                }
                fieldelement(qq;"Loans Import Buffer"."Created On")
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

