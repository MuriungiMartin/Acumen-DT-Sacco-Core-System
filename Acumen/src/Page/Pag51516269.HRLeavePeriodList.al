#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516269 "HR Leave Period List"
{
    PageType = List;
    SourceTable = "HR Leave Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Code";"Period Code")
                {
                    ApplicationArea = Basic;
                }
                field("Period Description";"Period Description")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Date";"Starting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("New Fiscal Year";"New Fiscal Year")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Closed;Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Locked";"Date Locked")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008;Outlook)
            {
            }
            systempart(Control1102755009;Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Report 51516233>")
            {
                ApplicationArea = Basic;
                Caption = '&Create Year';
                Ellipsis = true;
                Image = CreateYear;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report UnknownReport51516233;
            }
            action("C&lose Year")
            {
                ApplicationArea = Basic;
                Caption = 'C&lose Year';
                Image = CloseYear;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Codeunit "Leave Year-Closeoldd";
            }
        }
    }
}

