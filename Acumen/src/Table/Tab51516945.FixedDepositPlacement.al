#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516945 "Fixed Deposit Placement"
{

    fields
    {
        field(1;"Document No";Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                  SalesSetup.Get;
                  NoSeriesMgt.TestManual(SalesSetup."Fixed Deposit Placement");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Member No";Code[30])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then
                  begin
                    "Member Name":=ObjCust.Name;
                    end;
            end;
        }
        field(3;"Member Name";Code[100])
        {
        }
        field(4;"Fixed Deposit Account No";Code[30])
        {
            TableRelation = Vendor."No." where ("Account Type"=filter('FIXED'));
        }
        field(5;"Application Date";Date)
        {
        }
        field(6;"Fixed Deposit Type";Code[20])
        {
            TableRelation = "Fixed Deposit Type".Code;

            trigger OnValidate()
            begin

                if ObjFDType.Get("Fixed Deposit Type") then
                  begin
                    "FD Maturity Date":=CalcDate(ObjFDType.Duration,Today);
                     "Fixed Duration":=ObjFDType."No. of Months";
                     "Fixed Deposit Status":="fixed deposit status"::Active;
                     "FD Duration":=ObjFDType.Duration;

                 end;

                ObjIntCalc.Reset;
                ObjIntCalc.SetRange(ObjIntCalc.Code,"Fixed Deposit Type");
                if ObjIntCalc.FindSet then
                  begin
                   if ("Amount to Fix">=ObjIntCalc."Minimum Amount") and ("Amount to Fix"<=ObjIntCalc."Maximum Amount") then
                    begin
                     "FD Interest Rate":=ObjIntCalc."Interest Rate";
                     "FD Maturity Date":=CalcDate("FD Duration","Fixed Deposit Start Date");
                    end;
                 end;
            end;
        }
        field(7;"FD Maturity Date";Date)
        {
        }
        field(8;"Fixed Duration";Integer)
        {
            TableRelation = "FD Interest Calculation Crite"."No of Months" where (Code=field("Fixed Deposit Type"));

            trigger OnValidate()
            begin
                ObjGenSetup.Get();

                ObjIntCalc.Reset;
                ObjIntCalc.SetRange(ObjIntCalc.Code,"Fixed Deposit Type");
                ObjIntCalc.SetRange(ObjIntCalc.Duration,"FD Duration");
                if ObjIntCalc.Find('-') then begin
                  "FD Interest Rate":=ObjIntCalc."Interest Rate";
                  "Fixed Duration":=ObjIntCalc."No of Months";
                  "Expected Interest Earned":=ROUND((("Amount to Fix"*ObjIntCalc."Interest Rate"/100)/12)*ObjIntCalc."No of Months",1,'<');
                  "Expected Tax After Term Period":=ROUND("Expected Interest Earned"*(ObjGenSetup."Withholding Tax (%)"/100),1,'>');
                  "Expected Net After Term Period":="Expected Interest Earned"-"Expected Tax After Term Period";
                  end;
            end;
        }
        field(9;"FDR Deposit Status Type";Option)
        {
            Editable = false;
            OptionCaption = ' ,New,Renewed,Terminated';
            OptionMembers = " ",New,Renewed,Terminated;
        }
        field(10;"Fixed Deposit Start Date";Date)
        {

            trigger OnValidate()
            begin
                "FD Maturity Date":=CalcDate("FD Duration","Fixed Deposit Start Date");
            end;
        }
        field(11;"Fixed Deposit Status";Option)
        {
            OptionCaption = ' ,Active,Matured,Closed,Not Matured';
            OptionMembers = " ",Active,Matured,Closed,"Not Matured";
        }
        field(12;"Amount to Fix";Decimal)
        {

            trigger OnValidate()
            begin
                ObjGenSetup.Get();

                ObjIntCalc.Reset;
                ObjIntCalc.SetRange(ObjIntCalc.Code,"Fixed Deposit Type");
                ObjIntCalc.SetRange(ObjIntCalc.Duration,"FD Duration");
                if ObjIntCalc.Find('-') then begin
                  "FD Interest Rate":=ObjIntCalc."Interest Rate";
                  "Fixed Duration":=ObjIntCalc."No of Months";
                  "Expected Interest Earned":=ROUND((("Amount to Fix"*ObjIntCalc."Interest Rate"/100)/12)*ObjIntCalc."No of Months",1,'<');
                  "Expected Tax After Term Period":=ROUND("Expected Interest Earned"*(ObjGenSetup."Withholding Tax (%)"/100),1,'>');
                  "Expected Net After Term Period":="Expected Interest Earned"-"Expected Tax After Term Period";
                  end;
            end;
        }
        field(13;"FD Interest Rate";Decimal)
        {
        }
        field(14;"FD Duration";DateFormula)
        {
        }
        field(15;"Expected Interest Earned";Decimal)
        {
        }
        field(16;"Expected Tax After Term Period";Decimal)
        {
        }
        field(17;"Expected Net After Term Period";Decimal)
        {
        }
        field(18;"Created By";Code[20])
        {
        }
        field(19;"Effected By";Code[20])
        {
        }
        field(20;"Date Effected";Date)
        {
        }
        field(21;"No. Series";Code[20])
        {
        }
        field(22;Status;Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(23;"Account to Tranfers FD Amount";Code[20])
        {
            TableRelation = Vendor."No." where ("BOSA Account No"=field("Member No"));
        }
        field(24;"FD Closed On";Date)
        {
        }
        field(25;"FD Closed By";Code[30])
        {
        }
        field(26;Effected;Boolean)
        {
        }
        field(27;Closed;Boolean)
        {
        }
        field(28;"Interest Earned to Date";Decimal)
        {
            CalcFormula = sum("Interest Buffer"."Interest Amount" where ("Account No"=field("Fixed Deposit Account No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
          SalesSetup.Get;
          SalesSetup.TestField(SalesSetup."Fixed Deposit Placement");
          NoSeriesMgt.InitSeries(SalesSetup."Fixed Deposit Placement",xRec."No. Series",0D,"Document No","No. Series");
        end;

        "Created By":=UserId;
        "Application Date":=Today;
    end;

    var
        ObjFDType: Record "Fixed Deposit Type";
        ObjIntCalc: Record "FD Interest Calculation Crite";
        ObjGenSetup: Record "Sacco General Set-Up";
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjCust: Record "Member Register";
}

