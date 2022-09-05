#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516371 "Loans Register"
{
    DrillDownPageID = "Loans  List All";
    LookupPageID = "Loans  List All";

    fields
    {
        field(1; "Loan  No."; Code[30])
        {

            trigger OnValidate()
            begin
                //SURESTEP
                if Source = Source::BOSA then begin

                    if "Loan  No." <> xRec."Loan  No." then begin
                        SalesSetup.Get;
                        NoSeriesMgt.TestManual(SalesSetup."BOSA Loans Nos");
                        "No. Series" := '';
                    end;

                end else
                    if Source = Source::FOSA then begin
                        if "Loan  No." <> xRec."Loan  No." then begin
                            SalesSetup.Get;
                            NoSeriesMgt.TestManual(SalesSetup."FOSA Loans Nos");
                            "No. Series" := '';
                        end;


                    end else
                        if Source = Source::MICRO then begin

                            if "Loan  No." <> xRec."Loan  No." then begin
                                SalesSetup.Get;
                                NoSeriesMgt.TestManual(SalesSetup."Micro Loans");
                                "No. Series" := '';
                            end;


                        end;
                //SURESTEP
            end;
        }
        field(2; "Application Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Application Date" > Today then
                    Error('Application date can not be in the future.');
            end;
        }
        field(3; "Loan Product Type"; Code[25])
        {
            Editable = true;
            TableRelation = "Loan Products Setup".Code;

            trigger OnValidate()
            begin
                if LoanType.Get("Loan Product Type") then begin

                    "Type Of Loan Duration" := LoanType."Type Of Loan";

                    if (LoanType."Loan Product Expiry Date" = 0D) or (LoanType."Loan Product Expiry Date" > Today) then begin
                        sHARES := 0;
                        MonthlyRepayT := 0;
                        //----------------------------------------Validate FOSALOAN----------------------------
                        if ("Loan Product Type" = 'FOSALOAN') then begin
                            // MESSAGE('%1 %2',"Client Code","BOSA No");
                            MonthlyRepayT := 0;
                            LoanApp.Reset;
                            LoanApp.SetRange(LoanApp."BOSA No", "BOSA No");
                            LoanApp.SetRange(LoanApp.Posted, true);
                            if LoanApp.Find('-') then begin
                                repeat
                                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                                    if (LoanApp."Outstanding Balance" > 0) then begin
                                        if LoanApp."Outstanding Balance" < LoanApp."Loan Principle Repayment" then begin
                                            MonthlyRepayT := MonthlyRepayT + (LoanApp."Loan Principle Repayment");//+LoanApp."Loan Interest Repayment");
                                        end else begin
                                            MonthlyRepayT := MonthlyRepayT + (LoanApp."Loan Principle Repayment");//+LoanApp."Loan Interest Repayment");
                                        end
                                    end;
                                // MESSAGE('Monthly Repayment %1 Loan No %2 Total %3',LoanApp."Loan Principle Repayment",MonthlyRepayT,LoanApp."Loan  No.");
                                until LoanApp.Next = 0;
                            end;
                            "Existing Loan Repayments" := MonthlyRepayT;
                            // MODIFY;
                        end;
                        //-------------------------------------------END---------------------------------------






                        if (Source = Source::BOSA) then begin
                            //NEW SACCO
                            //Evaluate if the member does not have shares
                            Cust.Reset;
                            Cust.SetRange(Cust."No.", "Client Code");
                            if Cust.Find('-') then begin
                                Cust.CalcFields(Cust."Current Shares");
                                sHARES := Cust."Current Shares" * -1;
                                if sHARES = 0 then
                                    Error('This member does not have shares, therefore cannot qualify for any Loan');
                            end;
                        end;

                        //**********************************Find Similar Products**************************//
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                        LoanApp.SetRange(LoanApp."Loan Product Type", "Loan Product Type");
                        LoanApp.SetRange(LoanApp.Posted, true);
                        if LoanApp.Find('-') then begin
                            repeat
                                LoanApp.CalcFields(LoanApp."Outstanding Balance");
                                if LoanApp."Outstanding Balance" > 0 then begin
                                    loannums := loannums + 1;
                                end;
                            until LoanApp.Next = 0;
                        end;

                        //MESSAGE(FORMAT(loannums));
                        //**********************************Find Similar Products**************************//


                        //**********************************Compute Loan Repayments**************************//
                        MonthlyRepayT := 0;
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                        LoanApp.SetRange(LoanApp.Posted, true);
                        if LoanApp.Find('-') then begin
                            repeat
                                LoanApp.CalcFields(LoanApp."Outstanding Balance");
                                if (LoanApp."Outstanding Balance" > 0) then begin
                                    if LoanApp."Outstanding Balance" < LoanApp."Loan Principle Repayment" then begin
                                        MonthlyRepayT := MonthlyRepayT + (LoanApp."Loan Principle Repayment");//+LoanApp."Loan Interest Repayment");
                                    end else begin
                                        MonthlyRepayT := MonthlyRepayT + (LoanApp."Loan Principle Repayment");//+LoanApp."Loan Interest Repayment");
                                    end
                                end;
                            //MESSAGE('Monthly Repayment %1 Loan No %2 Total %3',LoanApp."Loan Principle Repayment",MonthlyRepayT,LoanApp."Loan  No.");
                            until LoanApp.Next = 0;
                        end;
                        if "Loan Product Type" <> 'FOSALOAN' then
                            "Existing Loan Repayments" := MonthlyRepayT;
                        //**********************************Compute Loan Repayments**************************//


                        //**********************************Populate Parameters*****************************//
                        if LoanType.Get("Loan Product Type") then begin
                            "Loan Product Type Name" := LoanType."Product Description";
                            //MESSAGE('Test Interest %1',LoanType."Interest rate");
                            Interest := LoanType."Interest rate";
                            "Instalment Period" := LoanType."Instalment Period"; //Cyrus
                            "Grace Period" := LoanType."Grace Period";
                            "Grace Period - Principle (M)" := LoanType."Grace Period - Principle (M)";
                            "Grace Period - Interest (M)" := LoanType."Grace Period - Interest (M)";
                            "Loan to Share Ratio" := LoanType."Loan to Share Ratio";
                            "Interest Calculation Method" := LoanType."Interest Calculation Method";
                            "Repayment Method" := LoanType."Repayment Method";
                            "Product Currency Code" := LoanType."Product Currency Code";
                            Installments := LoanType."Default Installements";
                            "Max. Installments" := LoanType."No of Installment";
                            "Max. Loan Amount" := LoanType."Max. Loan Amount";
                            "Repayment Frequency" := LoanType."Repayment Frequency";
                            "Amortization Interest Rate" := LoanType."Amortization Interest Rate(SI)";
                            "Loan Deposit Multiplier" := LoanType."Deposits Multiplier";
                            "Recovery Mode" := LoanType."Recovery Method";

                            //Where repayment is by employer

                            if LoanType."Use Cycles" = false then begin
                                "Loan Cycle" := 0;
                                "Max. Installments" := LoanType."No of Installment";
                                "Max. Loan Amount" := LoanType."Max. Loan Amount";
                                Installments := LoanType."Default Installements";
                                "Product Code" := LoanType."Source of Financing";
                                "Paying Bank Account No" := LoanType."BacK Code";

                            end;

                            if LoanType."Use Cycles" = true then begin
                                LoanApp.Reset;
                                LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                                LoanApp.SetRange(LoanApp."Loan Product Type", "Loan Product Type");
                                LoanApp.SetRange(LoanApp.Posted, true);
                                if LoanApp.Find('-') then
                                    MemberCycle := LoanApp.Count + 1
                                else
                                    MemberCycle := 1;



                                ProdCycles.Reset;
                                ProdCycles.SetRange(ProdCycles."Product Code", "Loan Product Type");
                                if ProdCycles.Find('-') then begin
                                    repeat
                                        if MemberCycle = ProdCycles.Cycle then begin
                                            "Loan Cycle" := ProdCycles.Cycle;
                                            "Max. Installments" := ProdCycles."Max. Installments";
                                            "Max. Loan Amount" := ProdCycles."Max. Amount";
                                            Installments := ProdCycles."Max. Installments";
                                        end;
                                    until ProdCycles.Next = 0;
                                    if "Loan Cycle" = 0 then begin
                                        "Loan Cycle" := ProdCycles.Cycle;
                                        "Max. Installments" := ProdCycles."Max. Installments";
                                        "Max. Loan Amount" := ProdCycles."Max. Amount";
                                        Installments := ProdCycles."Max. Installments";
                                    end;
                                end;


                            end;
                        end;
                        if LoanType.Get("Loan Product Type") then begin
                            if "Approved Amount" <> 0 then
                                Validate("Approved Amount");
                        end else
                            Error('Loan product has been suspended');
                    end;
                    //END;
                end else
                    exit;

                if LoanType.Get("Loan Product Type") then begin
                    if "Shares Balance" < LoanType."Minimum Deposit For Loan Appl" then begin
                        // ERROR('The member needs to have a minimum of %1 deposit contribution for application of a %2 Product',LoanType."Minimum Deposit For Loan Appl",LoanType."Product Description");
                    end;
                end;

                //**************************Dividend Advance **************************************//
                if LoanType.Get("Loan Product Type") then begin
                    if "Loan Product Type" = 'DIVIDENDADV' then begin
                        FirstDateOfYear := CalcDate('-CY', Today);
                        LastDateIssue := CalcDate('2M-1D', FirstDateOfYear);
                        if (Today < FirstDateOfYear) or (Today > LastDateIssue) then
                            Error(Text00002, "Loan Product Type", Format(FirstDateOfYear), Format(LastDateIssue));
                    end;
                end;
                //**************************Dividend Advance **************************************//
            end;
        }
        field(4; "Client Code"; Code[50])
        {
            TableRelation = if (Source = const(BOSA)) Customer."No."
            else
            if (Source = const(FOSA)) Customer."No."
            else
            if (Source = const(MICRO)) Customer."No." where("Group Account" = field("Group Account"))
            else
            if (Source = filter(" ")) Customer."No.";

            trigger OnValidate()
            begin

                if Source = Source::BOSA then begin
                    if "Loan  No." = '' then begin
                        SalesSetup.Get;
                        SalesSetup.TestField(SalesSetup."BOSA Loans Nos");
                        NoSeriesMgt.InitSeries(SalesSetup."BOSA Loans Nos", xRec."No. Series", 0D, "Loan  No.", "No. Series");
                    end;

                end else
                    if Source = Source::FOSA then begin
                        if "Loan  No." = '' then begin
                            SalesSetup.Get;
                            SalesSetup.TestField(SalesSetup."FOSA Loans Nos");
                            NoSeriesMgt.InitSeries(SalesSetup."FOSA Loans Nos", xRec."No. Series", 0D, "Loan  No.", "No. Series");
                        end;


                    end else
                        if Source = Source::MICRO then begin

                            if "Loan  No." = '' then begin
                                SalesSetup.Get;
                                SalesSetup.TestField(SalesSetup."Micro Loans");
                                NoSeriesMgt.InitSeries(SalesSetup."Micro Loans", xRec."No. Series", 0D, "Loan  No.", "No. Series");
                            end;


                        end;
                /*
                //credit policy assessment-check if member is a defaulter
                LoanApp.RESET;
                LoanApp.SETRANGE(LoanApp."Client Code","Client Code");
                LoanApp.SETRANGE(LoanApp.Posted,TRUE);
                IF LoanApp.FIND('-') THEN BEGIN
                REPEAT
                LoanApp.CALCFIELDS(LoanApp."Outstanding Balance");
                //IF LoanApp."Outstanding Balance">0 THEN BEGIN
                //IF (LoanApp."Loans Category"=LoanApp."Loans Category"::Substandard) OR
                //(LoanApp."Loans Category"=LoanApp."Loans Category"::Doubtful) OR (LoanApp."Loans Category"=LoanApp."Loans Category"::Loss)
                //THEN BEGIN
                //MESSAGE:='The member is a defaulter' +'. '+ 'Loan No' + ' '+LoanApp."Loan  No."+' ' + 'is in loan category' +' '+
                //FORMAT(LoanApp."Loans Category");
                //END;
                END;
                UNTIL LoanApp.NEXT=0;
                END;
                */

                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                LoanApp.SetRange(LoanApp.Posted, true);
                if LoanApp.Find('-') then begin
                    repeat
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            TotalLoanOutstanding := TotalLoanOutstanding + LoanApp."Outstanding Balance";
                            "Total Outstanding Loan BAL" := TotalLoanOutstanding;
                        end;
                    until LoanApp.Next = 0;
                end;



                GenSetUp.Get(0);

                "BOSA No" := "Client Code";

                LoansClearedSpecial.Reset;
                LoansClearedSpecial.SetRange(LoansClearedSpecial."Loan No.", "Loan  No.");
                if LoansClearedSpecial.Find('-') then
                    LoansClearedSpecial.DeleteAll;

                if "Client Code" = '' then
                    "Client Name" := '';


                if CustomerRecord.Get("Client Code") then begin
                    "Monthly Shares Cont" := CustomerRecord."Monthly Contribution";
                    "Insurance On Shares" := CustomerRecord."Insurance on Shares";
                    "Global Dimension 2 Code" := CustomerRecord."Global Dimension 2 Code";
                    //MODIFY;
                end;


                if CustomerRecord.Get("BOSA No") then begin
                    /*IF CustomerRecord.Pin='' THEN
                      ERROR(Text00003,"BOSA No");*/

                    if CustomerRecord.Blocked = CustomerRecord.Blocked::All then
                        Error('Member is blocked from transacting ' + "Client Code");

                    //---Check if 1st time Loanee
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                    if LoanApp.Find('-') = false then begin
                        "1st Time Loanee" := true;
                    end;
                    //---End Of Check if 1st time Lonee


                    //IF Source = Source::BOSA THEN BEGIN
                    //CustomerRecord.TESTFIELD(CustomerRecord."ID No.");

                    //IF CustomerRecord."Registration Date" <> 0D THEN BEGIN
                    //IF CALCDATE(GenSetUp."Min. Loan Application Period",CustomerRecord."Registration Date") > TODAY THEN
                    //ERROR('Member is less than six months old therefor not eligible for loan application.');
                    //END;


                    CustomerRecord.CalcFields(CustomerRecord."Current Shares", CustomerRecord."Outstanding Balance",
                    CustomerRecord."Current Loan", CustomerRecord."Shares Retained", CustomerRecord."Group Shares", CustomerRecord."Existing Loan Repayments");
                    GenSetUp.Get();
                    "Client Name" := CustomerRecord.Name;
                    "Employer Code" := CustomerRecord."Employer Code";
                    "Shares Balance" := CustomerRecord."Current Shares";
                    Savings := CustomerRecord."Current Shares";
                    "Existing Loan" := CustomerRecord."Outstanding Balance";
                    "Account No" := CustomerRecord."FOSA Account";
                    "Staff No" := CustomerRecord."Personal No";
                    "Registration Date" := CustomerRecord."Registration Date";
                    "Member Share Capital" := CustomerRecord."Shares Retained";
                    //"Membership Duration(Years)":=FORMAT(Dates.DetermineAge("Registration Date",TODAY),2);
                    //"Membership Duration(Years)":=ROUND((TODAY-"Registration Date")/30,1,'<');
                    Gender := CustomerRecord.Gender;
                    "ID NO" := CustomerRecord."ID No.";
                    "Member Deposits" := CustomerRecord."Current Shares";
                    "Group Shares" := CustomerRecord."Shares Retained";
                    "Pension No" := "Pension No";
                    "Monthly Contribution" := CustomerRecord."Monthly Contribution";
                    "Insurance On Shares" := CustomerRecord."Insurance on Shares";
                    "KRA Pin No." := CustomerRecord.Pin;
                    "Global Dimension 2 Code" := CustomerRecord."Global Dimension 2 Code";
                    "Account No" := CustomerRecord."FOSA Account";
                    "Existing Loan Repayments" := CustomerRecord."Existing Loan Repayments";
                    "Member House Group" := CustomerRecord."Member House Group";
                    Staff := CustomerRecord.Staff;
                    Disabled := CustomerRecord.Disabled;
                    "Risk MGT" := GenSetUp."Risk Fund Amount";
                    "Member Account Category" := CustomerRecord."Account Category";
                    if CustomerRecord."Shares Retained" < GenSetUp."Retained Shares" then begin
                        "Share Capital Due" := GenSetUp."Retained Shares" - CustomerRecord."Shares Retained"
                    end else
                        "Share Capital Due" := 0;

                    //TESTFIELD("Account No");

                    GenSetUp.Get();
                    if ((CustomerRecord."Shares Retained" < GenSetUp."Retained Shares") and ("Loan Product Type" <> 'BLOAN')) then
                        //ERROR('Shares Must be More or equal to %1',GenSetUp."Retained Shares");

                        "Branch Code" := CustomerRecord."Global Dimension 2 Code";
                    if ("Loan Product Type" <> 'DFTL FOSA') and ("Loan Product Type" <> 'DFTL') then begin
                        //Check Shares Boosting
                        if "Application Date" <> 0D then begin
                        end;
                    end;

                end;

                //END;




                CalcFields("Total Loans Outstanding");
                TotalOutstanding := "Total Loans Outstanding" + "Requested Amount";
                if BANDING.Find('-') then begin
                    repeat
                        if (TotalOutstanding >= BANDING."Minimum Amount") and (TotalOutstanding <= BANDING."Maximum Amount") then begin
                            Band := BANDING."Minimum Dep Contributions";
                            "Min Deposit As Per Tier" := Band;
                            Modify;
                        end;
                    until BANDING.Next = 0;
                end;

                //Block if loan Previously recovered from gurantors
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."BOSA No", "BOSA No");
                LoanApp.SetRange("Recovered From Guarantor", true);
                if LoanApp.Find('-') then
                    Error('Member has a loan which has previously been recovered from gurantors. - %1', LoanApp."Loan  No.");

                //Block if loan Previously recovered from gurantors
                //SURESTEP MICRO CREDIT
                if Source = Source::MICRO then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", "Client Code");
                    //Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::MicroFinance);
                    if Cust.Find('-') = false then
                        Error('Sorry selected Member is not a microfinance member');
                end else
                    "Group Code" := Cust."Group Code";
                //SURESTEP MICRO CREDIT


                if Source = Source::BOSA then begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                    LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
                    if LoanApp.Find('-') then begin
                        repeat
                            LoanApp.CalcFields(LoanApp."Outstanding Balance");
                            if LoanApp."Outstanding Balance" > 0 then begin
                                if LoanType.Get(LoanApp."Loan Product Type") then begin
                                    SaccoDedInt := LoanApp."Outstanding Balance" * (LoanType."Interest rate" / 1200);
                                    Saccodeduct := Saccodeduct + LoanApp."Loan Principle Repayment" + SaccoDedInt;
                                end;
                            end;
                        until LoanApp.Next = 0;
                    end;
                    "Sacco Deductions" := Saccodeduct;
                end;
                //VALIDATE("Member House Group");


                //Insert Member Deposit History
                //FnGetMemberDepositHistory();

                if CustomerRecord.Get("Client Code")
                then begin
                    "Client Name" := CustomerRecord.Name;
                    "BOSA No" := "Client Code";
                    "ID NO" := CustomerRecord."ID No.";
                    "Employer Code" := CustomerRecord."Employer Code";
                end;

                //Clear Offset Records when a client Code is Changed.
                ObjLoanOffsets.Reset;
                ObjLoanOffsets.SetRange("Loan No.", "Loan  No.");
                if ObjLoanOffsets.Find('-') then
                    ObjLoanOffsets.DeleteAll;

            end;
        }
        field(5; "Group Code"; Code[20])
        {
        }
        field(6; Savings; Decimal)
        {
            Editable = false;
        }
        field(7; "Existing Loan"; Decimal)
        {
            Editable = false;
        }
        field(8; "Requested Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                //******************************Loan Advance Check***********************************//
                if "Loan Product Type" = 'LOANADV' then begin
                    TestField("Advance Loan No");
                    if Loan.Get("Advance Loan No") then begin
                        if "Requested Amount" > Loan."Approved Amount" then
                            Error(Text00005);
                    end;
                end;
                //******************************Loan Advance Check***********************************//




                if LoanType.Get("Loan Product Type") then begin
                    if "Requested Amount" > LoanType."Max. Loan Amount" then begin
                        Error('You Can not request more than the Loan Allowable limit of %1', LoanType."Max. Loan Amount");
                    end;
                end;
                "Approved Amount" := 0;
                "Net Payment to FOSA" := "Requested Amount";

                Validate("Approved Amount");

                CalcFields("Total Loans Outstanding");
                TotalOutstanding := "Total Loans Outstanding" + "Requested Amount";
                if BANDING.Find('-') then begin
                    repeat
                        if ((TotalOutstanding >= BANDING."Minimum Amount") and (TotalOutstanding <= BANDING."Maximum Amount")) then begin
                            Band := BANDING."Minimum Dep Contributions";
                            "Min Deposit As Per Tier" := Band;
                            Modify;
                        end;
                    until BANDING.Next = 0;
                end;

                //Repayments for amortised method

                if "Repayment Method" = "repayment method"::Amortised then begin
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -Installments)) * "Requested Amount", 1, '>');
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');

                    if "Repayment Method" = "repayment method"::"Reducing Balance" then
                        LInterest := ROUND(("Approved Amount" * InterestRate / 1200), 0.05, '>');



                    LPrincipal := TotalMRepay - LInterest;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;


                    if "Repayment Method" = "repayment method"::"Straight Line" then begin
                        //TESTFIELD(Installments);
                        LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                        LInterest := ROUND((InterestRate / 1200) * LoanAmount, 1, '>');

                        ObjProductCharge.Reset;
                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                        if ObjProductCharge.FindSet then begin
                            LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                        end;

                        Repayment := TotalMRepay + LInsurance;
                    end;

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                        LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                    end;

                    Repayment := TotalMRepay + LInsurance;
                end;


                //End Repayments for amortised method
                GenSetUp.Get();
                "Boosting Commision" := 0;
                "Boosted Amount" := 0;
                if (("Member Deposits" < "Requested Amount") and ("Boost this Loan" = true)) then begin
                    if LoanType.Get("Loan Product Type") then begin
                        "Boosted Amount" := ROUND(("Requested Amount" - "Member Deposits" * LoanType."Shares Multiplier") / 3, 0.05, '>');//
                        "Boosting Commision" := "Boosted Amount" * GenSetUp."Boosting Shares %" / 100;
                        "Boosted Amount Interest" := "Boosted Amount" * Interest / 1200;

                    end
                end;



                LPrincipal := TotalMRepay - LInterest;
                "Loan Principle Repayment" := LPrincipal;
                "Loan Interest Repayment" := LInterest;
                RepayPeriod := 1;

                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                    //TESTFIELD(Installments);
                    LPrincipal := ROUND("Requested Amount" / RepayPeriod, 1, '>');
                    LInterest := ROUND(((InterestRate / 1200) * "Requested Amount") * Installments, 1, '>');

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                        LInsurance := ("Requested Amount" * (ObjProductCharge.Percentage / 100)) * Installments;
                    end;

                    Repayment := LPrincipal + LInterest + LInsurance;
                end;
            end;
        }
        field(9; "Approved Amount"; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin
                if "Max. Loan Amount" <> 0 then begin
                    if "Approved Amount" > "Max. Loan Amount" then
                        Error('Approved amount cannot be greater than the Maximum Amount. %1', "Loan  No.");
                end;

                if "Loan Status" <> "loan status"::Application then begin
                    //Approved must not be more than requested amount
                    if "Approved Amount" > "Requested Amount" then
                        Error('Approved amount must not be more than the requested amount. %1', "Loan  No.");

                end;
                LAppCharges.Reset;
                LAppCharges.SetRange(LAppCharges."Loan No", "Loan  No.");
                if LAppCharges.Find('-') then
                    LAppCharges.DeleteAll;



                "Flat rate Interest" := 0;
                "Flat Rate Principal" := 0;
                //Repayment :=0;
                "Total Repayment" := 0;

                if Installments <= 0 then
                    //ERROR('Number of installments must be greater than Zero.');



                    //
                    TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                InterestRate := Interest;
                LoanAmount := "Approved Amount";
                RepayPeriod := Installments;
                LBalance := "Approved Amount";



                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                    //TESTFIELD(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    LInterest := ROUND(((InterestRate / 100) * LoanAmount) / RepayPeriod, 1, '>');
                    //MESSAGE()
                    Repayment := LPrincipal + LInterest;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;
                    //Insuarence:=0.15*LoanAmount;s
                end;

                //Monthly Interest Formula PR(T+1)/200T  for Nafaka
                if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                    TestField(Interest);
                    //TESTFIELD(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>'); //ROUND(LoanAmount/RepayPeriod,0.05,'>');
                    LInterest := ROUND(LoanAmount * Interest / 12 * (RepayPeriod + 1) / (200 * RepayPeriod), 1, '>');//ROUND((InterestRate/12/100)*LBalance,0.05,'>');
                                                                                                                     //MESSAGE('Monthly Interest Repayment=%1, Monthly Principal Repayment=%2, ****Total Monthly Repayment=%3***',LInterest,LPrincipal,LPrincipal+LInterest);
                    if LoanType.Get("Loan Product Type") then begin
                        if LoanType.Code <> 'EMERGENCY 6' then
                            Repayment := LPrincipal + LInterest;
                        if "Loan Product Type" = 'EMERGENCY 6' then
                            Repayment := LPrincipal;
                        //MESSAGE('evsdff1v 1 %1',Repayment);
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;

                        //MODIFY;
                    end;
                end;
                //SURESTEP


                if "Repayment Method" = "repayment method"::Amortised then begin
                    //TESTFIELD(Interest);
                    //TESTFIELD(Installments);

                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                    LPrincipal := TotalMRepay - LInterest;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;
                    "Approved Repayment" := TotalMRepay;
                    Repayment := TotalMRepay;

                end;


                if LoanType."Charge Interest Upfront" = true then begin
                    "Interest Upfront Amount" := ROUND(("Approved Amount" * Interest) / 1200, 0.05, '=');
                end;

            end;
        }
        field(16; Interest; Decimal)
        {

            trigger OnValidate()
            begin
                Validate(Installments);
            end;
        }
        field(17; Insurance; Decimal)
        {
            Editable = false;
        }
        field(21; "Source of Funds"; Code[25])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                GLSetup.Get;
                Dimension := GLSetup."Shortcut Dimension 3 Code";
            end;
        }
        field(22; "Client Cycle"; Integer)
        {
            Editable = false;
        }
        field(26; "Client Name"; Text[100])
        {
            Editable = false;
        }
        field(27; "Loan Status"; Option)
        {
            OptionCaption = 'Application,Appraisal,Rejected,Approved,Issued,Being Repaid,Repaid,Committee,Approval1,Recommended,Loans Manager,Finance Manger|CEO';
            OptionMembers = Application,Appraisal,Rejected,Approved,Issued,"Being Repaid",Repaid,Committee,Approval1,Recommended,"Loans Manager","Finance Manger|CEO";

            trigger OnValidate()
            begin
                /*"Date Approved":=TODAY;
                
                IF "Loan Status" <> "Loan Status"::Approved THEN
                EXIT;
                
                RepaySched.RESET;
                RepaySched.SETRANGE(RepaySched."Loan No.","Loan  No.");
                IF NOT RepaySched.FIND('-') THEN
                ERROR('Loan Schedule must be generated and confirmed before loan is approved');
                
                IF "Account No" = '' THEN BEGIN
                IF CONFIRM('This Applicant does not have FOSA account. Do you wish to proceed?',FALSE)=FALSE THEN
                ERROR('You must specify the FOSA Account No. for this members.');
                END;
                
                
                
                
                //Check STO for Family & Ex Company
                IF "External EFT" = FALSE THEN BEGIN
                IF LoanType.GET("Loan Product Type") THEN BEGIN
                IF LoanType."Check Off Recovery" = TRUE THEN BEGIN
                IF CustomerRecord.GET("BOSA No") THEN BEGIN
                IF Employer.GET(CustomerRecord."Employer Code") THEN BEGIN
                IF Employer."Check Off" = FALSE THEN BEGIN
                RAllocation.RESET;
                RAllocation.SETRANGE(RAllocation."Loan No.","Loan  No.");
                IF RAllocation.FIND('-') THEN BEGIN
                IF "Standing Orders".GET(RAllocation."Document No") THEN BEGIN
                IF "Standing Orders".Status <> "Standing Orders".Status::Pending THEN
                ERROR('Standing order No. %1 for this loan must be activated',RAllocation."Document No");
                END;
                END ELSE
                ERROR('You must place a active standing order for this loan for non-check of members.');
                END;
                END;
                END;
                END;
                END;
                END;
                  */

            end;
        }
        field(29; "Issued Date"; Date)
        {
        }
        field(30; Installments; Integer)
        {

            trigger OnValidate()
            begin
                if Posted <> true then begin
                    if Installments > "Max. Installments" then
                        Error('Installments cannot be greater than the maximum installments.');
                end;

                GenSetUp.Get(0);

                if Cust.Get("Client Code") then begin
                    if (Cust."Date of Birth" <> 0D) and ("Application Date" <> 0D) and (Installments > 0) then begin
                        if CalcDate(Format(Installments) + 'M', "Application Date") < CalcDate(GenSetUp."Retirement Age", Cust."Date of Birth") then
                            if Confirm('Member due to retire before loan repayment is complete. Do you wish to continue?') = false then
                                Installments := 0;

                    end;
                end;

                //***********************************Graduated Interest********************************//
                if LoanType.Get("Loan Product Type") then begin
                    ObjGradInt.Reset;
                    ObjGradInt.SetRange(ObjGradInt."Loan Code", "Loan Product Type");
                    if ObjGradInt.FindSet then begin
                        repeat
                            if (ObjGradInt."Period From" <= Installments) and (ObjGradInt."Period To" >= Installments) then
                                Interest := ObjGradInt."Interest Rate";

                        until ObjGradInt.Next = 0;
                    end;
                end;
                //***********************************Graduated Interest********************************//
                //***********************************Check Loan Minimum Period********************************//
                if LoanType.Get("Loan Product Type") then begin
                    if LoanType."Min Installments Period" <> 0 then begin
                        if Installments < LoanType."Min Installments Period" then
                            Error(Text00001, LoanType."Min Installments Period");
                    end;
                end;
                //***********************************Check Loan Minimum Period********************************//


                Validate("Approved Amount");
            end;
        }
        field(34; "Loan Disbursement Date"; Date)
        {

            trigger OnValidate()
            begin
                // "Issued Date":="Loan Disbursement Date";
                //
                // GenSetUp.GET;
                // StartDate:=CALCDATE('CM',"Loan Disbursement Date");
                // "Repayment Start Date":=StartDate;
                // "Expected Date of Completion":=CALCDATE(FORMAT(Installments)+'M',"Repayment Start Date");

                ///................................................................................

                "Issued Date" := "Loan Disbursement Date";
                GenSetUp.Get;
                StartDate := CalcDate('+1M', "Issued Date");
                "Repayment Start Date" := StartDate;
                //MODIFY;
                "Expected Date of Completion" := CalcDate(Format(Installments) + 'M', "Loan Disbursement Date");

                ////////////////////////////////.....................................
                /*//
                currYear := DATE2DMY(TODAY,3);
                StartDate := 0D;
                EndDate := 0D;
                Month:=DATE2DMY("Loan Disbursement Date",2);
                DAY:=DATE2DMY("Loan Disbursement Date",1);
                
                
                StartDate := DMY2DATE(1, Month, currYear); // StartDate will be the date of the first day of the month
                
                IF Month=12 THEN BEGIN
                Month:=0;
                currYear:=currYear+1;
                
                END;
                
                
                EndDate := DMY2DATE(1, Month+1, currYear)-1;
                
                 IF DAY <=5 THEN BEGIN
                 "Repayment Start Date":=CALCDATE('-CM',"Loan Disbursement Date");
                 END ELSE BEGIN
                "Repayment Start Date":=CALCDATE('-CM',CALCDATE('-CM+1M',"Loan Disbursement Date"));
                END;
                "Expected Date of Completion":=CALCDATE('CM',CALCDATE('CM+1M',"Loan Disbursement Date"));
                "Expected Date of Completion":=CALCDATE(FORMAT(Installments)+'M',"Repayment Start Date");
                VALIDATE("Repayment Start Date");
                */

            end;
        }
        field(35; "Mode of Disbursement"; Option)
        {
            OptionCaption = ' ,Cheque,Bank Transfer,EFT,RTGS,Cheque NonMember';
            OptionMembers = " ",Cheque,"Bank Transfer",EFT,RTGS,"Cheque NonMember";

            trigger OnValidate()
            begin
                if "Mode of Disbursement" = "mode of disbursement"::"Bank Transfer" then begin
                    //TESTFIELD("Account No");
                end;
            end;
        }
        field(53; "Affidavit - Item 1 Details"; Text[10])
        {
        }
        field(54; "Affidavit - Estimated Value 1"; Decimal)
        {
        }
        field(55; "Affidavit - Item 2 Details"; Text[10])
        {
        }
        field(56; "Affidavit - Estimated Value 2"; Decimal)
        {
        }
        field(57; "Affidavit - Item 3 Details"; Text[10])
        {
        }
        field(58; "Affidavit - Estimated Value 3"; Decimal)
        {
        }
        field(59; "Board Approval Comment"; Text[100])
        {
        }
        field(60; "Affidavit - Estimated Value 4"; Decimal)
        {
        }
        field(61; "Affidavit - Item 5 Details"; Text[90])
        {
        }
        field(62; "Affidavit - Estimated Value 5"; Decimal)
        {
        }
        field(63; "Magistrate Name"; Text[30])
        {
        }
        field(64; "Date for Affidavit"; Date)
        {
        }
        field(65; "Board Approved By"; Text[30])
        {
        }
        field(66; "Affidavit Signed?"; Boolean)
        {
        }
        field(67; "Date Approved"; Date)
        {
        }
        field(53048; "Grace Period"; DateFormula)
        {
        }
        field(53049; "Instalment Period"; DateFormula)
        {
        }
        field(53050; Repayment; Decimal)
        {

            trigger OnValidate()
            begin

                "Previous Repayment" := xRec.Repayment;
                Advice := true;

                "Previous Repayment" := xRec.Repayment;

                Advice := true;
                "Advice Type" := "advice type"::Adjustment;

                if LoanTypes.Get("Loan Product Type") then begin
                    if Customer.Get("Client Code") then begin
                        Loan."Staff No" := Customer."Personal No";

                        DataSheet.Init;
                        DataSheet."PF/Staff No" := "Staff No";
                        DataSheet."Type of Deduction" := LoanTypes."Product Description";
                        DataSheet."Remark/LoanNO" := "Loan  No.";
                        DataSheet.Name := "Client Name";
                        DataSheet."ID NO." := "ID NO";
                        DataSheet."Amount ON" := Repayment;
                        DataSheet."Amount OFF" := xRec.Repayment;

                        DataSheet."REF." := '2026';
                        DataSheet."New Balance" := "Approved Amount";
                        DataSheet.Date := Loan."Issued Date";
                        DataSheet.Date := Today;
                        DataSheet.Employer := "Employer Code";
                        //DataSheet.Employer:=EmployerName;
                        DataSheet."Transaction Type" := DataSheet."transaction type"::"ADJUSTMENT LOAN";
                        //DataSheet."Sort Code":=PTEN;
                        DataSheet.Insert;
                    end;
                end;
            end;
        }
        field(53051; "Pays Interest During GP"; Boolean)
        {
        }
        field(53053; "Percent Repayments"; Decimal)
        {
            Editable = false;
        }
        field(53054; "Paying Bank Account No"; Code[25])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(53055; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(53056; "Loan Product Type Name"; Text[100])
        {
        }
        field(53057; "Cheque Number"; Code[25])
        {

            trigger OnValidate()
            begin
                Loan.Reset;

                Loan.SetRange(Loan."Cheque Number", "Cheque Number");
                Loan.SetRange(Loan."Bela Branch", "Bela Branch");
                if Loan.Find('-') then begin
                    if Loan."Cheque Number" = "Cheque Number" then
                        Error('The Cheque No. has already been used');
                end;

                if "Cheque No." <> '' then begin
                    Loan.Reset;
                    Loan.SetRange(Loan."Cheque No.", "Cheque No.");
                    Loan.SetRange(Loan."Bela Branch", "Bela Branch");
                    if Loan.Find('-') then begin
                        if Loan."Cheque No." <> "Cheque No." then
                            Error('"Cheque No.". already exists');
                    end;
                end;
            end;
        }
        field(53058; "Bank No"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Bank Account"."No.";
        }
        field(53059; "Slip Number"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(53060; "Total Paid"; Decimal)
        {
            FieldClass = FlowFilter;
        }
        field(53061; "Schedule Repayments"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Principal Repayment" where("Loan No." = field("Loan  No."),
                                                                                     "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53062; "Doc No Used"; Code[20])
        {
        }
        field(53063; "Posting Date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(53065; "Batch No."; Code[20])
        {
            Editable = true;
            FieldClass = Normal;
            TableRelation = if (Posted = const(false)) "Loan Disburesment-Batching"."Batch No."
            else
            if (Posted = const(true)) "Loan Disburesment-Batching"."Batch No.";

            trigger OnValidate()
            begin

                /*ApprovalsUsers.RESET;
                ApprovalsUsers.SETRANGE(ApprovalsUsers."Approval Type",);
                ApprovalsUsers.SETRANGE(ApprovalsUsers.Stage,);
                ApprovalsUsers.SETRANGE(ApprovalsUsers."User ID",);*/

                if "Loan Product Type" <> 'FL353' then begin
                    RepaySched.Reset;
                    RepaySched.SetRange(RepaySched."Loan No.", "Loan  No.");
                    if not RepaySched.Find('-') then
                        Error('Loan Schedule must be generated and confirmed before loan is attached to batch');

                end;
                if "Batch No." <> '' then begin
                    if "Loan Product Type" = '' then
                        Error('You must specify Loan Product Type before assigning a loan a Batch No.');

                    if LoansBatches.Get("Batch No.") then begin
                        if LoansBatches.Status <> LoansBatches.Status::Open then
                            Error('You cannot modify the loan because the batch is already %1', LoansBatches.Status);
                    end;
                end;
                if "Approval Status" = "approval status"::Open then
                    Error('You Can Only Batch Loans Sent for Approval');

            end;
        }
        field(53066; "Edit Interest Rate"; Boolean)
        {
        }
        field(53067; Posted; Boolean)
        {
            Editable = true;
        }
        field(53068; "Product Code"; Code[25])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                GLSetup.Get;
                Dimension := GLSetup."Shortcut Dimension 3 Code";
            end;
        }
        field(53077; "Document No 2 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(53078; "Field Office"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('FIELD OFFICE'));
        }
        field(53079; Dimension; Code[20])
        {
        }
        field(53080; "Amount Disbursed"; Decimal)
        {

            trigger OnValidate()
            begin
                if Posted then
                    "Amount Disbursed" := "Approved Amount";
            end;
        }
        field(53081; "Fully Disbursed"; Boolean)
        {
        }
        field(53082; "New Interest Rate"; Decimal)
        {
            Editable = false;
        }
        field(53083; "New No. of Instalment"; Integer)
        {
            Editable = false;
        }
        field(53084; "New Grace Period"; DateFormula)
        {
            Editable = false;
        }
        field(53085; "New Regular Instalment"; DateFormula)
        {
            Editable = false;
        }
        field(53086; "Loan Balance at Rescheduling"; Decimal)
        {
            Editable = false;
        }
        field(53087; "Loan Reschedule"; Boolean)
        {
        }
        field(53088; "Date Rescheduled"; Date)
        {
        }
        field(53089; "Reschedule by"; Code[20])
        {
        }
        field(53090; "Flat Rate Principal"; Decimal)
        {
        }
        field(53091; "Flat rate Interest"; Decimal)
        {
        }
        field(53092; "Total Repayment"; Decimal)
        {
            Editable = false;
        }
        field(53093; "Interest Calculation Method"; Option)
        {
            OptionMembers = ,"No Interest","Flat Rate","Reducing Balances";
        }
        field(53094; "Edit Interest Calculation Meth"; Boolean)
        {
        }
        field(53095; "Balance BF"; Decimal)
        {
        }
        field(53098; "Interest to be paid"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Interest" where("Loan No." = field("Loan  No."),
                                                                                  "Member No." = field("Client Code"),
                                                                                  "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53099; "Date filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(53101; "Cheque Date"; Date)
        {
        }
        field(53102; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  "Currency Code" = field("Currency Filter"),
                                                                  "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53103; "Loan to Share Ratio"; Decimal)
        {
        }
        field(53104; "Shares Balance"; Decimal)
        {
            Editable = false;
        }
        field(53105; "Max. Installments"; Integer)
        {
            Editable = false;
        }
        field(53106; "Max. Loan Amount"; Decimal)
        {
            Editable = false;
        }
        field(53107; "Loan Cycle"; Integer)
        {
            Editable = false;
        }
        field(53108; "Penalty Charged"; Decimal)
        {
            // CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
            //                                                       "Transaction Type" = filter(),
            //                                                       "Loan No" = field("Loan  No."),
            //                                                       "Posting Date" = field("Date filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(53109; "Loan Amount"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter("Share Capital"),
                                                                  "Loan No" = field("Loan  No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53110; "Current Shares"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                   "Transaction Type" = filter(Loan)));
            FieldClass = FlowField;
        }
        field(53111; "Loan Repayment"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter("Interest Paid"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53112; "Repayment Method"; Option)
        {
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;

            trigger OnValidate()
            begin
                Validate("Approved Amount");
            end;
        }
        field(53113; "Grace Period - Principle (M)"; Integer)
        {

            trigger OnValidate()
            begin
                Installments := "Installment Including Grace" - "Grace Period - Principle (M)"
            end;
        }
        field(53114; "Grace Period - Interest (M)"; Integer)
        {
        }
        field(53115; Adjustment; Text[80])
        {
        }
        field(53116; "Payment Due Date"; Text[80])
        {
        }
        field(53117; "Tranche Number"; Integer)
        {
        }
        field(53118; "Amount Of Tranche"; Decimal)
        {
        }
        field(53119; "Total Disbursment to Date"; Decimal)
        {
        }
        field(53133; "Copy of ID"; Boolean)
        {
        }
        field(53134; Contract; Boolean)
        {
        }
        field(53135; Payslip; Boolean)
        {
        }
        field(53136; "Contractual Shares"; Decimal)
        {
        }
        field(53182; "Last Pay Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Loan No" = field("Loan  No."),
                                                                          "Transaction Type" = filter("Interest Paid" | "Share Capital")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53183; "Interest Due"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter("Interest Due"),
                                                                  "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53184; "Appraisal Status"; Option)
        {
            OptionCaption = 'Expresion of Interest,Desk Appraisal,Loan form purchased,Loan Officer Approved,Management Approved,Credit Subcommitee Approved,Trust Board Approved';
            OptionMembers = "Expresion of Interest","Desk Appraisal","Loan form purchased","Loan Officer Approved","Management Approved","Credit Subcommitee Approved","Trust Board Approved";

            trigger OnValidate()
            begin
                if "Appraisal Status" = "appraisal status"::"Management Approved" then begin
                    if "Requested Amount" > 5000000 then
                        Error('Management can only approve a request below or equal to 5,000,000.')
                    else
                        "Loan Status" := "loan status"::Appraisal;

                end;

                if "Appraisal Status" = "appraisal status"::"Credit Subcommitee Approved" then begin
                    if "Requested Amount" > 10000000 then
                        Error('Creit Subcommittee can only approve a request below or equal to 10,000,000.')
                    else
                        "Loan Status" := "loan status"::Appraisal;

                end;

                if "Appraisal Status" = "appraisal status"::"Trust Board Approved" then
                    "Loan Status" := "loan status"::Appraisal;
            end;
        }
        field(53185; "Interest Paid"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter("Interest Paid"),
                                                                  "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53186; "Penalty Paid"; Decimal)
        {
            // CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
            //                                                       "Transaction Type" = filter("Penalty Paid"),
            //                                                       "Loan No" = field("Loan  No."),
            //                                                       "Posting Date" = field("Date filter")));
            // FieldClass = FlowField;
        }
        field(53187; "Application Fee Paid"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter(Dividend),
                                                                  "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53188; "Appraisal Fee Paid"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter("FOSA Account"),
                                                                  "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53189; "Global Dimension 1 Code"; Code[25])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(53190; "Repayment Start Date"; Date)
        {

            trigger OnValidate()
            begin
                "Expected Date of Completion" := CalcDate(Format(Installments) + 'M', "Repayment Start Date");
            end;
        }
        field(53191; "Installment Including Grace"; Integer)
        {

            trigger OnValidate()
            begin
                if "Installment Including Grace" > "Max. Installments" then
                    Error('Installments cannot be greater than the maximum installments.');

                Installments := "Installment Including Grace" - "Grace Period - Principle (M)"
            end;
        }
        field(53192; "Schedule Repayment"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Principal Repayment" where("Loan No." = field("Loan  No."),
                                                                                     "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53193; "Schedule Interest"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Interest" where("Loan No." = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(53194; "Interest Debit"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter("Deposit Contribution"),
                                                                  "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53195; "Schedule Interest to Date"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Interest" where("Loan No." = field("Loan  No."),
                                                                                  "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53196; "Repayments BF"; Decimal)
        {
        }
        field(68000; "Account No"; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = const("FOSA Account"));

            trigger OnValidate()
            begin

                //Surestep
                if (Source = Source::BOSA) or (Source = Source::MICRO) then
                    exit;

                GenSetUp.Get(0);

                LoansClearedSpecial.Reset;
                LoansClearedSpecial.SetRange(LoansClearedSpecial."Loan No.", "Loan  No.");
                if LoansClearedSpecial.Find('-') then
                    LoansClearedSpecial.DeleteAll;



                if Vendor.Get("Account No") then begin
                    CustomerRecord.Reset;
                    CustomerRecord.SetRange(CustomerRecord."No.", Vendor."BOSA Account No");
                    if CustomerRecord.Find('-') then begin
                        CustomerRecord.CalcFields(CustomerRecord."Current Shares", CustomerRecord."Outstanding Balance",
                        CustomerRecord."Current Loan");
                        "Client Name" := CustomerRecord.Name;
                        "Shares Balance" := CustomerRecord."Current Shares";
                        Savings := CustomerRecord."Current Shares";
                        "Existing Loan" := CustomerRecord."Outstanding Balance";

                        "Account No" := CustomerRecord."FOSA Account";
                        "Staff No" := CustomerRecord."Personal No";
                        Gender := CustomerRecord.Gender;
                        "BOSA No" := Vendor."BOSA Account No";
                        "Client Code" := Vendor."BOSA Account No";
                        "Branch Code" := Vendor."Global Dimension 2 Code";
                        "ID NO" := Vendor."ID No.";
                        if "Branch Code" = '' then
                            "Branch Code" := CustomerRecord."Global Dimension 2 Code";

                        if ("Loan Product Type" <> 'DFTL FOSA') and ("Loan Product Type" <> 'DFTL') then begin
                            //Check Shares Boosting
                            if "Application Date" <> 0D then begin
                                CustLedg.Reset;
                                CustLedg.SetRange(CustLedg."Customer No.", Vendor."BOSA Account No");
                                CustLedg.SetRange(CustLedg."Transaction Type", CustLedg."transaction type"::"Deposit Contribution");
                                CustLedg.SetRange(CustLedg.Reversed, false);
                                if CustLedg.Find('-') then begin
                                    repeat
                                        if CustLedg."Posting Date" > CalcDate(GenSetUp."Boosting Shares Maturity (M)", "Application Date") then begin
                                            CustLedg.CalcFields(CustLedg.Amount);
                                            if Abs(CustLedg.Amount) >
                                            (((CustomerRecord."Monthly Contribution" * GenSetUp."Boosting Shares %") * 0.01)) then begin
                                                "Shares Boosted" := true;
                                            end;
                                        end;
                                    until CustLedg.Next = 0;
                                end;
                            end;
                        end;




                    end else

                        if CustR.Get("Account No") then begin
                            "BOSA No" := Vendor."BOSA Account No";
                            "Client Code" := Vendor."No.";
                            "Client Name" := Vendor.Name;
                            Validate("Client Code");

                        end else begin
                            "BOSA No" := Vendor."BOSA Account No";
                            "Client Code" := Vendor."No.";
                            "Client Name" := Vendor.Name;
                            Validate("Client Code");

                            CustR.Init;
                            CustR."No." := Vendor."No.";
                            CustR.Name := Vendor.Name;
                            CustR."Global Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                            CustR."Global Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                            CustR.Status := Cust.Status::Active;
                            CustR."Customer Type" := CustR."customer type"::FOSA;
                            CustR."Customer Posting Group" := 'FOSA';
                            CustR."FOSA Account No." := "Account No";
                            if CustR."Personal No" <> '' then
                                CustR."Personal No" := Vendor."Personal No.";
                            CustR."ID No." := Vendor."ID No.";
                            CustR.Gender := Vendor.Gender;
                            CustR.Insert;

                            CustR.Reset;
                            if CustR.Get("Account No") then begin
                                CustR.Name := Vendor.Name;
                                CustR."Global Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                                CustR."Global Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                                CustR."Customer Posting Group" := 'FOSA';
                                CustR.Validate(CustR.Name);
                                CustR.Validate(CustR."Global Dimension 1 Code");
                                CustR.Validate(CustR."Global Dimension 2 Code");
                                //CustR.VALIDATE(CustR."Customer Posting Group");
                                CustR.Modify;

                            end;

                        end;

                    Cust2.Reset;
                    //Cust2.SETRANGE(Cust2."Customer Type",Cust2."Customer Type"::Member);
                    Cust2.SetRange(Cust2."FOSA Account No.", Vendor."No.");
                    if Cust2.Find('-') then begin
                        "BOSA No" := Cust2."No.";
                        if Cust2."Personal No" <> '' then
                            "Staff No" := Cust2."Personal No";
                        Validate("BOSA No");
                    end;



                end;

                //Block if loan Previously recovered from gurantors
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."BOSA No", "BOSA No");
                LoanApp.SetRange("Recovered From Guarantor", true);
                if LoanApp.Find('-') then
                    Error('Member has a loan which has previously been recovered from gurantors. - %1', LoanApp."Loan  No.");
                //Block if loan Previously recovered from gurantors

                Cust.Reset;
                Cust.SetRange(Cust."ID No.", "ID NO");
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Outstanding Balance", Cust."Current Shares");//,Cust."Loans Guaranteed"
                    "BOSA Deposits" := Cust."Current Shares";

                    //"Amont Guaranteed":=Cust."Current Shares";
                end;
                //End Surestep



                if Vendor.Get("Account No") then begin
                    "Employer Code" := Vendor."Employer Code";
                    if Vendor."Salary Processing" = false then begin
                        if Confirm('Member salary not processed throuch the SACCO. Do you wish to continue?', false) = false then begin
                            "Account No" := '';
                            "ID NO" := Vend."ID No.";
                            Modify;
                            exit;
                        end;
                    end;


                    Cust.Reset;
                    Cust.SetRange(Cust."FOSA Account No.", "Account No");
                    if Cust.Find('-') then begin
                        Cust.CalcFields("Current Shares");
                        "Member Account Category" := Cust."Account Category";
                        "Shares Balance" := "Current Shares";


                        Modify;
                    end;

                    if Cust.Get("Account No") then begin
                        "BOSA No" := Vendor."BOSA Account No";
                        "Client Code" := Vendor."No.";
                        "Client Name" := Vendor.Name;
                        "ID NO" := Vendor."ID No.";
                        "ID NO" := Vend."ID No.";
                        //"Member Account Category":=Vend."Account Category";

                        //VALIDATE("Client Code");
                    end else begin
                        "BOSA No" := Vendor."BOSA Account No";
                        "Client Code" := Vendor."No.";
                        "Client Name" := Vendor.Name;
                        "ID NO" := Vendor."ID No.";
                        "ID NO" := Vend."ID No.";
                        //VALIDATE("Client Code");
                        "Staff No" := Cust."Personal No";


                        Cust.Init;
                        Cust."No." := Vendor."No.";
                        Cust.Name := Vendor.Name;
                        Cust."Global Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                        Cust."Global Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                        Cust.Status := Cust.Status::Applicant;
                        Cust."Customer Type" := Cust."customer type"::FOSA;
                        Cust."Customer Posting Group" := 'FOSA';
                        Cust."FOSA Account No." := "Account No";
                        if Cust."Personal No" <> '' then
                            Cust."Personal No" := Vendor."Personal No.";
                        "ID NO" := Vendor."ID No.";

                        Cust.Insert;

                        Cust.Reset;
                        if Cust.Get("Account No") then begin
                            Cust.Name := Vendor.Name;
                            //"ID Identifier":=Cust2."ID No.";
                            Cust."Global Dimension 1 Code" := Vendor."Global Dimension 1 Code";
                            Cust."Global Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                            Cust."Customer Posting Group" := 'MEMBER';
                            Cust.Validate(Cust.Name);
                            Cust.Validate(Cust."Global Dimension 1 Code");
                            Cust.Validate(Cust."Global Dimension 2 Code");
                            //Cust.VALIDATE(Cust."Customer Posting Group");
                            Cust.Modify;
                        end;
                    end;

                    Cust2.Reset;
                    Cust2.SetRange(Cust2."Customer Type", Cust2."customer type"::Member);
                    Cust2.SetRange(Cust2."FOSA Account No.", Vendor."No.");
                    if Cust2.Find('-') then begin
                        "BOSA No" := Cust2."No.";
                        "ID NO" := Cust2."ID No.";
                        if Cust2."Personal No" <> '' then
                            "Staff No" := Cust2."Personal No";
                        "ID NO" := Cust2."ID No.";
                        Validate("BOSA No");
                    end;
                end;

                //Sacco Deductions
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Account No", "Account No");
                LoanApp.SetRange(Source, Source::" ");
                if LoanApp.Find('-') then begin
                    if LoanApp."Account No" <> '' then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        repeat
                            LoanApp.CalcFields(LoanApp."Outstanding Balance");
                            if LoanApp."Outstanding Balance" > 0 then begin
                                if LoanType.Get(LoanApp."Loan Product Type") then begin
                                    SaccoDedInt := LoanApp."Outstanding Balance" * (LoanType."Interest rate" / 1200);
                                    Saccodeduct := Saccodeduct + LoanApp."Loan Principle Repayment" + SaccoDedInt;
                                end;
                            end;
                        until LoanApp.Next = 0;
                    end;
                end;
                "Sacco Deductions" := Saccodeduct;


                //credit policy assessment-check if member is a defaulter
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."ID NO", "ID NO");
                LoanApp.SetRange(LoanApp.Posted, true);
                if LoanApp.Find('-') then begin
                    repeat
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            if (LoanApp."Loans Category" = LoanApp."loans category"::Substandard) or
                            (LoanApp."Loans Category" = LoanApp."loans category"::Doubtful) or (LoanApp."Loans Category" = LoanApp."loans category"::Loss)
                            then begin
                                Message('The member is a defaulter' + '. ' + 'Loan No' + ' ' + LoanApp."Loan  No." + ' ' + 'is in loan category' + ' ' +
                                Format(LoanApp."Loans Category"));
                            end;
                        end;
                    until LoanApp.Next = 0;
                end;

                Cust.Reset;
                Cust.SetRange(Cust."No.", "BOSA No");
                Cust.SetRange("Customer Posting Group", 'MEMBER');
                if Cust.Find('-') then begin
                    Cust.CalcFields("Current Shares");
                    "Member Account Category" := Cust."Account Category";
                    "Shares Balance" := Cust."Current Shares";
                    Modify;
                end;

                FnGetMemberDepositHistory_FOSA();
            end;
        }
        field(68001; "BOSA No"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(68002; "Staff No"; Code[20])
        {

            trigger OnValidate()
            begin
                /*IF xRec."Staff No" <> '' THEN BEGIN
                IF xRec."Staff No" <> "Staff No" THEN BEGIN
                IF CONFIRM('Are you sure you want to change the staff No.') = FALSE THEN
                ERROR('Change cancelled.');
                END;
                END;
                
                
                IF (Source=Source::BOSA) THEN BEGIN
                CustomerRecord.RESET;
                CustomerRecord.SETRANGE(CustomerRecord."Customer Type",CustomerRecord."Customer Type"::Member);
                CustomerRecord.SETRANGE(CustomerRecord."Payroll/Staff No","Staff No");
                IF CustomerRecord.FIND('-') THEN BEGIN
                "Client Code":=CustomerRecord."No.";
                VALIDATE("Client Code");
                END
                ELSE
                ERROR('Record not found.');
                
                END
                ELSE BEGIN
                Vend.RESET;
                Vend.SETFILTER(Vend."Account Type",'SAVINGS');
                Vend.SETRANGE(Vend."Staff No","Staff No");
                IF Vend.FIND('-') THEN BEGIN
                "Account No":=Vend."No.";
                VALIDATE("Account No");
                END
                ELSE
                ERROR('Record not found.');
                
                END;
                */

            end;
        }
        field(68003; "BOSA Loan Amount"; Decimal)
        {
        }
        field(68004; "Top Up Amount"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details"."Total Top Up" where("Loan No." = field("Loan  No."),
                                                                          "Client Code" = field("Client Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68005; "Loan Received"; Boolean)
        {
        }
        field(68006; "Period Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(68007; "Current Repayment"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter("Interest Paid"),
                                                                  "Posting Date" = field("Period Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68008; "Oustanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                  "Currency Code" = field("Currency Filter"),
                                                                  "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68009; "Oustanding Interest to Date"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter("Insurance Contribution" | "Deposit Contribution"),
                                                                  "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68010; "Current Interest Paid"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = const("Insurance Contribution"),
                                                                  "Posting Date" = field("Period Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68011; "Document No. Filter"; Code[80])
        {
            FieldClass = FlowFilter;
        }
        field(68012; "Cheque No."; Code[10])
        {

            trigger OnValidate()
            begin
                /*
               Loan.SETRANGE(Loan."Cheque Number","Cheque Number");
               Loan.SETRANGE(Loan."Bela Branch","Bela Branch");
               IF Loan.FIND('-') THEN BEGIN
               IF Loan."Cheque Number"="Cheque Number" THEN
               ERROR('The Cheque No. has already been used');
               END; */

                if "Cheque No." <> '' then begin
                    Loan.Reset;
                    Loan.SetRange(Loan."Cheque No.", "Cheque No.");
                    Loan.SetRange(Loan."Bela Branch", "Bela Branch");
                    if Loan.Find('-') then begin
                        if Loan."Cheque No." = "Cheque No." then
                            Error('Cheque No. already exists');
                    end;
                end;

            end;
        }
        field(68013; "Personal Loan Off-set"; Decimal)
        {
        }
        field(68014; "Old Account No."; Code[20])
        {
        }
        field(68015; "Loan Principle Repayment"; Decimal)
        {

            trigger OnValidate()
            begin
                Repayment := "Loan Principle Repayment" + "Loan Interest Repayment";
                Advice := true;
                Validate(Repayment);
            end;
        }
        field(68016; "Loan Interest Repayment"; Decimal)
        {
        }
        field(68017; "Contra Account"; Code[20])
        {
        }
        field(68018; "Transacting Branch"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(68019; Source; Option)
        {
            OptionCaption = ' ,BOSA,FOSA,MICRO';
            OptionMembers = " ",BOSA,FOSA,MICRO;
        }
        field(68020; "Net Income"; Decimal)
        {
        }
        field(68021; "No. Of Guarantors"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Loan No" = field("Loan  No."),
                                                                 Substituted = const(false)));
            FieldClass = FlowField;
        }
        field(68022; "Total Loan Guaranted"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details".Shares where("Loan No" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(68023; "Shares Boosted"; Boolean)
        {
        }
        field(68024; "Basic Pay"; Decimal)
        {

            trigger OnValidate()
            begin
                //"Net Income":=("Basic Pay H"+"House Allowance"+"Other Allowance"+"Cleared Effects")-"Total Deductions";
                "Net Income" := ("Basic Pay H" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68025; "House Allowance"; Decimal)
        {

            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay H" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68026; "Other Allowance"; Decimal)
        {

            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay H" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68027; "Total Deductions"; Decimal)
        {

            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay H" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68028; "Cleared Effects"; Decimal)
        {

            trigger OnValidate()
            begin
                //"Net Income":=("Basic Pay H"+"House Allowance"+"Other Allowance"+"Milage Allowance"+"Transport Allowance"+"Other Benefits")
                //-"Total Deductions";
            end;
        }
        field(68029; Remarks; Text[100])
        {
        }
        field(68030; Advice; Boolean)
        {
        }
        field(68031; "Special Loan Amount"; Decimal)
        {
            CalcFormula = sum("Loan Special Clearance"."Total Off Set" where("Loan No." = field("Loan  No."),
                                                                              "Client Code" = field("BOSA No")));
            Caption = 'Bridging Loan Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68032; "Bridging Loan Posted"; Boolean)
        {
        }
        field(68033; "BOSA Loan No."; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(68034; "Previous Repayment"; Decimal)
        {
        }
        field(68035; "No Loan in MB"; Boolean)
        {
        }
        field(68036; "Recovered Balance"; Decimal)
        {
        }
        field(68037; "Recon Issue"; Boolean)
        {
        }
        field(68038; "Loan Purpose"; Code[20])
        {
            TableRelation = "Loans Purpose".Code;
        }
        field(68039; Reconciled; Boolean)
        {
        }
        field(68040; "Appeal Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if Posted = false then
                    Error('Appeal only applicable for issued loans.');
                "Approved Amount" := "Appeal Amount" + "Approved Amount";
                Validate("Approved Amount");
            end;
        }
        field(68041; "Appeal Posted"; Boolean)
        {
        }
        field(68042; "Project Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                CalcFields("Top Up Amount", "Special Loan Amount");

                SpecialComm := 0;
                if "Special Loan Amount" > 0 then
                    SpecialComm := ("Special Loan Amount" * 0.01) + ("Special Loan Amount" + ("Special Loan Amount" * 0.01)) * 0.1;

                if "Project Amount" > ("Approved Amount" - ("Top Up Amount" + "Special Loan Amount" + SpecialComm)) then
                    Error('Amount to project cannot be more than the net payable amount i.e.  %1',
                         ("Approved Amount" - ("Top Up Amount" + "Special Loan Amount" + SpecialComm)));
            end;
        }
        field(68043; "Project Account No"; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = const("FOSA Account"),
                                                "Account Type" = filter('SAVINGS' | 'ENCASHCH'),
                                                Status = const(Active));
        }
        field(68044; "Location Filter"; Integer)
        {
            FieldClass = FlowFilter;
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));
        }
        field(68045; "Other Commitments Clearance"; Decimal)
        {
            CalcFormula = sum("Other Commitements Clearance".Amount where("Loan No." = field("Loan  No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68046; "Discounted Amount"; Decimal)
        {
            Editable = false;
        }
        field(68047; "Transport Allowance"; Decimal)
        {

            trigger OnValidate()
            begin
                "Mileage Allowance" := 0;
                "Net Income" := ("Basic Pay H" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance") - "Total Deductions";
            end;
        }
        field(68048; "Mileage Allowance"; Decimal)
        {

            trigger OnValidate()
            begin
                "Transport Allowance" := 0;
                "Net Income" := ("Basic Pay H" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance") - "Total Deductions";
            end;
        }
        field(68049; "System Created"; Boolean)
        {
        }
        field(68050; "Boosting Commision"; Decimal)
        {
        }
        field(68051; "Voluntary Deductions"; Decimal)
        {
        }
        field(68052; "4 % Bridging"; Boolean)
        {

            trigger OnValidate()
            begin
                //IF CONFIRM('Are you sure you want to charge 7.5%') = TRUE THEN
            end;
        }
        field(68053; "No. Of Guarantors-FOSA"; Integer)
        {
            FieldClass = Normal;
        }
        field(68054; Defaulted; Boolean)
        {
        }
        field(68055; "Bridging Posting Date"; Date)
        {
        }
        field(68056; "Commitements Offset"; Decimal)
        {
        }
        field(68057; Gender; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(68058; "Captured By"; Code[50])
        {
            TableRelation = User."User Security ID";
        }
        field(68059; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //  "Branch Code" := UsersID."Branch Code";
            end;
        }
        field(68060; "Recovered From Guarantor"; Boolean)
        {
        }
        field(68061; "Guarantor Amount"; Decimal)
        {
        }
        field(68062; "External EFT"; Boolean)
        {

            trigger OnValidate()
            begin
                //Surestep
                /*StatusPermissions.RESET;
                StatusPermissions.SETRANGE(StatusPermissions."Account No",USERID);
                StatusPermissions.SETRANGE(StatusPermissions.Name,StatusPermissions.Name::"7");
                IF StatusPermissions.FIND('-') = FALSE THEN
                ERROR('You do not have permissions to update External EFT.');
                 */

            end;
        }
        field(68063; "Defaulter Overide Reasons"; Text[120])
        {
        }
        field(68064; "Defaulter Overide"; Boolean)
        {

            trigger OnValidate()
            begin
                //Surestep
                /*TESTFIELD("Defaulter Overide Reasons");
                
                StatusPermissions.RESET;
                StatusPermissions.SETRANGE(StatusPermissions."Account No",USERID);
                StatusPermissions.SETRANGE(StatusPermissions.Name,StatusPermissions.Name::"8");
                IF StatusPermissions.FIND('-') = FALSE THEN
                ERROR('You do not have permissions to overide defaulters.');
                 */

            end;
        }
        field(68065; "Last Interest Pay Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Loan No" = field("Loan  No."),
                                                                          "Transaction Type" = filter("Insurance Contribution"),
                                                                          "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68066; "Other Benefits"; Decimal)
        {

            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay H" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68067; "Recovered Loan"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(68068; "1st Notice"; Date)
        {
        }
        field(68069; "2nd Notice"; Date)
        {
        }
        field(68070; "Final Notice"; Date)
        {
        }
        field(68071; "Outstanding Balance to Date"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter("Share Capital" | "Interest Paid" | "FOSA Shares"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68072; "Last Advice Date"; Date)
        {
        }
        field(68073; "Advice Type"; Option)
        {
            OptionMembers = " ","Fresh Loan",Adjustment,Reintroduction,Stoppage;
        }
        field(68074; "Current Location"; Code[20])
        {
            CalcFormula = max("Movement Tracker".Station where("Document No." = field("Batch No."),
                                                                "Current Location" = const(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68090; "Compound Balance"; Decimal)
        {
        }
        field(68091; "Repayment Rate"; Decimal)
        {
        }
        field(68092; "Exp Repay"; Decimal)
        {
            FieldClass = Normal;
        }
        field(68093; "ID NO"; Code[30])
        {

            trigger OnValidate()
            begin
                //Surestep
                /*IF Source=Source::FOSA THEN BEGIN
                IF "Account No"='00-0000003000' THEN BEGIN
                Vend.RESET;
                Vend.SETCURRENTKEY(Vend."ID No.");
                Vend.SETRANGE(Vend."ID No.","ID NO");
                IF Vend.FIND('-') THEN BEGIN
                REPEAT
                MESSAGE('THE MEMBER HAS AN ACCOUNT'+' '+ Vend."No."+' ''+ HE/SHE CANNOT TRANSACT ON THIS ACCOUNT');
                UNTIL Vend.NEXT=0;
                END;
                END;
                END;
                */

            end;
        }
        field(68094; RAmount; Decimal)
        {
        }
        field(68095; "Employer Code"; Code[20])
        {
        }
        field(68096; "Last Loan Issue Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("Client Code"),
                                                                          "Transaction Type" = filter("Share Capital"),
                                                                          "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(68097; "Lst LN1"; Boolean)
        {
        }
        field(68098; "Lst LN2"; Boolean)
        {
        }
        field(68099; "Last loan"; Code[20])
        {
            FieldClass = Normal;
        }
        field(69000; "Loans Category"; Option)
        {
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(69001; "Loans Category-SASRA"; Option)
        {
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(69002; "Bela Branch"; Code[10])
        {
        }
        field(69003; "Net Amount"; Decimal)
        {
        }
        field(69004; "Bank code"; Code[10])
        {
            TableRelation = Banks;

            trigger OnValidate()
            begin
                /*banks.RESET;
                banks.SETRANGE(banks.Code,"Bank code");
                
                IF  banks.FIND('-') THEN BEGIN
                
                "Bank code":=banks.Code;
                "Bank Name":=banks."Bank Name";
                "Bank Branch":=banks.Branch;
                
                Loan.MODIFY;
                END;*/

            end;
        }
        field(69005; "Bank Name"; Text[120])
        {
        }
        field(69006; "Bank Branch"; Text[80])
        {
        }
        field(69007; "Outstanding Loan"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69008; "Loan Count"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("Client Code"),
                                                             "Transaction Type" = filter("Share Capital"),
                                                             "Loan No" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69009; "Repay Count"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("Client Code"),
                                                             "Transaction Type" = filter("Interest Paid"),
                                                             "Loan No" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69010; "Outstanding Loan2"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Amount = field("Approved Amount")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69011; "Topup Loan No"; Code[20])
        {
            CalcFormula = lookup("Loan Offset Details"."Loan No." where("Loan Top Up" = field("Loan  No."),
                                                                         "Client Code" = field("Client Code")));
            FieldClass = FlowField;
        }
        field(69012; Defaulter; Boolean)
        {
        }
        field(69013; DefaulterInfo; Text[20])
        {
        }
        field(69014; "Total Earnings(Salary)"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69015; "Total Deductions(Salary)"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69016; "Share Purchase"; Decimal)
        {
        }
        field(69017; "Product Currency Code"; Code[20])
        {
            TableRelation = Currency;
        }
        field(69018; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(69019; "Amount Disburse"; Decimal)
        {
        }
        field(69020; Prepayments; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter(Children),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Posting Date" = field("Date filter"),
                                                                  "Document No." = field("Document No. Filter")));
            FieldClass = FlowField;
        }
        field(69021; "Appln. between Currencies"; Option)
        {
            Caption = 'Appln. between Currencies';
            OptionCaption = 'None,EMU,All';
            OptionMembers = "None",EMU,All;
        }
        field(69022; "Expected Date of Completion"; Date)
        {
        }
        field(69023; "Total Schedule Repayment"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Repayment" where("Loan No." = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69024; "Recovery Mode"; Option)
        {
            OptionCaption = ' ,Checkoff,Standing Order,Salary,Pension,Recover From FOSA,Cash';
            OptionMembers = " ",Checkoff,"Standing Order",Salary,Pension,"Recover From FOSA",Cash;
        }
        field(69025; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quaterly';
            OptionMembers = Daily,Weekly,Monthly,Quaterly;

            trigger OnValidate()
            begin
                if "Repayment Frequency" = "repayment frequency"::Daily then
                    Evaluate("Instalment Period", '1D')
                else
                    if "Repayment Frequency" = "repayment frequency"::Weekly then
                        Evaluate("Instalment Period", '1W')
                    else
                        if "Repayment Frequency" = "repayment frequency"::Monthly then
                            Evaluate("Instalment Period", '1M')
                        else
                            if "Repayment Frequency" = "repayment frequency"::Quaterly then
                                Evaluate("Instalment Period", '1Q');
            end;
        }
        field(69026; "Approval Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(69027; "Old Vendor No"; Code[20])
        {
        }
        field(69028; "Insurance 0.25"; Decimal)
        {
        }
        field(69029; "Total TopUp Commission"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69030; "Total loan Outstanding"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69031; "Monthly Shares Cont"; Decimal)
        {
        }
        field(69032; "Insurance On Shares"; Decimal)
        {
        }
        field(69033; "Total Loan Repayment"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Loan Principle Repayment" where("Client Code" = field("Client Code"),
                                                                                 "Outstanding Balance" = filter(> 1)));
            FieldClass = FlowField;
        }
        field(69034; "Total Loan Interest"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Loan Interest Repayment" where("Client Code" = field("Client Code"),
                                                                                "Outstanding Balance" = filter(> 1)));
            FieldClass = FlowField;
        }
        field(69035; "Net Payment to FOSA"; Decimal)
        {
        }
        field(69036; "Processed Payment"; Boolean)
        {
        }
        field(69037; "Date payment Processed"; Date)
        {
        }
        field(69038; "Attached Amount"; Decimal)
        {
        }
        field(69039; PenaltyAttached; Decimal)
        {
        }
        field(69040; InDueAttached; Decimal)
        {
        }
        field(69041; Attached; Boolean)
        {
        }
        field(69042; "Advice Date"; Date)
        {
        }
        field(69043; "Attachement Date"; Date)
        {
        }
        field(69044; "Total Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter("Share Capital" | "Interest Paid"),
                                                                  "Loan Type" = filter(<> 'ADV' | 'ASSET' | 'B/L' | 'FL' | 'IPF')));
            FieldClass = FlowField;
        }
        field(69045; "Jaza Deposits"; Decimal)
        {

            trigger OnValidate()
            begin

                //LoanType.GET("Loan Product Type");
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                if LoanApp.Find('-') then begin
                    Mdep := "Member Deposits" * 3;
                    Message('Member Deposits *3 is %1', Mdep);

                    if "Jaza Deposits" > Mdep then
                        Error('Jaza deposits can not be more than 3 times the deposits');

                    //"Jaza Deposits":=ROUND(Mdep,1,'<' );
                    if "Jaza Deposits" > Mdep then
                        "Jaza Deposits" := Mdep
                    else
                        "Jaza Deposits" := "Jaza Deposits"

                end;
                Modify;


                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
                if PCharges.Find('-') then begin
                    "Levy On Jaza Deposits" := "Jaza Deposits" * (PCharges.Percentage / 100);
                    Modify;
                end;
            end;
        }
        field(69046; "Member Deposits"; Decimal)
        {
            Editable = false;
        }
        field(69047; "Levy On Jaza Deposits"; Decimal)
        {
        }
        field(69048; "Min Deposit As Per Tier"; Decimal)
        {
        }
        field(69049; "Total Repayments"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Loan Principle Repayment" where("Client Code" = field("Client Code"),
                                                                                 "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(69050; "Total Interest"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Loan Interest Repayment" where("Client Code" = field("Client Code"),
                                                                                "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(69051; Bridged; Boolean)
        {
        }
        field(69052; "Deposit Reinstatement"; Decimal)
        {
        }
        field(69053; "Member Found"; Boolean)
        {
        }
        field(69054; "Recommended Amount"; Decimal)
        {
        }
        field(69055; "Previous Years Dividend"; Decimal)
        {
        }
        field(69056; "partially Bridged"; Boolean)
        {
        }
        field(69057; "loan  Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter("Insurance Contribution" | "Deposit Contribution"),
                                                                  "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69058; "BOSA Deposits"; Decimal)
        {
        }
        field(69059; "Topup Commission"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details".Commision where("Loan No." = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69060; "Topup iNTEREST"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details"."Interest Top Up" where("Loan No." = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69061; "No of Gurantors FOSA"; Integer)
        {
            CalcFormula = count("Loan GuarantorsFOSA" where("Loan No" = field("Loan  No."),
                                                             Substituted = const(false)));
            FieldClass = FlowField;
        }
        field(69062; "Loan No Found"; Boolean)
        {
        }
        field(69063; "Checked By"; Code[20])
        {
        }
        field(69064; "Approved By"; Code[20])
        {
        }
        field(69065; "New Repayment Period"; Integer)
        {

            trigger OnValidate()
            begin
                //Reschedule
                //Surestep
                /*{``IF Posted=TRUE THEN BEGIN
                StatusPermissions.RESET;
                StatusPermissions.SETRANGE(StatusPermissions."Account No",USERID);
                StatusPermissions.SETRANGE(StatusPermissions.Name,StatusPermissions.Name::"27");
                IF StatusPermissions.FIND('-') = FALSE THEN
                ERROR('You do not have permissions to Reschedule Loans.');
                 END;
                
                
                
                
                
                
                
                 "Checked By":=USERID;
                IF "New Repayment Period" > Installments THEN BEGIN
                ERROR('you cannot reshedule loan  more than the original installments');
                END;
                Enddates:= CALCDATE(FORMAT("New Repayment Period")+'M',"Repayment Start Date");
                //MESSAGE('Enddates is %1',Enddates);
                IF "Expected Date of Completion"< CALCDATE(FORMAT("New Repayment Period")+'M',"Repayment Start Date") THEN
                
                ERROR('you cannot reshedule loan  more than the original installments');
                     }
                
                Installments:="New Repayment Period";
                ///IF CALCDATE(GenSetUp."Min. Loan Application Period",CustomerRecord."Registration Date") > TODAY THEN
                */

            end;
        }
        field(69066; "Rejected By"; Code[15])
        {
        }
        field(69067; "Loans Insurance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter("Loan Insurance Charged" | "Loan Insurance Paid"),
                                                                  "Loan No" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69068; "Last Int Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("Client Code"),
                                                                          "Loan No" = field("Loan  No."),
                                                                          "Transaction Type" = filter("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(69069; "Approval remarks"; Code[15])
        {
        }
        field(69070; "Loan Disbursed Amount"; Decimal)
        {
        }
        field(69071; "Bank Bridge Amount"; Decimal)
        {
        }
        field(69072; "Approved Repayment"; Decimal)
        {
        }
        field(69073; "Rejection  Remark"; Text[80])
        {
            CalcFormula = lookup("Approval Comment Line".Comment where("Document No." = field("Loan  No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69074; "Original Approved Amount"; Decimal)
        {
        }
        field(69075; "Original Approved Updated"; Boolean)
        {
        }
        field(69077; "Employer Name"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Employer Code")));
            FieldClass = FlowField;
        }
        field(69078; "Totals Loan Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter("Share Capital" | "Interest Paid"),
                                                                  "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(69079; "Interest Upfront Amount"; Decimal)
        {
        }
        field(69080; "Loan Processing Fee"; Decimal)
        {
        }
        field(69081; "Loan Appraisal Fee"; Decimal)
        {
        }
        field(69082; "Loan Insurance"; Decimal)
        {
        }
        field(69083; "Received Copy Of ID"; Boolean)
        {
        }
        field(69084; "Received Payslip/Bank Statemen"; Boolean)
        {
        }
        field(69085; "1st Time Loanee"; Boolean)
        {
        }
        field(69092; "Adjted Repayment"; Decimal)
        {
        }
        field(69093; "Member Category"; Option)
        {
            OptionCaption = 'Government Ministry,Other Institution,Private,Sacco Staff';
            OptionMembers = "Government Ministry","Other Institution",Private,"Sacco Staff";
        }
        field(69094; "Shares to Boost"; Decimal)
        {
        }
        field(69095; "Hisa Allocation"; Decimal)
        {
        }
        field(69096; "Hisa Commission"; Decimal)
        {
        }
        field(69097; "Hisa Boosting Commission"; Decimal)
        {
        }
        field(69098; "Share Capital Due"; Decimal)
        {
        }
        field(69099; IntersetInArreas; Decimal)
        {
        }
        field(69100; Upfronts; Decimal)
        {
        }
        field(69101; "Loan Calc. Offset Loan"; Boolean)
        {
        }
        field(69102; "Loan Transfer Fee"; Decimal)
        {
        }
        field(69103; "Loan SMS Fee"; Decimal)
        {
        }
        field(69104; "Scheduled Principal to Date"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Principal Repayment" where("Loan No." = field("Loan  No."),
                                                                                     "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(69105; Penalty; Decimal)
        {
        }
        field(69106; "Basic Pay H"; Decimal)
        {
            Description = 'Payslip Details';

            trigger OnValidate()
            begin
                "Monthly Contribution" := 0;

                if "Basic Pay H" > 4000000 then
                    Error('Basic pay is above maximum expected');
                if "Basic Pay H" < 100 then
                    Error('Basic pay is Less than minimum');

                "Monthly Contribution" := fngetmonthlycontrib("Client Code");
                if "Monthly Contribution" < GenSetUp."Min. Contribution" then begin
                    "Monthly Contribution" := GenSetUp."Min. Contribution";
                    Validate("Monthly Contribution");
                end;
                "Sacco Deductions" := 0;
                if Source = Source::BOSA then begin
                    Loans.Reset;
                    Loans.SetRange(Loans."Client Code", "Client Code");
                    Loans.SetRange(Loans.Source, Loans.Source::BOSA);
                    Loans.SetRange(Loans.Posted, true);
                    if Loans.Find('-') then begin
                        repeat
                            Loans.CalcFields(Loans."Outstanding Balance");
                            if Loans."Outstanding Balance" > 0 then begin
                                "Sacco Deductions" := "Sacco Deductions" + Loans."Adjted Repayment" + Loans."Loan Interest Repayment";
                            end;
                        until Loans.Next = 0;
                        Validate("Sacco Deductions");
                    end;
                end else begin
                    Loans.Reset;
                    Loans.SetRange(Loans."Client Code", "Client Code");
                    Loans.SetRange(Loans.Source, Loans.Source::FOSA);
                    Loans.SetRange(Loans.Posted, true);
                    if Loans.Find('-') then begin
                        repeat
                            Loans.CalcFields(Loans."Outstanding Balance");
                            if Loans."Outstanding Balance" > 0 then begin
                                "Sacco Deductions" := "Sacco Deductions" + Loans."Adjted Repayment" + Loans."Loan Interest Repayment";
                            end;
                        until Loans.Next = 0;
                        Validate("Sacco Deductions");
                    end;

                end;
            end;
        }
        field(69107; "Medical AllowanceH"; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF "Basic Pay H">500000 THEN
                ERROR('Basic pay is above maximum expected'); */

            end;
        }
        field(69108; "House AllowanceH"; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF "Basic Pay H">500000 THEN
                ERROR('Basic pay is above maximum expected');  */

            end;
        }
        field(69109; "Staff Assement"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Staff Assement" > 500000 then
                    Error('Staff Assement is above maximum expected');
            end;
        }
        field(69110; Pension; Decimal)
        {

            trigger OnValidate()
            begin
                if Pension > 500000 then
                    Error('Pension is above maximum expected');
            end;
        }
        field(69111; "Medical Insurance"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Medical Insurance" > 500000 then
                    Error('Medical Insurance is above maximum expected');
            end;
        }
        field(69112; "Life Insurance"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Life Insurance" > 500000 then
                    Error('Life Insurance is above maximum expected');
            end;
        }
        field(69113; "Other Liabilities"; Decimal)
        {

            trigger OnValidate()
            begin
                if "House AllowanceH" > 500000 then
                    Error('Other Allowances is above maximum expected');
            end;
        }
        field(69114; "Transport/Bus Fare"; Decimal)
        {
        }
        field(69115; "Other Income"; Decimal)
        {
        }
        field(69116; "Pension Scheme"; Decimal)
        {
        }
        field(69117; "Other Non-Taxable"; Decimal)
        {
        }
        field(69118; "Monthly Contribution"; Decimal)
        {
        }
        field(69119; "Sacco Deductions"; Decimal)
        {
        }
        field(69120; "Other Tax Relief"; Decimal)
        {
        }
        field(69121; NHIF; Decimal)
        {
        }
        field(69122; NSSF; Decimal)
        {
        }
        field(69123; PAYE; Decimal)
        {

            trigger OnValidate()
            begin
                /*ust.RESET;
                cust.SETRANGE(cust."No.","No.");
                IF cust.FIND('-') THEN BEGIN
                cust.PAYE:=xRec.PAYE;
                //cust.MODIFY;
                MESSAGE('NIKO HAPA');
                END;
                         */

            end;
        }
        field(69124; "Risk MGT"; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF "Risk MGT"<>xRec."Risk MGT" THEN BEGIN
                Changed:=TRUE;
                //"Advice Shares":=TRUE;
                "Welfare Advice Date":=TODAY;
                END;
                */

            end;
        }
        field(69125; "Other Loans Repayments"; Decimal)
        {
        }
        field(69126; "Bridge Amount Release"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details"."Monthly Repayment" where("Client Code" = field("Client Code"),
                                                                               "Loan No." = field("Loan  No.")));
            Description = 'End Payslip Details';
            FieldClass = FlowField;
        }
        field(69127; Staff; Boolean)
        {
        }
        field(69128; Disabled; Boolean)
        {
        }
        field(69129; "Staff Union Contribution"; Decimal)
        {
        }
        field(69130; "Non Payroll Payments"; Decimal)
        {
        }
        field(69131; "Gross Pay"; Decimal)
        {
        }
        field(69132; "Total DeductionsH"; Decimal)
        {
        }
        field(69133; "Utilizable Amount"; Decimal)
        {
        }
        field(69134; "Net Utilizable Amount"; Decimal)
        {
        }
        field(69135; "Net take Home"; Decimal)
        {
        }
        field(69136; Signature; Boolean)
        {
        }
        field(69137; "Witnessed By"; Code[20])
        {
            Enabled = false;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Witnessed By");
                if HREmp.Find('-') then begin
                    "Witness Name" := HREmp.Name;    //"First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";
                end;
            end;
        }
        field(69138; "Witness Name"; Text[20])
        {
            Enabled = false;
        }
        field(69139; "Received Copies of Payslip"; Boolean)
        {
        }
        field(69140; "Interest In Arrears"; Decimal)
        {
        }
        field(69141; "Private Member"; Boolean)
        {
        }
        field(69142; "Loan Processing"; Decimal)
        {
        }
        field(69143; "Total Topup Amount"; Decimal)
        {
        }
        field(69144; "Loan  Cash Cleared"; Decimal)
        {
        }
        field(69145; "Loan Cash Clearance fee"; Decimal)
        {
        }
        field(69146; "Loan Due"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter(Loan),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(69147; "Partial Disbursed(Amount Due)"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Transaction Type" = filter(Loan),
                                                                  "Currency Code" = field("Currency Filter"),
                                                                  "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(69148; "Loan Last Pay date 2009Nav"; Date)
        {
        }
        field(69149; "Loans Referee 1"; Code[5])
        {
            Enabled = false;
        }
        field(69150; "Loans Referee 1 Name"; Code[5])
        {
            Enabled = false;
        }
        field(69151; "Loans Referee 2"; Code[5])
        {
            Enabled = false;
        }
        field(69152; "Loans Referee 2 Name"; Code[5])
        {
            Enabled = false;
        }
        field(69153; "Loans Referee 1 Relationship"; Code[5])
        {
            Enabled = false;
            TableRelation = "Relationship Types";
        }
        field(69154; "Loans Referee 2 Relationship"; Code[5])
        {
            Enabled = false;
            TableRelation = "Relationship Types";
        }
        field(69155; "Loans Referee 1 Mobile No."; Code[5])
        {
            Enabled = false;

            trigger OnValidate()
            begin
                if StrLen("Loans Referee 1 Mobile No.") <> 10 then
                    Error('Loans Referee 1 Mobile No. Can not be more or less than 10 Characters');
            end;
        }
        field(69156; "Loans Referee 2 Mobile No."; Code[5])
        {
            Enabled = false;

            trigger OnValidate()
            begin
                if StrLen("Loans Referee 2 Mobile No.") <> 10 then
                    Error('Loans Referee 2 Mobile No. Can not be more or less than 10 Characters');
            end;
        }
        field(69157; "Loans Referee 1 Address"; Code[5])
        {
            Enabled = false;
        }
        field(69158; "Loans Referee 2 Address"; Code[5])
        {
            Enabled = false;
        }
        field(69159; "Loans Referee 1 Physical Addre"; Code[5])
        {
            Enabled = false;
        }
        field(69160; "Loans Referee 2 Physical Addre"; Code[5])
        {
            Enabled = false;
        }
        field(69161; "Loan to Appeal"; Code[5])
        {
            Enabled = false;
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Client Code"));

            trigger OnValidate()
            begin
                LoanAppeal.Reset;
                LoanAppeal.SetRange(LoanAppeal."Loan  No.", "Loan to Appeal");
                if LoanAppeal.Find('-') then begin
                    "Loan to Appeal Approved Amount" := LoanAppeal."Approved Amount";
                    "Loan to Appeal issued Date" := LoanAppeal."Issued Date";
                end;
            end;
        }
        field(69162; "Loan to Appeal Approved Amount"; Decimal)
        {
            Enabled = false;
        }
        field(69163; "Loan to Appeal issued Date"; Date)
        {
            Enabled = false;
        }
        field(69164; "Loan Appeal"; Boolean)
        {
        }
        field(69165; "Disbursed By"; Code[15])
        {
        }
        field(69166; "Member Account Category"; Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Parish,Church,Church Department,Staff';
            OptionMembers = Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff;
        }
        field(69167; "Member Not Found"; Boolean)
        {
        }
        field(69168; "Loan to Reschedule"; Code[15])
        {
            TableRelation = "Loans Register"."Loan  No." where("BOSA No" = field("BOSA No"),
                                                                Posted = filter(true));

            trigger OnValidate()
            begin
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Loan  No.", "Loan to Reschedule");
                if LoanApp.Find('-') then begin
                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                    "Requested Amount" := LoanApp."Outstanding Balance";
                    "Recommended Amount" := LoanApp."Outstanding Balance";
                    "Approved Amount" := LoanApp."Outstanding Balance";
                    "Loan Product Type" := LoanApp."Loan Product Type";
                    Interest := LoanApp.Interest;
                    "Application Date" := Today;

                end;


                if LoanType.Get("Loan Product Type") then begin
                    Installments := LoanType."Default Installements";
                    Validate("Loan Product Type");
                end;
            end;
        }
        field(69169; Rescheduled; Boolean)
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Client Code"),
                                                                "Outstanding Balance" = filter(> 0));
        }
        field(69170; "Loan Rescheduled Date"; Date)
        {
        }
        field(69171; "Loan Rescheduled By"; Code[20])
        {
        }
        field(69172; "Reason For Loan Reschedule"; Text[15])
        {
        }
        field(69173; "Loan Under Debt Collection"; Boolean)
        {
        }
        field(69174; "Loan Debt Collector"; Code[15])
        {
            TableRelation = Vendor."No." where("Debt Collector" = filter(true));

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.", "Loan Debt Collector");
                if Vend.Find('-') then begin
                    "Loan Debt Collector Interest %" := Vend."Debt Collector %";
                    "Loan Under Debt Collection" := true;
                    "Debt Collector Name" := Vendor.Name;
                    "Debt Collection date Assigned" := Today;
                end;
            end;
        }
        field(69175; "Loan Debt Collector Interest %"; Decimal)
        {
        }
        field(69176; "Debt Collection date Assigned"; Date)
        {
        }
        field(69177; "Debt Collector Name"; Code[10])
        {
        }
        field(69178; "Global Dimension 2 Code"; Code[15])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(69179; Discard; Boolean)
        {
        }
        field(69180; Upraised; Boolean)
        {
        }
        field(69181; "Pension No"; Code[10])
        {
        }
        field(69182; "Loan Series Count"; Integer)
        {
        }
        field(69183; "Loan Account No"; Code[15])
        {
        }
        field(69184; Deductible; Boolean)
        {
        }
        field(69185; "Outstanding Balance-Capitalize"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  "Loan No" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69186; "Last Interest Due Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("Client Code"),
                                                                          "Posting Date" = field("Date filter"),
                                                                          "Loan No" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69187; "Amount Payed Off"; Decimal)
        {
            CalcFormula = sum("Loans PayOff Details"."Total PayOff" where("Loan to PayOff" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69188; "Amount in Arrears"; Decimal)
        {
        }
        field(69189; "No of Months in Arrears"; Decimal)
        {
        }
        field(69190; "No of Active Loans"; Integer)
        {
        }
        field(69191; "Doublicate Loans"; Boolean)
        {
        }
        field(69192; "Capitalized Charges"; Decimal)
        {
        }
        field(69193; "Armotization Factor"; Decimal)
        {
        }
        field(69194; "Sacco Interest"; Decimal)
        {
        }
        field(69195; "Amortization Interest Rate"; Decimal)
        {
        }
        field(69196; "Total Outstanding Loan BAL"; Decimal)
        {
        }
        field(69197; "Member Group"; Code[15])
        {
            TableRelation = Customer."No." where("Group Account" = filter(true));

            trigger OnValidate()
            begin
                LineNoG := LineNoG + 1;

                Cust.Reset;
                Cust.SetRange(Cust."Group Account No", "Member Group");
                if Cust.Find('-') then begin
                    repeat
                        Cust.CalcFields(Cust."Current Shares");
                        if (Cust."No." <> "Client Code") and (Cust."Current Shares" <> 0) then begin



                            LoansG.Init;
                            LoansG."Loan No" := "Loan  No.";
                            LoansG."Member No" := Cust."No.";
                            LoansG.Name := Cust.Name;
                            LoansG."Amont Guaranteed" := Cust."Current Shares";
                            Message('Current Shares is %1', Cust."Current Shares");
                            LoansG."ID No." := Cust."ID No.";
                            LoansG.Shares := Cust."Current Shares";
                            LoansG."Shares *3" := Cust."Current Shares" * 3;
                            LoansG.Insert;
                            LoansG.Validate(LoansG."Member No");
                            LoansG.Modify;
                        end;
                    until Cust.Next = 0;
                end;


                if Cust.Get("Member Group") then begin
                    "Member Group Name" := Cust.Name;
                end;
            end;
        }
        field(69198; "Member Group Name"; Code[15])
        {
        }
        field(69199; "Payroll CodeB"; Option)
        {
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10,11,12,13';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10","11","12","13";
        }
        field(69200; "Group Shares"; Decimal)
        {
            Editable = false;
        }
        field(69201; "Cashier Branch"; Code[15])
        {
        }
        field(69202; Sceduled; Boolean)
        {
        }
        field(69203; "Boost this Loan"; Boolean)
        {

            trigger OnValidate()
            begin
                GenSetUp.Get();
                if ((("Member Deposits" * 3) < "Requested Amount") and ("Boost this Loan" = true)) then begin
                    if LoanType.Get("Loan Product Type") then begin
                        if Source = Source::BOSA then begin
                            "Boosting Commision" := 0;
                            "Boosted Amount" := 0;
                            "Boosted Amount" := ROUND(("Requested Amount" - ("Member Deposits" * 3)), 0.05, '>');//
                            "Boosting Commision" := "Boosted Amount" * GenSetUp."Boosting Shares %" / 100;
                            //"Boosted Amount Interest":="Boosted Amount"*Interest/1200;
                        end else begin
                            "Boosting Commision" := "Boosted Amount" * GenSetUp."Boosting Shares %" / 100;
                            //"Boosted Amount Interest":="Boosted Amount"*Interest/1200;
                        end

                    end
                end
            end;
        }
        field(69204; "Boosted Amount"; Decimal)
        {
        }
        field(69205; "Notify Guarantor SMS"; Boolean)
        {
        }
        field(69206; "Boosted Amount Interest"; Decimal)
        {
        }
        field(69207; "Booster Loan No"; Code[10])
        {
        }
        field(69208; "Provident Fund"; Decimal)
        {
        }
        field(69209; "Provident Fund (Self)"; Decimal)
        {
        }
        field(69210; "Existing Loan Repayments"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69211; "Chargeable Pay"; Decimal)
        {
        }
        field(69212; "Net take home 2"; Decimal)
        {
        }
        field(69213; "Least Retained Amount"; Decimal)
        {
        }
        field(69214; Reversed; Boolean)
        {
        }
        field(69215; "Principal Paid"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter("Loan Repayment"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(69216; "Group Account"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Group Account" = true then
                    "Loan Product Type" := 'BORESHA'
                else
                    "Loan Product Type" := 'INUKA';
            end;
        }
        field(69217; "Member Share Capital"; Decimal)
        {
        }
        field(69218; "Membership Duration(Years)"; Integer)
        {
        }
        field(69219; "Registration Date"; Date)
        {
        }
        field(69220; "Loan Deposit Multiplier"; Integer)
        {
        }
        field(69221; "Income Type"; Option)
        {
            OptionCaption = 'Payslip,Bank Statement';
            OptionMembers = Payslip,"Bank Statement";
        }
        field(69222; "Bank Statement Avarage Credits"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := "Bank Statement Avarage Credits" - "Bank Statement Avarage Debits";
            end;
        }
        field(69223; "Bank Statement Avarage Debits"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := "Bank Statement Avarage Credits" - "Bank Statement Avarage Debits";
            end;
        }
        field(69224; "Bank Statement Net Income"; Decimal)
        {
        }
        field(69225; "Loan Insurance Charged"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter("Loan Insurance Charged"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(69226; "Loan Insurance Paid"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter("Loan Insurance Paid"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(69227; "Outstanding Insurance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter("Loan Insurance Paid" | "Loan Insurance Charged"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(69228; "Salary Total Income"; Decimal)
        {

            trigger OnValidate()
            begin
                VarTotalMonthlyRepayments := 0;

                ObjLoansRec2.Reset;
                ObjLoansRec2.SetRange(ObjLoansRec2."Client Code", "Client Code");
                if ObjLoansRec2.FindSet then begin
                    ObjLoansRec2.CalcFields(ObjLoansRec2."Outstanding Balance");
                    repeat
                        if ObjLoansRec2."Outstanding Balance" > 0 then begin
                            ObjLoanOffsets.Reset;
                            ObjLoanOffsets.SetRange(ObjLoanOffsets."Loan No.", "Loan  No.");
                            ObjLoanOffsets.SetRange(ObjLoanOffsets."Loan Top Up", ObjLoansRec2."Loan  No.");
                            if ObjLoanOffsets.FindSet = false then begin
                                VarTotalMonthlyRepayments := VarTotalMonthlyRepayments + ObjLoansRec2.Repayment;
                            end;
                        end;
                    until ObjLoansRec2.Next = 0;
                end;

                "Existing Loan Repayments" := VarTotalMonthlyRepayments;


                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others");
            end;
        }
        field(69229; "SExpenses Rent"; Decimal)
        {

            trigger OnValidate()
            begin

                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others");
            end;
        }
        field(69230; "SExpenses Transport"; Decimal)
        {

            trigger OnValidate()
            begin
                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others");
            end;
        }
        field(69231; "SExpenses Education"; Decimal)
        {

            trigger OnValidate()
            begin
                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others");
            end;
        }
        field(69232; "SExpenses Food"; Decimal)
        {

            trigger OnValidate()
            begin
                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others");
            end;
        }
        field(69233; "SExpenses Utilities"; Decimal)
        {

            trigger OnValidate()
            begin
                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others");
            end;
        }
        field(69234; "SExpenses Others"; Decimal)
        {

            trigger OnValidate()
            begin
                "Salary Net Utilizable" := "Salary Total Income" - ("SExpenses Rent" + "Exisiting Loans Repayments" + "SExpenses Transport" + "SExpenses Food" + "SExpenses Utilities" + "SExpenses Others");
            end;
        }
        field(69235; "Salary Net Utilizable"; Decimal)
        {
        }
        field(69236; "Member House Group"; Code[5])
        {
            TableRelation = "Member House Groups"."Cell Group Code";

            trigger OnValidate()
            begin
                if ObjCellGroup.Get("Member House Group") then begin
                    "Member House Group Name" := ObjCellGroup."Cell Group Name";
                    "Credit Officer" := ObjCellGroup."Credit Officer";
                end;

                ObjGuarantors.Reset;
                ObjGuarantors.SetRange(ObjGuarantors."Loan No", "Loan  No.");
                if ObjGuarantors.FindSet then begin
                    //REPEAT
                    ObjGuarantors.DeleteAll;
                    //UNTIL ObjGuarantors.NEXT=0;
                end;

                ObjCust.Reset;
                ObjCust.SetRange(ObjCust."Member House Group", "Member House Group");
                if ObjCust.FindSet then begin
                    repeat
                        if ObjCust."Member House Group" <> '' then begin
                            ObjCust.CalcFields(ObjCust."Current Shares");
                            ObjGuarantors.Init;
                            ObjGuarantors."Loan No" := "Loan  No.";
                            ObjGuarantors."Member No" := ObjCust."No.";
                            ObjGuarantors.Name := ObjCust.Name;
                            ObjGuarantors."Amont Guaranteed" := ObjCust."Current Shares";
                            ObjGuarantors.Insert;
                        end;
                    //ObjGuarantors.VALIDATE(ObjGuarantors."Member No");
                    //ObjGuarantors.MODIFY;
                    until ObjCust.Next = 0;
                end;
            end;
        }
        field(69237; "Member House Group Name"; Code[5])
        {
        }
        field(69238; "Statement Account"; Code[15])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Client Code"));
        }
        field(69239; "Share Boosting Comission"; Decimal)
        {
        }
        field(69240; "BSExpenses Transport"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := "Bank Statement Net Income" - ("BSExpenses Rent" + "Exisiting Loans Repayments" + "BSExpenses Transport" + "BSExpenses Food" + "BSExpenses Utilities" + "BSExpenses Others");
            end;
        }
        field(69241; "BSExpenses Education"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := "Bank Statement Net Income" - ("BSExpenses Rent" + "Exisiting Loans Repayments" + "BSExpenses Transport" + "BSExpenses Food" + "BSExpenses Utilities" + "BSExpenses Others");
            end;
        }
        field(69242; "BSExpenses Food"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := "Bank Statement Net Income" - ("BSExpenses Rent" + "Exisiting Loans Repayments" + "BSExpenses Transport" + "BSExpenses Food" + "BSExpenses Utilities" + "BSExpenses Others");
            end;
        }
        field(69243; "BSExpenses Utilities"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := "Bank Statement Net Income" - ("BSExpenses Rent" + "Exisiting Loans Repayments" + "BSExpenses Transport" + "BSExpenses Food" + "BSExpenses Utilities" + "BSExpenses Others");
            end;
        }
        field(69244; "BSExpenses Others"; Decimal)
        {

            trigger OnValidate()
            begin
                "Bank Statement Net Income" := "Bank Statement Net Income" - ("BSExpenses Rent" + "Exisiting Loans Repayments" + "BSExpenses Transport" + "BSExpenses Food" + "BSExpenses Utilities" + "BSExpenses Others");
            end;
        }
        field(69245; "BSExpenses Rent"; Decimal)
        {

            trigger OnValidate()
            begin
                VarTotalMonthlyRepayments := 0;

                ObjLoansRec2.Reset;
                ObjLoansRec2.SetRange(ObjLoansRec2."Client Code", "Client Code");
                ObjLoansRec2.SetRange(ObjLoansRec2.Posted, true);
                if ObjLoansRec2.FindSet then begin
                    ObjLoansRec2.CalcFields(ObjLoansRec2."Outstanding Balance");
                    repeat
                        if ObjLoansRec2."Outstanding Balance" > 0 then begin
                            /*ObjLoanOffsets.RESET;
                            ObjLoanOffsets.SETRANGE(ObjLoanOffsets."Loan No.","Loan  No.");
                            ObjLoanOffsets.SETRANGE(ObjLoanOffsets."Loan Top Up",ObjLoansRec2."Loan  No.");
                            IF ObjLoanOffsets.FINDSET=FALSE THEN BEGIN
                              VarTotalMonthlyRepayments:=VarTotalMonthlyRepayments+ObjLoansRec2.Repayment;
                              MESSAGE(FORMAT(VarTotalMonthlyRepayments));
                              END;*/
                            VarTotalMonthlyRepayments := VarTotalMonthlyRepayments + ObjLoansRec2.Repayment;
                        end;
                    until ObjLoansRec2.Next = 0;
                    "Existing Loan Repayments" := VarTotalMonthlyRepayments;
                    Message(Format(VarTotalMonthlyRepayments));
                end;




                "Bank Statement Net Income" := "Bank Statement Net Income" - ("BSExpenses Rent" + "Existing Loan Repayments" + "BSExpenses Transport" + "BSExpenses Food" + "BSExpenses Utilities" + "BSExpenses Others");

            end;
        }
        field(69246; "Exisiting Loans Repayments"; Decimal)
        {
        }
        field(51516208; "Credit Officer"; Code[20])
        {
            Caption = 'User ID';
            NotBlank = true;
            TableRelation = "User Setup"."User ID";// User."User Name" where("Credit Officer" = filter(Yes));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
            // UserMgt: Codeunit "User Management";
            begin
                // UserMgt.LookupUserID("Credit Officer");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
                //UserMgt.ValidateUserID("Credit Officer");

                ObjUser.Reset;
                ObjUser.SetRange(ObjUser."User Name", "Credit Officer");
                if ObjUser.FindSet then begin
                    // "Loan Centre" := ObjUser."Branch Code";
                end;
            end;
        }
        field(51516209; "Loan Centre"; Code[10])
        {
            Enabled = false;
        }
        field(51516210; "Loan Reschedule Instalments"; Integer)
        {

            trigger OnValidate()
            begin
                InterestRate := Interest;
                CalcFields("Outstanding Balance");

                LBalance := "Outstanding Balance";

                //Repayments for amortised method

                if "Repayment Method" = "repayment method"::Amortised then begin
                    //TotalMRepay:=ROUND((InterestRate/12/100) / (1 - POWER((1 + (InterestRate/12/100)),- "Loan Reschedule Instalments")) * LBalance,1,'>');
                    //LInterest:=ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');

                    //IF "Repayment Method"="Repayment Method"::"Reducing Balance" THEN
                    //  LInterest:=ROUND(("Approved Amount"*InterestRate/1200),0.05,'>');



                    LPrincipal := TotalMRepay - LInterest;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;


                    if "Repayment Method" = "repayment method"::"Straight Line" then begin
                        //TESTFIELD(Installments);
                        LPrincipal := ROUND(LBalance / "Loan Reschedule Instalments", 1, '>');
                        LInterest := ROUND((InterestRate / 1200) * LBalance, 1, '>');

                        ObjProductCharge.Reset;
                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                        if ObjProductCharge.FindSet then begin
                            LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                        end;

                        Repayment := TotalMRepay + LInsurance;
                    end;

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                        LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                    end;

                    Repayment := TotalMRepay + LInsurance;
                end;
                //End Repayments for amortised method
            end;
        }
        field(51516211; "Disburesment Type"; Option)
        {
            OptionCaption = ' ,Full/Single disbursement,Tranche/Multiple Disbursement';
            OptionMembers = " ","Full/Single disbursement","Tranche/Multiple Disbursement";

            trigger OnValidate()
            begin
                /*IF "Disburesment Type"="Disburesment Type"::"Full/Single disbursement" THEN BEGIN
                  "Requested Amount":="Approved Amount";
                  "Approved Amount":="Amount to Disburse";
                
                END;*/

                if "Amount To Disburse" > "Approved Amount" then
                    Error(Text0006, "Approved Amount", "Loan  No.");

                if "Approved Amount" = "Amount To Disburse" then
                    "Disburesment Type" := "disburesment type"::"Full/Single disbursement";

                if "Approved Amount" < "Amount To Disburse" then
                    "Disburesment Type" := "disburesment type"::"Tranche/Multiple Disbursement";



                if Usersetup.Get(UserId) then begin
                    if Usersetup."Issue Trunch" = false then
                        Error('You dont have permissions to Trunch a Loan! ')
                end;

            end;
        }
        field(51516212; "Amount to Disburse on Tranch 1"; Decimal)
        {

            trigger OnValidate()
            begin
                /*ObjTranchDetails.RESET;
                ObjTranchDetails.SETRANGE(ObjTranchDetails."Loan No","Loan  No.");
                IF ObjTranchDetails.FINDSET THEN BEGIN
                  ObjTranchDetails.DELETEALL;
                  END;
                
                  VarTranchNo:=VarTranchNo+1;
                
                  ObjTranchDetails.INIT;
                  ObjTranchDetails."Loan No":="Loan  No.";
                  ObjTranchDetails.Description:='Tranch Disburesment '+VarTranchNo;
                  ObjTranchDetails."Client Code":="Client Code";
                  ObjTranchDetails."Client Name":="Client Name";
                  ObjTranchDetails.INSERT;*/

            end;
        }
        field(51516213; "No of Tranch Disbursment"; Integer)
        {
        }
        field(51516214; "Loan Stages"; Code[10])
        {
            Enabled = false;
            TableRelation = "Loan Stages"."Loan Stage";

            trigger OnValidate()
            begin
                /*IF ObjLoanStages.GET() THEN BEGIN
                 "Loan Stage Description":=ObjLoanStages."Transaction Date";
                  END;*/

            end;
        }
        field(51516215; "Loan Stage Description"; Text[10])
        {
            Enabled = false;
        }
        field(51516216; "Loan Current Payoff Amount"; Decimal)
        {
            Enabled = false;
        }
        field(51516217; "Outstanding Penalty"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("Client Code"),
                                                                  "Transaction Type" = filter("Loan Insurance Paid" | "Loan Insurance Charged"),
                                                                  "Loan No" = field("Loan  No."),
                                                                  "Posting Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(51516218; "Tranch Amount Disbursed"; Decimal)
        {
        }
        field(51516219; "Repayment Dates Rescheduled"; Boolean)
        {
        }
        field(51516220; "Repayment Dates Rescheduled On"; Date)
        {
        }
        field(51516221; "Repayment Dates Rescheduled By"; Code[20])
        {
        }
        field(51516222; "KRA Pin No."; Code[15])
        {
        }
        field(51516223; "Advance Loan No"; Code[10])
        {
            TableRelation = "Loans Register"."Loan  No." where("Approval Status" = filter(Approved),
                                                                "Outstanding Balance" = filter(0),
                                                                "Loan Status" = filter(<> Issued));

            trigger OnValidate()
            begin
                //**************************Loan Advance **************************************//
                if Loan.Get("Advance Loan No") then begin
                    if LoanType.Get(Loan."Loan Product Type") then begin
                        if LoanType."Allow Loan Advance" = false then begin
                            Error(Text00004, Loan."Loan Product Type")
                        end
                        else
                            if LoanType."Allow Loan Advance" then begin
                                Loan."Advance To Recover" := "Loan  No.";
                                Loan.Modify;

                                "Basic Pay H" := Loan."Basic Pay H";
                                "House AllowanceH" := Loan."House AllowanceH";
                                "Medical AllowanceH" := Loan."Medical AllowanceH";
                                "Transport/Bus Fare" := Loan."Transport/Bus Fare";
                                "Other Income" := Loan."Other Income";
                                "Provident Fund" := Loan."Provident Fund";
                                NSSF := Loan.NSSF;
                                NHIF := Loan.NHIF;

                                /*ObjGuarantors.RESET;
                                ObjGuarantors.SETRANGE(ObjGuarantors."Loan No",Loan."Advance Loan No");
                                IF ObjGuarantors.FIND('-') THEN
                                  BEGIN
                                    REPEAT
                                      LoansG.INIT;
                                      LoansG."Loan No":="Loan  No.";
                                      LoansG."Member No"
                                      UNTIL ObjGuarantors.NEXT=0;
                                    END;*/
                            end;

                    end;
                end;
                //**************************Loan Advance **************************************//

            end;
        }
        field(51516224; "Advance To Recover"; Code[10])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(51516225; "Bank Account"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(51516226; "Released By Auditor"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if true then
                    "Captured By" := UserId;
            end;
        }
        field(51516227; "Interest Upfront"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516228; "Disbursement Status"; Option)
        {
            DataClassification = ToBeClassified;
            InitValue = Full;
            OptionCaption = ' ,Partial,Full';
            OptionMembers = " ",Partial,Full;
        }
        field(51516229; "Initial Trunch"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Usersetup.Get(UserId) then begin
                    if Usersetup."Issue Trunch" = false then
                        Error('You dont have permissions to Trunch a Loan! ')
                end;
            end;
        }
        field(51516230; "Amount To Disburse"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516231; "Total Charges and Commissions"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516232; "Released By"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Released By Auditor" = true then
                    "Released By" := (UserId);
            end;
        }
        field(51516233; "Board Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Approved,Rejected';
            OptionMembers = ,Approved,Rejected;
        }
        field(51516234; "Type Of Loan Duration"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Short Term,Long Term';
            OptionMembers = ,"Short Term","Long Term";
        }
        field(51516235; "Is BLA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516236; "BLA Clearance Loan"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loans Register"."Loan  No." where("Loan Status" = const(Approved),
                                                                Posted = const(false),
                                                                "Client Code" = field("Client Code"));
        }
        field(51516237; "Main Sector"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Sector".Code;
        }
        field(51516238; "Sub Sector"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(51516239; "Specific Sector"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(51516240; "Risk Classification"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",High,Moderate,low;
        }
        field(51516241; "Days in Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516242; "Loan reschedule Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516243; "Loan reschedule installament"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(51516244; "Board Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516245; "Anticipated Deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516246; Performing; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516247; Watch; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516248; Substandard; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516249; Doubtful; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516250; Loss; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan  No.")
        {
            Clustered = true;
        }
        key(Key2; Posted)
        {
        }
        key(Key3; "Loan Product Type")
        {
            SumIndexFields = "Requested Amount";
        }
        key(Key4; Source, "Client Code", "Loan Product Type", "Issued Date")
        {
        }
        key(Key5; "Batch No.", Source, "Loan Status", "Loan Product Type")
        {
            SumIndexFields = "Approved Amount", "Appeal Amount";
        }
        key(Key6; "BOSA Loan No.", "Account No", "Batch No.")
        {
        }
        key(Key7; "Old Account No.")
        {
        }
        key(Key8; "Client Code")
        {
        }
        key(Key9; "Staff No")
        {
        }
        key(Key10; "BOSA No")
        {
        }
        key(Key11; "Loan Product Type", "Client Code", Posted)
        {
        }
        key(Key12; "Client Code", "Loan Product Type", Posted, "Issued Date")
        {
            SumIndexFields = "Approved Amount";
        }
        key(Key13; "Loan Product Type", "Application Date", Posted)
        {
            SumIndexFields = "Approved Amount";
        }
        key(Key14; Source, "Mode of Disbursement", "Issued Date", Posted)
        {
            SumIndexFields = "Approved Amount";
        }
        key(Key15; "Issued Date", "Loan Product Type")
        {
            SumIndexFields = "Approved Amount";
        }
        key(Key16; "Application Date")
        {
        }
        key(Key17; "Client Code", "Old Account No.")
        {
        }
        key(Key18; "Group Code")
        {
        }
        key(Key19; "Account No")
        {
        }
        key(Key20; Source, "Issued Date", "Loan Product Type", "Client Code")
        {
        }
        key(Key21; "Client Code", "Loan Product Type")
        {
        }
        key(Key22; "Issued Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Loan  No.", "Client Code", "Client Name", "Loan Product Type", "Loan Product Type Name", "Outstanding Balance", "Oustanding Interest", Repayment)
        {
        }
    }

    trigger OnDelete()
    begin
        if "Loan Status" = "loan status"::Approved then
            Error('A loan cannot be deleted once it has been approved');

        TestField(Posted, false);
    end;

    trigger OnInsert()
    begin
        //SURESTEP

        if Source = Source::BOSA then begin
            if "Loan  No." = '' then begin
                SalesSetup.Get;
                SalesSetup.TestField(SalesSetup."BOSA Loans Nos");
                NoSeriesMgt.InitSeries(SalesSetup."BOSA Loans Nos", xRec."No. Series", 0D, "Loan  No.", "No. Series");
            end;

        end else
            if Source = Source::FOSA then begin
                if "Loan  No." = '' then begin
                    SalesSetup.Get;
                    SalesSetup.TestField(SalesSetup."FOSA Loans Nos");
                    NoSeriesMgt.InitSeries(SalesSetup."FOSA Loans Nos", xRec."No. Series", 0D, "Loan  No.", "No. Series");
                end;


            end else
                if Source = Source::MICRO then begin

                    if "Loan  No." = '' then begin
                        SalesSetup.Get;
                        SalesSetup.TestField(SalesSetup."Micro Loans");
                        NoSeriesMgt.InitSeries(SalesSetup."Micro Loans", xRec."No. Series", 0D, "Loan  No.", "No. Series");
                    end;


                end;
        //SURESTEP

        "Application Date" := Today;
        Advice := true;

        "Captured By" := UpperCase(UserId);


        Users.Reset;
        Users.SetRange(Users."User Name", "Captured By");
        if Users.Find('-') then begin
            //"Cashier Branch" := Users."Branch Code";
            //MODIFY;
        end;

        "Mode of Disbursement" := "mode of disbursement"::"Bank Transfer";
    end;

    var
        saving6: Decimal;
        saving5: Decimal;
        saving4: Decimal;
        Saving3: Decimal;
        saving2: Decimal;
        Saving1: Decimal;
        Monthlysavingsetup: Record "Monthly  saving setup";
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanType: Record "Loan Products Setup";
        CustomerRecord: Record Customer;
        i: Integer;
        PeriodDueDate: Date;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        IssuedDate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        NoOfGracePeriod: Integer;
        G: Integer;
        RunningDate: Date;
        NewSchedule: Record "Loan Repayment Schedule";
        ScheduleCode: Code[20];
        GP: Text[30];
        Groups: Record "Loan Product Cycles";
        PeriodInterval: Code[10];
        GLSetup: Record "General Ledger Setup";
        Users: Record User;
        FlatPeriodInterest: Decimal;
        FlatRateTotalInterest: Decimal;
        FlatPeriodInterval: Code[10];
        ProdCycles: Record "Loan Product Cycles";
        LoanApp: Record "Loans Register";
        MemberCycle: Integer;
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        Vendor: Record Vendor;
        Cust: Record Customer;
        Vend: Record Vendor;
        Cust2: Record Customer;
        TotalMRepay: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        UsersID: Record User;
        LoansBatches: Record "Loan Disburesment-Batching";
        Employer: Record "Sacco Employers";
        GenSetUp: Record "Sacco General Set-Up";
        Batches: Record "Loan Disburesment-Batching";
        MovementTracker: Record "Movement Tracker";
        SpecialComm: Decimal;
        CustR: Record Customer;
        RAllocation: Record "Receipt Allocation";
        "Standing Orders": Record "Standing Orders";
        StatusPermissions: Record "Status Change Permision";
        CustLedg: Record "Cust. Ledger Entry";
        LoansClearedSpecial: Record "Loan Special Clearance";
        BridgedLoans: Record "Loan Special Clearance";
        Loan: Record "Loans Register";
        banks: Record "Bank Account";
        DefaultInfo: Text[180];
        sHARES: Decimal;
        MonthlyRepayT: Decimal;
        MonthlyRepay: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        RepaySched: Record "Loan Repayment Schedule";
        currYear: Integer;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        Mwezikwisha: Date;
        AvailDep: Decimal;
        LoansOut: Decimal;
        Mdep: Decimal;
        BANDING: Record "Deposit Tier Setup";
        Band: Decimal;
        TotalOutstanding: Decimal;
        Insuarence: Decimal;
        LoanTyped: Record "Loan Products Setup";
        DAY: Integer;
        loannums: Integer;
        Enddates: Date;
        LoanTypes: Record "Loan Products Setup";
        Customer: Record Customer;
        DataSheet: Record "Data Sheet Main";
        Loans: Record "Loans Register";
        Chargeable: Decimal;
        Saccodeduct: Decimal;
        SaccoDedInt: Decimal;
        LoanAppeal: Record "Loans Register";
        HREmp: Record Customer;
        LoansRec: Record "Loans Register";
        TotalLoanOutstanding: Decimal;
        LineNoG: Integer;
        LoansG: Record "Loans Guarantee Details";
        ObjProductDepositLoan: Record "Product Deposit>Loan Analysis";
        ObjLoansRec: Record "Loans Register";
        Dates: Codeunit "Dates Calculation";
        ObjCellGroup: Record "Member House Groups";
        ObjGuarantors: Record "Loans Guarantee Details";
        ObjCust: Record Customer;
        ObjProductCharge: Record "Loan Product Charges";
        LInsurance: Decimal;
        ObjDepositHistory: Record "Member Deposits Saving History";
        ObjAccountLedger: Record "Cust. Ledger Entry";
        ObjStatementB: Record "Member Deposits Saving History";
        StatementStartDate: Date;
        StatementDateFilter: Date;
        StatementEndDate: Date;
        VerStatementAvCredits: Decimal;
        VerStatementsAvDebits: Decimal;
        VerMonth1Date: Integer;
        VerMonth1Month: Integer;
        VerMonth1Year: Integer;
        VerMonth1StartDate: Date;
        VerMonth1EndDate: Date;
        VerMonth1DebitAmount: Decimal;
        VerMonth1CreditAmount: Decimal;
        VerMonth2Date: Integer;
        VerMonth2Month: Integer;
        VerMonth2Year: Integer;
        VerMonth2StartDate: Date;
        VerMonth2EndDate: Date;
        VerMonth2DebitAmount: Decimal;
        VerMonth2CreditAmount: Decimal;
        VerMonth3Date: Integer;
        VerMonth3Month: Integer;
        VerMonth3Year: Integer;
        VerMonth3StartDate: Date;
        VerMonth3EndDate: Date;
        VerMonth3DebitAmount: Decimal;
        VerMonth3CreditAmount: Decimal;
        VerMonth4Date: Integer;
        VerMonth4Month: Integer;
        VerMonth4Year: Integer;
        VerMonth4StartDate: Date;
        VerMonth4EndDate: Date;
        VerMonth4DebitAmount: Decimal;
        VerMonth4CreditAmount: Decimal;
        VerMonth5Date: Integer;
        VerMonth5Month: Integer;
        VerMonth5Year: Integer;
        VerMonth5StartDate: Date;
        VerMonth5EndDate: Date;
        VerMonth5DebitAmount: Decimal;
        VerMonth5CreditAmount: Decimal;
        VerMonth6Date: Integer;
        VerMonth6Month: Integer;
        VerMonth6Year: Integer;
        VerMonth6StartDate: Date;
        VerMonth6EndDate: Date;
        VerMonth6DebitAmount: Decimal;
        VerMonth6CreditAmount: Decimal;
        VarMonth1Datefilter: Text;
        VarMonth2Datefilter: Text;
        VarMonth3Datefilter: Text;
        VarMonth4Datefilter: Text;
        VarMonth5Datefilter: Text;
        VarMonth6Datefilter: Text;
        ObjLoansRec2: Record "Loans Register";
        ObjLoanOffsets: Record "Loan Offset Details";
        VarTotalMonthlyRepayments: Decimal;
        ObjUser: Record User;
        ObjTranchDetails: Record "Tranch Disburesment Details";
        VarTranchNo: Integer;
        ObjLoanStages: Record "Collateral Depr Register";
        ObjGradInt: Record "Graduated Loan Int.";
        Text00001: label 'This loan installments cannot be less than the minimum set installments of %1 months';
        FirstDateOfYear: Date;
        LastDateIssue: Date;
        Text00002: label '%1 loan application is only allowed for dates between %2 and %3.';
        Text00003: label 'The member %1 does not have a valid KRA Pin.Please edit This to continue.';
        AdvanceVisible: Boolean;
        Text00004: label '%1 Loan does not allow Application of an Advance towarsd it.';
        Text00005: label 'You cannot be awarded an advance more than the approved amount of the Main Loan';
        Usersetup: Record "User Setup";
        Text0006: label 'Amount To Disburse Cannot Be Greater Than %1 For %2';


    procedure CreateAnnuityLoan()
    var
        LoanTypeRec: Record "Loan Products Setup";
        LoopEndBool: Boolean;
        LineNoInt: Integer;
        PeriodCode: Code[10];
        InterestAmountDec: Decimal;
        RemainingPrincipalAmountDec: Decimal;
        RepaymentAmountDec: Decimal;
        RoundPrecisionDec: Decimal;
        RoundDirectionCode: Code[10];
    begin
    end;


    procedure DebtService(Principal: Decimal; Interest: Decimal; PayPeriods: Integer): Decimal
    var
        PeriodInterest: Decimal;
    begin
    end;


    procedure GetGracePeriod()
    begin
        IssuedDate := "Loan Disbursement Date";
        GracePeiodEndDate := CalcDate("Grace Period", IssuedDate);
        InstalmentEnddate := CalcDate("Instalment Period", IssuedDate);
        GracePerodDays := GracePeiodEndDate - IssuedDate;
        InstalmentDays := InstalmentEnddate - IssuedDate;
        if InstalmentDays <> 0 then
            NoOfGracePeriod := ROUND(GracePerodDays / InstalmentDays, 1);
    end;


    procedure FlatRateCalc(var FlatLoanAmount: Decimal; var FlatInterestRate: Decimal) FlatRateCalc: Decimal
    begin
    end;

    local procedure SetCurrencyCode(AccType2: Option "G/L Account",Customer,Vendor,"Bank Account"; AccNo2: Code[20]): Boolean
    begin
        /* := '';
        IF AccNo2 <> '' THEN
          CASE AccType2 OF
            AccType2::Customer:
              IF Cust2.GET(AccNo2) THEN
                "Currency Code" := Cust2."Currency Code";
            AccType2::Vendor:
              IF Vend2.GET(AccNo2) THEN
                "Currency Code" := Vend2."Currency Code";
            AccType2::"Bank Account":
              IF BankAcc2.GET(AccNo2) THEN
                "Currency Code" := BankAcc2."Currency Code";
          END;
        EXIT("Currency Code" <> '');
        */

    end;

    local procedure GetCurrency()
    begin
        /*IF "Additional-Currency Posting" =
           "Additional-Currency Posting"::"Additional-Currency Amount Only"
        THEN BEGIN
          IF GLSetup."Additional Reporting Currency" = '' THEN
            GLSetup.GET;
          CurrencyCode := GLSetup."Additional Reporting Currency";
        END ELSE
          CurrencyCode := "Currency Code";
        
        IF CurrencyCode = '' THEN BEGIN
          CLEAR(Currency);
          Currency.InitRoundingPrecision
        END ELSE
          IF CurrencyCode <> Currency.Code THEN BEGIN
            Currency.GET(CurrencyCode);
            Currency.TESTFIELD("Amount Rounding Precision");
          END;
         */

    end;

    local procedure FnGetMemberDepositHistory()
    begin
        //Clear Buffer
        ObjStatementB.Reset;
        ObjStatementB.SetRange(ObjStatementB."Loan No", "Loan  No.");
        if ObjStatementB.FindSet then begin
            ObjStatementB.DeleteAll;
        end;



        //Initialize Variables
        VerMonth1CreditAmount := 0;
        VerMonth1DebitAmount := 0;


        VerMonth4CreditAmount := 0;
        VerMonth4DebitAmount := 0;
        VerMonth5CreditAmount := 0;
        VerMonth5DebitAmount := 0;
        VerMonth6CreditAmount := 0;
        VerMonth6DebitAmount := 0;
        GenSetUp.Get();

        //Month 1
        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
        VerMonth1Date := Date2dmy(StatementStartDate, 1);
        VerMonth1Month := Date2dmy(StatementStartDate, 2);
        VerMonth1Year := Date2dmy(StatementStartDate, 3);


        VerMonth1StartDate := Dmy2date(1, VerMonth1Month, VerMonth1Year);
        VerMonth1EndDate := CalcDate('CM', VerMonth1StartDate);

        VarMonth1Datefilter := Format(VerMonth1StartDate) + '..' + Format(VerMonth1EndDate);
        VerMonth1CreditAmount := 0;
        VerMonth1DebitAmount := 0;
        ObjAccountLedger.Reset;
        ObjAccountLedger.SetRange(ObjAccountLedger."Customer No.", "Client Code");
        ObjAccountLedger.SetRange(ObjAccountLedger."Transaction Type", ObjAccountLedger."transaction type"::"Deposit Contribution");
        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth1Datefilter);
        if ObjAccountLedger.FindSet then begin
            repeat
                if ObjAccountLedger.Amount > 0 then begin
                    VerMonth1DebitAmount := VerMonth1DebitAmount + ObjAccountLedger.Amount
                end else
                    VerMonth1CreditAmount := VerMonth1CreditAmount + ObjAccountLedger.Amount;
            until ObjAccountLedger.Next = 0;

            ObjStatementB.Init;
            ObjStatementB."Loan No" := "Loan  No.";
            ObjStatementB."Transaction Date" := VerMonth1EndDate;
            ObjStatementB."Transaction Description" := 'Month 1 Transactions';
            ObjStatementB."Amount Out" := VerMonth1DebitAmount;
            ObjStatementB."Amount In" := VerMonth1CreditAmount * -1;
            ObjStatementB.Insert;

        end;


        //Month 2
        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
        VerMonth2Date := Date2dmy(StatementStartDate, 1);
        VerMonth2Month := (VerMonth1Month + 1);
        VerMonth2Year := Date2dmy(StatementStartDate, 3);

        if VerMonth2Month > 12 then begin
            VerMonth2Month := VerMonth2Month - 12;
            VerMonth2Year := VerMonth2Year + 1;
        end;

        VerMonth2StartDate := Dmy2date(1, VerMonth2Month, VerMonth1Year);
        VerMonth2EndDate := CalcDate('CM', VerMonth2StartDate);
        VarMonth2Datefilter := Format(VerMonth2StartDate) + '..' + Format(VerMonth2EndDate);
        VerMonth2CreditAmount := 0;
        VerMonth2DebitAmount := 0;
        ObjAccountLedger.Reset;
        ObjAccountLedger.SetRange(ObjAccountLedger."Customer No.", "Client Code");
        ObjAccountLedger.SetRange(ObjAccountLedger."Transaction Type", ObjAccountLedger."transaction type"::"Deposit Contribution");
        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth2Datefilter);
        if ObjAccountLedger.FindSet then begin
            repeat
                if ObjAccountLedger.Amount > 0 then begin
                    VerMonth2DebitAmount := VerMonth2DebitAmount + ObjAccountLedger.Amount
                end else
                    VerMonth2CreditAmount := VerMonth2CreditAmount + ObjAccountLedger.Amount;
            until ObjAccountLedger.Next = 0;

            ObjStatementB.Init;
            ObjStatementB."Loan No" := "Loan  No.";
            ObjStatementB."Transaction Date" := VerMonth2EndDate;
            ObjStatementB."Transaction Description" := 'Month 2 Transactions';
            ObjStatementB."Amount Out" := VerMonth2DebitAmount;
            ObjStatementB."Amount In" := VerMonth2CreditAmount * -1;
            ObjStatementB.Insert;

        end;

        VerMonth3CreditAmount := 0;
        VerMonth3DebitAmount := 0;
        //Month 3
        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
        VerMonth3Date := Date2dmy(StatementStartDate, 1);
        VerMonth3Month := (VerMonth1Month + 2);
        VerMonth3Year := Date2dmy(StatementStartDate, 3);

        if VerMonth3Month > 12 then begin
            VerMonth3Month := VerMonth3Month - 12;
            VerMonth3Year := VerMonth3Year + 1;
        end;

        VerMonth3StartDate := Dmy2date(1, VerMonth3Month, VerMonth3Year);
        VerMonth3EndDate := CalcDate('CM', VerMonth3StartDate);
        VarMonth3Datefilter := Format(VerMonth3StartDate) + '..' + Format(VerMonth3EndDate);
        VerMonth3CreditAmount := 0;
        VerMonth3DebitAmount := 0;
        ObjAccountLedger.Reset;
        ObjAccountLedger.SetRange(ObjAccountLedger."Customer No.", "Client Code");
        ObjAccountLedger.SetRange(ObjAccountLedger."Transaction Type", ObjAccountLedger."transaction type"::"Deposit Contribution");
        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth3Datefilter);
        if ObjAccountLedger.FindSet then begin
            repeat
                if ObjAccountLedger.Amount > 0 then begin
                    VerMonth3DebitAmount := VerMonth3DebitAmount + ObjAccountLedger.Amount
                end else
                    VerMonth3CreditAmount := VerMonth3CreditAmount + ObjAccountLedger.Amount;
            until ObjAccountLedger.Next = 0;

            ObjStatementB.Init;
            ObjStatementB."Loan No" := "Loan  No.";
            ObjStatementB."Transaction Date" := VerMonth3EndDate;
            ObjStatementB."Transaction Description" := 'Month 3 Transactions';
            ObjStatementB."Amount Out" := VerMonth3DebitAmount;
            ObjStatementB."Amount In" := VerMonth3CreditAmount * -1;
            ObjStatementB.Insert;
        end;


        //Month 4
        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
        VerMonth4Date := Date2dmy(StatementStartDate, 1);
        VerMonth4Month := (VerMonth1Month + 3);
        VerMonth4Year := Date2dmy(StatementStartDate, 3);

        if VerMonth4Month > 12 then begin
            VerMonth4Month := VerMonth4Month - 12;
            VerMonth4Year := VerMonth4Year + 1;
        end;

        VerMonth4StartDate := Dmy2date(1, VerMonth4Month, VerMonth4Year);
        VerMonth4EndDate := CalcDate('CM', VerMonth4StartDate);
        VarMonth4Datefilter := Format(VerMonth4StartDate) + '..' + Format(VerMonth4EndDate);

        VerMonth4CreditAmount := 0;
        VerMonth4DebitAmount := 0;
        ObjAccountLedger.Reset;
        ObjAccountLedger.SetRange(ObjAccountLedger."Customer No.", "Client Code");
        ObjAccountLedger.SetRange(ObjAccountLedger."Transaction Type", ObjAccountLedger."transaction type"::"Deposit Contribution");
        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth4Datefilter);
        if ObjAccountLedger.FindSet then begin
            repeat
                if ObjAccountLedger.Amount > 0 then begin
                    VerMonth4DebitAmount := VerMonth4DebitAmount + ObjAccountLedger.Amount
                end else
                    VerMonth4CreditAmount := VerMonth4CreditAmount + ObjAccountLedger.Amount;
            until ObjAccountLedger.Next = 0;

            ObjStatementB.Init;
            ObjStatementB."Loan No" := "Loan  No.";
            ObjStatementB."Transaction Date" := VerMonth4EndDate;
            ObjStatementB."Transaction Description" := 'Month 4 Transactions';
            ObjStatementB."Amount Out" := VerMonth4DebitAmount;
            ObjStatementB."Amount In" := VerMonth4CreditAmount * -1;
            ObjStatementB.Insert;
        end;


        //Month 5
        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
        VerMonth5Date := Date2dmy(StatementStartDate, 1);
        VerMonth5Month := (VerMonth1Month + 4);
        VerMonth5Year := Date2dmy(StatementStartDate, 3);

        if VerMonth5Month > 12 then begin
            VerMonth5Month := VerMonth5Month - 12;
            VerMonth5Year := VerMonth5Year + 1;
        end;

        VerMonth5StartDate := Dmy2date(1, VerMonth5Month, VerMonth5Year);
        VerMonth5EndDate := CalcDate('CM', VerMonth5StartDate);
        VarMonth5Datefilter := Format(VerMonth5StartDate) + '..' + Format(VerMonth5EndDate);

        VerMonth5CreditAmount := 0;
        VerMonth5DebitAmount := 0;
        ObjAccountLedger.Reset;
        ObjAccountLedger.SetRange(ObjAccountLedger."Customer No.", "Client Code");
        ObjAccountLedger.SetRange(ObjAccountLedger."Transaction Type", ObjAccountLedger."transaction type"::"Deposit Contribution");
        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth5Datefilter);
        if ObjAccountLedger.FindSet then begin
            repeat
                if ObjAccountLedger.Amount > 0 then begin
                    VerMonth5DebitAmount := VerMonth5DebitAmount + ObjAccountLedger.Amount
                end else
                    VerMonth5CreditAmount := VerMonth5CreditAmount + ObjAccountLedger.Amount;
            until ObjAccountLedger.Next = 0;

            ObjStatementB.Init;
            ObjStatementB."Loan No" := "Loan  No.";
            ObjStatementB."Transaction Date" := VerMonth5EndDate;
            ObjStatementB."Transaction Description" := 'Month 5 Transactions';
            ObjStatementB."Amount Out" := VerMonth5DebitAmount;
            ObjStatementB."Amount In" := VerMonth5CreditAmount * -1;
            ObjStatementB.Insert;
        end;


        //Month 6
        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
        VerMonth6Date := Date2dmy(StatementStartDate, 1);
        VerMonth6Month := (VerMonth1Month + 5);
        VerMonth6Year := Date2dmy(StatementStartDate, 3);

        if VerMonth6Month > 12 then begin
            VerMonth6Month := VerMonth6Month - 12;
            VerMonth6Year := VerMonth6Year + 1;
        end;

        VerMonth6StartDate := Dmy2date(1, VerMonth6Month, VerMonth6Year);
        VerMonth6EndDate := CalcDate('CM', VerMonth6StartDate);
        VarMonth6Datefilter := Format(VerMonth6StartDate) + '..' + Format(VerMonth6EndDate);

        VerMonth6CreditAmount := 0;
        VerMonth6DebitAmount := 0;
        ObjAccountLedger.Reset;
        ObjAccountLedger.SetRange(ObjAccountLedger."Customer No.", "Client Code");
        ObjAccountLedger.SetRange(ObjAccountLedger."Transaction Type", ObjAccountLedger."transaction type"::"Deposit Contribution");
        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth6Datefilter);
        if ObjAccountLedger.FindSet then begin
            repeat

                if ObjAccountLedger.Amount > 0 then begin
                    VerMonth6DebitAmount := VerMonth6DebitAmount + ObjAccountLedger.Amount
                end else
                    VerMonth6CreditAmount := VerMonth6CreditAmount + ObjAccountLedger.Amount;
            until ObjAccountLedger.Next = 0;

            ObjStatementB.Init;
            ObjStatementB."Loan No" := "Loan  No.";
            ObjStatementB."Transaction Date" := VerMonth6EndDate;
            ObjStatementB."Transaction Description" := 'Month 6 Transactions';
            ObjStatementB."Amount Out" := VerMonth6DebitAmount;
            ObjStatementB."Amount In" := VerMonth6CreditAmount * -1;
            ObjStatementB.Insert;
        end;
    end;

    local procedure FnGetMemberDepositHistory_FOSA()
    begin
        //Clear Buffer
        ObjStatementB.Reset;
        ObjStatementB.SetRange(ObjStatementB."Loan No", "Loan  No.");
        if ObjStatementB.FindSet then begin
            ObjStatementB.DeleteAll;
        end;



        //Initialize Variables
        VerMonth1CreditAmount := 0;
        VerMonth1DebitAmount := 0;


        VerMonth4CreditAmount := 0;
        VerMonth4DebitAmount := 0;
        VerMonth5CreditAmount := 0;
        VerMonth5DebitAmount := 0;
        VerMonth6CreditAmount := 0;
        VerMonth6DebitAmount := 0;
        GenSetUp.Get();

        //Month 1
        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
        VerMonth1Date := Date2dmy(StatementStartDate, 1);
        VerMonth1Month := Date2dmy(StatementStartDate, 2);
        VerMonth1Year := Date2dmy(StatementStartDate, 3);


        VerMonth1StartDate := Dmy2date(1, VerMonth1Month, VerMonth1Year);
        VerMonth1EndDate := CalcDate('CM', VerMonth1StartDate);

        VarMonth1Datefilter := Format(VerMonth1StartDate) + '..' + Format(VerMonth1EndDate);
        VerMonth1CreditAmount := 0;
        VerMonth1DebitAmount := 0;
        ObjAccountLedger.Reset;
        ObjAccountLedger.SetRange(ObjAccountLedger."Customer No.", "BOSA No");
        ObjAccountLedger.SetRange(ObjAccountLedger."Transaction Type", ObjAccountLedger."transaction type"::"Deposit Contribution");
        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth1Datefilter);
        if ObjAccountLedger.FindSet then begin
            repeat
                if ObjAccountLedger.Amount > 0 then begin
                    VerMonth1DebitAmount := VerMonth1DebitAmount + ObjAccountLedger.Amount
                end else
                    VerMonth1CreditAmount := VerMonth1CreditAmount + ObjAccountLedger.Amount;
            until ObjAccountLedger.Next = 0;

            ObjStatementB.Init;
            ObjStatementB."Loan No" := "Loan  No.";
            ObjStatementB."Transaction Date" := VerMonth1EndDate;
            ObjStatementB."Transaction Description" := 'Month 1 Transactions';
            ObjStatementB."Amount Out" := VerMonth1DebitAmount;
            ObjStatementB."Amount In" := VerMonth1CreditAmount * -1;
            ObjStatementB.Insert;

        end;


        //Month 2
        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
        VerMonth2Date := Date2dmy(StatementStartDate, 1);
        VerMonth2Month := (VerMonth1Month + 1);
        VerMonth2Year := Date2dmy(StatementStartDate, 3);

        if VerMonth2Month > 12 then begin
            VerMonth2Month := VerMonth2Month - 12;
            VerMonth2Year := VerMonth2Year + 1;
        end;

        VerMonth2StartDate := Dmy2date(1, VerMonth2Month, VerMonth1Year);
        VerMonth2EndDate := CalcDate('CM', VerMonth2StartDate);
        VarMonth2Datefilter := Format(VerMonth2StartDate) + '..' + Format(VerMonth2EndDate);
        VerMonth2CreditAmount := 0;
        VerMonth2DebitAmount := 0;
        ObjAccountLedger.Reset;
        ObjAccountLedger.SetRange(ObjAccountLedger."Customer No.", "BOSA No");
        ObjAccountLedger.SetRange(ObjAccountLedger."Transaction Type", ObjAccountLedger."transaction type"::"Deposit Contribution");
        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth2Datefilter);
        if ObjAccountLedger.FindSet then begin
            repeat
                if ObjAccountLedger.Amount > 0 then begin
                    VerMonth2DebitAmount := VerMonth2DebitAmount + ObjAccountLedger.Amount
                end else
                    VerMonth2CreditAmount := VerMonth2CreditAmount + ObjAccountLedger.Amount;
            until ObjAccountLedger.Next = 0;

            ObjStatementB.Init;
            ObjStatementB."Loan No" := "Loan  No.";
            ObjStatementB."Transaction Date" := VerMonth2EndDate;
            ObjStatementB."Transaction Description" := 'Month 2 Transactions';
            ObjStatementB."Amount Out" := VerMonth2DebitAmount;
            ObjStatementB."Amount In" := VerMonth2CreditAmount * -1;
            ObjStatementB.Insert;

        end;

        VerMonth3CreditAmount := 0;
        VerMonth3DebitAmount := 0;
        //Month 3
        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
        VerMonth3Date := Date2dmy(StatementStartDate, 1);
        VerMonth3Month := (VerMonth1Month + 2);
        VerMonth3Year := Date2dmy(StatementStartDate, 3);

        if VerMonth3Month > 12 then begin
            VerMonth3Month := VerMonth3Month - 12;
            VerMonth3Year := VerMonth3Year + 1;
        end;

        VerMonth3StartDate := Dmy2date(1, VerMonth3Month, VerMonth3Year);
        VerMonth3EndDate := CalcDate('CM', VerMonth3StartDate);
        VarMonth3Datefilter := Format(VerMonth3StartDate) + '..' + Format(VerMonth3EndDate);
        VerMonth3CreditAmount := 0;
        VerMonth3DebitAmount := 0;
        ObjAccountLedger.Reset;
        ObjAccountLedger.SetRange(ObjAccountLedger."Customer No.", "BOSA No");
        ObjAccountLedger.SetRange(ObjAccountLedger."Transaction Type", ObjAccountLedger."transaction type"::"Deposit Contribution");
        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth3Datefilter);
        if ObjAccountLedger.FindSet then begin
            repeat
                if ObjAccountLedger.Amount > 0 then begin
                    VerMonth3DebitAmount := VerMonth3DebitAmount + ObjAccountLedger.Amount
                end else
                    VerMonth3CreditAmount := VerMonth3CreditAmount + ObjAccountLedger.Amount;
            until ObjAccountLedger.Next = 0;

            ObjStatementB.Init;
            ObjStatementB."Loan No" := "Loan  No.";
            ObjStatementB."Transaction Date" := VerMonth3EndDate;
            ObjStatementB."Transaction Description" := 'Month 3 Transactions';
            ObjStatementB."Amount Out" := VerMonth3DebitAmount;
            ObjStatementB."Amount In" := VerMonth3CreditAmount * -1;
            ObjStatementB.Insert;
        end;


        //Month 4
        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
        VerMonth4Date := Date2dmy(StatementStartDate, 1);
        VerMonth4Month := (VerMonth1Month + 3);
        VerMonth4Year := Date2dmy(StatementStartDate, 3);

        if VerMonth4Month > 12 then begin
            VerMonth4Month := VerMonth4Month - 12;
            VerMonth4Year := VerMonth4Year + 1;
        end;

        VerMonth4StartDate := Dmy2date(1, VerMonth4Month, VerMonth4Year);
        VerMonth4EndDate := CalcDate('CM', VerMonth4StartDate);
        VarMonth4Datefilter := Format(VerMonth4StartDate) + '..' + Format(VerMonth4EndDate);

        VerMonth4CreditAmount := 0;
        VerMonth4DebitAmount := 0;
        ObjAccountLedger.Reset;
        ObjAccountLedger.SetRange(ObjAccountLedger."Customer No.", "BOSA No");
        ObjAccountLedger.SetRange(ObjAccountLedger."Transaction Type", ObjAccountLedger."transaction type"::"Deposit Contribution");
        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth4Datefilter);
        if ObjAccountLedger.FindSet then begin
            repeat
                if ObjAccountLedger.Amount > 0 then begin
                    VerMonth4DebitAmount := VerMonth4DebitAmount + ObjAccountLedger.Amount
                end else
                    VerMonth4CreditAmount := VerMonth4CreditAmount + ObjAccountLedger.Amount;
            until ObjAccountLedger.Next = 0;

            ObjStatementB.Init;
            ObjStatementB."Loan No" := "Loan  No.";
            ObjStatementB."Transaction Date" := VerMonth4EndDate;
            ObjStatementB."Transaction Description" := 'Month 4 Transactions';
            ObjStatementB."Amount Out" := VerMonth4DebitAmount;
            ObjStatementB."Amount In" := VerMonth4CreditAmount * -1;
            ObjStatementB.Insert;
        end;


        //Month 5
        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
        VerMonth5Date := Date2dmy(StatementStartDate, 1);
        VerMonth5Month := (VerMonth1Month + 4);
        VerMonth5Year := Date2dmy(StatementStartDate, 3);

        if VerMonth5Month > 12 then begin
            VerMonth5Month := VerMonth5Month - 12;
            VerMonth5Year := VerMonth5Year + 1;
        end;

        VerMonth5StartDate := Dmy2date(1, VerMonth5Month, VerMonth5Year);
        VerMonth5EndDate := CalcDate('CM', VerMonth5StartDate);
        VarMonth5Datefilter := Format(VerMonth5StartDate) + '..' + Format(VerMonth5EndDate);

        VerMonth5CreditAmount := 0;
        VerMonth5DebitAmount := 0;
        ObjAccountLedger.Reset;
        ObjAccountLedger.SetRange(ObjAccountLedger."Customer No.", "BOSA No");
        ObjAccountLedger.SetRange(ObjAccountLedger."Transaction Type", ObjAccountLedger."transaction type"::"Deposit Contribution");
        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth5Datefilter);
        if ObjAccountLedger.FindSet then begin
            repeat
                if ObjAccountLedger.Amount > 0 then begin
                    VerMonth5DebitAmount := VerMonth5DebitAmount + ObjAccountLedger.Amount
                end else
                    VerMonth5CreditAmount := VerMonth5CreditAmount + ObjAccountLedger.Amount;
            until ObjAccountLedger.Next = 0;

            ObjStatementB.Init;
            ObjStatementB."Loan No" := "Loan  No.";
            ObjStatementB."Transaction Date" := VerMonth5EndDate;
            ObjStatementB."Transaction Description" := 'Month 5 Transactions';
            ObjStatementB."Amount Out" := VerMonth5DebitAmount;
            ObjStatementB."Amount In" := VerMonth5CreditAmount * -1;
            ObjStatementB.Insert;
        end;


        //Month 6
        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
        VerMonth6Date := Date2dmy(StatementStartDate, 1);
        VerMonth6Month := (VerMonth1Month + 5);
        VerMonth6Year := Date2dmy(StatementStartDate, 3);

        if VerMonth6Month > 12 then begin
            VerMonth6Month := VerMonth6Month - 12;
            VerMonth6Year := VerMonth6Year + 1;
        end;

        VerMonth6StartDate := Dmy2date(1, VerMonth6Month, VerMonth6Year);
        VerMonth6EndDate := CalcDate('CM', VerMonth6StartDate);
        VarMonth6Datefilter := Format(VerMonth6StartDate) + '..' + Format(VerMonth6EndDate);

        VerMonth6CreditAmount := 0;
        VerMonth6DebitAmount := 0;
        ObjAccountLedger.Reset;
        ObjAccountLedger.SetRange(ObjAccountLedger."Customer No.", "BOSA No");
        ObjAccountLedger.SetRange(ObjAccountLedger."Transaction Type", ObjAccountLedger."transaction type"::"Deposit Contribution");
        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth6Datefilter);
        if ObjAccountLedger.FindSet then begin
            repeat

                if ObjAccountLedger.Amount > 0 then begin
                    VerMonth6DebitAmount := VerMonth6DebitAmount + ObjAccountLedger.Amount
                end else
                    VerMonth6CreditAmount := VerMonth6CreditAmount + ObjAccountLedger.Amount;
            until ObjAccountLedger.Next = 0;

            ObjStatementB.Init;
            ObjStatementB."Loan No" := "Loan  No.";
            ObjStatementB."Transaction Date" := VerMonth6EndDate;
            ObjStatementB."Transaction Description" := 'Month 6 Transactions';
            ObjStatementB."Amount Out" := VerMonth6DebitAmount;
            ObjStatementB."Amount In" := VerMonth6CreditAmount * -1;
            ObjStatementB.Insert;
        end;
    end;

    local procedure InitInsert()
    begin

        //SURESTEP
        if Source = Source::BOSA then begin

            if "Loan  No." <> xRec."Loan  No." then begin
                SalesSetup.Get;
                NoSeriesMgt.TestManual(SalesSetup."BOSA Loans Nos");
                "No. Series" := '';
            end;

        end else
            if Source = Source::FOSA then begin
                if "Loan  No." <> xRec."Loan  No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."FOSA Loans Nos");
                    "No. Series" := '';
                end;


            end else begin

                if "Loan  No." <> xRec."Loan  No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Micro Loans");
                    "No. Series" := '';
                end;


            end;
        //SURESTEP
    end;

    local procedure FnCalculateQualifyingDeposits(EndDate: Date; MemberNo: Code[10])
    var
        ObjCust: Record Customer;
        Datefilter: Text;
        QualifyingAmount: Decimal;
    begin
    end;

    local procedure fngetmonthlycontrib(MemberNo: Code[20]) Contrib: Decimal
    var
        Cust: Record Customer;
    begin

        Contrib := 0;
        if Cust.Get(MemberNo) then
            Contrib := Cust."Monthly Contribution";
        exit(Contrib);
    end;
}

