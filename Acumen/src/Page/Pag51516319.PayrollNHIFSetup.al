#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516319 "Payroll NHIF Setup."
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Payroll NHIF Setup.";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tier Code";"Tier Code")
                {
                    ApplicationArea = Basic;
                }
                field("NHIF Tier";"NHIF Tier")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Lower Limit";"Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit";"Upper Limit")
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

