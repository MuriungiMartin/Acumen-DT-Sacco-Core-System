#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516265 "HR Education Assistance List"
{
    CardPageID = "HR Education Assistance";
    PageType = List;
    SourceTable = "HR Education Assistance";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No.";"Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee First Name";"Employee First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Last Name";"Employee Last Name")
                {
                    ApplicationArea = Basic;
                }
                field("Type Of Institution";"Type Of Institution")
                {
                    ApplicationArea = Basic;
                }
                field("Educational Institution";"Educational Institution")
                {
                    ApplicationArea = Basic;
                }
                field("Year Of Study";"Year Of Study")
                {
                    ApplicationArea = Basic;
                }
                field("Refund Level";"Refund Level")
                {
                    ApplicationArea = Basic;
                }
                field("Student Number";"Student Number")
                {
                    ApplicationArea = Basic;
                }
                field("Study Period";"Study Period")
                {
                    ApplicationArea = Basic;
                }
                field("Total Cost";"Total Cost")
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

