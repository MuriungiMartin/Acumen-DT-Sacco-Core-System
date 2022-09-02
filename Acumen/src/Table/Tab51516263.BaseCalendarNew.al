#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516263 "Base Calendar New"
{
    Caption = 'Base Calendar';
    DataCaptionFields = "Code",Name;
    LookupPageID = "Base Calendar List";

    fields
    {
        field(1;"Code";Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2;Name;Text[30])
        {
            Caption = 'Name';
        }
        field(3;"Customized Changes Exist";Boolean)
        {
            CalcFormula = exist("Customized Calendar Change" where ("Base Calendar Code"=field(Code)));
            Caption = 'Customized Changes Exist';
            Editable = false;
            FieldClass = FlowField;
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

    trigger OnDelete()
    begin
        CustCalendarChange.Reset;
        CustCalendarChange.SetRange("Base Calendar Code",Code);
        if CustCalendarChange.FindFirst then
          Error(Text001,Code);

        BaseCalendarLine.Reset;
        BaseCalendarLine.SetRange("Base Calendar Code",Code);
        BaseCalendarLine.DeleteAll;
    end;

    var
        CustCalendarChange: Record "Customized Calendar Change";
        BaseCalendarLine: Record "Base Calendar Change";
        Text001: label 'You cannot delete this record. Customized calendar changes exist for calendar code=<%1>.';
}

