#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516229 "HR Shortlisting Lines"
{
    Caption = 'Shorlisted Candidates';
    Editable = false;
    PageType = List;
    SourceTable = "HR Shortlisted Applicants";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Qualified;Qualified)
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualified';

                    trigger OnValidate()
                    begin
                        "Manual Change":=true;
                        Modify;
                    end;
                }
                field("Job Application No";"Job Application No")
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
                field("ID No";"ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Stage Score";"Stage Score")
                {
                    ApplicationArea = Basic;
                }
                field(Position;Position)
                {
                    ApplicationArea = Basic;
                }
                field(Employ;Employ)
                {
                    ApplicationArea = Basic;
                    Caption = 'Employed';
                }
                field("Reporting Date";"Reporting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Manual Change";"Manual Change")
                {
                    ApplicationArea = Basic;
                    Caption = 'Manual Change';
                }
            }
        }
    }

    actions
    {
    }

    var
        MyCount: Integer;


    procedure GetApplicantNo() AppicantNo: Code[20]
    begin
        //AppicantNo:=Applicant;
    end;
}

