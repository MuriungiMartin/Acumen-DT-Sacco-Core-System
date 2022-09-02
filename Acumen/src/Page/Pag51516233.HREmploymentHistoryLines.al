#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516233 "HR Employment History Lines"
{
    Caption = 'Employment History Lines';
    PageType = List;
    SourceTable = "HR Employment History";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Company Name";"Company Name")
                {
                    ApplicationArea = Basic;
                }
                field(From;From)
                {
                    ApplicationArea = Basic;
                }
                field("To Date";"To Date")
                {
                    ApplicationArea = Basic;
                }
                field("Job Title";"Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Key Experience";"Key Experience")
                {
                    ApplicationArea = Basic;
                }
                field("Salary On Leaving";"Salary On Leaving")
                {
                    ApplicationArea = Basic;
                }
                field("Postal Address";"Postal Address")
                {
                    ApplicationArea = Basic;
                }
                field("Address 2";"Address 2")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Leaving";"Reason For Leaving")
                {
                    ApplicationArea = Basic;
                }
                field(Comment;Comment)
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

