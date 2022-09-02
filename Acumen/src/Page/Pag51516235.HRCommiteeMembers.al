#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516235 "HR Commitee Members"
{
    PageType = List;
    SourceTable = "HR Commitee Members";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Member No.";"Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(Role;Role)
                {
                    ApplicationArea = Basic;
                }
                field("Date Appointed";"Date Appointed")
                {
                    ApplicationArea = Basic;
                }
                field(Active;Active)
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

