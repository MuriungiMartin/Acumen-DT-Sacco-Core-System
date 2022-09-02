#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516700 "Members Nominee Temp"
{
    DrillDownPageID = "Members Nominee Details List";
    LookupPageID = "Members Nominee Details List";

    fields
    {
        field(2;Name;Text[100])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                Name:=UpperCase(Name);
                if Existing then
                  Error('You cannot modify the name of an existing account');
            end;
        }
        field(3;Relationship;Text[30])
        {
            TableRelation = "Relationship Types";
        }
        field(4;Beneficiary;Boolean)
        {
        }
        field(5;"Date of Birth";Date)
        {
        }
        field(6;Address;Text[150])
        {
        }
        field(7;Telephone;Code[100])
        {

            trigger OnValidate()
            begin
                //IF STRLEN(Telephone) <> 10 THEN
                  //ERROR('Telephone No. Can not be more or less than 10 Characters')
            end;
        }
        field(9;Email;Text[100])
        {
        }
        field(10;"Account No";Code[30])
        {
            TableRelation = "Member Register"."No.";
        }
        field(11;"ID No.";Code[40])
        {
        }
        field(12;"%Allocation";Decimal)
        {
        }
        field(13;"New Upload";Boolean)
        {
        }
        field(14;"Total Allocation";Decimal)
        {
            CalcFormula = sum("Members Nominee"."%Allocation" where ("Account No"=field("Account No")));
            FieldClass = FlowField;
        }
        field(15;"Maximun Allocation %";Decimal)
        {
        }
        field(16;"NOK Residence";Code[100])
        {
        }
        field(17;"Entry No";Integer)
        {
            AutoIncrement = true;
        }
        field(18;Description;Text[100])
        {
        }
        field(19;Guardian;Code[100])
        {
        }
        field(20;"Created By";Code[40])
        {
        }
        field(21;"Last date Modified";Date)
        {
        }
        field(22;"Modified by";Code[40])
        {
        }
        field(23;"Date Created";Date)
        {
        }
        field(24;"Next Of Kin Type";Option)
        {
            OptionCaption = ' ,Beneficiary,Guardian,Dependants';
            OptionMembers = " ",Beneficiary,Guardian,Dependants;
        }
        field(25;"Relationship(New)";Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Relationship Types";
        }
        field(26;"Beneficiary(New)";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27;"Date of Birth(New)";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28;"Address(New)";Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(29;"Telephone(New)";Code[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //IF STRLEN(Telephone) <> 10 THEN
                  //ERROR('Telephone No. Can not be more or less than 10 Characters')
            end;
        }
        field(30;"Email(New)";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(31;"ID No.(New)";Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(32;"%Allocation(New)";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33;"New Upload(New)";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34;"Total Allocation(New)";Decimal)
        {
            CalcFormula = sum("Members Nominee"."%Allocation" where ("Account No"=field("Account No")));
            FieldClass = FlowField;
        }
        field(35;"Maximun Allocation %(New)";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36;"NOK Residence(New)";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(37;"Description(New)";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(38;"Guardian(New)";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(39;"Next Of Kin Type(New)";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Beneficiary,Guardian,Dependants';
            OptionMembers = " ",Beneficiary,Guardian,Dependants;
        }
        field(40;"Add New";Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Existing then
                  Error('Cannot be checked for existing account');
            end;
        }
        field(41;"Document No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(42;Existing;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(43;Remove;Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Entry No","Document No","Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //"Document No":=
    end;

    var
        MembersNomineeTemp: Record "Members Nominee Temp";
}

