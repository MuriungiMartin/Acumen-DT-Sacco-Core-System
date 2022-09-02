#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516148 "HR Medical Claims-Posted"
{
    ApplicationArea = Basic;
    CardPageID = "Medical Claim Posted";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Medical Claims";
    SourceTableView = where(Posted=filter(true));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Claim No";"Claim No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Type";"Claim Type")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Date";"Claim Date")
                {
                    ApplicationArea = Basic;
                }
                field(Dependants;Dependants)
                {
                    ApplicationArea = Basic;
                }
                field("Patient Name";"Patient Name")
                {
                    ApplicationArea = Basic;
                }
                field("Document Ref";"Document Ref")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Service";"Date of Service")
                {
                    ApplicationArea = Basic;
                }
                field("Attended By";"Attended By")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Charged";"Amount Charged")
                {
                    ApplicationArea = Basic;
                }
                field(Comments;Comments)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        Dependants: Record "HR Employee Kin";
}

