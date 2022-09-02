#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516318 "Payroll PAYE Setup."
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Payroll PAYE Setup.";
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
                field("PAYE Tier";"PAYE Tier")
                {
                    ApplicationArea = Basic;
                }
                field(Rate;Rate)
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

