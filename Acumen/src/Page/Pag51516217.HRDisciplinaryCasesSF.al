#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516217 "HR Disciplinary Cases SF"
{
    PageType = List;
    SourceTable = "HR Disciplinary Cases";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Case Number";"Case Number")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Complaint";"Date of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(Selected;Selected)
                {
                    ApplicationArea = Basic;
                }
                field("Type of Disciplinary Case";"Type of Disciplinary Case")
                {
                    ApplicationArea = Basic;
                }
                field("Case Description";"Case Description")
                {
                    ApplicationArea = Basic;
                }
                field("Case Discussion";"Case Discussion")
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Lodging the Complaint";"Mode of Lodging the Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(Accuser;Accuser)
                {
                    ApplicationArea = Basic;
                }
                field("Witness #1";"Witness #1")
                {
                    ApplicationArea = Basic;
                }
                field("Witness #2";"Witness #2")
                {
                    ApplicationArea = Basic;
                }
                field("Recommended Action";"Recommended Action")
                {
                    ApplicationArea = Basic;
                }
                field("Action Taken";"Action Taken")
                {
                    ApplicationArea = Basic;
                }
                field("Support Documents";"Support Documents")
                {
                    ApplicationArea = Basic;
                }
                field("Policy Guidlines In Effect";"Policy Guidlines In Effect")
                {
                    ApplicationArea = Basic;
                }
                field(Recomendations;Recomendations)
                {
                    ApplicationArea = Basic;
                }
                field("HR/Payroll Implications";"HR/Payroll Implications")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Remarks";"Disciplinary Remarks")
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
}

