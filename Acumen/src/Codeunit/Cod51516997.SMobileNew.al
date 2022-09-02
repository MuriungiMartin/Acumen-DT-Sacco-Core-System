#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516997 "S-Mobile-New"
{

    trigger OnRun()
    begin
        //AccountBalance('00364');
        //MiniStatement ('8721-001-101-000001');
        OutstandingLoans('00364');
    end;

    var
        Vendor: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        miniBalance: Decimal;
        accBalance: Decimal;
        minimunCount: Integer;
        VendorLedgEntry: Record "Vendor Ledger Entry";
        amount: Decimal;
        Loans: Integer;
        LoansRegister: Record "Loans Register";
        LoanProductsSetup: Record "Loan Products Setup";


    procedure AccountBalance(Acc: Code[30]) Bal: Text[500]
    begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."BOSA Account No", Acc);
          if Vendor.Find('-') then
           begin
              minimunCount:=1;
              Bal:='';
              repeat
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
                if AccountTypes.Find('-') then
                begin
                  miniBalance:=AccountTypes."Minimum Balance";
                end;
                Vendor.CalcFields(Vendor."Balance (LCY)");
                Vendor.CalcFields(Vendor."ATM Transactions");
                Vendor.CalcFields(Vendor."Uncleared Cheques");
                Vendor.CalcFields(Vendor."EFT Transactions");

                accBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions");
                minimunCount:= minimunCount +1;
                Bal :=Bal+'~~~~'+Vendor."Account Type"+',,,'+Vendor.Name+',,,'+Format(Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"));
              until Vendor.Next =0;
            Message(Bal);
          end
    end;


    procedure MiniStatement(Acc: Text[20]) MiniStmt: Text[250]
    begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."No.", Acc);
          if Vendor.Find('-') then begin
             minimunCount:=1;
             //Docno :=Reference;
             Vendor.CalcFields(Vendor.Balance);

             VendorLedgEntry.SetCurrentkey(VendorLedgEntry."Entry No.");
             VendorLedgEntry.Ascending(false);
             VendorLedgEntry.SetRange(VendorLedgEntry."Vendor No.",Vendor."No.");
             VendorLedgEntry.SetRange(VendorLedgEntry.Reversed,VendorLedgEntry.Reversed::"0");
            if VendorLedgEntry.FindSet then begin
                MiniStmt:='';
                repeat
                  VendorLedgEntry.CalcFields(VendorLedgEntry.Amount);
                  amount:=VendorLedgEntry.Amount;
                  if amount<1 then
                     amount:= amount*-1;
                     //StrTel:=COPYSTR("MPESA Mobile No",1,4);
                     MiniStmt :=MiniStmt + Format(VendorLedgEntry."Posting Date") +'~'+ CopyStr(VendorLedgEntry.Description,1,25) +'~' +
                     Format(amount)+'---';
                     minimunCount:= minimunCount +1;
                     if minimunCount>5 then
                     exit
                 until VendorLedgEntry.Next =0;
                  Message(MiniStmt);
                end;
          end;
    end;


    procedure OutstandingLoans(BOSAAcc: Text[20]) LoanBalances: Text[150]
    begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."BOSA Account No",BOSAAcc);
          if Vendor.Find('-') then begin
            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
          if AccountTypes.Find('-') then
          begin
            miniBalance:=AccountTypes."Minimum Balance";
          end;

          Vendor.CalcFields(Vendor.Balance);
          LoansRegister.SetRange(LoansRegister."Client Code",Vendor."BOSA Account No");
          if LoansRegister.Find('-') then begin
            repeat

            LoansRegister.CalcFields(LoansRegister."Outstanding Balance",LoansRegister."Interest Due",LoansRegister."Interest to be paid",LoansRegister."Interest Paid");
            if (LoansRegister."Outstanding Balance">1)or(LoansRegister."Interest Due">1) then
            LoanBalances:= LoanBalances+'---'+LoansRegister."Loan Product Type"+'~~~'+LoansRegister."Loan  No."+'~~~'
            +Format(LoansRegister."Outstanding Balance"+LoansRegister."Interest to be paid");
            until LoansRegister.Next = 0;
            Message(LoanBalances);
          end;
          end;
    end;


    procedure LoanProducts() LoanTypes: Text[150]
    begin
        LoanProductsSetup.Reset;
        LoanProductsSetup.SetRange(LoanProductsSetup.Source, LoanProductsSetup.Source::BOSA);
          if LoanProductsSetup.Find('-') then begin
            repeat
              LoanTypes:=LoanTypes +':::'+LoanProductsSetup."Product Description";
            until LoanProductsSetup.Next =0;
          end
    end;
}

