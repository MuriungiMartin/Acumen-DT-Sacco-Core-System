#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516911 "Group Members Statistics"
{
    PageType = ListPart;
    SourceTable = "Member Register";

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
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No";"Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Personal No";"Personal No")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Current Shares";"Current Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest";"Outstanding Interest")
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

