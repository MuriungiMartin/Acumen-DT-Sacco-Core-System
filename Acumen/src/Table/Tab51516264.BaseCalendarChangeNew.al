#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516264 "Base Calendar Change New"
{
    Caption = 'Base Calendar Change';
    DataCaptionFields = "Base Calendar Code";

    fields
    {
        field(1;"Base Calendar Code";Code[10])
        {
            Caption = 'Base Calendar Code';
            Editable = false;
            TableRelation = "Base Calendar New";
        }
        field(2;"Recurring System";Option)
        {
            Caption = 'Recurring System';
            OptionCaption = ' ,Annual Recurring,Weekly Recurring';
            OptionMembers = " ","Annual Recurring","Weekly Recurring";

            trigger OnValidate()
            begin
                if "Recurring System" <> xRec."Recurring System" then
                  case "Recurring System" of
                    "recurring system"::"Annual Recurring":
                      Day := Day::" ";
                    "recurring system"::"Weekly Recurring":
                      Date := 0D;
                  end;
            end;
        }
        field(3;Date;Date)
        {
            Caption = 'Date';

            trigger OnValidate()
            begin
                if ("Recurring System" = "recurring system"::" ") or
                   ("Recurring System" = "recurring system"::"Annual Recurring")
                then
                  TestField(Date)
                else
                  TestField(Date,0D);
                UpdateDayName;
            end;
        }
        field(4;Day;Option)
        {
            Caption = 'Day';
            OptionCaption = ' ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;

            trigger OnValidate()
            begin
                if "Recurring System" = "recurring system"::"Weekly Recurring" then
                  TestField(Day);
                UpdateDayName;
            end;
        }
        field(5;Description;Text[30])
        {
            Caption = 'Description';
        }
        field(6;Nonworking;Boolean)
        {
            Caption = 'Nonworking';
            InitValue = true;
        }
    }

    keys
    {
        key(Key1;"Base Calendar Code","Recurring System",Date,Day)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        CheckEntryLine;
    end;

    trigger OnModify()
    begin
        CheckEntryLine;
    end;

    trigger OnRename()
    begin
        CheckEntryLine;
    end;


    procedure UpdateDayName()
    var
        DateTable: Record Date;
    begin
        if (Date > 0D) and
           ("Recurring System" = "recurring system"::"Annual Recurring")
        then
          Day := Day::" "
        else begin
          DateTable.SetRange("Period Type",DateTable."period type"::Date);
          DateTable.SetRange("Period Start",Date);
          if DateTable.FindFirst then
            Day := DateTable."Period No.";
        end;
        if (Date = 0D) and (Day = Day::" ") then begin
          Day := xRec.Day;
          Date := xRec.Date;
        end;
        if "Recurring System" = "recurring system"::"Annual Recurring" then
          TestField(Day,Day::" ");
    end;


    procedure CheckEntryLine()
    begin
        case "Recurring System" of
          "recurring system"::" ":
            begin
              TestField(Date);
              TestField(Day);
            end;
          "recurring system"::"Annual Recurring":
            begin
              TestField(Date);
              TestField(Day,Day::" ");
            end;
          "recurring system"::"Weekly Recurring":
            begin
              TestField(Date,0D);
              TestField(Day);
            end;
        end;
    end;
}

