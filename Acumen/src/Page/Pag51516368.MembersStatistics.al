#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516368 "Members Statistics"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Monthly Contribution"; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Width = 50;
                }
                field("FOSA Contribution"; "FOSA Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Retained"; "Shares Retained")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital Balance';
                }
                field("Current Shares"; "Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits Contribution Balance';
                }
                field("Benevolent Fund"; "Benevolent Fund")
                {
                    ApplicationArea = Basic;
                    Caption = 'Benevolent Fund Balance';
                    Editable = false;
                }
                field("FOSA Shares"; "FOSA Shares")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Additional Shares"; "Additional Shares")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Registration Fee Paid"; "Registration Fee Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Fund"; "Insurance Fund")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Amount"; "Dividend Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Outstanding Balance"; "Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outstanding Loan Balance';
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Outstanding Interest"; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Un-allocated Funds"; "Un-allocated Funds")
                {
                    ApplicationArea = Basic;
                    StyleExpr = FieldStyle;
                }
                field("Loans Recoverd from Guarantors"; "Loans Recoverd from Guarantors")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1102755002; "Loans Sub-Page List")
            {
                SubPageLink = "BOSA No" = field("No.");
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

    trigger OnAfterGetCurrRecord()
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange("Client Code", "No.");
        if ObjLoans.Find('-') then
            OutstandingInterest := SFactory.FnGetInterestDueTodate(ObjLoans) - ObjLoans."Interest Paid";
    end;

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
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "SURESTEP Factory.";
        ObjLoans: Record "Loans Register";

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        CalcFields("Un-allocated Funds");
        if "Un-allocated Funds" <> 0 then
            FieldStyle := 'Attention';
    end;
}

