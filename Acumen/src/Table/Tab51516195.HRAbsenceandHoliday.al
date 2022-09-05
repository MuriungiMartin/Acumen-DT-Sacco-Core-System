#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516195 "HR Absence and Holiday"
{
    DataCaptionFields = "Employee No.", "Start Date", "End Date", "Days Lost", Reason, Cost, "% On Cost", "Additional Cost", "Total Cost";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                /*
                OK:= Employee.GET("Employee No.");
                IF OK THEN BEGIN
                  "Job Title":= Employee.Position;
                  Department:= Employee."Department Code";
                 "Employee First Name":= Employee."First Name";
                  "Employee Last Name":= Employee."Last Name";
                END;
                */

            end;
        }
        field(2; "Start Date"; Date)
        {

            trigger OnValidate()
            var
                "lRec Employee": Record "HR Employees";
                "lRec Job Budget Entry": Record "G/L Budget Entry";
            begin
                /*
                  IF (("End Date" <> 0D) AND ("Start Date" <> 0D)) THEN BEGIN
                  IF DifDates.ReservedDates("Start Date","End Date","Employee No.") THEN
                  MESSAGE('The time between %1 and %2 is already scheduled for employee %3',"Start Date","End Date","Employee No.");
                                  "Days Lost":= DifDates.DifferenceStartEnd("Start Date","End Date");
                                {   CompPayPer.FIND('-');
                                  "Hours Lost":= ("Days Lost") * (CompPayPer."Working Hours Per Day");

                                   Employee.SETFILTER("No.","Employee No.");
                                   Employee.GET("Employee No.");
                                   IF (CompPayPer."Working Days Per Year" = 0) THEN
                                    MESSAGE('Enter the amount of working days per year in the Company Pay Periods Screen! (Setup)')
                                   ELSE IF (Employee."Contracted Hours" = 0) THEN
                                    MESSAGE('Amount of contracted hours must be entered onto the employee details screen!')
                                   ELSE BEGIN
                                   HourlyRate:= (Employee."Per Annum"/CompPayPer."Working Days Per Year")/(Employee."Contracted Hours"/5);
                                   Cost:= ("Hours Lost") * (HourlyRate);
                                   END;
                                   }
                                   "Total Cost":= Cost;

                 END;
                 */
                //commented by linus
                /*
                IF "lRec Employee".GET ("Employee No.") THEN BEGIN
                   IF "lRec Employee"."Resource No." <> '' THEN BEGIN
                      "lRec Job Budget Entry".SETRANGE("lRec Job Budget Entry".Type,"lRec Job Budget Entry".Type::Resource);
                      "lRec Job Budget Entry".SETRANGE("lRec Job Budget Entry"."No.","lRec Employee"."Resource No.");
                      "lRec Job Budget Entry".SETRANGE("lRec Job Budget Entry".Date,"Start Date");
                      IF "lRec Job Budget Entry".FIND('-') THEN
                        ERROR ('The employee is already booked for %1 on Job number %2!',"lRec Job Budget Entry".Date,
                              "lRec Job Budget Entry"."Job No.");

                     END;
                  END;
               */

            end;
        }
        field(3; "End Date"; Date)
        {

            trigger OnValidate()
            var
                "lRec Job budget Entry": Record "G/L Budget Entry";
                "lRec Employee": Record "HR Employees";
            begin
                /*
                 IF DifDates.ReservedDates("Start Date","End Date","Employee No.") THEN
                  MESSAGE('The time between %1 and %2 is already scheduled for employee %3',"Start Date","End Date","Employee No.");
                                  "Days Lost":= DifDates.DifferenceStartEnd("Start Date","End Date");
                                   CompPayPer.FIND('-');
                                                    {

                                // "Hours Lost":= ("Days Lost") * (CompPayPer."Working Hours Per Day");

                                   Employee.SETFILTER("No.","Employee No.");
                                   Employee.GET("Employee No.");
                                   IF (CompPayPer."Working Days Per Year" = 0) THEN
                                    ERROR('Enter the amount of working days per year in the Company Pay Periods Screen! (Setup)')
                                   ELSE IF (Employee."Contracted Hours" = 0) THEN
                                    ERROR('Amount of contracted hours must be entered onto the employee details screen!')
                                   ELSE BEGIN
                                   HourlyRate:= (Employee."Per Annum"/CompPayPer."Working Days Per Year")/(Employee."Contracted Hours"/5);
                                   Cost:= ("Hours Lost") * (HourlyRate);
                                   END;
                                   }
                                   "Total Cost":= Cost;


                 IF "Start Date" = 0D THEN
                   ERROR ('You must spesify the Start Date!');
               */

                //commented by linus
                /*
                IF "lRec Employee".GET ("Employee No.") THEN BEGIN
                   IF "lRec Employee"."Resource No." <> '' THEN BEGIN
                     "lRec Job budget Entry".SETRANGE("lRec Job budget Entry".Type,"lRec Job budget Entry".Type::Resource);
                     "lRec Job budget Entry".SETRANGE("lRec Job budget Entry"."No.","lRec Employee"."Resource No.");
                     "lRec Job budget Entry".SETRANGE("lRec Job budget Entry".Date,"Start Date","End Date");
                     IF "lRec Job budget Entry".FIND('-') THEN
                      ERROR ('The employee is already booked for %1 on Job number %2!',"lRec Job budget Entry".Date,
                             "lRec Job budget Entry"."Job No.");


                   END;
                 END;
                */


                //"Days Lost":="End Date"-"Start Date" ;
                Message('%1', "Days Lost");

            end;
        }
        field(4; "Days Lost"; Integer)
        {

            trigger OnValidate()
            begin
                /*
                  {  CompPayPer.FIND('-');
                  "Hours Lost":= ("Days Lost") * (CompPayPer."Working Hours Per Day");

                   Employee.SETFILTER("No.","Employee No.");
                   Employee.GET("Employee No.");
                   IF (CompPayPer."Working Days Per Year" = 0) THEN
                    MESSAGE('Enter the amount of working days per year in the Company Pay Periods Screen! (Setup)')
                   ELSE IF (Employee."Contracted Hours" = 0) THEN
                    MESSAGE('Amount of contracted hours must be entered onto the employee details screen!')
                   ELSE BEGIN
                   HourlyRate:= (Employee."Per Annum"/CompPayPer."Working Days Per Year")/(Employee."Contracted Hours"/5);
                   Cost:= ("Hours Lost") * (HourlyRate);
                   END;
                   "Total Cost":= Cost;
                  }

                 // companyinfo.FIND('-');
                  "Hours Lost":= ("Days Lost") * (companyinfo."Working Hours Per Day");
                   emp.GET("Employee No.");
//                    Cost:= "Days Lost" * emp."Daily Rate";

                   "Total Cost":= Cost;
                   */

            end;
        }
        field(5; Reason; Option)
        {
            OptionMembers = Holiday,"Sick Leave",Training,Unauthorised,Maternity;
        }
        field(7; Cost; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Cost" := Cost + "% On Cost" + "Additional Cost";
            end;
        }
        field(8; "% On Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Cost" := Cost + "% On Cost" + "Additional Cost";
            end;
        }
        field(9; "Additional Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Cost" := Cost + "% On Cost" + "Additional Cost";
            end;
        }
        field(10; "Total Cost"; Decimal)
        {
        }
        field(11; "Hours Lost"; Integer)
        {
        }
        field(12; "Job Title"; Text[30])
        {
        }
        field(13; Department; Code[10])
        {
        }
        field(14; "Employee First Name"; Text[30])
        {
        }
        field(15; "Employee Last Name"; Text[30])
        {
        }
        field(16; "Resource No."; Code[20])
        {
            CalcFormula = lookup("HR Employees"."Resource No." where("No." = field("Employee No.")));
            FieldClass = FlowField;
        }
        field(17; Comment; Boolean)
        {
            CalcFormula = exist("HR Human Resource Comments" where("Table Name" = const("Absence and Holiday"), "No." = field("Employee No."), "Key Date" = field("Start Date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Line No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*OK:= Employee.GET("Employee No.");
        IF OK THEN BEGIN
         "Employee First Name":= Employee."First Name";
         "Employee Last Name":= Employee."Last Name";
         "Job Title":= Employee."Job Title";
         Department:= Employee."Department Code";

        END; */

    end;

    var
        // DifDates: Codeunit UnknownCodeunit51516113;
        // CompPayPer: Record Customer;
        Employee: Record "HR Employees";
        HourlyRate: Decimal;
        OK: Boolean;
        emp: Record "HR Employees";
        companyinfo: Record "Company Information";
}

