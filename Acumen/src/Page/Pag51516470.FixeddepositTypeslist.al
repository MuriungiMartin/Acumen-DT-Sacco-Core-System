#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516470 "Fixed deposit Types list"
{
    ApplicationArea = Basic;
    CardPageID = "Fixed Deposit Types Card";
    Editable = false;
    PageType = List;
    SourceTable = "Fixed Deposit Type";
    SourceTableView = sorting(Code,"Maximum Amount")
                      order(descending);
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
                field(Duration;Duration)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("No. of Months";"No. of Months")
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

