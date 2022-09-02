#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516563 "Meetings Schedule"
{
    PageType = List;
    SourceTable = "Meetings Schedule";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Meeting Date";"Meeting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Place";"Meeting Place")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Status";"Meeting Status")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Outcome(Brief)";"Meeting Outcome(Brief)")
                {
                    ApplicationArea = Basic;
                }
                field("User to Notify";"User to Notify")
                {
                    ApplicationArea = Basic;
                }
                field("User Email";"User Email")
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

