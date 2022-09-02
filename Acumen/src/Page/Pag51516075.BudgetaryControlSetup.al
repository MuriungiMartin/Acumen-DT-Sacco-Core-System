#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516075 "Budgetary Control Setup"
{
    ApplicationArea = Basic;
    PageType = Card;
    SourceTable = "Budgetary Control Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Mandatory;Mandatory)
                {
                    ApplicationArea = Basic;
                }
                field("Allow OverExpenditure";"Allow OverExpenditure")
                {
                    ApplicationArea = Basic;
                }
                field("Actual Source";"Actual Source")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Check Criteria";"Budget Check Criteria")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Budget)
            {
                Caption = 'Budget';
                field("Current Budget Code";"Current Budget Code")
                {
                    ApplicationArea = Basic;
                }
                field("Current Budget Start Date";"Current Budget Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Current Budget End Date";"Current Budget End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Dimension 1 Code";"Budget Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Dimension 2 Code";"Budget Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Dimension 3 Code";"Budget Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Dimension 4 Code";"Budget Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Dimension 5 Code";"Budget Dimension 5 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Dimension 6 Code";"Budget Dimension 6 Code")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Actuals)
            {
                Caption = 'Actuals';
                field("Analysis View Code";"Analysis View Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 1 Code";"Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 2 Code";"Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 3 Code";"Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 4 Code";"Dimension 4 Code")
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

