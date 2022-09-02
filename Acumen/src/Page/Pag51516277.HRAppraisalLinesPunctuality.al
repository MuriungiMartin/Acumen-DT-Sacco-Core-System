#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516277 "HR Appraisal Lines-Punctuality"
{
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";
    SourceTableView = where(Sections=filter("Attendance&Punctuality"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No";"Appraisal No")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period";"Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No";"Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(Sections;Sections)
                {
                    ApplicationArea = Basic;
                }
                field("Perfomance Goals and Targets";"Perfomance Goals and Targets")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    Width = 300;
                }
                field("Self Rating";"Self Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Peer Rating";"Peer Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Rating";"Supervisor Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Sub-ordinates Rating";"Sub-ordinates Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Outside Agencies Rating";"Outside Agencies Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Agreed Rating";"Agreed Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Agreed Rating x Weighting";"Agreed Rating x Weighting")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Comments";"Employee Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Peer Comments";"Peer Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Comments";"Supervisor Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Subordinates Comments";"Subordinates Comments")
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

