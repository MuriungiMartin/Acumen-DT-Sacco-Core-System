#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516549 "Deposit Tier"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Deposit Tier Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Amount";"Minimum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Amount";"Maximum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Dep Contributions";"Minimum Dep Contributions")
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

