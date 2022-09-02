#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516266 "HR Leave Family Groups List"
{
    CardPageID = "HR Leave Family Groups Card";
    PageType = List;
    SourceTable = "HR Leave Family Groups";

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
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Max Employees On Leave";"Max Employees On Leave")
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

