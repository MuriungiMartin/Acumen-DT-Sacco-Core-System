#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516910 "Group Statistics"
{
    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No of Active Group Members"; "No of Active Group Members")
                {
                    ApplicationArea = Basic;
                }
                field("No of Dormant Group Members"; "No of Dormant Group Members")
                {
                    ApplicationArea = Basic;
                }
                field("Group Deposits"; "Group Deposits")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        FieldStyle := '';
                        if "Group Deposits" <> 0 then
                            FieldStyle := 'Green';
                    end;
                }
                field("Group Loan Balance"; "Group Loan Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Fee Paid"; "Registration Fee Paid")
                {
                    ApplicationArea = Basic;
                    Caption = 'Entrance Fee Paid';
                }
                field("Shares Retained"; "Shares Retained")
                {
                    ApplicationArea = Basic;
                    Caption = 'Shares';
                }
            }
            part(Control1102755002; "Group Members Statistics")
            {
                SubPageLink = "Group Account No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Loan Disburesment Slip")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Loan Disburesment Slip";

                trigger OnAction()
                begin
                    //51516412
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*IF ("Assigned System ID"<>'') AND ("Assigned System ID"<>USERID) THEN BEGIN
          ERROR('You do not have permission to view this account Details');
          END;*/

        if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
            if UserSetup.Get(UserId) then begin
                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
            end;

        end;

        SetFieldStyle;

    end;

    var
        UserSetup: Record "User Setup";
        FieldStyle: Text;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        CalcFields("Un-allocated Funds");
        if "Un-allocated Funds" <> 0 then
            FieldStyle := 'Attention';
    end;
}

