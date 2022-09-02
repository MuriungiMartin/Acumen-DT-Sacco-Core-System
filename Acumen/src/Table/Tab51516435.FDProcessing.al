#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516435 "FD Processing"
{
    LookupPageID = "Posted Funeral Expense Card";

    fields
    {
        field(1;"Document No.";Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                if "Document No." <> xRec."Document No." then begin
                 ObjFDProcessing.Get;
                  NoSeriesMgt.TestManual(ObjSaccoSetup."Fixed Deposit Placement");
                  "Fixed Deposit Nos" := '';
                end;
            end;
        }
        field(2;Name;Text[70])
        {
            Caption = 'Name';
            Editable = false;

            trigger OnValidate()
            begin
                //IF ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN
                  //"Search Name" := Name;
            end;
        }
        field(3;"Search Name";Code[70])
        {
            Caption = 'Search Name';
        }
        field(4;"Name 2";Text[50])
        {
            Caption = 'Name 2';
        }
        field(5;Address;Text[50])
        {
            Caption = 'Address';
        }
        field(6;"Address 2";Text[50])
        {
            Caption = 'Address 2';
        }
        field(7;City;Text[30])
        {
            Caption = 'City';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(8;Contact;Text[50])
        {
            Caption = 'Contact';

            trigger OnValidate()
            begin
                // IF RMSetup.GET THEN
                //   IF RMSetup."Bus. Rel. Code for Vendors" <> '' THEN
                //     IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') THEN BEGIN
                //       MODIFY;
                //       UpdateContFromVend.OnModify(Rec);
                //       UpdateContFromVend.InsertNewContactPerson(Rec,FALSE);
                //       MODIFY(TRUE);
                //     END
            end;
        }
        field(9;"Phone No.";Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(16;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(17;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(56;"Global Dimension 1 Filter";Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(57;"Global Dimension 2 Filter";Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(68001;"Personal No.";Code[20])
        {
            Editable = false;
        }
        field(68002;"ID No.";Code[50])
        {
            Editable = false;
        }
        field(68007;"Fixed Deposit Status";Option)
        {
            Editable = false;
            OptionCaption = 'Open ,Active,Matured,Closed,Not Matured';
            OptionMembers = "Open ",Active,Matured,Closed,"Not Matured";
        }
        field(68008;"Call Deposit";Boolean)
        {

            trigger OnValidate()
            begin
                // IF AccountTypes.GET("Account Type") THEN BEGIN
                // IF AccountTypes."Fixed Deposit" = FALSE THEN
                // ERROR('Call deposit only applicable for Fixed Deposits.');
                // END;
                // IF "Call Deposit"=FALSE THEN
                //   ObjGroup:=TRUE;
            end;
        }
        field(68009;"Mobile Phone No";Code[30])
        {

            trigger OnValidate()
            begin
                
                /*Vend.RESET;
                Vend.SETRANGE(Vend."Personal No.","Personal No.");
                IF Vend.FIND('-') THEN
                Vend.MODIFYALL(Vend."Mobile Phone No","Mobile Phone No");*/
                
                /*Cust.RESET;
                Cust.SETRANGE(Cust."Staff No","Staff No");
                IF Cust.FIND('-') THEN
                Cust.MODIFYALL(Cust."Mobile Phone No","Mobile Phone No");*/

            end;
        }
        field(68012;"BOSA Account No";Code[20])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                /*ObjMembReg.RESET;
                ObjMembReg.SETRANGE(ObjMembReg."No.","BOSA Account No");
                IF ObjMembReg.FIND('-') THEN BEGIN
                  "Transaction Date":=ObjMembReg.Name;
                  "Savings Account No.":=ObjMembReg."FOSA Account No.";
                  "ID No.":=ObjMembReg."ID No.";
                  "Personal No.":=ObjMembReg."Personal No";
                  "Mobile Phone No":=ObjMembReg."Phone No.";
                  ObjMembReg.MODIFY;
                  END;
                  */

            end;
        }
        field(68013;Signature;Blob)
        {
            Caption = 'Signature';
            SubType = Bitmap;
        }
        field(68015;"Employer Code";Code[20])
        {
        }
        field(68016;Status;Option)
        {
            Editable = true;
            OptionCaption = 'New,Open,Pending Approval,Rejected,Cancelled,Approved';
            OptionMembers = New,Open,"Pending Approval",Rejected,Cancelled,Approved;

            trigger OnValidate()
            begin
                // IF (Status = Status::Active) OR (Status = Status::New) THEN
                // Blocked:=Blocked::" "
                // ELSE
                // Blocked:=Blocked::All
            end;
        }
        field(68017;"Account Type";Code[20])
        {
            TableRelation = "Account Types-Saving Products".Code where (Code=filter('FIXED'|'CALL'));

            trigger OnValidate()
            begin
                // IF AccountTypes.GET("Account Type") THEN BEGIN
                // AccountTypes.TESTFIELD(AccountTypes."Posting Group");
                // "Vendor Posting Group":=AccountTypes."Posting Group";
                // "Call Deposit" := FALSE;
                // END;
            end;
        }
        field(68018;"Account Category";Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Parish,Church,Church Department,Staff';
            OptionMembers = Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff;
        }
        field(68019;"FD Marked for Closure";Boolean)
        {
        }
        field(68027;"Expected Maturity Date";Date)
        {
        }
        field(68032;"E-Mail (Personal)";Text[20])
        {
        }
        field(68041;"Fixed Deposit Type";Code[20])
        {
            TableRelation = "Fixed Deposit Type".Code;

            trigger OnValidate()
            begin
                // //TESTFIELD("Registration Date");
                // IF "Account Type"='FIXED' THEN BEGIN
                // IF FDType.GET("Fixed Deposit Type") THEN
                // //"FD Maturity Date":=CALCDATE(FDType.Duration,"Registration Date");
                // "FD Maturity Date":=CALCDATE(FDType.Duration,TODAY);
                //  "Fixed Duration":=FDType.Duration;
                //  //"Fixed duration2":=FDType."No. of Months";
                //  //"FD Duration":=FDType."No. of Months";
                //  "Fixed Deposit Status":="Fixed Deposit Status"::Active;
                //  END;
                //
                // //IF "Account Type"='FIXED' THEN BEGIN
                //  IF interestCalc.GET(interestCalc.Code) THEN
                //  "Interest rate":=interestCalc."Interest Rate";
                //
                //
                // //  IF "Account Type"='CALLDEPOSIT' THEN BEGIN
                // //  IF interestCalc.GET(interestCalc.Code) THEN
                // //  "Interest rate":=interestCalc."On Call Interest Rate";
                // //  END;
            end;
        }
        field(68042;"Interest Earned";Decimal)
        {
            CalcFormula = sum("Interest Buffer"."Interest Amount" where ("Document No."=field("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68043;"Untranfered Interest";Decimal)
        {
            CalcFormula = sum("Interest Buffer"."Interest Amount" where ("Document No."=field("Document No."),
                                                                         Transferred=filter(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68044;"FD Maturity Date";Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                /*"FD Duration":="FD Maturity Date"-"Registration Date";
                 "FD Duration":=ROUND("FD Duration"/30,1);
                MODIFY;
                */

            end;
        }
        field(68045;"Savings Account No.";Code[20])
        {
            TableRelation = Vendor."No." where ("Account Type"=const('CURRENT'));

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.","Savings Account No.");
                if Vend.Find('-') then begin
                  Vend.CalcFields(Vend.Balance,Vend."Balance (LCY)");
                  Name:=Vend.Name;
                  "BOSA Account No":=Vend."BOSA Account No";
                  "Personal No.":=Vend."Personal No.";
                  "ID No.":="ID No.";
                  "Mobile Phone No":="Mobile Phone No";
                  "Current Account Balance":=Vend.Balance;
                  "Global Dimension 2 Code":=Vend."Global Dimension 2 Code";
                  end;
            end;
        }
        field(68048;"Amount to Transfer";Decimal)
        {

            trigger OnValidate()
            begin
                //CALCFIELDS(Balance);
                //TESTFIELD("Registration Date");
                /*
                
                IF AccountTypes.GET("Account Type") THEN BEGIN
                IF "Account Type" = 'MUSTARD' THEN BEGIN
                IF "Last Withdrawal Date" = 0D THEN BEGIN
                "Last Withdrawal Date" :="Registration Date";
                MODIFY;
                END;
                
                IF (CALCDATE(AccountTypes."Savings Duration","Last Withdrawal Date") > TODAY) THEN BEGIN
                ERROR('You can only withdraw from this account once in %1.',AccountTypes."Savings Duration")
                END ELSE BEGIN
                IF "Amount to Transfer" > (Balance*0.25) THEN
                ERROR('Amount cannot be more than 25 Percent of the balance. i.e. %1',(Balance*0.25));
                
                END;
                
                END ELSE BEGIN
                IF AccountTypes."Savings Withdrawal penalty" > 0 THEN BEGIN
                IF (CALCDATE(AccountTypes."Savings Duration","Registration Date") > TODAY) THEN BEGIN
                IF ("Amount to Transfer"+ROUND(("Amount to Transfer"*(AccountTypes."Savings Withdrawal penalty")),1,'>')) > Balance THEN
                ERROR('You cannot transfer more than %1.',Balance-ROUND((Balance*(AccountTypes."Savings Withdrawal penalty")),1,'>'));
                
                END;
                
                END ELSE BEGIN
                IF "Amount to Transfer" > Balance THEN
                MESSAGE('Amount cannot be more than the balance.');
                
                END;
                END;
                END;
                  */
                //"Expected Interest On Term Dep":=ROUND((("Amount to Transfer"*"Interest rate"/100)/12)*FDDuration,1);
                
                if "Account Type"='FIXED' then begin
                interestCalc.Reset;
                interestCalc.SetRange(interestCalc.Code,"Fixed Deposit Type");
                interestCalc.SetRange(interestCalc.Duration,"Fixed Duration");
                if interestCalc.Find('-') then begin
                GenSetUp.Get();
                "Interest rate":=interestCalc."Interest Rate";
                FDDuration:=interestCalc."No of Months";
                "Expected Interest On Term Dep":=ROUND((("Amount to Transfer"*"Interest rate"/100)/365)*FDDuration,0.01,'=');
                "Expected Interest On Term Dep":="Expected Interest On Term Dep"-("Expected Interest On Term Dep"*(GenSetUp."Withholding Tax (%)"/100));
                if ("Amount to Transfer"<interestCalc."Minimum Amount") or ("Amount to Transfer">interestCalc."Maximum Amount") then
                Error('You Cannot Deposit More OR less than the limits');
                end;
                end;

            end;
        }
        field(68055;"Fixed Duration";DateFormula)
        {
            TableRelation = "FD Interest Calculation Crite".Duration where (Code=field("Fixed Deposit Type"));

            trigger OnValidate()
            begin
                // IF "Account Type" = 'FIXED' THEN BEGIN
                // //TESTFIELD("Registration Date");
                // //"FD Maturity Date":=CALCDATE("Fixed Duration","Registration Date");
                "FD Maturity Date":=CalcDate("Fixed Duration","Fixed Deposit Start Date");
                // END;
                //
                //
                //
                if "Account Type"='FIXED' then begin
                interestCalc.Reset;
                interestCalc.SetRange(interestCalc.Code,"Fixed Deposit Type");
                interestCalc.SetRange(interestCalc.Duration,"Fixed Duration");
                if interestCalc.Find('-') then begin
                "Interest rate":=interestCalc."Interest Rate";
                FDDuration:=interestCalc."No of Months";
                "Expected Interest On Term Dep":=ROUND((("Amount to Transfer"*"Interest rate"/100)/365)*FDDuration,0.01,'=');
                end;
                end;

                if "Account Type"='CALL' then begin
                interestCalc.Reset;
                interestCalc.SetRange(interestCalc.Code,"Fixed Deposit Type");
                interestCalc.SetRange(interestCalc.Duration,"Fixed Duration");
                if interestCalc.Find('-') then begin
                "Interest rate":=interestCalc."On Call Interest Rate";
                FDDuration:=interestCalc."No of Months";
                "Expected Interest On Term Dep":=ROUND((("Amount to Transfer"*"Interest rate"/100)/365)*FDDuration,0.01,'=');
                end;
                end;
            end;
        }
        field(68067;"Neg. Interest Rate";Decimal)
        {
        }
        field(68068;"Date Renewed";Date)
        {
        }
        field(68069;"Last Interest Date";Date)
        {
            CalcFormula = max("Interest Buffer"."Interest Date" where ("Document No."=field("Document No.")));
            FieldClass = FlowField;
        }
        field(68070;"Don't Transfer to Savings";Boolean)
        {
        }
        field(68073;"S-Mobile No";Code[20])
        {
        }
        field(69009;"FD Duration";Integer)
        {

            trigger OnValidate()
            begin
                /* IF "Account Type"='FIXED' THEN
                  "FD Maturity Date":="Registration Date"+("FD Duration"*30);
                  MODIFY;*/
                 /*
                interestCalc.RESET;
                interestCalc.SETRANGE(interestCalc.Code,"Fixed Deposit Type");
                interestCalc.SETRANGE(interestCalc."No of Months","FD Duration");
                IF interestCalc.FIND('-') THEN BEGIN
                "Interest rate":=interestCalc."Interest Rate";
                END;
                */
                // IF "Account Type" = 'FIXED' THEN BEGIN
                // TESTFIELD("Fixed Deposit Start Date");
                // "FD Maturity Date":=CALCDATE("FD Duration","Fixed Deposit Start Date");
                // //"FD Maturity Date":=CALCDATE("FD Duration",TODAY);
                // END;
                
                
                if "Account Type"='FIXED' then begin
                interestCalc.Reset;
                interestCalc.SetRange(interestCalc.Code,"Fixed Deposit Type");
                interestCalc.SetRange(interestCalc."No of Months","FD Duration");
                if interestCalc.Find('-') then begin
                "Interest rate":=interestCalc."Interest Rate";
                FDDuration:=interestCalc."No of Months";
                "Expected Interest On Term Dep":=ROUND((("Amount to Transfer"*interestCalc."Interest Rate"/100)/12)*interestCalc."No of Months",1);
                end;
                end;
                
                if "Account Type"='CALLDEPOSIT' then begin
                interestCalc.Reset;
                interestCalc.SetRange(interestCalc.Code,"Fixed Deposit Type");
                interestCalc.SetRange(interestCalc."No of Months","FD Duration");
                if interestCalc.Find('-') then begin
                "Interest rate":=interestCalc."On Call Interest Rate";
                FDDuration:=interestCalc."No of Months";
                //"Expected Interest On Term Dep":=ROUND((("Amount to Transfer"*interestCalc."On Call Interest Rate"/100)/12)*interestCalc."No of Months",1);
                end;
                end;

            end;
        }
        field(69037;"Transfer Amount to Savings";Decimal)
        {
        }
        field(69040;"Interest rate";Decimal)
        {
        }
        field(69042;"FDR Deposit Status Type";Option)
        {
            Editable = false;
            OptionCaption = 'New,Running,Terminated';
            OptionMembers = New,Running,Terminated;
        }
        field(69153;"On Term Deposit Maturity";Option)
        {
            OptionCaption = 'Pay to Current_ Principle+Interest,Roll Over Principle+Interest,Roll Over Principle Only ';
            OptionMembers = "Pay to Current_ Principle+Interest","Roll Over Principle+Interest","Roll Over Principle Only ";
        }
        field(69179;"Expected Interest On Term Dep";Decimal)
        {
        }
        field(69188;"Fixed Deposit Start Date";Date)
        {
        }
        field(69189;"Prevous Fixed Deposit Type";Code[20])
        {
        }
        field(69190;"Prevous FD Start Date";Date)
        {
        }
        field(69191;"Prevous Fixed Duration";DateFormula)
        {
        }
        field(69192;"Prevous Expected Int On FD";Decimal)
        {
        }
        field(69193;"Prevous FD Maturity Date";Date)
        {
        }
        field(69194;"Prevous FD Deposit Status Type";Option)
        {
            OptionMembers = Matured;
        }
        field(69195;"Prevous Interest Rate FD";Decimal)
        {
        }
        field(69196;"Last Interest Earned Date";Date)
        {
            CalcFormula = max("Interest Buffer"."Interest Date" where ("Document No."=field("Document No.")));
            FieldClass = FlowField;
        }
        field(69197;"Fixed Deposit Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(69198;"Destination Account";Code[50])
        {
            TableRelation = Vendor."No." where ("BOSA Account No"=field("BOSA Account No"),
                                                "Account Type"=filter('FIXED'|'CALL'));
        }
        field(69199;"User ID";Code[70])
        {
            Editable = false;
        }
        field(69200;"Application Date";Date)
        {
            Editable = false;
        }
        field(69201;"Current Account Balance";Decimal)
        {
            CalcFormula = -sum("Detailed Vendor Ledg. Entry".Amount where ("Vendor No."=field("Savings Account No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69202;"Date Posted";Date)
        {
            Editable = false;
        }
        field(69203;Posted;Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No." = '' then begin
          ObjSaccoSetup.Get;
         ObjSaccoSetup.TestField( ObjSaccoSetup."Fixed Deposit Placement");
          NoSeriesMgt.InitSeries( ObjSaccoSetup."Fixed Deposit Placement",xRec."Document No.",0D,"Document No.","Fixed Deposit Nos");


        end;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        CommentLine: Record "Comment Line";
        PurchOrderLine: Record "Purchase Line";
        PostCode: Record "Post Code";
        VendBankAcc: Record "Vendor Bank Account";
        OrderAddr: Record "Order Address";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ItemCrossReference: Record "Item Cross Reference";
        RMSetup: Record "Marketing Setup";
        ServiceItem: Record "Service Item";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromVend: Codeunit "VendCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        AccountTypes: Record "Account Types-Saving Products";
        FDType: Record "Fixed Deposit Type";
        ReplCharge: Decimal;
        Vends: Record Vendor;
        gnljnlLine: Record "Gen. Journal Line";
        FOSAAccount: Record Vendor;
        Member: Record "Member Register";
        Vend: Record Vendor;
        Loans: Record "Loans Register";
        StatusPermissions: Record "Status Change Permision";
        interestCalc: Record "FD Interest Calculation Crite";
        GenSetUp: Record "Sacco General Set-Up";
        Parishes: Record "Member's Parishes";
        FDDuration: Integer;
        ObjVendor: Record Vendor;
        ObjFDProcessing: Record "Loan Officers Details";
        ObjSaccoSetup: Record "Sacco No. Series";
        ObjMembReg: Record "Member Register";


    procedure AssistEdit(OldVend: Record "Loan Repay Schedule-Calc"): Boolean
    var
        Vend: Record "Loan Repay Schedule-Calc";
    begin
        // WITH Vend DO BEGIN
        //   Vend := Rec;
        //   ObjFDProcessing.GET;
        //   ObjFDProcessing.TESTFIELD("Fixed Deposit Nos");
        //   IF NoSeriesMgt.SelectSeries(ObjFDProcessing."Fixed Deposit Nos",OldVend."Fixed Deposit Nos","Fixed Deposit Nos") THEN BEGIN
        //     ObjFDProcessing.GET;
        //    ObjFDProcessing.TESTFIELD("Fixed Deposit Nos");
        //     NoSeriesMgt.SetSeries("Fixed Deposit Nos");
        //     Rec := Vend;
        //     EXIT(TRUE);
        //   END;
        // END;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
        // DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        // DimMgt.SaveDefaultDim(DATABASE::Vendor,"No.",FieldNumber,ShortcutDimCode);
        // MODIFY;
    end;


    procedure ShowContact()
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
    begin
        // IF "No." = '' THEN
        //   EXIT;
        //
        // ContBusRel.SETCURRENTKEY("Link to Table","No.");
        // ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Vendor);
        // ContBusRel.SETRANGE("No.","No.");
        // IF NOT ContBusRel.FINDFIRST THEN BEGIN
        //   IF NOT CONFIRM(Text003,FALSE,TABLECAPTION,"No.") THEN
        //     EXIT;
        //   UpdateContFromVend.InsertNewContact(Rec,FALSE);
        //   ContBusRel.FINDFIRST;
        // END;
        // COMMIT;
        //
        // Cont.SETCURRENTKEY("Company Name","Company No.",Type,Name);
        // Cont.SETRANGE("Company No.",ContBusRel."Contact No.");
        // PAGE.RUN(PAGE::"Contact List",Cont);
    end;


    procedure SetInsertFromContact(FromContact: Boolean)
    begin
        InsertFromContact := FromContact;
    end;


    procedure CheckBlockedVendOnDocs(Vend2: Record Vendor;Transaction: Boolean)
    begin
        if Vend2.Blocked = Vend2.Blocked::All then
          VendBlockedErrorMessage(Vend2,Transaction);
    end;


    procedure CheckBlockedVendOnJnls(Vend2: Record Vendor;DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;Transaction: Boolean)
    begin
        // WITH Vend2 DO BEGIN
        //   IF (Blocked = Blocked::All) OR
        //      (Blocked = Blocked::Payment) AND (DocType = DocType::Payment)
        //   THEN
        //     VendBlockedErrorMessage(Vend2,Transaction);
        // END;
    end;


    procedure CreateAndShowNewInvoice()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        // PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice;
        // PurchaseHeader.SETRANGE("Buy-from Vendor No.","No.");
        // PurchaseHeader.INSERT(TRUE);
        // COMMIT;
        // PAGE.RUNMODAL(PAGE::"Mini Purchase Invoice",PurchaseHeader)
    end;


    procedure CreateAndShowNewCreditMemo()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        // PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::"Credit Memo";
        // PurchaseHeader.SETRANGE("Buy-from Vendor No.","No.");
        // PurchaseHeader.INSERT(TRUE);
        // COMMIT;
        // PAGE.RUNMODAL(PAGE::"Mini Purchase Credit Memo",PurchaseHeader)
    end;


    procedure VendBlockedErrorMessage(Vend2: Record Vendor;Transaction: Boolean)
    var
        "Action": Text[30];
    begin
        // IF Transaction THEN
        //   Action := Text005
        // ELSE
        //   Action := Text006;
        // ERROR(Text007,Action,Vend2."No.",Vend2.Blocked);
    end;


    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        // IF MapPoint.FINDFIRST THEN
        //   MapMgt.MakeSelection(DATABASE::Vendor,GETPOSITION)
        // ELSE
        //   MESSAGE(Text011);
    end;


    procedure CalcOverDueBalance() OverDueBalance: Decimal
    var
        [SecurityFiltering(Securityfilter::Filtered)]VendLedgEntryRemainAmtQuery: Query "Vend. Ledg. Entry Remain. Amt.";
    begin
        // VendLedgEntryRemainAmtQuery.SETRANGE(Vendor_No,"No.");
        // VendLedgEntryRemainAmtQuery.SETRANGE(IsOpen,TRUE);
        // VendLedgEntryRemainAmtQuery.SETFILTER(Due_Date,'<%1',WORKDATE);
        // VendLedgEntryRemainAmtQuery.OPEN;
        //
        // IF VendLedgEntryRemainAmtQuery.READ THEN
        //   OverDueBalance := VendLedgEntryRemainAmtQuery.Sum_Remaining_Amt_LCY;
    end;


    procedure ValidateRFCNo(Length: Integer)
    begin
        // IF STRLEN("RFC No.") <> Length THEN
        //   ERROR(Text10000,"RFC No.");
    end;


    procedure GetInvoicedPrepmtAmountLCY(): Decimal
    var
        PurchLine: Record "Purchase Line";
    begin
        // PurchLine.SETCURRENTKEY("Document Type","Pay-to Vendor No.");
        // PurchLine.SETRANGE("Document Type",PurchLine."Document Type"::Order);
        // PurchLine.SETRANGE("Pay-to Vendor No.","No.");
        // PurchLine.CALCSUMS("Prepmt. Amount Inv. (LCY)","Prepmt. VAT Amount Inv. (LCY)");
        // EXIT(PurchLine."Prepmt. Amount Inv. (LCY)" + PurchLine."Prepmt. VAT Amount Inv. (LCY)");
    end;


    procedure GetTotalAmountLCY(): Decimal
    begin
        // CALCFIELDS(
        //   "Balance (LCY)","Outstanding Orders (LCY)","Amt. Rcd. Not Invoiced (LCY)","Outstanding Invoices (LCY)");
        //
        // EXIT(
        //   "Balance (LCY)" + "Outstanding Orders (LCY)" +
        //   "Amt. Rcd. Not Invoiced (LCY)" + "Outstanding Invoices (LCY)" - GetInvoicedPrepmtAmountLCY);
    end;
}

