#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516261 "HR Asset Transfer Lines"
{

    fields
    {
        field(1;"No.";Code[20])
        {
        }
        field(2;"Asset No.";Code[20])
        {
            TableRelation = "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                 if fasset.Get("Asset No.") then begin
                    "Asset Description":=fasset.Description;
                    "FA Location":=fasset."FA Location Code";
                    "Responsible Employee Code":=fasset."Responsible Employee";
                    "Asset Serial No":=fasset."Serial No.";
                    "Global Dimension 1 Code":=fasset."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=fasset."Global Dimension 2 Code";

                    if HRTAB.Get("Responsible Employee Code") then
                       "Employee Name":=HRTAB."First Name"+' '+HRTAB."Last Name";

                 end;
            end;
        }
        field(3;"Asset Bar Code";Code[50])
        {
        }
        field(4;"Asset Description";Text[200])
        {
        }
        field(5;"FA Location";Code[80])
        {
            TableRelation = "FA Location".Code;
        }
        field(6;"Responsible Employee Code";Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(7;"Asset Serial No";Text[50])
        {
        }
        field(8;"Employee Name";Text[50])
        {
        }
        field(9;"Reason for Transfer";Text[50])
        {
        }
        field(10;"New Responsible Employee Code";Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin

                     HRTAB.Reset;
                     if HRTAB.Get("New Responsible Employee Code") then begin
                     "New Employee Name":=HRTAB."First Name"+' '+HRTAB."Last Name";
                     end else begin
                     "New Employee Name":='';
                   end;
            end;
        }
        field(11;"New Employee Name";Text[100])
        {
        }
        field(12;"Global Dimension 1 Code";Code[50])
        {
            Caption = 'Current Project Code';
            TableRelation = "Dimension Value".Code where ("Dimension Code"=const('1'));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"Global Dimension 1 Code");
                   if Dimn.Find('-') then begin
                      "Dimension 1 Name":=Dimn.Name;
                       end;
            end;
        }
        field(13;"New Global Dimension 1 Code";Code[50])
        {
            Caption = 'New Project Code';
            TableRelation = "Dimension Value".Code where ("Dimension Code"=const('1'));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"New Global Dimension 1 Code");
                   if Dimn.Find('-') then begin
                      "New  Dimension 1 Name":=Dimn.Name;
                       end;
            end;
        }
        field(14;"Global Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,1,2';
            Caption = 'Current Department Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"Global Dimension 2 Code");
                   if Dimn.Find('-') then begin
                      "Dimension 2 Name":=Dimn.Name;
                       end;
            end;
        }
        field(15;"New Global Dimension 2 Code";Code[50])
        {
            CaptionClass = '1,1,2';
            Caption = 'New Department Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"New Global Dimension 2 Code");
                   if Dimn.Find('-') then begin
                      "New  Dimension 2 Name":=Dimn.Name;
                       end;
            end;
        }
        field(16;"Global Dimension 3 Code";Code[50])
        {
            Caption = 'Current Station Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"Global Dimension 3 Code");
                   if Dimn.Find('-') then begin
                      "Dimension 3 Name":=Dimn.Name;
                       end;
            end;
        }
        field(17;"New Global Dimension 3 Code";Code[50])
        {
            Caption = 'New Station Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3));

            trigger OnValidate()
            var
                Dimn: Record "Dimension Value";
            begin
                  Dimn.SetRange(Dimn.Code,"New Global Dimension 3 Code");
                   if Dimn.Find('-') then begin
                      "New  Dimension 3 Name":=Dimn.Name;
                       end;
            end;
        }
        field(18;"Dimension 1 Name";Text[100])
        {
            Caption = 'Current Project Name';
        }
        field(19;"New  Dimension 1 Name";Text[100])
        {
            Caption = 'New Project Name';
        }
        field(20;"Dimension 2 Name";Text[100])
        {
            Caption = 'Current Department Name';
        }
        field(21;"New  Dimension 2 Name";Text[100])
        {
            Caption = 'New Department Name';
        }
        field(22;"Dimension 3 Name";Text[100])
        {
            Caption = 'Current Station Name';
        }
        field(23;"New  Dimension 3 Name";Text[100])
        {
            Caption = 'New Station Name';
        }
        field(24;"Is Asset Expected Back?";Option)
        {
            OptionMembers = No,Yes;
        }
        field(25;"Duration of Transfer";Text[20])
        {
        }
        field(26;"New Asset Location";Text[50])
        {
            TableRelation = "FA Location";
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

    var
        fasset: Record "Fixed Asset";
        HRTAB: Record "HR Employees";
        PrjctCde: Record "Dimension Value";
        Dimvalu: Integer;
}

