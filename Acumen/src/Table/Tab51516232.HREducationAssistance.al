#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516232 "HR Education Assistance"
{
    // DrillDownPageID = UnknownPage55660;
    // LookupPageID = UnknownPage55660;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                OK := Employee.Get("Employee No.");
                if OK then begin
                    "Employee First Name" := Employee."First Name";
                    "Employee Last Name" := Employee."Last Name";
                end;
            end;
        }
        field(2; "Refund Level"; Text[30])
        {
        }
        field(3; "Year Of Study"; Integer)
        {
        }
        field(4; "Student Number"; Text[30])
        {
        }
        field(5; "Educational Institution"; Text[100])
        {
        }
        field(6; "Type Of Institution"; Code[20])
        {
        }
        field(7; "Subject Registered1"; Text[80])
        {
        }
        field(8; "Cost Of Subject1"; Decimal)
        {
        }
        field(9; "Subject Registered2"; Text[80])
        {
        }
        field(10; "Cost Of Subject2"; Decimal)
        {
        }
        field(11; "Subject Registered3"; Text[80])
        {
        }
        field(12; "Cost Of Subject3"; Decimal)
        {
        }
        field(13; "Subject Registered4"; Text[80])
        {
        }
        field(14; "Cost Of Subject4"; Decimal)
        {
        }
        field(15; "Subject Registered5"; Text[80])
        {
        }
        field(16; "Cost Of Subject5"; Decimal)
        {
        }
        field(17; "Subject Registered6"; Text[80])
        {
        }
        field(18; "Cost Of Subject6"; Decimal)
        {
        }
        field(20; "Date Rewrite1"; Date)
        {
        }
        field(21; "Date Completed1"; Date)
        {
        }
        field(22; CompletedResult1; Option)
        {
            OptionMembers = " ",Passed,Failed;
        }
        field(23; "Date Rewrite2"; Date)
        {
        }
        field(24; "Date Completed2"; Date)
        {
        }
        field(25; CompletedResult2; Option)
        {
            OptionMembers = " ",Passed,Failed;
        }
        field(26; "Date Rewrite3"; Date)
        {
        }
        field(27; "Date Completed3"; Date)
        {
        }
        field(28; CompletedResult3; Option)
        {
            OptionMembers = " ",Passed,Failed;
        }
        field(29; "Date Rewrite4"; Date)
        {
        }
        field(30; "Date Completed4"; Date)
        {
        }
        field(31; CompletedResult4; Option)
        {
            OptionMembers = " ",Passed,Failed;
        }
        field(32; "Date Rewrite5"; Date)
        {
        }
        field(33; "Date Completed5"; Date)
        {
        }
        field(34; CompletedResult5; Option)
        {
            OptionMembers = " ",Passed,Failed;
        }
        field(35; "Date Rewrite6"; Date)
        {
        }
        field(36; "Date Completed6"; Date)
        {
        }
        field(37; CompletedResult6; Option)
        {
            OptionMembers = " ",Passed,Failed;
        }
        field(38; "Study Period"; Integer)
        {
        }
        field(39; "Employee First Name"; Text[50])
        {
        }
        field(40; "Employee Last Name"; Text[50])
        {
        }
        field(41; Duration; Option)
        {
            OptionMembers = Hours,Days,Weeks,Months,Years;
        }
        field(42; "Enrollment Fee"; Decimal)
        {
        }
        field(43; "Book Cost Subject1"; Decimal)
        {
        }
        field(44; "Book Cost Subject2"; Decimal)
        {
        }
        field(45; "Book Cost Subject3"; Decimal)
        {
        }
        field(46; "Book Cost Subject4"; Decimal)
        {
        }
        field(47; "Book Cost Subject5"; Decimal)
        {
        }
        field(48; "Book Cost Subject6"; Decimal)
        {
        }
        field(49; RewriteResult1; Option)
        {
            OptionMembers = " ",Passed,Failed;
        }
        field(50; RewriteResult2; Option)
        {
            OptionMembers = " ",Passed,Failed;
        }
        field(51; RewriteResult3; Option)
        {
            OptionMembers = " ",Passed,Failed;
        }
        field(52; RewriteResult4; Option)
        {
            OptionMembers = " ",Passed,Failed;
        }
        field(53; RewriteResult5; Option)
        {
            OptionMembers = " ",Passed,Failed;
        }
        field(54; RewriteResult6; Option)
        {
            OptionMembers = " ",Passed,Failed;
        }
        field(55; Refunded1; Boolean)
        {
        }
        field(56; Refunded2; Boolean)
        {
        }
        field(57; Refunded3; Boolean)
        {
        }
        field(58; Refunded4; Boolean)
        {
        }
        field(59; Refunded5; Boolean)
        {
        }
        field(60; Refunded6; Boolean)
        {
        }
        field(61; "Training Credits1"; Decimal)
        {
        }
        field(62; "Education Credits1"; Decimal)
        {
        }
        field(63; "Training Credits2"; Decimal)
        {
        }
        field(64; "Education Credits2"; Decimal)
        {
        }
        field(65; "Training Credits3"; Decimal)
        {
        }
        field(66; "Education Credits3"; Decimal)
        {
        }
        field(67; "Training Credits4"; Decimal)
        {
        }
        field(68; "Education Credits4"; Decimal)
        {
        }
        field(69; "Training Credits5"; Decimal)
        {
        }
        field(70; "Education Credits5"; Decimal)
        {
        }
        field(71; "Training Credits6"; Decimal)
        {
        }
        field(72; "Education Credits6"; Decimal)
        {
        }
        field(73; "Total Cost"; Decimal)
        {
        }
        field(74; Year; Integer)
        {
            Caption = 'From';
        }
        field(75; Comment; Boolean)
        {
            CalcFormula = exist("HR Human Resource Comments" where("Table Name" = const("Education Assistance"),
                                                                    "No." = field("Employee No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(76; "Line No"; Integer)
        {
        }
        field(77; "To"; Integer)
        {
        }
        field(78; Qualification; Code[20])
        {
            TableRelation = Qualification.Code;
        }
    }

    keys
    {
        key(Key1; "Employee No.", Year, "Line No")
        {
            Clustered = true;
            SumIndexFields = "Total Cost";
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HR Employees";
        OK: Boolean;
}

