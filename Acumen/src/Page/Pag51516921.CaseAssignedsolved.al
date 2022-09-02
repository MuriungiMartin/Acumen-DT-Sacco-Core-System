#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516921 "Case Assigned  solved"
{
    ApplicationArea = Basic;
    CardPageID = "Cases solved card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Cases Management";
    SourceTableView = where(Status=filter(Resolved));
    UsageCategory = History;

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
                field("Case Resolution Details";"Case Resolution Details")
                {
                    ApplicationArea = Basic;
                }
                field("Date To Settle Case";"Date To Settle Case")
                {
                    ApplicationArea = Basic;
                }
                field(Recomendations;Recomendations)
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
            }
        }
        area(factboxes)
        {
            part(Control6;"Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No."=field("Member No");
            }
            part(Control5;"FOSA Statistics FactBox")
            {
                SubPageLink = "No."=field("FOSA Account.");
            }
            part(Control4;"Loans Sub-Page List")
            {
                Caption = 'Loans Details';
                SubPageLink = "Client Code"=field("Member No");
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        //SETRANGE("Resource Assigned",USERID);
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("Resource Assigned",USERID);
    end;
}

