#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516422 "Employer list"
{
    ApplicationArea = Basic;
    CardPageID = "Paybill Processing Header";
    PageType = List;
    SourceTable = "Sacco Employers";
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
                field("Repayment Method";"Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off";"Check Off")
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

