#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516936 "Membership Cue"
{

    fields
    {
        field(1; "User ID"; Code[50])
        {
        }
        field(2; "Active Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Active)));
            FieldClass = FlowField;
        }
        field(3; "Dormant Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Dormant)));
            FieldClass = FlowField;
        }
        field(4; "Deceased Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Deceased)));
            FieldClass = FlowField;
        }
        field(5; "Withdrawn Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Withdrawal)));
            FieldClass = FlowField;
        }
        field(6; "Male Members"; Integer)
        {
            CalcFormula = count(Customer where(Gender = const(Male)));
            FieldClass = FlowField;
        }
        field(7; "Female Members"; Integer)
        {
            CalcFormula = count(Customer where(Gender = const(Female)));
            FieldClass = FlowField;
        }
        field(8; "Resigned Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Resigned)));
            FieldClass = FlowField;
        }
        field(9; BOSA; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('BOSA'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(10; BUSINESS; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('BUSINESS'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(11; COFFEE; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('COFFEE'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(12; EMERGENCY; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = filter('EMERGENCY' | 'EMERGENCY2'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(13; SCHOOL; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = filter('SCHOOLFEE' | 'SCHOOLFEE2'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(14; "Members with ID No"; Integer)
        {
            CalcFormula = count(Customer where("ID No." = filter(> '0')));
            FieldClass = FlowField;
        }
        field(15; "Members With Tell No"; Integer)
        {
            CalcFormula = count(Customer where("Phone No." = filter(> '0')));
            FieldClass = FlowField;
        }
        field(16; "Members With Mobile No"; Integer)
        {
            CalcFormula = count(Customer where("Mobile Phone No" = filter(> '0')));
            FieldClass = FlowField;
        }
        field(17; CROP; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('CROP'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(18; DEVELOPMENT; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('301'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(19; GROUP; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('GROUP'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(20; PENSION; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('PENSIONADV'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(21; SALARY; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('SALARYADV'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(22; SPECIAL; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('SPECIALADV'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(23; ADVANCE1A; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('ADVANCE1A'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(24; STAFF; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('STAFF'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(25; MILK; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('MILK'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(26; "Non-Active Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const("Non-Active")));
            FieldClass = FlowField;
        }
        field(27; "NoQsAsked Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('NOQS'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(28; StaffAsset; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('312'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(29; StaffCar; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('SCAR'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(30; "BDevt Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('BDEVT'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(31; "Normal Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = filter('NORMAL' | 'NORM 24' | 'NORM 36' | 'NORM 48' | 'NORM 60'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(32; "Asset Financing Loan"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('ASSET'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(33; "Junior Members"; Integer)
        {
        }
        field(34; ADVANCE1B; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('ADVANCE1B'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(35; ADVANCE1C; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('ADVANCE1C'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(36; SALARYADVANCE; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('SALARYADVANCE'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
        field(37; FOSALOAN; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Product Type" = const('FOSALOAN'),
                                                        Posted = const(true)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

