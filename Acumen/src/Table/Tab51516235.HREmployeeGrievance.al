#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516235 "HR Employee Grievance"
{
    // DrillDownPageID = UnknownPage55664;
    // LookupPageID = UnknownPage55664;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                OK := Employee.Get("Employee No.");
                if OK then begin
                    "Employee First Name" := Employee."First Name";
                    "Employee Last Name" := Employee."Last Name";
                end;
            end;
        }
        field(2; "Follow Up Completed"; Boolean)
        {
        }
        field(3; "Follow Up Date (Actual Date)"; Date)
        {
        }
        field(4; "Release Date"; Date)
        {
        }
        field(5; "Follow Up Date"; Date)
        {

            trigger OnValidate()
            begin
                /*
                    IF ("Follow Up Date" <> 0D) THEN BEGIN
                        RelationManagement.RUNMODAL;
                        OK:= RelationManagement.ReturnResult;
                        IF OK THEN BEGIN
                           RelationTable.INIT;
                           RelationTable."Employee No.":= "Employee No.";
                           RelationTable.Date:= "Date Of Grievance";
                           RelationTable."Date Of Grievance":= "Date Of Grievance";
                           RelationTable."Follow Up Date - Grievance":= "Follow Up Date";
                            OK:= Employee.GET("Employee No.");
                            IF OK THEN BEGIN
                             RelationTable."Employee First Name":= Employee."Known As";
                             RelationTable."Employee Last Name":= Employee."Last Name";
                            END;
                           RelationTable.INSERT;
                        END;
                    END;
                *///return later

            end;
        }
        field(6; "Letter Sent To Employee"; Boolean)
        {
        }
        field(7; "Letter Sent By Whom"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(8; "Cause Of Grievance"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Grievance Cause"));
        }
        field(9; "Outcome Of Grievance"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Grievance Outcome"));
        }
        field(10; "Employee First Name"; Text[80])
        {
            CalcFormula = lookup("HR Employees"."First Name" where("No." = field("Employee No.")));
            FieldClass = FlowField;
        }
        field(11; "Employee Last Name"; Text[50])
        {
            CalcFormula = lookup("HR Employees"."Last Name" where("No." = field("Employee No.")));
            FieldClass = FlowField;
        }
        field(12; "Date Of Grievance"; Date)
        {

            trigger OnValidate()
            begin
                /*
                    IF ("Date Of Grievance" <> 0D) THEN BEGIN
                       CareerEvent.SetMessage('Grievance Reported By Employee');
                       CareerEvent.RUNMODAL;
                       OK:= CareerEvent.ReturnResult;
                        IF OK THEN BEGIN
                           CareerHistory.INIT;
                           CareerHistory."Employee No.":= "Employee No.";
                           CareerHistory."Date Of Event":= "Release Date";
                           CareerHistory."Career Event":= 'Grievance Reported By Employee' ;
                           CareerHistory.Grievance:= TRUE;
                            OK:= Employee.GET("Employee No.");
                            IF OK THEN BEGIN
                             CareerHistory."Employee First Name":= Employee."Known As";
                             CareerHistory."Employee Last Name":= Employee."Last Name";
                            END;
                           CareerHistory.INSERT;
                        END;
                    END;
                *///to return later

            end;
        }
        field(13; Comment; Boolean)
        {
            CalcFormula = exist("HR Human Resource Comments" where("Table Name" = const(Grievances),
                                                                    "No." = field("Employee No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        OK: Boolean;
        Employee: Record "HR Employees";
}

