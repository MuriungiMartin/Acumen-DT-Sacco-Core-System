#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516192 "HR Job Requirement Lines"
{
    PageType = List;
    SourceTable = "HR Job Requirements";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Qualification Type";"Qualification Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Qualification Code";"Qualification Code")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Qualification Description";"Qualification Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field(Priority;Priority)
                {
                    ApplicationArea = Basic;
                }
                field("Desired Score";"Desired Score")
                {
                    ApplicationArea = Basic;
                }
                field("Total (Stage)Desired Score";"Total (Stage)Desired Score")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Mandatory;Mandatory)
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

