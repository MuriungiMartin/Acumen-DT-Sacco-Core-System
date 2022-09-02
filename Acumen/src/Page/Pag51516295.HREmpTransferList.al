#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516295 "HR Emp Transfer List"
{
    CardPageID = "HR Emp Transfer Card";
    Editable = false;
    PageType = List;
    SourceTable = "HR Employee Transfer Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No";"Request No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested";"Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Date Approved";"Date Approved")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Transfer details Updated";"Transfer details Updated")
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

