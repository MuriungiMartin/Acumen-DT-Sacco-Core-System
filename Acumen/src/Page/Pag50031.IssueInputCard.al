#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50031 "Issue Input Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "PM Issue Tracker";
    SourceTableView = where(Posted=const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Module Code";"Module Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Module';
                }
                field("UAT Item";"UAT Item")
                {
                    ApplicationArea = Basic;
                    Caption = 'Issue Description';
                    MultiLine = true;
                }
                field("USER ID";"USER ID")
                {
                    ApplicationArea = Basic;
                }
                field("UAT Level";"UAT Level")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Status";"Customer Status")
                {
                    ApplicationArea = Basic;
                }
                field("User Comments";"User Comments")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Submit Issue';
                Image = post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if "Module Code" = '' then
                     Error('Kindly select module');
                    if "UAT Item" = '' then
                      Error('Kindly enter description of the issue being submitted.');
                    Posted:=true;
                    Modify;
                    Message('Your issue has been submitted and shall be handled ASAP! Thank you.');
                end;
            }
            group(ActionGroup9)
            {
            }
        }
    }

    var
        Post: Integer;
}

