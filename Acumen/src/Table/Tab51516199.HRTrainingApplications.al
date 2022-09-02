#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516199 "HR Training Applications"
{

    fields
    {
        field(1;"Application No";Code[20])
        {
            Editable = true;

            trigger OnValidate()
            begin
                if "Employee No." <> xRec."Employee No." then begin
                  HRSetup.Get;
                  NoSeriesMgt.TestManual(HRSetup."Training Application Nos.");
                  "No. Series":= '';
                end;
            end;
        }
        field(2;"Course Title";Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Training Needs".Code;

            trigger OnValidate()
            begin
                   HRTrainingNeeds.Reset ;
                if HRTrainingNeeds.Get("Course Title") then  begin
                //"Course Title":=HRTrainingNeeds.Code;
                Description:=HRTrainingNeeds.Description;
                "From Date":=HRTrainingNeeds."Start Date";
                "To Date":=HRTrainingNeeds."End Date";
                "Duration Units":=HRTrainingNeeds."Duration Units";
                Duration:=HRTrainingNeeds.Duration;
                "Cost Of Training":=HRTrainingNeeds."Cost Of Training";
                Location:=HRTrainingNeeds.Location;
                Provider:=HRTrainingNeeds.Provider;
                "Provider Name":=HRTrainingNeeds."Provider Name";
                 end ;
            end;
        }
        field(3;"From Date";Date)
        {
            Editable = false;
        }
        field(4;"To Date";Date)
        {
            Editable = false;
        }
        field(5;"Duration Units";Option)
        {
            Editable = false;
            OptionMembers = Hours,Days,Weeks,Months,Years;
        }
        field(6;Duration;Decimal)
        {
            Editable = false;
        }
        field(7;"Cost Of Training";Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                if Posted then begin
                if Duration <> xRec.Duration then begin
                Error('%1','You cannot change the costs after posting');
                Duration := xRec.Duration;
                end
                end
            end;
        }
        field(8;Location;Text[30])
        {
            Editable = false;
        }
        field(11;Posted;Boolean)
        {
            Editable = true;
        }
        field(12;Description;Text[100])
        {
            Editable = false;
        }
        field(28;"Training Evaluation Results";Option)
        {
            OptionMembers = "Not Evaluated",Passed,Failed;
        }
        field(29;Year;Integer)
        {
        }
        field(30;Provider;Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.",Provider);
                        if Vend.Find('-') then
                        begin
                            "Provider Name":=Vend.Name;
                        end;
            end;
        }
        field(31;"Purpose of Training";Text[100])
        {
        }
        field(32;Status;Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(33;"Employee No.";Code[30])
        {
            NotBlank = true;
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                             HREmp.Get("Employee No.");
                             "Employee Department":=HREmp."Global Dimension 2 Code";
                             "Employee Name":=HREmp.FullName;
            end;
        }
        field(35;"Application Date";Date)
        {
            Editable = false;
        }
        field(36;"No. Series";Code[30])
        {
        }
        field(37;Address;Text[50])
        {
            Caption = 'Address';
        }
        field(39;Recommendations;Code[20])
        {
        }
        field(40;"User ID";Code[50])
        {
        }
        field(41;"Responsibility Center";Code[30])
        {
        }
        field(42;"Employee Department";Code[30])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(43;"Employee Name";Text[50])
        {
        }
        field(44;"Provider Name";Text[50])
        {
        }
        field(45;"Training Group No.";Code[30])
        {
            NotBlank = true;
            TableRelation = "HR Training Applications Group"."Training No.";
        }
        field(46;"No. of Participant";Integer)
        {
        }
        field(47;"Approved Cost";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Application No")
        {
            Clustered = true;
        }
        key(Key2;'')
        {
            Clustered = true;
            Enabled = false;
        }
        key(Key3;'')
        {
            Enabled = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

                                if Status <> Status::New then
                                Error(mcontent);
    end;

    trigger OnInsert()
    begin
        if "Application No" = '' then begin
             HRSetup.Get;
             HRSetup.TestField(HRSetup."Training Application Nos.");
             NoSeriesMgt.InitSeries(HRSetup."Training Application Nos.",xRec."No. Series",0D,"Application No","No. Series");
        end;

         "User ID":=UserId;
         "Application Date":=Today;
    end;

    var
        HRTrainingNeeds: Record "HR Training Needs";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        mcontent: label 'Status must be new on Training Application No.';
        mcontent2: label '. Please cancel the approval request and try again';
        HREmp: Record "HR Employees";
        Vend: Record Vendor;
}

