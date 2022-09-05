#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516929 "CRM Trainings"
{
    // DrillDownPageID = UnknownPage55635;
    // LookupPageID = UnknownPage55635;

    fields
    {
        field(1;"Code";Code[20])
        {

            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                  SalesSetup.Get;
                  NoSeriesMgt.TestManual(SalesSetup."BD Training Nos");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;Description;Text[200])
        {
        }
        field(3;"Start Date";Date)
        {
        }
        field(4;"End Date";Date)
        {
        }
        field(5;"Duration Units";Option)
        {
            OptionMembers = Hours,Days,Weeks,Months,Years;
        }
        field(6;Duration;Decimal)
        {

            trigger OnValidate()
            begin
                /*BEGIN
                IF (Duration <> 0) AND ("Start Date" <> 0D) THEN
                
                "End Date" :=HRLeaveApp.DetermineLeaveReturnDate("Start Date",Duration);
                
                //---------------------------------------------------------
                "End Date":=CALCDATE('-1D',"End Date");
                mDay:=0;
                mDay:=DATE2DWY("End Date",1);
                IF mDay=6 THEN "End Date":=CALCDATE('+2D',"End Date");
                IF mDay=7 THEN "End Date":=CALCDATE('+1D',"End Date");
                //---------------------------------------------------------
                MODIFY;
                END;
                */

            end;
        }
        field(7;"Cost Of Training";Decimal)
        {

            trigger OnValidate()
            begin
                /*IF Posted THEN BEGIN
                IF Duration <> xRec.Duration THEN BEGIN
                MESSAGE('%1','You cannot change the costs after posting');
                Duration := xRec.Duration;
                END
                END
                */

            end;
        }
        field(8;Location;Text[100])
        {
        }
        field(10;"Re-Assessment Date";Date)
        {
        }
        field(12;"Need Source";Option)
        {
            OptionCaption = 'Appraisal,Succesion,Training,Employee,Employee Skill Plan';
            OptionMembers = Appraisal,Succesion,Training,Employee,"Employee Skill Plan";
        }
        field(13;Provider;Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                         /*Vend.RESET;
                         Vend.SETRANGE(Vend."No.",Provider);
                         IF Vend.FIND('-') THEN BEGIN
                            "Provider Name":=Vend.Name;
                         END;
                         */

            end;
        }
        field(15;Posted;Boolean)
        {
            Editable = false;
        }
        field(16;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(17;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(18;Closed;Boolean)
        {
            Editable = false;
        }
        field(19;"Qualification Code";Code[20])
        {
            TableRelation = "HR Job Qualifications".Code where ("Qualification Type"=field("Qualification Type"));

            trigger OnValidate()
            begin
                                    /*HRQualifications.SETRANGE(HRQualifications.Code,"Qualification Code");
                                    IF HRQualifications.FIND('-') THEN
                                    "Qualification Description":=HRQualifications.Description;*/

            end;
        }
        field(20;"Qualification Type";Code[30])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code where (Type=const("Qualification Type"));
        }
        field(21;"Qualification Description";Text[80])
        {
        }
        field(22;"Training Applicants";Integer)
        {
            CalcFormula = count("HR Training Applications" where ("Course Title"=field(Code)));
            FieldClass = FlowField;
        }
        field(23;"Training Applicants (Passed)";Integer)
        {
            CalcFormula = count("HR Training Applications" where ("Course Title"=field(Code),
                                                                  "Training Evaluation Results"=const(Passed)));
            FieldClass = FlowField;
        }
        field(24;"Training Applicants (Failed)";Integer)
        {
            CalcFormula = count("HR Training Applications" where ("Course Title"=field(Code),
                                                                  "Training Evaluation Results"=const(Failed)));
            FieldClass = FlowField;
        }
        field(25;"Provider Name";Text[50])
        {
        }
        field(26;"Job id";Code[50])
        {
        }
        field(27;"Responsibility Center";Code[10])
        {
            TableRelation = "Responsibility Center".Code where ("Global Dimension 2 Code"=field("Global Dimension 2 Code"));
        }
        field(28;"No. Series";Code[20])
        {
        }
        field(29;Status;Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(30;"Training Status";Option)
        {
            OptionCaption = 'Open,Closed';
            OptionMembers = Open,Closed;
        }
        field(31;"Created By";Code[30])
        {
        }
        field(32;"Created On";Date)
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
          SalesSetup.Get;
          SalesSetup.TestField(SalesSetup."BD Training Nos");
          NoSeriesMgt.InitSeries(SalesSetup."BD Training Nos",xRec."No. Series",0D,Code,"No. Series");
        end;

        "Created By":=UserId;
        "Created On":=Today;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

