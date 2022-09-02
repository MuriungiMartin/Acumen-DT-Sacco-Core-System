#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516247 "HR Rewards Header"
{

    fields
    {
        field(1;"No.";Code[20])
        {
        }
        field(2;"Employee No.";Code[20])
        {
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                if HREmployee.Get("Employee No.") then  begin
                   "Employee Name":=HREmployee."First Name"+' '+HREmployee."Middle Name"+' '+HREmployee."Last Name";
                    Department:=HREmployee."Department Code";
                  end;
            end;
        }
        field(3;"Employee Name";Text[60])
        {
        }
        field(4;Department;Code[20])
        {
            Editable = false;
        }
        field(5;"Request Date";Date)
        {
        }
        field(6;Type;Option)
        {
            OptionCaption = 'Reward,Compensation';
            OptionMembers = Reward,Compensation;
        }
        field(7;"No Series";Code[20])
        {
        }
        field(8;"User ID";Code[20])
        {
        }
        field(9;Status;Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Canceled,Rejected,Approved';
            OptionMembers = New,"Pending Approval",Canceled,Rejected,Approved;
        }
        field(10;"Responsibility Center";Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(11;"Last Date Modified";Date)
        {
        }
    }

    keys
    {
        key(Key1;"No.")
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
        if "No." = '' then begin
          HRSetup.Get;
          HRSetup.TestField(HRSetup."Company Documents");
          NoSeriesMgt.InitSeries(HRSetup."Company Documents",xRec."No Series",0D,"No.","No Series");
        end;
        "User ID":=UserId;
    end;

    trigger OnModify()
    begin
        "Last Date Modified":=Today;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmployee: Record "HR Employees";
}

