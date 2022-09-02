#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516177 "HR Jobss"
{
    DrillDownPageID = "HR Jobs List";
    LookupPageID = "HR Jobs List";

    fields
    {
        field(1;"Job ID";Code[60])
        {
            NotBlank = true;
        }
        field(2;"Job Description";Text[250])
        {
            Editable = true;
        }
        field(3;"No of Posts";Integer)
        {

            trigger OnValidate()
            begin
                if "No of Posts" <> xRec."No of Posts" then
                "Vacant Positions" := "No of Posts" - "Occupied Positions";
            end;
        }
        field(4;"Position Reporting to";Code[20])
        {
            TableRelation = "HR Jobss"."Job ID" where (Status=const(Approved));
        }
        field(5;"Occupied Positions";Integer)
        {
            CalcFormula = count("HR Employees" where ("Job Specification"=field("Job ID"),
                                                      Status=const(Active)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6;"Vacant Positions";Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                                 "Vacant Positions" := "No of Posts" - "Occupied Positions";
            end;
        }
        field(7;"Score code";Code[20])
        {
        }
        field(8;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(9;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(17;"Total Score";Decimal)
        {
            Editable = false;
        }
        field(19;"Main Objective";Text[250])
        {
        }
        field(21;"Key Position";Boolean)
        {
        }
        field(22;Category;Code[20])
        {
        }
        field(23;Grade;Code[20])
        {
            TableRelation = "HR Lookup Values".Code where (Type=const(Grade));
        }
        field(24;"Employee Requisitions";Integer)
        {
            CalcFormula = count("HR Employee Requisitions" where ("Job ID"=field("Job ID")));
            FieldClass = FlowField;
        }
        field(27;UserID;Code[50])
        {
        }
        field(28;"Supervisor/Manager";Code[50])
        {
            TableRelation = "HR Employees"."No." where (Status=const(Active));

            trigger OnValidate()
            begin
                                 HREmp.Get("Supervisor/Manager");
                                 "Supervisor Name":=HREmp.FullName;
            end;
        }
        field(29;"Supervisor Name";Text[60])
        {
            Editable = false;
        }
        field(30;Status;Option)
        {
            Editable = true;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(31;"Responsibility Center";Code[10])
        {
        }
        field(32;"Date Created";Date)
        {
        }
        field(33;"No. of Requirements";Integer)
        {
            CalcFormula = count("HR Job Requirements" where ("Job Id"=field("Job ID")));
            FieldClass = FlowField;
        }
        field(34;"No. of Responsibilities";Integer)
        {
            CalcFormula = count("HR Job Responsiblities" where ("Job ID"=field("Job ID")));
            FieldClass = FlowField;
        }
        field(44;"Is Supervisor";Boolean)
        {
        }
        field(45;"G/L Account";Code[50])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(46;"No series";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Job ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Job ID" = '' then
        begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Job Nos");
          NoSeriesMgt.InitSeries(HRSetup."Job Nos",xRec."No series",0D,"Job ID","No series");
        end;

         "Date Created":=Today;
    end;

    trigger OnModify()
    begin
         "Vacant Positions" := "No of Posts" - "Occupied Positions";
    end;

    var
        NoOfPosts: Decimal;
        HREmp: Record "HR Employees";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

