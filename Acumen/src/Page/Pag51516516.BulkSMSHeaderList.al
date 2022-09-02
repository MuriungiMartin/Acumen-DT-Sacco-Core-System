#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516516 "Bulk SMS Header List"
{
    CardPageID = "Bulk SMS Header";
    Editable = false;
    PageType = List;
    SourceTable = "Bulk SMS Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field(Message;Message)
                {
                    ApplicationArea = Basic;
                }
                field("SMS Type";"SMS Type")
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered";"Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered";"Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Status";"SMS Status")
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

