#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516301 "Hr ApprovedAsset Transfer List"
{
    ApplicationArea = Basic;
    CardPageID = "Hr Approved Asset Transfer";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HR Asset Transfer Header";
    SourceTableView = where(Transfered=filter(true));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date";"Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("No. Seriess";"No. Seriess")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(Transfered;Transfered)
                {
                    ApplicationArea = Basic;
                }
                field("Date Transfered";"Date Transfered")
                {
                    ApplicationArea = Basic;
                }
                field("Transfered By";"Transfered By")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted";"Time Posted")
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

