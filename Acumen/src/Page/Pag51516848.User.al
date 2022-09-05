#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516848 "User"
{
    Editable = false;
    PageType = List;
    SourceTable = User;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Security ID"; "User Security ID")
                {
                    ApplicationArea = Basic;
                }
                field("User Name"; "User Name")
                {
                    ApplicationArea = Basic;
                }
                field("Full Name"; "Full Name")
                {
                    ApplicationArea = Basic;
                }
                field(State; State)
                {
                    ApplicationArea = Basic;
                }
                // field("Branch Code";"Branch Code")
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
    }

    actions
    {
    }
}

