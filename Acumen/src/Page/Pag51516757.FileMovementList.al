#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516757 "File Movement List"
{
    ApplicationArea = Basic;
    CardPageID = "File Movement Header";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "File Movement Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("File Number";"File Number")
                {
                    ApplicationArea = Basic;
                }
                field("File Name";"File Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested";"Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Requested By";"Requested By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Retrieved";"Date Retrieved")
                {
                    ApplicationArea = Basic;
                }
                field("Responsiblity Center";"Responsiblity Center")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Return Date";"Expected Return Date")
                {
                    ApplicationArea = Basic;
                }
                field("Duration Requested";"Duration Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Date Returned";"Date Returned")
                {
                    ApplicationArea = Basic;
                }
                field("File Location";"File Location")
                {
                    ApplicationArea = Basic;
                }
                field("Current File Location";"Current File Location")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved By";"Retrieved By")
                {
                    ApplicationArea = Basic;
                }
                field("Returned By";"Returned By")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Issuing File Location";"Issuing File Location")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";"No. Series")
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

