#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516038 "Budgetary Control Setup"
{

    fields
    {
        field(1;"Primary Key";Code[10])
        {
        }
        field(2;"Current Budget Code";Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(3;"Current Budget Start Date";Date)
        {
        }
        field(4;"Current Budget End Date";Date)
        {
        }
        field(5;"Budget Dimension 1 Code";Code[20])
        {
            Caption = 'Budget Dimension 1 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 1 Code" <> xRec."Budget Dimension 1 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 1 Code",9,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 1 Code",0);
                END;
                */

            end;
        }
        field(6;"Budget Dimension 2 Code";Code[20])
        {
            Caption = 'Budget Dimension 2 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 2 Code" <> xRec."Budget Dimension 2 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 2 Code",10,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 2 Code",1);
                END;
                */

            end;
        }
        field(7;"Budget Dimension 3 Code";Code[20])
        {
            Caption = 'Budget Dimension 3 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 3 Code" <> xRec."Budget Dimension 3 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 3 Code",11,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 3 Code",2);
                END;
                */

            end;
        }
        field(8;"Budget Dimension 4 Code";Code[20])
        {
            Caption = 'Budget Dimension 4 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 4 Code" <> xRec."Budget Dimension 4 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 4 Code",12,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 4 Code",3);
                END;
                */

            end;
        }
        field(9;"Budget Dimension 5 Code";Code[20])
        {
            Caption = 'Budget Dimension 5 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 4 Code" <> xRec."Budget Dimension 4 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 4 Code",12,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 4 Code",3);
                END;
                */

            end;
        }
        field(10;"Budget Dimension 6 Code";Code[20])
        {
            Caption = 'Budget Dimension 6 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                IF "Budget Dimension 4 Code" <> xRec."Budget Dimension 4 Code" THEN BEGIN
                  IF Dim.CheckIfDimUsed("Budget Dimension 4 Code",12,Name,'',0) THEN
                    ERROR(Text000,Dim.GetCheckDimErr);
                  MODIFY;
                  UpdateBudgetDim("Budget Dimension 4 Code",3);
                END;
                */

            end;
        }
        field(11;"Analysis View Code";Code[20])
        {
            TableRelation = "Analysis View".Code;
        }
        field(12;"Dimension 1 Code";Code[20])
        {
            Caption = 'Dimension 1 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                TESTFIELD(Blocked,FALSE);
                IF Dim.CheckIfDimUsed("Dimension 1 Code",13,'',Code,0) THEN
                  ERROR(Text000,Dim.GetCheckDimErr);
                ModifyDim(FIELDCAPTION("Dimension 1 Code"),"Dimension 1 Code",xRec."Dimension 1 Code");
                MODIFY;
                */

            end;
        }
        field(13;"Dimension 2 Code";Code[20])
        {
            Caption = 'Dimension 2 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                TESTFIELD(Blocked,FALSE);
                IF Dim.CheckIfDimUsed("Dimension 2 Code",14,'',Code,0) THEN
                  ERROR(Text000,Dim.GetCheckDimErr);
                ModifyDim(FIELDCAPTION("Dimension 2 Code"),"Dimension 2 Code",xRec."Dimension 2 Code");
                MODIFY;
                */

            end;
        }
        field(14;"Dimension 3 Code";Code[20])
        {
            Caption = 'Dimension 3 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                TESTFIELD(Blocked,FALSE);
                IF Dim.CheckIfDimUsed("Dimension 3 Code",15,'',Code,0) THEN
                  ERROR(Text000,Dim.GetCheckDimErr);
                ModifyDim(FIELDCAPTION("Dimension 3 Code"),"Dimension 3 Code",xRec."Dimension 3 Code");
                MODIFY;
                */

            end;
        }
        field(15;"Dimension 4 Code";Code[20])
        {
            Caption = 'Dimension 4 Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*
                TESTFIELD(Blocked,FALSE);
                IF Dim.CheckIfDimUsed("Dimension 4 Code",16,'',Code,0) THEN
                  ERROR(Text000,Dim.GetCheckDimErr);
                ModifyDim(FIELDCAPTION("Dimension 4 Code"),"Dimension 4 Code",xRec."Dimension 4 Code");
                MODIFY;
                */

            end;
        }
        field(16;Mandatory;Boolean)
        {
        }
        field(17;"Allow OverExpenditure";Boolean)
        {
        }
        field(18;"Current Item Budget";Code[10])
        {
            TableRelation = "Item Budget Name".Name;
        }
        field(19;"Budget Check Criteria";Option)
        {
            OptionCaption = 'Current Month,Whole Year';
            OptionMembers = "Current Month","Whole Year";
        }
        field(20;"Actual Source";Option)
        {
            OptionCaption = 'G/L Entry,Analysis View Entry';
            OptionMembers = "G/L Entry","Analysis View Entry";

            trigger OnValidate()
            begin
                    if "Actual Source"="actual source"::"G/L Entry" then begin
                        if not Confirm('Changing to Actual Source type G/L Entry will result in deletion of all Actuals Continue?',true,false) then
                          Error('Change to G/L Entry source cancelled');
                        "Analysis View Code":='';
                        "Dimension 1 Code":='';
                        "Dimension 2 Code":='';
                        "Dimension 3 Code":='';
                        "Dimension 4 Code":='';
                         Modify;
                     end;
            end;
        }
        field(21;"Partial Budgetary Check";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

