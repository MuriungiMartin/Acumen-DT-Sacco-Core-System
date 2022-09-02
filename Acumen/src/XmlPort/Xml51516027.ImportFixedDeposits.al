#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 51516027 "Import Fixed Deposits"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Fixed Deposit Data Buffer";"Fixed Deposit Data Buffer")
            {
                XmlName = 'ChequeImport';
                fieldelement(A;"Fixed Deposit Data Buffer"."Account No")
                {
                }
                fieldelement(B;"Fixed Deposit Data Buffer"."Account Name")
                {
                }
                fieldelement(C;"Fixed Deposit Data Buffer"."Amount to Transfer")
                {
                }
                fieldelement(D;"Fixed Deposit Data Buffer"."Fixed Deposit Duration")
                {
                }
                fieldelement(E;"Fixed Deposit Data Buffer"."FD Interest Rate")
                {
                }
                fieldelement(F;"Fixed Deposit Data Buffer"."Interest Expected")
                {
                }
                fieldelement(G;"Fixed Deposit Data Buffer"."Fixed Deposit Status")
                {
                }
                fieldelement(H;"Fixed Deposit Data Buffer"."Current Account No")
                {
                }
                fieldelement(I;"Fixed Deposit Data Buffer"."Current Account Name")
                {
                }
                fieldelement(J;"Fixed Deposit Data Buffer"."Account Type")
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

