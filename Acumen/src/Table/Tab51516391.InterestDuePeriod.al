#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516391 "Interest Due Period"
{

    fields
    {
        field(1;"Interest Due Date";Date)
        {
            Caption = 'Interest Due Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                Name := Format("Interest Due Date",0,Text000);
            end;
        }
        field(2;Name;Text[10])
        {
            Caption = 'Name';
        }
        field(3;"New Fiscal Year";Boolean)
        {
            Caption = 'New Fiscal Year';

            trigger OnValidate()
            begin
                TestField("Date Locked",false);
                if "New Fiscal Year" then begin
                  if not InvtSetup.Get then
                    exit;
                  "Average Cost Calc. Type" := InvtSetup."Average Cost Calc. Type";
                  "Average Cost Period" := InvtSetup."Average Cost Period";
                end else begin
                  "Average Cost Calc. Type" := "average cost calc. type"::" ";
                  "Average Cost Period" := "average cost period"::" ";
                end;
            end;
        }
        field(4;Closed;Boolean)
        {
            Caption = 'Closed';
            Editable = true;
        }
        field(5;"Date Locked";Boolean)
        {
            Caption = 'Date Locked';
            Editable = true;
        }
        field(5804;"Average Cost Calc. Type";Option)
        {
            Caption = 'Average Cost Calc. Type';
            Editable = false;
            OptionCaption = ' ,Item,Item & Location & Variant';
            OptionMembers = " ",Item,"Item & Location & Variant";
        }
        field(5805;"Average Cost Period";Option)
        {
            Caption = 'Average Cost Period';
            Editable = false;
            OptionCaption = ' ,Day,Week,Month,Quarter,Year,Accounting Period';
            OptionMembers = " ",Day,Week,Month,Quarter,Year,"Accounting Period";
        }
        field(50000;"Closed by User";Code[20])
        {
        }
        field(50001;"Closing Date Time";DateTime)
        {
        }
        field(50002;"Posting Document No.";Code[20])
        {
        }
        field(50003;"Interest Calcuation Date";Date)
        {
            Caption = 'Interest Calculation Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                Name := Format("Interest Due Date",0,Text000);
            end;
        }
    }

    keys
    {
        key(Key1;"Interest Due Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField("Date Locked",false);
        UpdateAvgItems(3);
    end;

    trigger OnInsert()
    begin

        AccountingPeriod2 := Rec;
        if AccountingPeriod2.Find('>') then
          AccountingPeriod2.TestField("Date Locked",false);
        UpdateAvgItems(1);
    end;

    trigger OnModify()
    begin
        UpdateAvgItems(2);
    end;

    trigger OnRename()
    begin

        TestField("Date Locked",false);
        AccountingPeriod2 := Rec;
        if AccountingPeriod2.Find('>') then
          AccountingPeriod2.TestField("Date Locked",false);
        UpdateAvgItems(4);
    end;

    var
        AccountingPeriod2: Record "Interest Due Period";
        InvtSetup: Record "Inventory Setup";
        Text000: label '<Month Text>';


    procedure UpdateAvgItems(UpdateType: Option)
    var
        ChangeAvgCostSetting: Codeunit "Change Average Cost Setting";
    begin
        //ChangeAvgCostSetting.UpdateAvgCostFromAccPeriodChg(Rec,xRec,UpdateType);
    end;
}

