#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516259 "HR Employee Transfer Lines"
{

    fields
    {
        field(1;"Request No";Code[50])
        {
        }
        field(2;"Employee No";Code[50])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                if Employees.Get("Employee No") then
                begin
                "Employee Name":=Employees."First Name"+' '+Employees."Middle Name"+' '+Employees."Last Name";
                //"Global Dimension 1 Code":=Employees."Global Dimension 1 Code";
                "Current Department":=Employees.Office;
                "Global Dimension 2 Code":=Employees."Global Dimension 2 Code";
                //"Shortcut Dimension 3 Code":=Employees."Shortcut Dimension 3 Code";
                //"Current Department Name":=Employees."Department Name";
                //"Current Region Name":= Employees."Station Name";
                //"Current Directorate Name":= Employees."Directorate Name"
                end;
            end;
        }
        field(3;"Employee Name";Text[100])
        {
        }
        field(4;"Global Dimension 1 Code";Code[50])
        {
            Caption = 'Current Directorate Code';
            Description = 'Stores the reference to the first global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(5;"New Global Dimension 1 Code";Code[50])
        {
            Caption = 'Requested New Directorate Code';
            Description = 'Stores the reference to the New first global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"New Global Dimension 1 Code");
                   if Dimn.Find('-') then begin
                      "New Directorate Name":=Dimn.Name;
                       end;
            end;
        }
        field(6;"Global Dimension 2 Code";Code[50])
        {
            Caption = 'Current Region Code';
            Description = 'Stores the reference of the second global dimension in the database';
            Editable = false;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(7;"New Global Dimension 2 Code";Code[50])
        {
            Caption = 'New Current Region Code';
            Description = 'Stores the reference of the second global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"New Global Dimension 2 Code");
                   if Dimn.Find('-') then begin
                      "New Region Name":=Dimn.Name;
                       end;
            end;
        }
        field(8;"Shortcut Dimension 3 Code";Code[50])
        {
            Caption = 'Current Department Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3));
        }
        field(9;"New Shortcut Dimension 3 Code";Code[50])
        {
            Caption = 'Requested New Department Code';
            Description = 'Stores the reference of the New Third global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"New Shortcut Dimension 3 Code");
                   if Dimn.Find('-') then begin
                      "New Department Name":=Dimn.Name;
                       end;
            end;
        }
        field(10;"Current Department Name";Text[100])
        {
        }
        field(11;"New Department Name";Text[100])
        {
        }
        field(12;"Current Region Name";Text[100])
        {
        }
        field(13;"Current Directorate Name";Text[100])
        {
        }
        field(14;"New Directorate Name";Text[100])
        {
            CalcFormula = lookup("Dimension Value".Name where ("Global Dimension No."=filter(2),
                                                               Code=field("New Global Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(15;"New Region Name";Text[30])
        {
        }
        field(16;"Line No";Integer)
        {
            AutoIncrement = true;
        }
        field(17;Comments;Text[200])
        {
        }
        field(18;"Current Department";Code[40])
        {
            Editable = false;
        }
        field(19;"New Department";Code[40])
        {
        }
    }

    keys
    {
        key(Key1;"Request No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        hrsetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employees: Record "HR Employees";
}

