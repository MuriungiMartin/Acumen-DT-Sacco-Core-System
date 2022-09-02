#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 55475 "CalcBudget"
{

    trigger OnRun()
    begin
    end;

    var
        CheckDate: Date;
        CheckType: Option " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        CheckNo: Code[20];
        CheckDim1: Code[20];
        CheckDim2: Code[20];
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        BudgetGl: Code[20];
        BCSetup: Record UnknownRecord55881;
        gl: Record "G/L Account";
        items: Record Item;
        fa: Record "Fixed Asset";
        Gsetup: Record "General Ledger Setup";
        Dimval: Record "Dimension Value";
        BudgetAmount: Decimal;
        ActualAmount: Decimal;
        CommittmentAmount: Decimal;
        AvailableAmount: Decimal;
        Budget: Record "Analysis View Budget Entry";
        Actuals: Record "Analysis View Entry";
        Committments: Record UnknownRecord55882;


    procedure UpdateAnalysisView()
    var
        UpdateAnalysisView: Codeunit "Update Analysis View";
        BudgetaryControl: Record UnknownRecord55881;
        AnalysisView: Record "Analysis View";
    begin
        //Update Budget Lines
        if BudgetaryControl.Get then begin
          if BudgetaryControl."Analysis View Code"<>'' then begin
           AnalysisView.Reset;
           AnalysisView.SetRange(AnalysisView.Code,BudgetaryControl."Analysis View Code");
           if AnalysisView.Find('-') then
             UpdateAnalysisView.UpdateAnalysisView_Budget(AnalysisView);
          end;
        end;
    end;


    procedure CheckIfBlocked(BudgetName: Code[20])
    var
        GLBudgetName: Record "G/L Budget Name";
    begin
        GLBudgetName.Get(BudgetName);
        GLBudgetName.TestField(Blocked,false);
    end;


    procedure CheckBudget(PurchLine: Record "Purchase Line";ExitOption: Option Available,Budget,Committment,Actuals): Decimal
    var
        PurchHeader: Record "Purchase Header";
    begin
        //First Update Analysis View
        //UpdateAnalysisView();
        
        PurchHeader.Reset;
        PurchHeader.SetRange(PurchHeader."No.",PurchLine."Document No.");
        if PurchHeader.FindFirst then begin
        CheckDate:=PurchHeader."Document Date";
        CheckType:=PurchLine.Type;
        CheckNo:=PurchLine."No.";
        CheckDim1:=PurchLine."Shortcut Dimension 1 Code";
        CheckDim2:=PurchLine."Shortcut Dimension 2 Code";
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.Reset;
        BCSetup.Get();
        if BCSetup.Mandatory then//budgetary control is mandatory
          begin
            //check if the dates are within the specified range in relation to the payment header table
            if (CheckDate< BCSetup."Current Budget Start Date") then
              begin
                exit;
                //ERROR('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3',CheckDate,
                //BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
              end
            else if (CheckDate>BCSetup."Current Budget End Date") then
              begin
                exit;
                //ERROR('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3',CheckDate,
                //BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
              end;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");
        end;
        //check dates
        if CheckDate =0D then Error('Document has no date');
          FirstDay:=Dmy2date(1,Date2dmy(CheckDate,2),Date2dmy(CheckDate,3));
          CurrMonth:=Date2dmy(CheckDate,2);
          if CurrMonth=12 then
           begin
             LastDay:=Dmy2date(1,1,Date2dmy(CheckDate,3) +1);
             LastDay:=CalcDate('-1D',LastDay);
           end
          else
           begin
             CurrMonth:=CurrMonth +1;
             LastDay:=Dmy2date(1,CurrMonth,Date2dmy(CheckDate,3));
             LastDay:=CalcDate('-1D',LastDay);
           end;
        
        if CheckType=Checktype::Item then begin
            Item.Reset;
           if not Item.Get(CheckNo) then
        //     ERROR('Item Does not Exist');
        exit;
            Item.TestField("Item G/L Budget Account");
            BudgetGl:=Item."Item G/L Budget Account";
         end;
        
          if CheckType=Checktype::"Fixed Asset" then begin
                 FixedAssetsDet.Reset;
                 FixedAssetsDet.SetRange(FixedAssetsDet."No.",CheckNo);
                   if FixedAssetsDet.Find('-') then begin
                       FAPostingGRP.Reset;
                        //FAPostingGRP.SETRANGE(FAPostingGRP.Code,FixedAssetsDet."FA Posting Group");
        
                       //Use the default posting group on purchase line
                       FAPostingGRP.SetRange(FAPostingGRP.Code,PurchLine."Posting Group");
        
        
                       if FAPostingGRP.Find('-') then
                         if PurchLine."FA Posting Type"=PurchLine."fa posting type"::Maintenance then
                          begin
                             BudgetGl:=FAPostingGRP."Maintenance Expense Account";
                               if BudgetGl ='' then
                                 exit;
                                 //ERROR('Ensure Fixed Asset No %1 has the Maintenance G/L Account',PurchLine."No.");
                         end else begin
                           if PurchLine."FA Posting Type"=PurchLine."fa posting type"::"Acquisition Cost" then begin
                             BudgetGl:=FAPostingGRP."Acquisition Cost Account";
                                if BudgetGl ='' then
                                   exit;
                                   //ERROR('Ensure Fixed Asset No %1 has the Acquisition G/L Account',PurchLine."No.");
                           end;
                           //To Accomodate any Additional Item under Custom 1 and Custom 2
        /*                   IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::"Custom 1" THEN BEGIN
                             BudgetGl:=FAPostingGRP."Fuel Account";
                                IF BudgetGl ='' THEN
                                   exit;
                                   //ERROR('Ensure Fixed Asset No %1 has the %2 G/L Account',PurchLine."No.",
                                   //FAPostingGRP."Fuel Account");
                           END;
        
                           IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::"Custom 2" THEN BEGIN
                             BudgetGl:=FAPostingGRP."Custom 2 Account";
                                IF BudgetGl ='' THEN
                                   exit;
                                   //ERROR('Ensure Fixed Asset No %1 has the %2 G/L Account',PurchLine."No.",
                                   //FAPostingGRP."Custom 2 Account");
                           END;
         */                  //To Accomodate any Additional Item under Custom 1 and Custom 2
        
                          end;
                   end;
         end;
        
         if CheckType=Checktype::"G/L Account" then begin
            BudgetGl:=CheckNo;
        //    IF GLAcc.GET(CheckNo) THEN
        //       GLAcc.TESTFIELD("Budget Controlled",TRUE);
         end;
        
        
        
          Budget.SetCurrentkey(Budget."Budget Name",Budget."Posting Date",Budget."G/L Account No.",
          Budget."Dimension 1 Value Code",Budget."Dimension 2 Value Code",Budget."Dimension 3 Value Code",
          Budget."Dimension 4 Value Code");
          Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
          Budget.SetRange(Budget."Posting Date",BCSetup."Current Budget Start Date",LastDay);
          Budget.SetRange(Budget."G/L Account No.",BudgetGl);
          Budget.SetRange(Budget."Dimension 1 Value Code",CheckDim1);
          Budget.SetRange(Budget."Dimension 2 Value Code",CheckDim2);
        //  Budget.SETRANGE(Budget."Dimension 3 Value Code",ShortcutDimCode[3]);
        //  Budget.SETRANGE(Budget."Dimension 4 Value Code",ShortcutDimCode[4]);
          Budget.CalcSums(Budget.Amount);
          BudgetAmount:=Budget.Amount;
        
        
          Actuals.SetCurrentkey(Actuals."Analysis View Code",Actuals."Dimension 1 Value Code",
          Actuals."Dimension 2 Value Code",Actuals."Dimension 3 Value Code",Actuals."Dimension 4 Value Code",
          Actuals."Posting Date",Actuals."Account No.");
          Actuals.SetRange(Actuals."Analysis View Code",BCSetup."Analysis View Code");
          Actuals.SetRange(Actuals."Dimension 1 Value Code",CheckDim1);
          Actuals.SetRange(Actuals."Dimension 2 Value Code",CheckDim2);
        //  Actuals.SETRANGE(Actuals."Dimension 3 Value Code",ShortcutDimCode[3]);
        //  Actuals.SETRANGE(Actuals."Dimension 4 Value Code",ShortcutDimCode[4]);
          Actuals.SetRange(Actuals."Posting Date",BCSetup."Current Budget Start Date",LastDay);
          Actuals.SetRange(Actuals."Account No.",BudgetGl);
          Actuals.CalcSums(Actuals.Amount);
          ActualAmount:=Actuals.Amount;
        
        
          Committments.SetCurrentkey(Committments.Budget,Committments."G/L Account No.",
          Committments."Posting Date",Committments."Shortcut Dimension 1 Code",Committments."Shortcut Dimension 2 Code",
          Committments."Shortcut Dimension 3 Code",Committments."Shortcut Dimension 4 Code");
          Committments.SetRange(Committments.Budget,BCSetup."Current Budget Code");
          Committments.SetRange(Committments."G/L Account No.",BudgetGl);
          Committments.SetRange(Committments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
          Committments.SetRange(Committments."Shortcut Dimension 1 Code",CheckDim1);
          Committments.SetRange(Committments."Shortcut Dimension 2 Code",CheckDim2);
        //  Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",ShortcutDimCode[3]);
        //  Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",ShortcutDimCode[4]);
          Committments.CalcSums(Committments.Amount);
          CommittmentAmount:=Committments.Amount;
        
        AvailableAmount:=BudgetAmount-CommittmentAmount-ActualAmount;
        
        if ExitOption=Exitoption::Available then
          exit(AvailableAmount)
        else if ExitOption=Exitoption::Budget then
          exit(BudgetAmount)
        else if ExitOption=Exitoption::Committment then
          exit(CommittmentAmount)
        else if ExitOption=Exitoption::Actuals then
          exit(ActualAmount)
        end

    end;
}

