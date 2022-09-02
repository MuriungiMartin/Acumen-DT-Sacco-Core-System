#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516283 "Hr Employee Transfer Line"
{
    PageType = ListPart;
    SourceTable = "HR Employee Transfer Lines";

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
                field("Employee No";"Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name";"Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Current Department";"Current Department")
                {
                    ApplicationArea = Basic;
                }
                field("Current Branch";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Branch';
                }
                field("New Department";"New Department")
                {
                    ApplicationArea = Basic;
                }
                field("New Branch";"New Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Branch';
                }
                field(Comments;Comments)
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

