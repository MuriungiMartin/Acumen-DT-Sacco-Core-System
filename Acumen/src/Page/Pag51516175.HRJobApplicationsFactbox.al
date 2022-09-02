#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516175 "HR Job Applications Factbox"
{
    PageType = ListPart;
    SourceTable = "HR Job Applications";

    layout
    {
        area(content)
        {
            field(GeneralInfo;GeneralInfo)
            {
                ApplicationArea = Basic;
                Style = Strong;
                StyleExpr = true;
            }
            field("Application No";"Application No")
            {
                ApplicationArea = Basic;
            }
            field("Date Applied";"Date Applied")
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
            field(Qualified;Qualified)
            {
                ApplicationArea = Basic;
            }
            field("Interview Invitation Sent";"Interview Invitation Sent")
            {
                ApplicationArea = Basic;
            }
            field("ID Number";"ID Number")
            {
                ApplicationArea = Basic;
            }
            field(PersonalInfo;PersonalInfo)
            {
                ApplicationArea = Basic;
                Style = Strong;
                StyleExpr = true;
            }
            field(Status;Status)
            {
                ApplicationArea = Basic;
            }
            field(Age;Age)
            {
                ApplicationArea = Basic;
            }
            field("Marital Status";"Marital Status")
            {
                ApplicationArea = Basic;
            }
            field(CommunicationInfo;CommunicationInfo)
            {
                ApplicationArea = Basic;
                Style = Strong;
                StyleExpr = true;
            }
            field("Cell Phone Number";"Cell Phone Number")
            {
                ApplicationArea = Basic;
                ExtendedDatatype = PhoneNo;
            }
            field("E-Mail";"E-Mail")
            {
                ApplicationArea = Basic;
                ExtendedDatatype = EMail;
            }
            field("Work Phone Number";"Work Phone Number")
            {
                ApplicationArea = Basic;
                ExtendedDatatype = PhoneNo;
            }
        }
    }

    actions
    {
    }

    var
        GeneralInfo: label 'General Applicant Information';
        PersonalInfo: label 'Personal Infomation';
        CommunicationInfo: label 'Communication Information';
}

