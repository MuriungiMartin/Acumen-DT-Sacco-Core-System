#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516206 "HR Disciplinary Cases"
{
    LookupPageID = UnknownPage53954;

    fields
    {
        field(1;"Case Number";Code[20])
        {
        }
        field(3;"Date of Complaint";Date)
        {
        }
        field(4;"Type of Disciplinary Case";Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code where (Type=const("Disciplinary Case"));
        }
        field(5;"Recommended Action";Code[20])
        {
            TableRelation = "HR Lookup Values".Code where (Type=const("Disciplinary Action"));
        }
        field(6;"Case Description";Text[250])
        {
        }
        field(7;Accuser;Code[10])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(8;"Witness #1";Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(9;"Witness #2";Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(10;"Action Taken";Code[20])
        {
            TableRelation = "HR Lookup Values".Code where (Type=const("Disciplinary Action"));
        }
        field(11;"Date To Discuss Case";Date)
        {
        }
        field(12;"Document Link";Text[200])
        {
        }
        field(13;"Disciplinary Remarks";Code[50])
        {
        }
        field(14;Comments;Text[250])
        {
        }
        field(15;"Case Discussion";Boolean)
        {
        }
        field(16;"Body Handling The Complaint";Code[10])
        {
        }
        field(17;Recomendations;Code[10])
        {
        }
        field(18;"HR/Payroll Implications";Integer)
        {
        }
        field(19;"Support Documents";Option)
        {
            OptionMembers = Yes,No;
        }
        field(20;"Policy Guidlines In Effect";Code[10])
        {
            TableRelation = "HR Policies".Code;
        }
        field(21;Status;Option)
        {
            Editable = false;
            OptionMembers = Open,Closed;
        }
        field(22;"Mode of Lodging the Complaint";Text[30])
        {
        }
        field(23;"No. Series";Code[20])
        {
        }
        field(24;"Employee No";Code[30])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(25;Selected;Boolean)
        {
        }
        field(26;"Closed By";Code[20])
        {
        }
        field(3963;"Responsibility Center";Code[10])
        {
            TableRelation = "Responsibility Center";
        }
    }

    keys
    {
        key(Key1;"Employee No","Case Number")
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
        if "Case Number" = '' then begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Disciplinary Cases Nos.");
          NoSeriesMgt.InitSeries(HRSetup."Disciplinary Cases Nos.",xRec."No. Series",0D,"Case Number","No. Series");
        end;
    end;

    trigger OnModify()
    begin
                   if Status=Status::Closed then
                   Error('You cannot modify a closed case');
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

