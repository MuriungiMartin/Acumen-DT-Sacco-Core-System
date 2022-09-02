#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516920 "Case Assigned  list"
{
    ApplicationArea = Basic;
    CardPageID = "Cases Assigned card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Cases Management";
    SourceTableView = where(Status=filter(Escalated));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case Number";"Case Number")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID No";"ID No")
                {
                    ApplicationArea = Basic;
                }
                field(Gender;Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Date of Complaint";"Date of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Recommended Action";"Recommended Action")
                {
                    ApplicationArea = Basic;
                }
                field("Case Description";"Case Description")
                {
                    ApplicationArea = Basic;
                }
                field("Action Taken";"Action Taken")
                {
                    ApplicationArea = Basic;
                }
                field("Date To Settle Case";"Date To Settle Case")
                {
                    ApplicationArea = Basic;
                }
                field("Document Link";"Document Link")
                {
                    ApplicationArea = Basic;
                }
                field("Solution Remarks";"Solution Remarks")
                {
                    ApplicationArea = Basic;
                }
                field(Comments;Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Body Handling The Complaint";"Body Handling The Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(Recomendations;Recomendations)
                {
                    ApplicationArea = Basic;
                }
                field(Implications;Implications)
                {
                    ApplicationArea = Basic;
                }
                field("Support Documents";"Support Documents")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Resource Assigned";"Resource Assigned")
                {
                    ApplicationArea = Basic;
                }
                field(Selected;Selected)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Member No.";"Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Account.";"FOSA Account.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name.";"Account Name.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No";"Loan No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control7;"Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No."=field("Member No");
            }
            part(Control6;"FOSA Statistics FactBox")
            {
                SubPageLink = "No."=field("FOSA Account.");
            }
            part(Control5;"Loans Sub-Page List")
            {
                Caption = 'Loans Details';
                SubPageLink = "Client Code"=field("Member No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'Member Details';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No."=field("Member No");
            }
        }
    }

    trigger OnInit()
    begin
        SetRange("Resource Assigned",UserId);
    end;

    trigger OnOpenPage()
    begin
        SetRange("Resource Assigned",UserId);
    end;
}

