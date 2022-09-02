#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516240 "HR Interview Evaluation"
{

    fields
    {
        field(10;"Interview No.";Code[20])
        {

            trigger OnValidate()
            begin
                /*IF "Interview No." <> xRec."Interview No." THEN BEGIN
                  HRSetup.GET;
                  NoSeriesMgt.TestManual(HRSetup."Job Interview Nos");
                 // "No series" := '';
                  NoSeriesMgt.InitSeries(HRSetup."Job Interview Nos",xRec."No series",0D,"Interview No.","No series");
                END;
                  */

            end;
        }
        field(20;"Application No.";Code[20])
        {
            TableRelation = "HR Job Applications"."Application No";

            trigger OnValidate()
            begin
                HrJobs.Reset;
                if HrJobs.Get("Application No.") then begin
                 "First Name":=HrJobs."First Name";
                 "Middle Name":= HrJobs."Middle Name" ;
                 "Last Name":= HrJobs."Last Name"     ;
                 Initial:= HrJobs.Initials ;
                 "Date Applied":= HrJobs."Date Applied" ;
                 Email:= HrJobs."E-Mail" ;
                 "Job Title":=HrJobs."Job Applied For";

                objEmpReq.Reset;
                objEmpReq.SetRange(objEmpReq."Requisition No.",HrJobs."Employee Requisition No");
                if objEmpReq.Find('-') then
                 begin
                  "Job Position":=objEmpReq."Job ID";
                  "Responsibility Center":=objEmpReq."Responsibility Center";
                 end;
                end;
            end;
        }
        field(30;"First Name";Text[50])
        {
            Editable = false;
        }
        field(40;"Middle Name";Text[50])
        {
            Editable = false;
        }
        field(50;"Last Name";Text[50])
        {
            Editable = false;
        }
        field(60;Initial;Text[30])
        {
            Editable = false;
        }
        field(70;"Date Applied";Date)
        {
            Editable = false;
        }
        field(80;Email;Text[50])
        {
            Editable = false;
        }
        field(90;"Interview Date";Date)
        {
        }
        field(100;"Interview Done By";Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                                    if HREmp.Get("Interview Done By") then
                                   "Interviewer Name":=HREmp.FullName;
            end;
        }
        field(110;"Interviewer Name";Text[50])
        {
            Editable = false;
        }
        field(115;"No series";Code[20])
        {
        }
        field(120;"Job Title";Code[20])
        {
            TableRelation = "HR Jobs";

            trigger OnValidate()
            begin
                 if Hrjob1.Get("Job Title")  then
                 "Job Position":= Hrjob1."Job Description" ;
            end;
        }
        field(130;"Job Position";Text[50])
        {
        }
        field(140;Status;Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(150;"Job Acceptance";Boolean)
        {
        }
        field(160;"Stage 1 Score";Decimal)
        {
            CalcFormula = sum("HR Interview Specific Evaluatn"."Stage 1 Score" where ("Interview No."=field("Interview No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(170;"Stage 2 Score";Decimal)
        {
            CalcFormula = sum("HR Interview Specific Evaluatn"."Stage 2 Score" where ("Interview No."=field("Interview No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(180;"Stage 3 Score";Decimal)
        {
            CalcFormula = sum("HR Interview Specific Evaluatn"."Stage 3 Score" where ("Interview No."=field("Interview No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(190;"Recommend for Stage 2";Boolean)
        {
        }
        field(200;"Recommend for Stage 3";Boolean)
        {
        }
        field(210;"Recommendation for Hire";Boolean)
        {
        }
        field(220;Comment;Text[250])
        {
        }
        field(230;"Responsibility Center";Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
    }

    keys
    {
        key(Key1;"Interview No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Interview No." = '' then
          begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Job Interview Nos") ;
           NoSeriesMgt.InitSeries(HRSetup."Job Interview Nos",xRec."No series",0D,"Interview No.","No series");
           end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "HR Setup";
        HrJobs: Record "HR Job Applications";
        Hrjob1: Record "HR Jobss";
        HREmp: Record "HR Employees";
        objEmpReq: Record "HR Employee Requisitions";
}

