#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516211 "HR Committees"
{
    PageType = List;
    SourceTable = "HR Committees";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Roles;Roles)
                {
                    ApplicationArea = Basic;
                }
                field("Monetary Benefit?";"Monetary Benefit?")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Code";"Transaction Code")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Visible = false;
                }
                field(Amount;"Transaction Amount")
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
            group(Committee)
            {
                Caption = 'Committee';
                action(Members)
                {
                    ApplicationArea = Basic;
                    Caption = 'Members';
                    RunObject = Page "HR Commitee Members";
                    RunPageLink = Committee=field(Code);
                }
            }
        }
    }
}

