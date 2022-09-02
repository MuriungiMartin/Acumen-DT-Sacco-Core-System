#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516172 "HR Value Change"
{

    fields
    {
        field(1;"Field";Option)
        {
            OptionCaption = 'ENU=,Department,Employee No.,Location,Status,Office,Title,Date of Exit,Position,Manager,Category,Names,Religion,Marital Status,Contract Type,Job Grade,Succession,Job Title';
            OptionMembers = "ENU=",Department,"Employee No.",Location,Status,Office,Title,"Date of Exit",Position,Manager,Category,Names,Religion,"Marital Status","Contract Type","Job Grade",Succession,"Job Title";
        }
        field(2;"Employee No";Code[50])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(3;"No.";Integer)
        {
        }
        field(4;Date;Date)
        {
        }
        field(5;"Old Value";Text[150])
        {
        }
        field(6;"New Value";Text[150])
        {
        }
        field(7;Reason;Text[150])
        {
        }
        field(8;UserID;Code[50])
        {
        }
    }

    keys
    {
        key(Key1;"Employee No","Field","No.",Date,"Old Value")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

