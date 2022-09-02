#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516087 "Accountants  Role Centre"
{
    Caption = 'Accounts  Role Centre';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1000000015)
            {
            }
            part(Control3;"My Job Queue")
            {
                ApplicationArea = Advanced;
                Visible = false;
            }
            part(Control2;"Membership Cue")
            {
                AccessByPermission = TableData "Sales Shipment Header"=R;
                ApplicationArea = Basic,Suite;
            }
            part(Control1;"Team Member Activities")
            {
                ApplicationArea = Suite;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Customer Care logs")
            {
                ApplicationArea = Basic;
                Caption = 'Customer Care logs';
                Image = "Report";
                RunObject = Report "Treasury Transfer.";
            }
            action("Member Statement")
            {
                ApplicationArea = Basic;
                Caption = 'Member Statement';
                Image = "Report";
                RunObject = Report "Member Account Statement-New";
            }
        }
        area(embedding)
        {
            action("51516435")
            {
                ApplicationArea = Basic;
                Caption = 'Fosa Accounts';
                RunObject = Page "FOSA Accounts Details Master";
            }
            action("Member List")
            {
                ApplicationArea = Basic;
                Caption = 'Member List';
                RunObject = Page "Member List";
            }
        }
        area(processing)
        {
            action("Defaulter aging report")
            {
                ApplicationArea = Basic;
                RunObject = Report "Loans Defaulter Aging";
            }
        }
    }
}

