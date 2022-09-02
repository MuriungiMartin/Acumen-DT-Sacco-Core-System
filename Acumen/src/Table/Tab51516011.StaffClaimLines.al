#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516011 "Staff Claim Lines"
{

    fields
    {
        field(1;No;Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                // IF Pay.GET(No) THEN
                // "Imprest Holder":=Pay."Account No.";
            end;
        }
        field(2;"Account No:";Code[20])
        {
            Editable = false;
            NotBlank = false;
            TableRelation = "G/L Account"."No." where (test=field(Grouping));

            trigger OnValidate()
            begin
                if GLAcc.Get("Account No:") then
                 "Account Name":=GLAcc.Name;
                 GLAcc.TestField("Direct Posting",true);
                 "Budgetary Control A/C":=GLAcc."Budget Controlled";
                 Pay.SetRange(Pay."No.",No);
                if Pay.FindFirst then begin
                 if Pay."Account No."<>'' then
                "Imprest Holder":=Pay."Account No."
                 else
                  Error('Please Enter the Customer/Account Number');
                end;
            end;
        }
        field(3;"Account Name";Text[50])
        {
        }
        field(4;Amount;Decimal)
        {

            trigger OnValidate()
            begin

                ImprestHeader.Reset;
                ImprestHeader.SetRange(ImprestHeader."No.",No);
                if ImprestHeader.FindFirst then
                  begin
                    "Date Taken":=ImprestHeader.Date;
                   // ImprestHeader.TESTFIELD("Responsibility Center");
                    ImprestHeader.TestField("Global Dimension 1 Code");
                    ImprestHeader.TestField("Shortcut Dimension 2 Code");
                    "Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code":=ImprestHeader."Shortcut Dimension 2 Code";
                    "Shortcut Dimension 3 Code":=ImprestHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code":=ImprestHeader."Shortcut Dimension 4 Code";
                    "Currency Factor":=ImprestHeader."Currency Factor";
                    "Currency Code":=ImprestHeader."Currency Code";
                    if Purpose='' then
                          Purpose:=ImprestHeader.Purpose;

                  end;

                 if "Currency Factor"<>0 then
                   "Amount LCY":=Amount/"Currency Factor"
                  else
                    "Amount LCY":=Amount;
            end;
        }
        field(5;"Due Date";Date)
        {
        }
        field(6;"Imprest Holder";Code[20])
        {
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(7;"Actual Spent";Decimal)
        {
        }
        field(30;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1),
                                                          "Dimension Value Type"=const(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(41;"Apply to";Code[20])
        {
        }
        field(42;"Apply to ID";Code[20])
        {
        }
        field(44;"Surrender Date";Date)
        {
        }
        field(45;Surrendered;Boolean)
        {
        }
        field(46;"M.R. No";Code[20])
        {
        }
        field(47;"Date Issued";Date)
        {
        }
        field(48;"Type of Surrender";Option)
        {
            OptionMembers = " ",Cash,Receipt;
        }
        field(49;"Dept. Vch. No.";Code[20])
        {
        }
        field(50;"Cash Surrender Amt";Decimal)
        {
        }
        field(51;"Bank/Petty Cash";Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(52;"Surrender Doc No.";Code[20])
        {
        }
        field(53;"Date Taken";Date)
        {
        }
        field(54;Purpose;Text[250])
        {
        }
        field(56;"Shortcut Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2),
                                                          "Dimension Value Type"=const(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(79;"Budgetary Control A/C";Boolean)
        {
        }
        field(81;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Dimension Code"=const('PRODUCT'));
        }
        field(82;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the fourth global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(4));
        }
        field(83;Committed;Boolean)
        {
        }
        field(84;"Advance Type";Code[20])
        {
            Caption = 'Claim Type';
            TableRelation = "Receipts and Payment Types".Code where (Type=const(Claim),
                                                                     Blocked=const(false));

            trigger OnValidate()
            begin
                ImprestHeader.Reset;
                ImprestHeader.SetRange(ImprestHeader."No.",No);
                if ImprestHeader.FindFirst then
                  begin
                        if
                         (ImprestHeader.Status=ImprestHeader.Status::Approved) or
                         (ImprestHeader.Status=ImprestHeader.Status::Posted) then
                //        (ImprestHeader.Status=ImprestHeader.Status::"Pending Approval") THEN
                       Error('You Cannot Insert a new record when the status of the document is not Pending');
                  end;

                     RecPay.Reset;
                    RecPay.SetRange(RecPay.Code,"Advance Type");
                    RecPay.SetRange(RecPay.Type,RecPay.Type::Claim);
                    if RecPay.Find('-') then begin
                      Grouping:=RecPay."Default Grouping";
                      "Account No:":=RecPay."G/L Account";
                      Validate("Account No:");
                    end;
            end;
        }
        field(85;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0:15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                 if "Currency Factor"<>0 then
                   "Amount LCY":=Amount/"Currency Factor"
                  else
                    "Amount LCY":=Amount;
            end;
        }
        field(86;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(87;"Amount LCY";Decimal)
        {
        }
        field(88;"Line No.";Integer)
        {
            AutoIncrement = true;
        }
        field(89;"Claim Receipt No";Code[20])
        {
        }
        field(90;"Expenditure Date";Date)
        {
        }
        field(91;"Attendee/Organization Names";Text[250])
        {
        }
        field(92;Grouping;Code[20])
        {
            Description = 'Stores Expense Code';
        }
        field(480;"Dimension Set ID";Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions
            end;
        }
        field(50006;"Account Type";Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Staff,None';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff,"None";
        }
        field(50007;"No. Of Days";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                PayrollEmployee.Reset;
                PayrollEmployee.SetRange(PayrollEmployee."No.","Personal No");
                if PayrollEmployee.Find('-') then begin
                  BasicPay:=PayrollEmployee."Basic Pay";
                  end;
                Amount:=ROUND(BasicPay/21*"No. Of Days",1,'>');
                "Amount LCY":=ROUND(BasicPay/21*"No. Of Days",1,'>');
            end;
        }
        field(50008;"Personal No";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Employee."."No.";
        }
    }

    keys
    {
        key(Key1;"Line No.",No)
        {
            Clustered = true;
            SumIndexFields = Amount,"Amount LCY";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."No.",No);
        if ImprestHeader.FindFirst then
          begin
                if
                //(ImprestHeader.Status=ImprestHeader.Status::Approved)
                (ImprestHeader.Status=ImprestHeader.Status::Posted)or
                (ImprestHeader.Status=ImprestHeader.Status::"Pending Approval") then
               Error('You Cannot Delete this record its status is not Pending');
          end;
          TestField(Committed,false);
    end;

    trigger OnInsert()
    begin
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."No.",No);
        if ImprestHeader.FindFirst then
          begin
            "Date Taken":=ImprestHeader.Date;
           // ImprestHeader.TESTFIELD("Responsibility Center");
            ImprestHeader.TestField("Global Dimension 1 Code");
            ImprestHeader.TestField("Shortcut Dimension 2 Code");
            "Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code":=ImprestHeader."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code":=ImprestHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code":=ImprestHeader."Shortcut Dimension 4 Code";
            "Currency Factor":=ImprestHeader."Currency Factor";
            "Currency Code":=ImprestHeader."Currency Code";
            if Purpose='' then
            Purpose:=ImprestHeader.Purpose;
          end;
    end;

    trigger OnModify()
    begin
        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."No.",No);
        if ImprestHeader.FindFirst then
          begin
            if
            // (ImprestHeader.Status=ImprestHeader.Status::"Pending Approval") or
                (ImprestHeader.Status=ImprestHeader.Status::Posted) or
                (ImprestHeader.Status=ImprestHeader.Status::Approved) then
               Error('You Cannot Modify this record its status is not Pending');

            "Date Taken":=ImprestHeader.Date;
        //    "Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
        //    "Shortcut Dimension 2 Code":=ImprestHeader."Shortcut Dimension 2 Code";
        //    "Shortcut Dimension 3 Code":=ImprestHeader."Shortcut Dimension 3 Code";
        //    "Shortcut Dimension 4 Code":=ImprestHeader."Shortcut Dimension 4 Code";
            "Currency Factor":=ImprestHeader."Currency Factor";
            "Currency Code":=ImprestHeader."Currency Code";
            if Purpose='' then
            Purpose:=ImprestHeader.Purpose;

          end;

          TestField(Committed,false);
    end;

    var
        GLAcc: Record "G/L Account";
        Pay: Record "Staff Claims Header";
        ImprestHeader: Record "Staff Claims Header";
        RecPay: Record "Receipts and Payment Types";
        DimMgt: Codeunit DimensionManagement;
        PayrollEmployee: Record "Payroll Employee.";
        ObjCustomer: Record Customer;
        BasicPay: Decimal;


    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID",StrSubstNo('%1 %2','Receipt',"Line No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Global Dimension 1 Code","Shortcut Dimension 2 Code");
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    end;


    procedure LookupShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber,ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber,ShortcutDimCode);
    end;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array [8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID",ShortcutDimCode);
    end;
}

