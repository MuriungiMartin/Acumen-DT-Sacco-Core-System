#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516913 "Case list"
{
    ApplicationArea = Basic;
    CardPageID = "Cases Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Cases Management";
    SourceTableView = where(Status=filter(Open));
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
                field("Date of Complaint";"Date of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Type of cases";"Type of cases")
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
                field("Recommended Action";"Recommended Action")
                {
                    ApplicationArea = Basic;
                }
                field("Case Description";"Case Description")
                {
                    ApplicationArea = Basic;
                }
                field("Caller Reffered To";"Caller Reffered To")
                {
                    ApplicationArea = Basic;
                    Caption = 'Case Escalated to:';
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
                field("Case Solved";"Case Solved")
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
                field("Mode of Lodging the Complaint";"Mode of Lodging the Complaint")
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
                field("Closed By";"Closed By")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";"Responsibility Center")
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
        }
    }

    actions
    {
        area(creation)
        {
            action("Recall Case")
            {
                ApplicationArea = Basic;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                     TestField("Recall Reason");
                     if ObjGenEnquiry.Get("Initiated Enquiry No") then
                       begin
                         if ObjGenEnquiry."Captured By"<>UserId then
                           begin
                            Error('You can only recall an issue you have initiated');
                             end;
                         end;

                    if Confirm('Confirm you want to recall this case',false)=true  then
                      begin
                        ObjCaseManagement.Reset;
                        ObjCaseManagement.SetRange(ObjCaseManagement."Case Number","Case Number");
                        if ObjCaseManagement.FindSet then
                          begin
                            ObjCaseManagement.Status:=ObjCaseManagement.Status::Recalled;
                            ObjCaseManagement.Modify;
                            end;

                            if ObjGenEnquiry.Get("Initiated Enquiry No") then
                              begin
                                ObjGenEnquiry.Status:=ObjGenEnquiry.Status::New;
                                ObjGenEnquiry.Send:=false;
                                ObjGenEnquiry.Modify;
                                end;
                        end;
                end;
            }
        }
    }

    var
        ObjCaseManagement: Record "Cases Management";
        ObjGenEnquiry: Record "General Equiries.";
}

