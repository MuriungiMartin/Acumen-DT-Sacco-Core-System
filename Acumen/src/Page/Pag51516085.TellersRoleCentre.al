#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516085 "Tellers  Role Centre"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control2;"Membership Cue")
            {
                AccessByPermission = TableData "Sales Shipment Header"=R;
                ApplicationArea = Basic,Suite;
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
    }
}

