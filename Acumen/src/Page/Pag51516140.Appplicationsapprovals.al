#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516140 "Appplications approvals"
{
    CardPageID = "S-Mobile Applications Card";
    Editable = false;
    PageType = List;
    SourceTable = "CloudPESA Applications";
    SourceTableView = where(Status=filter(" Pending Approval"));

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
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone;Telephone)
                {
                    ApplicationArea = Basic;
                }
                field("ID No";"ID No")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Applied";"Date Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Time Applied";"Time Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Created By";"Created By")
                {
                    ApplicationArea = Basic;
                }
                field(Sent;Sent)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Image = Approve;

                trigger OnAction()
                begin
                    if Status = Status::" Pending Approval" then
                      begin
                    if  Vendor.Get("Account No") then
                      begin
                        Vendor."S-Mobile No" := Telephone;
                        Vendor.Modify;
                        Status := Status::Approved;
                        Modify;

                    Message('Application has been approved');

                      end
                    end
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        StatusPermissions.Reset;
        StatusPermissions.SetRange(StatusPermissions."User ID",UserId);
        StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::Smobile);
        if StatusPermissions.Find('-') = false then
        Error('You do not have permissions to edit member information.');
    end;

    var
        Vendor: Record Vendor;
        StatusPermissions: Record "Status Change Permision";
}

