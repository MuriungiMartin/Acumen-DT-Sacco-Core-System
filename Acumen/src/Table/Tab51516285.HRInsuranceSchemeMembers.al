#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516285 "HR Insurance Scheme Members"
{

    fields
    {
        field(1;"Scheme No";Code[10])
        {
            TableRelation = "HR Medical Schemes"."Scheme No";

            trigger OnValidate()
            begin

                         Medscheme.Reset;
                         Medscheme.SetRange(Medscheme."Scheme No","Scheme No");
                          if Medscheme.Find('-') then begin
                         "Out-Patient Limit":=Medscheme."Out-patient limit";
                         "In-patient Limit":=Medscheme."In-patient limit";
                         "Balance In- Patient":="In-patient Limit"-"Cumm.Amount Spent";
                         "Balance Out- Patient":="Out-Patient Limit"-"Cumm.Amount Spent Out";
                          end;
            end;
        }
        field(2;"Employee No";Code[10])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                         Emp.Reset;
                         Emp.SetRange(Emp."No.","Employee No");
                         if Emp.Find('-') then begin
                         "First Name":=Emp."First Name"+' '+Emp."Middle Name";
                         "Last Name":=Emp."Last Name";
                         Designation:=Emp."Job Title";
                         Department:=Emp."Department Code";
                         "Scheme Join Date":=Emp."Medical Scheme Join Date";

                         //"In-patient Limit":=Medscheme."In-patient limit";
                          end;
            end;
        }
        field(3;"First Name";Text[30])
        {
        }
        field(4;"Last Name";Text[30])
        {
        }
        field(5;Designation;Text[50])
        {
        }
        field(6;Department;Text[100])
        {
        }
        field(7;"Scheme Join Date";Date)
        {
        }
        field(8;"Scheme Anniversary";Date)
        {
        }
        field(9;"Cumm.Amount Spent";Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Amount Charged" where ("Member No"=field("Employee No"),
                                                                          "Claim Type"=const(Inpatient)));
            FieldClass = FlowField;
        }
        field(10;"Out-Patient Limit";Decimal)
        {
        }
        field(11;"In-patient Limit";Decimal)
        {
        }
        field(12;"Maximum Cover";Decimal)
        {
        }
        field(13;"Cumm.Amount Spent Out";Decimal)
        {
            CalcFormula = sum("HR Medical Claims"."Amount Charged" where ("Member No"=field("Employee No"),
                                                                          "Claim Type"=const(Outpatient)));
            FieldClass = FlowField;
        }
        field(14;"Balance Out- Patient";Decimal)
        {
        }
        field(15;"Balance In- Patient";Decimal)
        {
        }
        field(16;"No Of Dependants";Code[10])
        {
        }
    }

    keys
    {
        key(Key1;"Scheme No","Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Medscheme: Record "HR Medical Schemes";
        Emp: Record "HR Employees";
}

