#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516733 "freeze"
{
    CardPageID = "freeze na re activeable";
    PageType = List;
    SourceTable = "Freeze and Activeate";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field(Time;Time)
                {
                    ApplicationArea = Basic;
                }
                field(user;user)
                {
                    ApplicationArea = Basic;
                }
                field("Member No.";"Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(Reason;Reason)
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

