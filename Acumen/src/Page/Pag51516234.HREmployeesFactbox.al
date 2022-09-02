#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516234 "HR Employees Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            field(PersonalDetails;PersonalDetails)
            {
                ApplicationArea = Basic;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("No.";"No.")
            {
                ApplicationArea = Basic;
            }
            field("First Name";"First Name")
            {
                ApplicationArea = Basic;
            }
            field("Middle Name";"Middle Name")
            {
                ApplicationArea = Basic;
            }
            field("Last Name";"Last Name")
            {
                ApplicationArea = Basic;
            }
            field("E-Mail";"E-Mail")
            {
                ApplicationArea = Basic;
            }
            field("Company E-Mail";"Company E-Mail")
            {
                ApplicationArea = Basic;
            }
            field(Status;Status)
            {
                ApplicationArea = Basic;
            }
            field(JobDetails;JobDetails)
            {
                ApplicationArea = Basic;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("Job Title";"Job Title")
            {
                ApplicationArea = Basic;
            }
            field(Grade;Grade)
            {
                ApplicationArea = Basic;
            }
            field(LeaveDetails;LeaveDetails)
            {
                ApplicationArea = Basic;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("Annual Leave Account";"Annual Leave Account")
            {
                ApplicationArea = Basic;
            }
            field("Compassionate Leave Acc.";"Compassionate Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Maternity Leave Acc.";"Maternity Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Paternity Leave Acc.";"Paternity Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Sick Leave Acc.";"Sick Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Study Leave Acc";"Study Leave Acc")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }

    var
        PersonalDetails: label 'Personal Details';
        BankDetails: label 'Bank Details';
        JobDetails: label 'Job Details';
        LeaveDetails: label 'Leave Details';
}

