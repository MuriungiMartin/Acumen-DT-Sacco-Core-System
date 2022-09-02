#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516250 "HR Asset Return Form"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Misc. Article Information";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Misc. Article Code";"Misc. Article Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Returned;Returned)
                {
                    ApplicationArea = Basic;
                }
                field("Status On Return";"Status On Return")
                {
                    ApplicationArea = Basic;
                }
                field("Date Returned";"Date Returned")
                {
                    ApplicationArea = Basic;
                }
                field(Recommendations;Recommendations)
                {
                    ApplicationArea = Basic;
                }
                field("Received By";"Received By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        EI: Record "HR Employee Exit Interviews";


    procedure refresh()
    begin
                        CurrPage.Update(false);
    end;
}

