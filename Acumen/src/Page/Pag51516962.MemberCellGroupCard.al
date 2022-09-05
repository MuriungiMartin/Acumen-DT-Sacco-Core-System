#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516962 "Member Cell Group Card"
{
    PageType = Card;
    SourceTable = "Member House Groups";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Cell Group Code"; "Cell Group Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cell Group Name"; "Cell Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Formed"; "Date Formed")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Date"; "Meeting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader"; "Group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader Name"; "Group Leader Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Group Leader Email"; "Group Leader Email")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assistant group Leader"; "Assistant group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Assistant Group Name"; "Assistant Group Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assistant Group Leader Email"; "Assistant Group Leader Email")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Officer"; "Credit Officer")
                {
                    ApplicationArea = Basic;
                }
                field("Field Officer"; "Field Officer")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Place"; "Meeting Place")
                {
                    ApplicationArea = Basic;
                }
                field("No of Members"; "No of Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created On"; "Created On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control12; "Cell Group Members Subpage")
            {
                SubPageLink = "Member House Group" = field("Cell Group Code");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Group Statement")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjCellGroups.Reset;
                    ObjCellGroups.SetRange(ObjCellGroups."Cell Group Code", "Cell Group Code");
                    if ObjCellGroups.Find('-') then
                        Report.Run(51516920, true, false, ObjCellGroups);
                end;
            }
            action("Member Savings History")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."Member House Group", "Cell Group Code");
                    if ObjCust.Find('-') then
                        Report.Run(51516929, true, false, ObjCust);
                end;
            }
            action("Meetings Schedule")
            {
                ApplicationArea = Basic;
                Image = FORM;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Meetings Schedule";
                RunPageLink = "Lead No" = field("Cell Group Code");
            }
        }
    }

    var
        ObjCellGroups: Record "Member House Groups";
        ObjCust: Record Customer;
}

