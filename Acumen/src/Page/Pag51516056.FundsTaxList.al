#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516056 "Funds Tax List"
{
    CardPageID = "Funds Tax Card";
    PageType = List;
    SourceTable = "Funds Tax Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tax Code";"Tax Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
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

