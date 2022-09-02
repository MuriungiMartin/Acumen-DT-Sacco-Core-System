#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516213 "HR Drivers Card"
{
    PageType = Card;
    SourceTable = "HR Drivers";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Driver Name";"Driver Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Driver License Number";"Driver License Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Last License Renewal";"Last License Renewal")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Renewal Interval";"Renewal Interval")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Renewal Interval Value";"Renewal Interval Value")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Next License Renewal";"Next License Renewal")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Year Of Experience";"Year Of Experience")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Grade;Grade)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Active;Active)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755013;Outlook)
            {
            }
            systempart(Control1102755014;Notes)
            {
            }
        }
    }

    actions
    {
    }
}

