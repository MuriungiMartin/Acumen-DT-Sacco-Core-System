#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516198 "HR Employee Exit Interviews"
{
    LookupPageID = UnknownPage55642;

    fields
    {
        field(1;"Exit Interview No";Code[10])
        {
        }
        field(2;"Date Of Interview";Date)
        {

            trigger OnValidate()
            begin
                
                    /* IF ("Date Of Interview" <> 0D) AND ("Date Of Interview" <> xRec."Date Of Interview") THEN BEGIN
                       CareerEvent.SetMessage('Exit Interview Conducted');
                       CareerEvent.RUNMODAL;
                       OK:= CareerEvent.ReturnResult;
                       IF OK THEN BEGIN
                           CareerHistory.INIT;
                           CareerHistory."Employee No.":= "Employee No.";
                           CareerHistory."Date Of Event":= "Date Of Interview";
                           CareerHistory."Career Event":= 'Exit Interview Conducted';
                           CareerHistory."Exit Interview":= TRUE;
                            OK:= Employee.GET("Employee No.");
                            IF OK THEN BEGIN
                             CareerHistory."Employee First Name":= Employee."Known As";
                             CareerHistory."Employee Last Name":= Employee."Last Name";
                            END;
                           CareerHistory.INSERT;
                        END;
                     END;
                       */

            end;
        }
        field(3;"Interview Done By";Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.","Interview Done By");
                if HREmp.Find('-') then
                begin
                    IntFullName:=HREmp."First Name" + ' '+ HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Interviewer Name":=IntFullName;
                end;
            end;
        }
        field(4;"Re Employ In Future";Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(5;"Reason For Leaving";Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Deceased,Termination,"Contract Ended",Abscondment,"Appt. Revoked","Contract Termination",Retrenchment,Other;
        }
        field(6;"Reason For Leaving (Other)";Text[150])
        {
        }
        field(7;"Date Of Leaving";Date)
        {
        }
        field(10;Comment;Boolean)
        {
            CalcFormula = exist("HR Human Resource Comments" where ("Table Name"=const("Exit Interviews"),
                                                                    "No."=field("Employee No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11;"Employee No.";Code[20])
        {
            TableRelation = "HR Employees"."No." where (Status=const(Active));

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.","Employee No.");
                if HREmp.Find('-') then
                begin
                    EmpFullName:=HREmp."First Name" + ' '+ HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Employee Name":=EmpFullName;
                end;
            end;
        }
        field(12;"No Series";Code[10])
        {
        }
        field(13;"Form Submitted";Boolean)
        {

            trigger OnValidate()
            begin
                    HREmp.Reset;
                    HREmp.SetRange("No.","Employee No.");
                    OK:= HREmp.Find('-');

                    if "Form Submitted"=true then begin

                            if OK then begin
                                HREmp.Status:=HREmp.Status::Inactive;
                                HREmp."Date Of Leaving the Company":= "Date Of Leaving";
                                HREmp."Termination Grounds":= "Reason For Leaving";
                                HREmp."Exit Interview Done by":="Interview Done By";
                                HREmp.Modify;
                            end
                    end;

                    if "Form Submitted"=false then begin
                           if OK then begin
                                HREmp.Status:=HREmp.Status::Active;
                                HREmp."Date Of Leaving the Company":=0D;
                                HREmp."Termination Grounds":= HREmp."termination grounds"::" ";
                                HREmp."Exit Interview Done by":='';
                                HREmp.Modify;
                           end;
                    end;
            end;
        }
        field(14;"Global Dimension 2";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(15;"Employee Name";Text[50])
        {
        }
        field(16;"Interviewer Name";Text[50])
        {
        }
    }

    keys
    {
        key(Key1;"Exit Interview No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Exit Interview No" = '' then begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Exit Interview Nos");
          NoSeriesMgt.InitSeries(HRSetup."Exit Interview Nos",xRec."No Series",0D,"Exit Interview No","No Series");
        end;
    end;

    var
        OK: Boolean;
        HREmp: Record "HR Employees";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpFullName: Text;
        IntFullName: Text;
}

