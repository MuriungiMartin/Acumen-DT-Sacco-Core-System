#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516545 "Agent App Signatories List"
{
    CardPageID = "Agent App Signatory Card";
    PageType = Card;
    SourceTable = "Account Agents App Details";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Names; Names)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CUST.Reset;
                        CUST.SetRange(CUST."ID No.", "ID No.");
                        if CUST.Find('-') then begin
                            "BOSA No." := CUST."No.";
                            Modify;
                        end;
                    end;
                }
                field("Staff/Payroll"; "Staff/Payroll")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff/Payroll No';
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Must Sign"; "Must Sign")
                {
                    ApplicationArea = Basic;
                }
                field("Must be Present"; "Must be Present")
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No."; "BOSA No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email Address"; "Email Address")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Signatory)
            {
                Caption = 'Signatory';
                action("Page Account Signatories Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "HR Training Application List";
                    RunPageLink = "Application No" = field("Account No"),
                                  "Course Title" = field(Names);
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        MemberApp.Reset;
        MemberApp.SetRange(MemberApp."No.", "Account No");
        if MemberApp.Find('-') then begin
            if MemberApp.Status = MemberApp.Status::Approved then begin
                CurrPage.Editable := false;
            end else
                CurrPage.Editable := true;
        end;
    end;

    var
        MemberApp: Record "Membership Applications";
        ReltnShipTypeEditable: Boolean;
        CUST: Record Customer;
}

