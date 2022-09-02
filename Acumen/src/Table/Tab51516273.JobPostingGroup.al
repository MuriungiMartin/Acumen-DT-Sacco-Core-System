#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516273 "Job-Posting Group"
{
    Caption = 'Job Posting Group';

    fields
    {
        field(1;"Code";Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2;"WIP Costs Account";Code[20])
        {
            Caption = 'WIP Costs Account';
            TableRelation = "G/L Account";
        }
        field(3;"WIP Accrued Costs Account";Code[20])
        {
            Caption = 'WIP Accrued Costs Account';
            TableRelation = "G/L Account";
        }
        field(4;"Job Costs Applied Account";Code[20])
        {
            Caption = 'Job Costs Applied Account';
            TableRelation = "G/L Account";
        }
        field(5;"Job Costs Adjustment Account";Code[20])
        {
            Caption = 'Job Costs Adjustment Account';
            TableRelation = "G/L Account";
        }
        field(6;"G/L Expense Acc. (Contract)";Code[20])
        {
            Caption = 'G/L Expense Acc. (Contract)';
            TableRelation = "G/L Account";
        }
        field(7;"Job Sales Adjustment Account";Code[20])
        {
            Caption = 'Job Sales Adjustment Account';
            TableRelation = "G/L Account";
        }
        field(8;"WIP Accrued Sales Account";Code[20])
        {
            Caption = 'WIP Accrued Sales Account';
            TableRelation = "G/L Account";
        }
        field(9;"WIP Invoiced Sales Account";Code[20])
        {
            Caption = 'WIP Invoiced Sales Account';
            TableRelation = "G/L Account";
        }
        field(10;"Job Sales Applied Account";Code[20])
        {
            Caption = 'Job Sales Applied Account';
            TableRelation = "G/L Account";
        }
        field(11;"Recognized Costs Account";Code[20])
        {
            Caption = 'Recognized Costs Account';
            TableRelation = "G/L Account";
        }
        field(12;"Recognized Sales Account";Code[20])
        {
            Caption = 'Recognized Sales Account';
            TableRelation = "G/L Account";
        }
        field(50000;Description;Text[100])
        {
        }
        field(50001;"job posting group type";Option)
        {
            OptionCaption = 'Type/Kind of Grant,Schools';
            OptionMembers = "Type/Kind of Grant",Schools;
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
}

