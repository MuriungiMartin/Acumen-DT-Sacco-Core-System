#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516916 "Opportunity list."
{
    CardPageID = "Opportunity card.";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Lead Management";

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
                field("Search Name";"Search Name")
                {
                    ApplicationArea = Basic;
                }
                field(Address;Address)
                {
                    ApplicationArea = Basic;
                }
                field(City;City)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.";"Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Salesperson Code";"Salesperson Code")
                {
                    ApplicationArea = Basic;
                }
                field("Country/Region Code";"Country/Region Code")
                {
                    ApplicationArea = Basic;
                }
                field(Comment;Comment)
                {
                    ApplicationArea = Basic;
                }
                field(status;status)
                {
                    ApplicationArea = Basic;
                }
                field("Lead Type";"Lead Type")
                {
                    ApplicationArea = Basic;
                }
                field("member no";"member no")
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

