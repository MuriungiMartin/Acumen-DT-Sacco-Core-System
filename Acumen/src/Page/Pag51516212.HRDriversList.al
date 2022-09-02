#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516212 "HR Drivers List"
{
    ApplicationArea = Basic;
    CardPageID = "HR Drivers Card";
    InsertAllowed = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Drivers";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field("Driver Name";"Driver Name")
                {
                    ApplicationArea = Basic;
                }
                field("Driver License Number";"Driver License Number")
                {
                    ApplicationArea = Basic;
                }
                field("Last License Renewal";"Last License Renewal")
                {
                    ApplicationArea = Basic;
                }
                field("Renewal Interval";"Renewal Interval")
                {
                    ApplicationArea = Basic;
                }
                field("Renewal Interval Value";"Renewal Interval Value")
                {
                    ApplicationArea = Basic;
                }
                field("Next License Renewal";"Next License Renewal")
                {
                    ApplicationArea = Basic;
                }
                field("Year Of Experience";"Year Of Experience")
                {
                    ApplicationArea = Basic;
                }
                field(Grade;Grade)
                {
                    ApplicationArea = Basic;
                }
                field(Active;Active)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755004;Outlook)
            {
            }
            systempart(Control1102755006;Notes)
            {
            }
        }
    }

    actions
    {
    }
}

