#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516552 "Change Request"
{
    DrillDownPageID = "Change Request List";
    LookupPageID = "Change Request List";

    fields
    {
        field(1; No; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Change Request No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Mobile Change,ATM Change,Backoffice Change,Agile Change,Microfinance Change';
            OptionMembers = " ","Mobile Change","ATM Change","Backoffice Change","Agile Change","Microfinance Change";

            trigger OnValidate()
            begin
                "Account No" := '';
            end;
        }
        field(3; "Account No"; Code[50])
        {
            TableRelation = if (Type = const("Backoffice Change")) Customer."No."
            else
            if (Type = const("Mobile Change")) Vendor."No."
            else
            if (Type = const("ATM Change")) Vendor."No."
            else
            if (Type = const("Agile Change")) Vendor."No." where("Vendor Posting Group" = filter(<> 'TCREDITORS'))
            else
            if (Type = filter("Microfinance Change")) Customer."No.";

            trigger OnValidate()
            begin
                if ((Type = Type::"Mobile Change") or (Type = Type::"ATM Change") or (Type = Type::"Agile Change")) then begin
                    vend.Reset;
                    vend.SetRange(vend."No.", "Account No");
                    if vend.Find('-') then begin

                        Name := vend.Name;
                        Branch := vend."Global Dimension 2 Code";
                        Address := vend.Address;
                        Picture := vend.Piccture;
                        signinature := vend.Signature;
                        Email := vend."E-Mail";
                        "Mobile No" := vend."Mobile Phone No";
                        "S-Mobile No" := vend."Phone No.";
                        "ATM Collector Name" := vend."ATM Collector Name";
                        "ID No" := vend."ID No.";
                        "Personal No" := vend."Personal No.";
                        "Account Type" := vend."Account Type";
                        City := vend.City;
                        Section := vend.Section;
                        "Card Expiry Date" := vend."Card Expiry Date";
                        "Card No" := vend."Card No.";
                        "Card Valid From" := vend."Card Valid From";
                        "Card Valid To" := vend."Card Valid To";
                        "Marital Status" := vend."Marital Status";
                        "Reason for change" := vend."Reason For Blocking Account";
                        "Phone No.(Old)" := vend."Phone No.";
                        "Mobile No" := vend."Mobile Phone No";
                        Blocked := vend.Blocked;
                        "Blocked (New)" := vend.Blocked;
                        "Status." := vend.Status;
                        "Status.(New)" := vend.Status;
                        "Member class" := vend."Member class";
                    end;


                end;

                //................................
                // IF  (Type=Type::"Mobile Change")  THEN BEGIN
                //       Memb.RESET;
                //    Memb.SETRANGE(Memb."No.","Account No");
                //  IF Memb.FIND('-') THEN BEGIN
                //
                //    "Phone No.(Old)":=Memb."Phone No.";
                //    "Mobile No":=Memb."Mobile Phone No";
                //    END;
                //    END;



                if Type = Type::"Backoffice Change" then begin
                    Memb.Reset;
                    Memb.SetRange(Memb."No.", "Account No");
                    if Memb.Find('-') then begin

                        Name := Memb.Name;
                        Branch := Memb."Global Dimension 2 Code";
                        Address := Memb.Address;
                        Email := Memb."E-Mail";
                        "Mobile No" := Memb."Mobile Phone No";
                        "ID No" := Memb."ID No.";
                        "Personal No" := Memb."Personal No";
                        City := Memb.City;
                        Section := Memb.Section;
                        "Marital Status" := Memb."Marital Status";
                        "Monthly Contributions" := Memb."Monthly Contribution";
                        //"Signing Instructions":=Memb."Signing Instructions";
                        "Member Account Status" := Memb.Status;
                        "Group Account No" := Memb."Group Account No";
                        "Group Account Name" := Memb."Group Account Name";
                        "Member Account Status" := Memb.Status;
                        "Employer Code" := Memb."Employer Code";
                        "Status." := Memb.Status;
                        "Status.(New)" := Memb.Status;
                        Gender := Memb.Gender;
                        "Recruited By" := Memb."Recruited By";
                        Picture := Memb.Piccture;
                        // MESSAGE ('picha ni %1',Picture);
                        "Picture 2" := Memb."Picture 2";
                        signinature := Memb.Signature;
                        signatures2 := Memb."Signature  2";

                        "Member class" := Memb."Member class";

                    end;

                    //Microfinance Change
                    if Type = Type::"Microfinance Change" then begin
                        Memb.Reset;
                        Memb.SetRange(Memb."No.", "Account No");
                        if Memb.Find('-') then begin

                            Name := Memb.Name;
                            Branch := Memb."Global Dimension 2 Code";
                            Address := Memb.Address;
                            Email := Memb."E-Mail";
                            "Mobile No" := Memb."Mobile Phone No";
                            "ID No" := Memb."ID No.";
                            "Personal No" := Memb."Personal No";
                            City := Memb.City;
                            Section := Memb.Section;
                            "Marital Status" := Memb."Marital Status";
                            "Monthly Contributions" := Memb."Monthly Contribution";
                            //"Signing Instructions":=Memb."Signing Instructions";
                            "Member Account Status" := Memb.Status;
                            "Group Account No" := Memb."Group Account No";
                            "Group Account Name" := Memb."Group Account Name";
                            Picture := Memb.Piccture;
                            signinature := Memb.Signature;
                            signatures2 := Memb."Signature  2";
                            "Member class" := Memb."Member class";
                            "Picture 2" := Memb."Picture 2";

                        end;

                    end;
                end;
            end;
        }
        field(4; "Mobile No"; Code[50])
        {
        }
        field(5; Name; Text[40])
        {
        }
        field(6; "No. Series"; Code[30])
        {
        }
        field(7; Address; Code[30])
        {
        }
        field(8; Branch; Code[30])
        {
        }
        field(9; Picture; MediaSet)
        {
        }
        field(10; signinature; MediaSet)
        {
        }
        field(11; City; Code[30])
        {
        }
        field(12; "E-mail"; Code[30])
        {
        }
        field(13; "Personal No"; Code[30])
        {
        }
        field(14; "ID No"; Code[40])
        {
        }
        field(15; "Marital Status"; Option)
        {
            OptionCaption = 'Married,Single';
            OptionMembers = Married,Single;
        }
        field(16; "Passport No."; Code[30])
        {
        }
        field(17; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(18; "Account Type"; Code[30])
        {
        }
        field(19; "Account Category"; Code[30])
        {
        }
        field(20; Email; Code[40])
        {
        }
        field(21; Section; Code[40])
        {
        }
        field(22; "Card No"; Code[30])
        {
        }
        field(23; "Home Address"; Code[30])
        {
        }
        field(24; Loaction; Code[20])
        {
        }
        field(25; "Sub-Location"; Code[30])
        {
        }
        field(26; District; Code[30])
        {
        }
        field(27; "Reason for change"; Text[50])
        {
        }
        field(28; "Signing Instructions"; Text[40])
        {
        }
        field(29; "S-Mobile No"; Code[20])
        {
        }
        field(30; "ATM Approve"; Code[30])
        {
        }
        field(31; "Card Expiry Date"; Date)
        {
        }
        field(32; "Card Valid From"; Date)
        {
        }
        field(33; "Card Valid To"; Date)
        {
        }
        field(34; "Date ATM Linked"; Date)
        {
        }
        field(35; "ATM No."; Code[16])
        {
        }
        field(36; "ATM Issued"; Boolean)
        {
        }
        field(37; "ATM Self Picked"; Boolean)
        {
        }
        field(38; "ATM Collector Name"; Code[30])
        {
        }
        field(39; "ATM Collectors ID"; Code[20])
        {
        }
        field(40; "Atm Collectors Moile"; Code[30])
        {
        }
        field(41; "Member Type"; Option)
        {
            OptionCaption = ' ,class A,class B';
            OptionMembers = " ","class A","class B";
        }
        field(42; "Monthly Contributions"; Decimal)
        {
        }
        field(43; "Captured by"; Code[50])
        {
            Editable = false;
        }
        field(44; "Capture Date"; Date)
        {
            Editable = false;
        }
        field(46; "Approved by"; Code[50])
        {
            Editable = false;
        }
        field(47; "Approval Date"; Date)
        {
            Editable = false;
        }
        field(48; Changed; Boolean)
        {
            Editable = false;
        }
        field(49; "Responsibility Centers"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(50; "Member Cell Group"; Code[30])
        {
            TableRelation = "Hexa Binary";

            trigger OnValidate()
            begin
                if MemberCell.Get("Member Cell Group") then begin
                    // "Member Cell Name":=MemberCell."Cell Group Name";
                end;
            end;
        }
        field(51; "Member Cell Name"; Code[30])
        {
        }
        field(52; "Group Account No"; Code[30])
        {
            TableRelation = Customer."No." where("Group Account" = filter(true));
        }
        field(53; "Group Account Name"; Code[30])
        {
        }
        field(54; "Member Account Status"; Option)
        {
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New,Awaiting Withdrawal';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New,"Awaiting Withdrawal";
        }
        field(55; "Mobile No(New Value)"; Code[50])
        {
        }
        field(56; "Name(New Value)"; Text[40])
        {
        }
        field(57; "No. Series(New Value)"; Code[30])
        {
        }
        field(58; "Address(New Value)"; Code[30])
        {
        }
        field(59; "Branch(New Value)"; Code[30])
        {
        }
        field(60; "Picture(New Value)"; MediaSet)
        {
        }
        field(61; "signinature(New Value)"; MediaSet)
        {
        }
        field(62; "City(New Value)"; Code[30])
        {
        }
        field(63; "E-mail(New Value)"; Code[30])
        {
        }
        field(64; "Personal No(New Value)"; Code[30])
        {
        }
        field(65; "ID No(New Value)"; Code[40])
        {
        }
        field(66; "Marital Status(New Value)"; Option)
        {
            OptionCaption = ' ,Single,Married,Devorced,Widower,Widow';
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(67; "Passport No.(New Value)"; Code[30])
        {
        }
        field(68; "Status(New Value)"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(69; "Account Type(New Value)"; Code[30])
        {
        }
        field(70; "Account Category(New Value)"; Code[30])
        {
        }
        field(71; "Email(New Value)"; Code[40])
        {
        }
        field(72; "Section(New Value)"; Code[40])
        {
        }
        field(73; "Card No(New Value)"; Code[30])
        {
        }
        field(74; "Home Address(New Value)"; Code[30])
        {
        }
        field(75; "Loaction(New Value)"; Code[20])
        {
        }
        field(76; "Sub-Location(New Value)"; Code[30])
        {
        }
        field(77; "District(New Value)"; Code[30])
        {
        }
        field(78; "Signing Instructions(NewValue)"; Text[40])
        {
        }
        field(79; "S-Mobile No(New Value)"; Code[20])
        {
        }
        field(80; "ATM No.(New Value)"; Date)
        {
        }
        field(81; "Monthly Contributions(NewValu)"; Decimal)
        {
        }
        field(82; "Member Account Status(NewValu)"; Option)
        {
            OptionCaption = ' ,Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawn,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New';
            OptionMembers = " ",Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawn,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New;
        }
        field(83; "Charge Reactivation Fee"; Boolean)
        {
        }
        field(84; "Phone No.(Old)"; Code[20])
        {
        }
        field(85; "Phone No.(New)"; Code[20])
        {
        }
        field(86; Blocked; Option)
        {
            OptionCaption = ' ,Payment,All';
            OptionMembers = " ",Payment,All;
        }
        field(87; "Blocked (New)"; Option)
        {
            OptionCaption = ' ,Payment,All';
            OptionMembers = " ",Payment,All;
        }
        field(88; "Status (New Value)"; Option)
        {
            OptionCaption = 'Active,Frozen,Closed,Archived,New,Dormant,Deceased,Retired';
            OptionMembers = Active,Frozen,Closed,Archived,New,Dormant,Deceased,Retired;
        }
        field(89; "Employer Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Employer Code(New)"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sacco Employers".Code;
        }
        field(91; "Status."; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New,Awaiting Withdrawal';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New,"Awaiting Withdrawal";
        }
        field(92; "Status.(New)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New,Awaiting Withdrawal';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New,"Awaiting Withdrawal";
        }
        field(93; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(94; "Retirement Date(New)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(95; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(96; "Gender(New)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(97; "Recruited By"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(98; "Recruited By(New)"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(99; Pictures; MediaSet)
        {
            Caption = 'Picture';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(100; Picturen; Blob)
        {
            Caption = 'Picture';
            DataClassification = ToBeClassified;
        }
        field(101; "Member class"; Option)
        {
            OptionCaption = ',Class A,Class B';
            OptionMembers = ,"Class A","Class B";
        }
        field(102; "Member class (New)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Class A,Class B';
            OptionMembers = " ","Class A","Class B";
        }
        field(103; signature2; MediaSet)
        {
            DataClassification = ToBeClassified;
        }
        field(104; signatures2; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(105; "Picture 2"; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        if No = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Change Request No");
            NoSeriesMgt.InitSeries(SalesSetup."Change Request No", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Captured by" := UserId;
        "Capture Date" := Today;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        vend: Record Vendor;
        Memb: Record Customer;
        MemberCell: Record "Hexa Binary";
}

