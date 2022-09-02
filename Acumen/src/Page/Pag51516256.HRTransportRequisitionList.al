#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516256 "HR Transport Requisition List"
{
    ApplicationArea = Basic;
    CardPageID = "HR Staff Transport Requisition";
    PageType = List;
    SourceTable = "HR Transport Requisition";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application Code";"Application Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Email";"Supervisor Email")
                {
                    ApplicationArea = Basic;
                }
                field("Job Tittle";"Job Tittle")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No";"Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(Supervisor;Supervisor)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Comment;Comment)
                {
                    ApplicationArea = Basic;
                }
                field("Purpose of Trip";"Purpose of Trip")
                {
                    ApplicationArea = Basic;
                }
                field("Transport type";"Transport type")
                {
                    ApplicationArea = Basic;
                }
                field("Time of Trip";"Time of Trip")
                {
                    ApplicationArea = Basic;
                }
                field("Pickup Point";"Pickup Point")
                {
                    ApplicationArea = Basic;
                }
                field("From Destination";"From Destination")
                {
                    ApplicationArea = Basic;
                }
                field("To Destination";"To Destination")
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

