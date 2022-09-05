#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516475 "Customer Care Role"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1000000004)
            {
                part("Credit Processor";"Credit Processor Role")
                {
                }
                systempart(Control1000000002;Outlook)
                {
                }
                systempart(Control1000000001;MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Loans Calculator")
            {
                ApplicationArea = Basic;
                Image = AdjustEntries;
                RunObject = Page "Loan Calculator";
            }
            action("Membership Applications")
            {
                ApplicationArea = Basic;
                Image = Add;
                RunObject = Page "Posted  Leave Application Card";
            }
            action("Members  List")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                RunObject = Page "Staff Leave Claim Lines";
            }
            action("Bosa Loans")
            {
                ApplicationArea = Basic;
                Image = Aging;
                RunObject = Page "HR Job Responsibilities";
            }
        }
        area(creation)
        {
            action("Fosa Loans")
            {
                ApplicationArea = Basic;
                Image = View;
                //RunObject = Page "HR Applicant Referees";
            }
            action("Fosa Accounts")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                RunObject = Page "HR Activity Participants SF";
            }
        }
    }
}

