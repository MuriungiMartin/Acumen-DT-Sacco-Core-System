#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516103 "Store Requistion Lines"
{

    fields
    {
        field(1;"Requistion No";Code[20])
        {

            trigger OnValidate()
            begin
                /*
                  IF ReqHeader.GET("Requistion No") THEN BEGIN
                    IF ReqHeader."Global Dimension 1 Code"='' THEN
                       ERROR('Please Select the Global Dimension 1 Requisitioning')
                  END;
                 */

            end;
        }
        field(3;"Line No.";Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(4;Type;Option)
        {
            Caption = 'Type';
            OptionCaption = 'Item';
            OptionMembers = Item;
        }
        field(5;"No.";Code[20])
        {
            Caption = 'No.';
            TableRelation = Item where (Blocked=const(false));

            trigger OnValidate()
            begin
                 Items.Reset;
                 Items.SetRange(Items."No.","No.") ;
                 if Items.Find ('-') then begin
                 "Category Code":=Items."Item Category Code";
                 "Item Group":=Items."Item Group" ;
                // "Item Product Group":= Items."Product Group Code";
                 "Issuing Store":=LocCode;
                 end;
                
                
                 Items.Reset;
                 Items.SetRange(Items."No.","No.");
                  if Items.Find ('-') then
                  LocCode:=Items."Location Code";
                 //Control: Don't Post Same Item Twice NOT GL's
                 /*IF Type=Type::Item THEN BEGIN
                 RequisitionLine.RESET;
                 RequisitionLine.SETRANGE(RequisitionLine."Requistion No","Requistion No");
                 RequisitionLine.SETRANGE(RequisitionLine."No.","No.");
                 IF RequisitionLine.FIND('-') THEN
                    ERROR('You Cannot enter two lines for the same Item');
                 END;
                 //  */
                
                "Action Type":="action type"::"Ask for Quote";
                
                if Type=Type::Item then begin
                   if QtyStore.Get("No.") then
                      Description:=QtyStore.Description;
                      "Unit of Measure":=QtyStore."Base Unit of Measure";
                      "Unit Cost":=QtyStore."Unit Cost";
                      "Issuing Store":=LocCode;
                      "Line Amount":="Unit Cost"*Quantity;
                      QtyStore.CalcFields(QtyStore.Inventory);
                      "Qty in store":=QtyStore.Inventory;
                      "Gen. Bus. Posting Group" := GenPostGroup."Gen. Bus. Posting Group";
                      "Gen. Prod. Posting Group" := QtyStore."Gen. Prod. Posting Group";
                
                 end;
                
                
                
                /*IF Type=Type::Item THEN BEGIN
                   IF GLAccount.GET("No.") THEN
                      Description:=GLAccount.Name;
                 END;*/
                
                /*
                {Modified}
                         //Validate Item
                      GLAccount.GET(QtyStore."Item G/L Budget Account");
                      GLAccount.CheckGLAcc;
                
                */

            end;
        }
        field(6;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(7;"Description 2";Text[50])
        {
            Caption = 'Description 2';
        }
        field(8;Quantity;Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0:5;

            trigger OnValidate()
            begin

                if Type=Type::Item then begin
                      "Line Amount":="Unit Cost"*Quantity;
                end;

                   if QtyStore.Get("No.") then
                      QtyStore.CalcFields(QtyStore.Inventory);
                      "Qty in store":=QtyStore.Inventory;
                       Qty:=QtyStore.Inventory;


                if "Last Quantity Issued">"Qty in store" then
                Error('You cannot request more  than what is in the store');

                if "Quantity Requested"<0 then
                Error('You cannot request negative quantities');
            end;
        }
        field(9;"Qty in store";Decimal)
        {
            FieldClass = Normal;
        }
        field(10;"Request Status";Option)
        {
            Editable = true;
            FieldClass = Normal;
            OptionMembers = Pending,Released,"Director Approval","Budget Approval","FD Approval","CEO Approval",Approved,Closed;
        }
        field(11;"Action Type";Option)
        {
            OptionMembers = " ",Issue,"Ask for Quote";

            trigger OnValidate()
            begin
                     if Type=Type::Item then begin
                        if "Action Type"="action type"::Issue then
                                 Error('You cannot Issue a G/L Account please order for it')
                     end;
                    //Compare Quantity in Store and Qty to Issue
                     if Type=Type::Item then begin
                        if "Action Type"="action type"::Issue then begin
                         if Quantity>"Qty in store" then
                           Error('You cannot Issue More than what is available in store')
                        end;
                     end;
            end;
        }
        field(12;"Unit of Measure";Code[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(13;"Total Budget";Decimal)
        {
        }
        field(14;"Current Month Budget";Decimal)
        {
        }
        field(15;"Unit Cost";Decimal)
        {

            trigger OnValidate()
            begin
                 // IF Type=Type::Item THEN
                   "Line Amount":="Unit Cost"*Quantity;
            end;
        }
        field(16;"Line Amount";Decimal)
        {
        }
        field(17;"Quantity Requested";Decimal)
        {
            Caption = 'Quantity Requested';
            DecimalPlaces = 0:5;

            trigger OnValidate()
            begin
                Quantity:="Quantity Requested";
                    Validate(Quantity);
                "Line Amount":="Unit Cost"*Quantity;


                       if QtyStore.Get("No.") then
                      QtyStore.CalcFields(QtyStore.Inventory);
                      "Qty in store":=QtyStore.Inventory;
                       Qty:=QtyStore.Inventory;


                if "Last Quantity Issued">"Qty in store" then
                Error('You cannot request more  than what is in the store');


                if "Quantity Requested">Qty then
                Error('You cannot request more  than what is in the store');
            end;
        }
        field(24;"Shortcut Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(25;"Shortcut Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(26;"Current Actuals Amount";Decimal)
        {
        }
        field(27;Committed;Boolean)
        {
        }
        field(57;"Gen. Bus. Posting Group";Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(58;"Gen. Prod. Posting Group";Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
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
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(4));
        }
        field(83;"Issuing Store";Code[20])
        {
            TableRelation = Location;
        }
        field(84;"Bin Code";Code[20])
        {
            TableRelation = Bin.Code where ("Location Code"=field("Issuing Store"));
        }
        field(85;"FA No.";Code[20])
        {
            TableRelation = "Fixed Asset"."No.";
        }
        field(86;"Maintenance Code";Code[10])
        {
            Caption = 'Maintenance Code';
            TableRelation = Maintenance;

            trigger OnValidate()
            begin
                /*
                IF "Maintenance Code" <> '' THEN
                  TESTFIELD("FA Posting Type","FA Posting Type"::Maintenance);
                */

            end;
        }
        field(87;"Last Date of Issue";Date)
        {
        }
        field(88;"Last Quantity Issued";Decimal)
        {
        }
        field(89;Remarks;Text[250])
        {
        }
        field(53900;"Lot No.";Code[20])
        {
            Caption = 'Lot No.';
            Editable = false;
        }
        field(53901;"Item Status";Option)
        {
            OptionMembers = ,Functional,Faulty;
        }
        field(53902;"Product Group";Code[20])
        {
            CalcFormula = lookup(Item."Item Category Code" where ("No."=field("No.")));
            FieldClass = FlowField;
        }
        field(54000;Test;Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(54001;"Location Filter";Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = Location.Code;
        }
        field(51516000;Posted;Boolean)
        {
        }
        field(51516001;"Posting Date";Date)
        {
        }
        field(51516002;"Category Code";Code[20])
        {
        }
        field(51516003;"Item Group";Code[20])
        {
        }
        field(51516004;"Item Product Group";Code[20])
        {
        }
        field(51516006;"Category Filter";Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Item Category".Code;
        }
        field(51516007;"Cost Center Filter";Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(51516008;"Date Filter";Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(51516009;"Item Product Group Filter";Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Product Group".Code;
        }
        field(51516010;"Cost Per Cost Center";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Requistion No","Line No.")
        {
            Clustered = true;
            SumIndexFields = "Line Amount";
        }
        key(Key2;"No.",Type)
        {
            SumIndexFields = Quantity;
        }
      
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /* ReqHeader.RESET;
         ReqHeader.SETRANGE(ReqHeader."No.","Requistion No");
         IF ReqHeader.FIND('-') THEN
          IF ReqHeader.Status<>ReqHeader.Status::Open THEN
              ERROR('You Cannot Delete Entries if status is not Pending')
         */

    end;

    trigger OnInsert()
    begin
           "Line Amount":="Unit Cost"*Quantity;

         ReqHeader.Reset;
         ReqHeader.SetRange(ReqHeader."No.","Requistion No");
         if ReqHeader.Find('-') then begin
         if ReqHeader."Global Dimension 1 Code"='' then Error ('Please enter the branch code!');
         if ReqHeader."Shortcut Dimension 2 Code"=''then Error ('Please enter the cost center code!');


          "Shortcut Dimension 1 Code":=ReqHeader."Global Dimension 1 Code";
          "Shortcut Dimension 2 Code":=ReqHeader."Shortcut Dimension 2 Code";
          "Shortcut Dimension 3 Code":=ReqHeader."Shortcut Dimension 3 Code";
          "Shortcut Dimension 4 Code":=ReqHeader."Shortcut Dimension 4 Code";
         // "Issuing Store":=ReqHeader."Issuing Store";
         // IF ReqHeader.Status<>ReqHeader.Status::Open THEN
           //   ERROR('You Cannot Enter Entries if status is not Pending')
         end;
    end;

    trigger OnModify()
    begin
          if Type=Type::Item then
           "Line Amount":="Unit Cost"*Quantity;

         ReqHeader.Reset;
         ReqHeader.SetRange(ReqHeader."No.","Requistion No");
         if ReqHeader.Find('-') then begin
          //"Shortcut Dimension 1 Code":=ReqHeader."Global Dimension 1 Code";
          //"Shortcut Dimension 2 Code":=ReqHeader."Shortcut Dimension 2 Code";
        //  "Shortcut Dimension 3 Code":=ReqHeader."Shortcut Dimension 3 Code";
        //  "Shortcut Dimension 4 Code":=ReqHeader."Shortcut Dimension 4 Code";
          if ReqHeader.Status<>ReqHeader.Status::Open then
              Error('You Cannot Modify Entries if status is not Pending')
         end;
    end;

    var
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        QtyStore: Record Item;
        GenPostGroup: Record "General Posting Setup";
        Budget: Decimal;
        CurrMonth: Code[10];
        CurrYR: Code[10];
        BudgDate: Text[30];
        ReqHeader: Record "Store Requistion Header P";
        BudgetDate: Date;
        YrBudget: Decimal;
        RequisitionLine: Record "Store Requistion Lines";
        Text031: label 'You cannot define item tracking on this line because it is linked to production order %1.';
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        Items: Record Item;
        LocCode: Code[20];
        Qty: Decimal;


    procedure OpenItemTrackingLines()
    begin
        TestField(Type,Type::Item);
        TestField("No.");
        if "Lot No." <> '' then
          Error(Text031,"Lot No.");

        TestField(Quantity);

        //ReservePurchLine.CallItemTrackingS11(Rec);
    end;
}

