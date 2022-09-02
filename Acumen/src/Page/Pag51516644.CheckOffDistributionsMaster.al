#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516644 "CheckOff Distributions Master"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Checkoff Processing Details(B)";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Check Off No";"Check Off No")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Advice No";"Check Off Advice No")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Date";"Check Off Date")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product";"Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No";"Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest";"Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

