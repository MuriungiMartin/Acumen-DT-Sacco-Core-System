#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516304 "HR Applicants UnQualified Card"
{
    PageType = Card;
    SourceTable = "HR Job Applications";
    SourceTableView = where("Qualification Status"=filter(UnQualified));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No";"Application No")
                {
                    ApplicationArea = Basic;
                }
                field("First Name";"First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Middle Name";"Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name";"Last Name")
                {
                    ApplicationArea = Basic;
                }
                field("Job Applied For";"Job Applied For")
                {
                    ApplicationArea = Basic;
                }
                field(Qualified;Qualified)
                {
                    ApplicationArea = Basic;
                }
                field("Date of Interview";"Date of Interview")
                {
                    ApplicationArea = Basic;
                }
                field("From Time";"From Time")
                {
                    ApplicationArea = Basic;
                }
                field("To Time";"To Time")
                {
                    ApplicationArea = Basic;
                }
                field(Venue;Venue)
                {
                    ApplicationArea = Basic;
                }
                field("Interview Type";"Interview Type")
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

