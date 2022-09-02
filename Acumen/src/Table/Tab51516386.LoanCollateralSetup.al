#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516386 "Loan Collateral Set-up"
{
    DrillDownPageID = "Loan Collateral Setup";
    LookupPageID = "Loan Collateral Setup";

    fields
    {
        field(1;"Code";Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                /*IF LoanApplications.GET(Code) THEN
                Category:=LoanApplications."Loan Product Type";    */

            end;
        }
        field(2;Type;Option)
        {
            NotBlank = true;
            OptionCaption = ' ,Shares,Deposits,Collateral,Fixed Deposit';
            OptionMembers = " ",Shares,Deposits,Collateral,"Fixed Deposit";
        }
        field(3;"Security Description";Text[50])
        {
        }
        field(5;Category;Option)
        {
            OptionCaption = ' ,Cash,Government Securities,Corporate Bonds,Equity,Mortgage Securities,Fixed Deposit';
            OptionMembers = " ",Cash,"Government Securities","Corporate Bonds",Equity,"Mortgage Securities","Fixed Deposit";
        }
        field(6;"Collateral Multiplier";Decimal)
        {

            trigger OnValidate()
            begin
                //"Guarantee Value":="Collateral Multiplier"*0.7;
            end;
        }
    }

    keys
    {
        key(Key1;"Code",Type,"Security Description")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LoanApplications: Record "Loans Register";
}

