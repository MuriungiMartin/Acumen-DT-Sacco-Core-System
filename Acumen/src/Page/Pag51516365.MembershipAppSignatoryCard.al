#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516365 "Membership App Signatory Card"
{
    PageType = Card;
    SourceTable = "Member App Signatories";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Names;Names)
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No.";"BOSA No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                }
                field("Date Of Birth";"Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Mobile No.";"Mobile No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Designation;Designation)
                {
                    ApplicationArea = Basic;
                    Caption = 'Designation';
                    ShowMandatory = true;
                }
                field(Signatory;Signatory)
                {
                    ApplicationArea = Basic;
                }
                field(self;self)
                {
                    ApplicationArea = Basic;
                }
                field("Must Sign";"Must Sign")
                {
                    ApplicationArea = Basic;
                }
                field("Must be Present";"Must be Present")
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date";"Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address";"Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Withdrawal";"Maximum Withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field(Picture;Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature;Signature)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

