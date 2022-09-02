#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516984 "CRM Trainings"
{
    ApplicationArea = Basic;
    CardPageID = "CRM Training Card";
    Editable = false;
    PageType = List;
    SourceTable = "CRM Trainings";
    UsageCategory = Lists;

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
                field("Start Date";"Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date";"End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Location;Location)
                {
                    ApplicationArea = Basic;
                }
                field(Provider;Provider)
                {
                    ApplicationArea = Basic;
                }
                field("Need Source";"Need Source")
                {
                    ApplicationArea = Basic;
                }
                field(Closed;Closed)
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

