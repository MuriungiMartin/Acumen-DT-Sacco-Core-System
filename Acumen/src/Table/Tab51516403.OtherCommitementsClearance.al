#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516403 "Other Commitements Clearance"
{

    fields
    {
        field(1;"Loan No.";Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2;Description;Text[50])
        {
        }
        field(3;Payee;Text[50])
        {
            NotBlank = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(4;Amount;Decimal)
        {

            trigger OnValidate()
            begin
                if Amount < 0 then
                Error('Amount cannot be less than 0');

                if LoanApp.Get("Loan No.") then begin
                  NetAmt:=0;
                  //NetAmt:=LoansProcess.ComputeCharges(LoanApp."Approved Amount",LoanApp."Loan Product Type",LoanApp."Loan No.",0);

                  if NetAmt-Amount<=0 then
                    Error(Text002);
                end;


                if Source = Source::Credit then begin
                    CalcFields("Total Loan Balance");

                    if Amount >= "Total Loan Balance" then begin
                      "Loan Clearance":=true;
                      Message('Loan Will be Fully Cleared');
                    end
                    else begin
                      "Loan Clearance":=false;
                      Message('Amount is not enough to clear the Loan. Only Current Loan Dues will be recovered');
                    end;
                end;
            end;
        }
        field(5;"Date Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(6;"Bankers Cheque No";Code[20])
        {
        }
        field(7;"Bankers Cheque No 2";Code[20])
        {
        }
        field(8;"Bankers Cheque No 3";Code[20])
        {
        }
        field(9;"Batch No.";Code[20])
        {
        }
        field(10;"Affects 2/3 Rule";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Monthly Deductions";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Account No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Account Name";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14;Type;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'External Loan Clearance,External Payment to Vendor,Internal Payment to Member';
            OptionMembers = "External Loan Clearance","External Payment to Vendor","Internal Payment to Member";
        }
        field(15;Source;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Savings,Credit';
            OptionMembers = Savings,Credit;
        }
        field(16;"Loan Account";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(17;"Member Loan Account";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(18;"Loan Clearance";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19;"Total Loan Balance";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20;"Charging Option";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',On Approved Amount,On Net Amount,Base on Installments';
            OptionMembers = ,"On Approved Amount","On Net Amount","Base on Installments";
        }
        field(21;"Additional Charge %";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Loan No.",Payee)
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2;Payee)
        {
        }
        key(Key3;"Batch No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if LoanApp.Get("Loan No.") then begin
          if (LoanApp."Loan Status"=LoanApp."loan status"::Appraisal) or (LoanApp."Loan Status"=LoanApp."loan status"::Approved) then
            Error(Text001,LoanApp."Loan Status");
        end;
    end;

    trigger OnInsert()
    begin
        if LoanApp.Get("Loan No.") then begin
          if (LoanApp."Loan Status"=LoanApp."loan status"::Appraisal) or (LoanApp."Loan Status"=LoanApp."loan status"::Approved) then
            Error(Text001,LoanApp."Loan Status");
        end;
    end;

    trigger OnModify()
    begin
        if LoanApp.Get("Loan No.") then begin
          if (LoanApp."Loan Status"=LoanApp."loan status"::Appraisal) or (LoanApp."Loan Status"=LoanApp."loan status"::Approved) then
            Error(Text001,LoanApp."Loan Status");
        end;
    end;

    trigger OnRename()
    begin
        if LoanApp.Get("Loan No.") then begin
          if (LoanApp."Loan Status"=LoanApp."loan status"::Appraisal) or (LoanApp."Loan Status"=LoanApp."loan status"::Approved) then
            Error(Text001,LoanApp."Loan Status");
        end;
    end;

    var
        LoanApp: Record "Loans Register";
        Text001: label 'You cannot modify this since the loan is already %1';
        Text002: label 'The approved amount is not sufficient to offset commitments';
        NetAmt: Decimal;
        GenSetup: Record "Sacco General Set-Up";
        LoanApps: Record "Loans Register";
        PCharges: Record "Loan Product Charges";
        TotalComputedCharges: Decimal;
        ChargeExtraComms: Boolean;
        TopUp: Record "Loan Offset Details";
        TotalCleared: Decimal;
        OtherComms: Decimal;
        OtherCommitments: Record "Other Commitements Clearance";
        PaySched: Record "Loan Repayment Schedule";
        TotalSched: Decimal;
        Difference: Decimal;

    local procedure ComputeCharges(ApprovedAmt: Decimal;ProdType: Code[20];LoanNo: Code[20];CurrValue: Decimal)
    begin
        /*GenSetup.GET();
        TotalComputedCharges:=0;
        ChargeExtraComms:=FALSE;
              TopUp.RESET;
              TopUp.SETRANGE(TopUp."Loan No.",LoanNo);
              IF TopUp.FIND('-') THEN BEGIN
                REPEAT
                  IF TopUp."Additional Top Up Commission"=TRUE THEN
                    ChargeExtraComms:=TRUE;
                UNTIL TopUp.NEXT=0;
              END;
        PCharges.RESET;
        PCharges.SETRANGE(PCharges."Product Code",ProdType);
        PCharges.SETRANGE(PCharges."Charge Type",PCharges."Charge Type"::General);
        IF PCharges.FIND('-') THEN BEGIN
           REPEAT
            IF (PCharges."Charge Method"=PCharges."Charge Method"::"% of Amount") THEN
               TotalComputedCharges:=TotalComputedCharges+(ApprovedAmt *PCharges.Percentage/100)
            ELSE IF PCharges."Charge Method"=PCharges."Charge Method"::"Flat Amount" THEN
               TotalComputedCharges:=TotalComputedCharges+PCharges.Amount;
            {
            ELSE IF PCharges."Charge Method"=PCharges."Charge Method"::Staggered THEN BEGIN
            }
              //PCharges.TESTFIELD(PCharges."Staggered Charge Code");
        {
              TariffDetails.RESET;
              TariffDetails.SETRANGE(TariffDetails.Code,PCharges."Staggered Charge Code");
              IF TariffDetails.FIND('-') THEN BEGIN
                REPEAT
                IF (ApprovedAmt >= TariffDetails."Lower Limit") AND (ApprovedAmt <= TariffDetails."Upper Limit") THEN BEGIN
                IF TariffDetails."Use Percentage"=TRUE THEN BEGIN
                  TotalComputedCharges:=TotalComputedCharges+ApprovedAmt*TariffDetails.Percentage*0.01;
                END ELSE BEGIN
                TotalComputedCharges := TotalComputedCharges+TariffDetails."Charge Amount";
                END;
                END;
                UNTIL TariffDetails.NEXT =0;
              END;
              END;
           UNTIL PCharges.NEXT = 0;
        END;
        }
        //MESSAGE('Running Charge general %1',TotalComputedCharges);
        
        
          //End of general charges
        
        TotalCleared:=0;
        //Pass loan clearance principle and interest
           TopUp.RESET;
           TopUp.SETRANGE(TopUp."Loan No.",LoanNo);
           IF TopUp.FIND('-') THEN BEGIN
              REPEAT
                //TopUp.CALCSUMS(TopUp."Principle Top Up",TopUp."Interest Top Up");
                TotalCleared:=TotalCleared+TopUp."Principle Top Up"+TopUp."Interest Top Up";
        
                PCharges.RESET;
                PCharges.SETRANGE(PCharges."Product Code",ProdType);
                PCharges.SETRANGE(PCharges."Charge Type",PCharges."Charge Type"::"Top up");
                IF PCharges.FIND('-') THEN BEGIN
                  REPEAT
        
                   IF (PCharges."Use Percentage" =TRUE) AND (PCharges."Charging Option"=PCharges."Charging Option"::"On Approved Amount") THEN BEGIN
                    IF ChargeExtraComms=TRUE THEN
                      TotalComputedCharges:=TotalComputedCharges+(ApprovedAmt * ((PCharges.Percentage+PCharges."Additional Charge %")/100))
                    ELSE
                      TotalComputedCharges:=TotalComputedCharges+( ApprovedAmt* (PCharges.Percentage/100))
                   END ELSE IF (PCharges."Use Percentage" =TRUE) AND (PCharges."Charging Option"=PCharges."Charging Option"::"On Net Amount") THEN BEGIN
                     IF ChargeExtraComms=TRUE THEN
                       TotalComputedCharges:=TotalComputedCharges+((TopUp."Principle Top Up"+TopUp."Interest Top Up") * ((PCharges.Percentage+PCharges."Additional Charge %")/100))
                     ELSE
                       TotalComputedCharges:=TotalComputedCharges+((TopUp."Principle Top Up"+TopUp."Interest Top Up") * (PCharges.Percentage/100))
                   END ELSE
                    TotalComputedCharges:=TotalComputedCharges+PCharges.Amount;
                 // MESSAGE('Running Charge topup %1',TotalComputedCharges);
           UNTIL PCharges.NEXT = 0;
           END;
        UNTIL TopUp.NEXT=0;
        END;
        
        
        
        OtherComms:=0;
        //Clearing external debts
        OtherCommitments.RESET;
        OtherCommitments.SETRANGE(OtherCommitments."Loan No.",LoanNo);
        IF OtherCommitments.FIND('-') THEN BEGIN
        REPEAT
          TotalCleared:=TotalCleared+OtherCommitments.Amount;
        //OtherCommitments.CALCSUMS(OtherCommitments.Amount);
        OtherComms:=OtherCommitments.Amount;
        
        
        PCharges.RESET;
        PCharges.SETRANGE(PCharges."Product Code",ProdType);
        PCharges.SETRANGE(PCharges."Charge Type",PCharges."Charge Type"::"External Loan");
        IF PCharges.FIND('-') THEN BEGIN
           REPEAT
           IF (PCharges."Use Percentage"=TRUE) THEN BEGIN
             IF ChargeExtraComms=TRUE THEN
              TotalComputedCharges :=TotalComputedCharges+(OtherCommitments.Amount * ((PCharges.Percentage+PCharges."Additional Charge %")/100))
             ELSE
               TotalComputedCharges :=TotalComputedCharges+(OtherCommitments.Amount * (PCharges.Percentage/100))
           END ELSE
               TotalComputedCharges:=TotalComputedCharges+OtherCommitments.Amount;
           //MESSAGE('Running Charge  other comms%1',TotalComputedCharges);
           UNTIL PCharges.NEXT = 0;
        
           END;
        UNTIL OtherCommitments.NEXT=0;
        END;
        
        LoanApps.RESET;
        LoanApps.SETRANGE("Loan  No.",LoanNo);
        IF LoanApps.FIND('-') THEN BEGIN
          LoanApps."Total Charges and Commissions":=TotalComputedCharges;
        
          IF (LoanApps."Appraisal Parameter Type"=LoanApps."Appraisal Parameter Type"::"Check Off") OR (LoanApps."Appraisal Parameter Type"=LoanApps."Appraisal Parameter Type"::"Corporate or Business") THEN
             TotalComputedCharges:=TotalComputedCharges+LoanApps."Boosted Amount";
        //LoanApps.MODIFY;
        END;
        
        PaySched.RESET;
        PaySched.SETRANGE(PaySched."Loan No.",LoanNo);
        IF PaySched.FIND('-') THEN BEGIN
          PaySched.CALCSUMS(PaySched."Loan Amount");
          TotalSched:=PaySched."Loan Amount";
        END;
        
        Difference:=ApprovedAmt-(TotalSched+TotalComputedCharges*0.1+TotalComputedCharges+TotalCleared+CurrValue);
        
        
        //MESSAGE('Apr %1 TotSched %2 TotCompCha %3 OtherComms %4 TotCleared %5',ApprovedAmt,TotalSched,TotalComputedCharges,OtherComms,TotalCleared);
        EXIT(TRUE);
        ELSE Difference:=0;*/

    end;
}

