#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516599 "Posted Share Boosting List"
{
    CardPageID = "Share Boosting Card";
    Editable = false;
    PageType = List;
    SourceTable = "Loan PayOff";
    SourceTableView = where(Posted=filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Requested PayOff Amount";"Requested PayOff Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved PayOff Amount";"Approved PayOff Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Created By";"Created By")
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

