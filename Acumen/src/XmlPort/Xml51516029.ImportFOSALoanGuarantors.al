#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516029 "Import FOSA Loan Guarantors"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Loan GuarantorsFOSA";"Loan GuarantorsFOSA")
            {
                XmlName = 'ChequeImport';
                fieldelement(A;"Loan GuarantorsFOSA"."Loanee No")
                {
                }
                fieldelement(B;"Loan GuarantorsFOSA"."FOSA  Accounts")
                {
                }
                fieldelement(C;"Loan GuarantorsFOSA"."Amount Guaranted")
                {
                }
                fieldelement(D;"Loan GuarantorsFOSA"."Loan Product")
                {
                }
                fieldelement(E;"Loan GuarantorsFOSA"."Entry No")
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

