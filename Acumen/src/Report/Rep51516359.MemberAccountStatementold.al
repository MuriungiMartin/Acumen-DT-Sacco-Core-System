#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516359_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516359 "Member Account Statement-old"
{
    RDLCLayout = './Layouts/MemberAccountStatement-old.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Loan Product Filter", "Outstanding Balance", "Date Filter";
            column(ReportForNavId_1102755000; 1102755000) { } // Autogenerated by ForNav - Do not delete
            column(UserId; UserId)
            {
            }
            column(Status; Customer.Status)
            {
            }
            column(PayrollStaffNo_Members; Customer."Personal No")
            {
            }
            column(No_Members; Customer."No.")
            {
            }
            column(Name_Members; Customer.Name)
            {
            }
            column(EmployerCode_Members; Customer."Employer Code")
            {
            }
            column(PageNo_Members; Format(ReportForNav.PageNo))
            {
            }
            column(Shares_Retained; Customer."Shares Retained")
            {
            }
            column(ShareCapBF; ShareCapBF)
            {
            }
            column(IDNo_Members; Customer."ID No.")
            {
            }
            column(GlobalDimension2Code_Members; Customer."Global Dimension 2 Code")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            dataitem(Shares; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("Recovery Account"), Reversed = filter(false));
                column(ReportForNavId_1102755022; 1102755022) { } // Autogenerated by ForNav - Do not delete
                column(openBalances; OpenBalance)
                {
                }
                column(CLosingBalances; CLosingBalance)
                {
                }
                column(Description_Shares; Shares.Description)
                {
                }
                column(DocumentNo_Shares; Shares."Document No.")
                {
                }
                column(PostingDate_Shares; Shares."Posting Date")
                {
                }
                column(CreditAmount_Shares; Shares."Credit Amount")
                {
                }
                column(DebitAmount_Shares; Shares."Debit Amount")
                {
                }
                column(Amount_Shares; Shares.Amount)
                {
                }
                column(TransactionType_Shares; Shares."Transaction Type")
                {
                }
                column(Shares_Description; Shares.Description)
                {
                }
                column(USER1; Shares."User ID")
                {
                }
                column(ShareCapBF2; ShareCapBF)
                {
                }
                trigger OnPreDataItem();
                begin
                    CLosingBalance := ShareCapBF;
                    OpeningBal := ShareCapBF * -1;
                end;

                trigger OnAfterGetRecord();
                begin
                    CLosingBalance := CLosingBalance - Shares.Amount;
                end;

            }
            dataitem(Deposits; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const(Loan), Reversed = filter(false));
                PrintOnlyIfDetail = false;
                column(ReportForNavId_1102755004; 1102755004) { } // Autogenerated by ForNav - Do not delete
                column(OpeningBal; OpeningBal)
                {
                }
                column(ClosingBal; ClosingBal)
                {
                }
                column(TransactionType_Deposits; Deposits."Transaction Type")
                {
                }
                column(Amount_Deposits; Deposits.Amount)
                {
                }
                column(Description_Deposits; Deposits.Description)
                {
                }
                column(DocumentNo_Deposits; Deposits."Document No.")
                {
                }
                column(PostingDate_Deposits; Deposits."Posting Date")
                {
                }
                column(DebitAmount_Deposits; Deposits."Debit Amount")
                {
                }
                column(CreditAmount_Deposits; Deposits."Credit Amount")
                {
                }
                column(Deposits_Description; Deposits.Description)
                {
                }
                column(USER2; Deposits."User ID")
                {
                }
                trigger OnPreDataItem();
                begin
                    ClosingBal := SharesBF;
                    OpeningBal := SharesBF * -1;
                end;

                trigger OnAfterGetRecord();
                begin
                    ClosingBal := ClosingBal + Deposits.Amount;
                end;

            }
            dataitem(Risk; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("Benevolent Fund"), Reversed = filter(false));
                column(ReportForNavId_1102755055; 1102755055) { } // Autogenerated by ForNav - Do not delete
                column(OpenBalancesRisk; OpenBalanceRisk)
                {
                }
                column(CLosingBalancesRisk; CLosingBalanceRisk)
                {
                }
                column(Description_Risk; Risk.Description)
                {
                }
                column(DocumentNo_Risk; Risk."Document No.")
                {
                }
                column(PostingDate_Risk; Risk."Posting Date")
                {
                }
                column(CreditAmount_Risk; Risk."Credit Amount")
                {
                }
                column(DebitAmount_Risk; Risk."Debit Amount")
                {
                }
                column(Amount_Risk; Risk.Amount)
                {
                }
                column(TransactionType_Risk; Risk."Transaction Type")
                {
                }
                column(USER3; Risk."User ID")
                {
                }
                trigger OnPreDataItem();
                begin
                    CLosingBalanceRisk := RiskBF;
                    OpenBalanceRisk := RiskBF * -1;
                end;

                trigger OnAfterGetRecord();
                begin
                    CLosingBalanceRisk := CLosingBalanceRisk - Risk.Amount;
                    Message('CLosingBalanceRisk ISACTIVE %1', CLosingBalanceRisk);
                end;

            }
            // dataitem(HousingWater; "Cust. Ledger Entry")
            // {
            //     DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
            //     DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("31"), Reversed = filter(false));
            //     column(ReportForNavId_1000000016; 1000000016) { } // Autogenerated by ForNav - Do not delete
            //     column(OpenBalancesHse; OpenBalanceHse)
            //     {
            //     }
            //     column(CLosingBalancesHse; CLosingBalanceHse)
            //     {
            //     }
            //     column(DescriptionHse; HousingWater.Description)
            //     {
            //     }
            //     column(DocumentNoHse; HousingWater."Document No.")
            //     {
            //     }
            //     column(PostingDateHse; HousingWater."Posting Date")
            //     {
            //     }
            //     column(CreditAmountHse; HousingWater."Credit Amount")
            //     {
            //     }
            //     column(DebitAmountHse; HousingWater."Debit Amount")
            //     {
            //     }
            //     column(AmountHse; HousingWater.Amount)
            //     {
            //     }
            //     column(TransactionTypeHse; HousingWater."Transaction Type")
            //     {
            //     }
            //     column(USER4; HousingWater."User ID")
            //     {
            //     }
            //     trigger OnPreDataItem();
            //     begin
            //         CLosingBalanceHse := HseBF;
            //         OpenBalanceHse := HseBF * -1;
            //     end;

            //     trigger OnAfterGetRecord();
            //     begin
            //         CLosingBalanceHse := CLosingBalanceHse - HousingWater.Amount;
            //     end;

            // }
            // dataitem(Konza; "Cust. Ledger Entry")
            // {
            //     DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
            //     DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("30"), Reversed = filter(false));
            //     column(ReportForNavId_1102755066; 1102755066) { } // Autogenerated by ForNav - Do not delete
            //     column(OpenBalancesKonza; OpenBalanceHse)
            //     {
            //     }
            //     column(CLosingBalancesKonza; CLosingBalanceHse)
            //     {
            //     }
            //     column(DescriptionKonza; Konza.Description)
            //     {
            //     }
            //     column(DocumentNoKonza; Konza."Document No.")
            //     {
            //     }
            //     column(PostingDateKonza; Konza."Posting Date")
            //     {
            //     }
            //     column(CreditAmountKonza; Konza."Credit Amount")
            //     {
            //     }
            //     column(DebitAmountKonza; Konza."Debit Amount")
            //     {
            //     }
            //     column(AmountKonza; Konza.Amount)
            //     {
            //     }
            //     column(TransactionTypeKonza; Konza."Transaction Type")
            //     {
            //     }
            //     trigger OnPreDataItem();
            //     begin
            //         CLosingBalanceHse := HseBF;
            //         OpenBalanceHse := HseBF * -1;
            //     end;

            //     trigger OnAfterGetRecord();
            //     begin
            //         CLosingBalanceHse := CLosingBalanceHse - Konza.Amount;
            //     end;

            // }
            // dataitem(Lukenya; "Cust. Ledger Entry")
            // {
            //     DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
            //     DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("29"), Reversed = filter(false));
            //     column(ReportForNavId_1102755076; 1102755076) { } // Autogenerated by ForNav - Do not delete
            //     column(OpenBalancesLukenya; OpenBalanceHse)
            //     {
            //     }
            //     column(CLosingBalancesLukenya; CLosingBalanceHse)
            //     {
            //     }
            //     column(DescriptionLukenya; Lukenya.Description)
            //     {
            //     }
            //     column(DocumentNoLukenya; Lukenya."Document No.")
            //     {
            //     }
            //     column(PostingDateLukenya; Lukenya."Posting Date")
            //     {
            //     }
            //     column(CreditAmountLukenya; Lukenya."Credit Amount")
            //     {
            //     }
            //     column(DebitAmountLukenya; Lukenya."Debit Amount")
            //     {
            //     }
            //     column(AmountLukenya; Lukenya.Amount)
            //     {
            //     }
            //     column(TransactionTypeLukenya; Lukenya."Transaction Type")
            //     {
            //     }
            //     trigger OnPreDataItem();
            //     begin
            //         CLosingBalanceHse := HseBF;
            //         OpenBalanceHse := HseBF * -1;
            //     end;

            //     trigger OnAfterGetRecord();
            //     begin
            //         CLosingBalanceHse := CLosingBalanceHse - Lukenya.Amount;
            //     end;

            // }
            // dataitem(HousingMain; "Cust. Ledger Entry")
            // {
            //     DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
            //     DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("34"), Reversed = filter(false));
            //     column(ReportForNavId_1000000026; 1000000026) { } // Autogenerated by ForNav - Do not delete
            //     column(OpenBalancesDep1; OpenBalanceDep1)
            //     {
            //     }
            //     column(CLosingBalancesDep1; CLosingBalanceDep1)
            //     {
            //     }
            //     column(DescriptionDep1; HousingMain.Description)
            //     {
            //     }
            //     column(DocumentNoDep1; HousingMain."Document No.")
            //     {
            //     }
            //     column(PostingDateDep1; HousingMain."Posting Date")
            //     {
            //     }
            //     column(CreditAmountDep1; HousingMain."Credit Amount")
            //     {
            //     }
            //     column(DebitAmountDep1; HousingMain."Debit Amount")
            //     {
            //     }
            //     column(AmountDep1; HousingMain.Amount)
            //     {
            //     }
            //     column(TransactionTypeDep1; HousingMain."Transaction Type")
            //     {
            //     }
            //     trigger OnPreDataItem();
            //     begin
            //         CLosingBalanceHse := Dep1BF;
            //         OpenBalanceHse := Dep1BF * -1;
            //     end;

            //     trigger OnAfterGetRecord();
            //     begin
            //         CLosingBalanceHse := CLosingBalanceHse - HousingMain.Amount;
            //     end;

            // }
            // dataitem(HousingTitle; "Cust. Ledger Entry")
            // {
            //     DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
            //     DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = filter("33"), Reversed = filter(false));
            //     column(ReportForNavId_1000000036; 1000000036) { } // Autogenerated by ForNav - Do not delete
            //     column(OpenBalancesDep2; OpenBalanceDep2)
            //     {
            //     }
            //     column(CLosingBalancesDep2; CLosingBalanceDep2)
            //     {
            //     }
            //     column(DescriptionDep2; HousingTitle.Description)
            //     {
            //     }
            //     column(DocumentNoDep2; HousingTitle."Document No.")
            //     {
            //     }
            //     column(PostingDateDep2; HousingTitle."Posting Date")
            //     {
            //     }
            //     column(CreditAmountDep2; HousingTitle."Credit Amount")
            //     {
            //     }
            //     column(DebitAmountDep2; HousingTitle."Debit Amount")
            //     {
            //     }
            //     column(AmountDep2; HousingTitle.Amount)
            //     {
            //     }
            //     column(TransactionTypeDep2; HousingTitle."Transaction Type")
            //     {
            //     }
            //     trigger OnPreDataItem();
            //     begin
            //         CLosingBalanceDep2 := Dep2BF;
            //         OpenBalanceDep2 := Dep2BF * -1;
            //     end;

            //     trigger OnAfterGetRecord();
            //     begin
            //         CLosingBalanceDep2 := CLosingBalanceDep2 - HousingTitle.Amount;
            //     end;

            // }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = field("No."), "Loan Product Type" = field("Loan Product Filter"), "Date filter" = field("Date Filter");
                DataItemTableView = sorting("Loan  No.") where(Posted = const(true), "Loan  No." = filter(<> '"'));
                column(ReportForNavId_1102755024; 1102755024) { } // Autogenerated by ForNav - Do not delete
                column(PrincipleBF; PrincipleBF)
                {
                }
                column(LoanNumber; Loans."Loan  No.")
                {
                }
                column(ProductType; Loans."Loan Product Type Name")
                {
                }
                column(RequestedAmount; Loans."Requested Amount")
                {
                }
                column(Interest; Loans.Interest)
                {
                }
                column(Installments; Loans.Installments)
                {
                }
                column(LoanPrincipleRepayment; Loans."Loan Principle Repayment")
                {
                }
                column(ApprovedAmount_Loans; Loans."Approved Amount")
                {
                }
                column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
                {
                }
                column(Repayment_Loans; Loans.Repayment)
                {
                }
                column(ModeofDisbursement_Loans; Loans."Mode of Disbursement")
                {
                }
                column(USER5; loan."User ID")
                {
                }
                dataitem(loan; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Loan No" = field("Loan  No."), "Posting Date" = field("Date filter");
                    DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("Share Capital" | "Interest Paid"), Reversed = filter(false), "Loan No" = filter(<> ''), Description = filter(<> 'Interest on salary advance'));
                    column(ReportForNavId_1102755031; 1102755031) { } // Autogenerated by ForNav - Do not delete
                    column(PostingDate_loan; loan."Posting Date")
                    {
                    }
                    column(DocumentNo_loan; loan."Document No.")
                    {
                    }
                    column(Description_loan; loan.Description)
                    {
                    }
                    column(DebitAmount_Loan; loan."Debit Amount")
                    {
                    }
                    column(CreditAmount_Loan; loan."Credit Amount")
                    {
                    }
                    column(Amount_Loan; loan.Amount)
                    {
                    }
                    column(openBalance_loan; OpenBalance)
                    {
                    }
                    column(CLosingBalance_loan; CLosingBalance)
                    {
                    }
                    column(TransactionType_loan; loan."Transaction Type")
                    {
                    }
                    column(LoanNo; loan."Loan No")
                    {
                    }
                    column(PrincipleBF_loans; PrincipleBF)
                    {
                    }
                    column(Loan_Description; loan.Description)
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        CLosingBalance := PrincipleBF;
                        OpeningBal := PrincipleBF;
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        /*CLosingBalance:=CLosingBalance+loan.Amount;
						ClosingBalInt:=ClosingBalInt+loan.Amount;
						//interest
						ClosingBal:=ClosingBal+LoanInterest.Amount;
						OpeningBal:=ClosingBal-LoanInterest.Amount;
						*/
                        CLosingBalance := CLosingBalance + loan.Amount;
                        if Loans."Loan  No." = '' then begin
                        end;
                        if loan."Transaction Type" = loan."transaction type"::"Insurance Contribution" then begin
                            InterestPaid := loan."Credit Amount";
                            SumInterestPaid := InterestPaid + SumInterestPaid;
                        end;
                        if loan."Transaction Type" = loan."transaction type"::"Interest Paid" then begin
                            loan."Credit Amount" := loan."Credit Amount"//+InterestPaid;
                        end;

                    end;

                }
                dataitem(Interest; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Loan No" = field("Loan  No."), "Posting Date" = field("Date filter");
                    DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = filter("Deposit Contribution" | "Insurance Contribution"), Reversed = filter(false), "Loan No" = filter(<> ''), Description = filter(<> 'Interest on salary advance'));
                    column(ReportForNavId_1102755077; 1102755077) { } // Autogenerated by ForNav - Do not delete
                    column(PostingDate_Interest; Interest."Posting Date")
                    {
                    }
                    column(DocumentNo_Interest; Interest."Document No.")
                    {
                    }
                    column(Description_Interest; Interest.Description)
                    {
                    }
                    column(DebitAmount_Interest; Interest."Debit Amount")
                    {
                    }
                    column(CreditAmount_Interest; Interest."Credit Amount")
                    {
                    }
                    column(Amount_Interest; Interest.Amount)
                    {
                    }
                    column(OpeningBalInt; OpeningBalInt)
                    {
                    }
                    column(ClosingBalInt; ClosingBalInt)
                    {
                    }
                    column(TransactionType_Interest; Interest."Transaction Type")
                    {
                    }
                    column(LoanNo_Interest; Interest."Loan No")
                    {
                    }
                    column(InterestBF; InterestBF)
                    {
                    }
                }
                trigger OnPreDataItem();
                begin
                    Loans.SetFilter(Loans."Date filter", Customer.GetFilter(Customer."Date Filter"));
                end;

                trigger OnAfterGetRecord();
                begin
                    if DateFilterBF <> '' then begin
                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
                        LoansR.SetFilter(LoansR."Date filter", DateFilterBF);
                        if LoansR.Find('-') then begin
                            LoansR.CalcFields(LoansR."Outstanding Balance");
                            PrincipleBF := LoansR."Outstanding Balance";
                            //InterestBF:=LoansR."Interest Paid";
                        end;
                    end;
                end;

            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Member No" = field("No.");
                column(ReportForNavId_1000000042; 1000000042) { } // Autogenerated by ForNav - Do not delete
                column(LoanNumb; "Loans Guarantee Details"."Loan No")
                {
                }
                column(MembersNo; "Loans Guarantee Details"."Member No")
                {
                }
                column(Name; "Loans Guarantee Details".Name)
                {
                }
                column(LBalance; "Loans Guarantee Details"."Loan Balance")
                {
                }
                column(Shares; "Loans Guarantee Details".Shares)
                {
                }
                column(LoansGuaranteed; "Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Substituted; "Loans Guarantee Details".Substituted)
                {
                }
            }
            trigger OnPreDataItem();
            begin
                if Customer.GetFilter(Customer."Date Filter") <> '' then
                    DateFilterBF := '..' + Format(CalcDate('-1D', Customer.GetRangeMin(Customer."Date Filter")));
            end;

            trigger OnAfterGetRecord();
            begin
                SharesBF := 0;
                InsuranceBF := 0;
                ShareCapBF := 0;
                RiskBF := 0;
                HseBF := 0;
                Dep1BF := 0;
                Dep2BF := 0;
                if DateFilterBF <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", "No.");
                    Cust.SetFilter(Cust."Date Filter", DateFilterBF);
                    if Cust.Find('-') then begin
                        Cust.CalcFields(Cust."Shares Retained", Cust."Current Shares", Cust."Insurance Fund");
                        SharesBF := Cust."Current Shares";
                        ShareCapBF := Cust."Shares Retained";
                        RiskBF := Cust."Insurance Fund";
                        //XmasBF:=Cust."Holiday Savings";
                        //HseBF:=Cust."Household Item Deposit";
                        //Dep1BF:=Cust."Dependant 1";
                        //Dep2BF:=Cust."Dependant 2";
                    end;
                end;
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ForNavOpenDesigner; ReportForNavOpenDesigner)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Design';
                        Visible = ReportForNavAllowDesign;
                        trigger OnValidate()
                        begin
                            ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
                            CurrReport.RequestOptionsPage.Close();
                        end;

                    }
                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            ReportForNavOpenDesigner := false;
        end;
    }

    trigger OnInitReport()
    begin
        ;
        ReportsForNavInit;

    end;

    trigger OnPostReport()
    begin
        ;
        ReportForNav.Post;
    end;

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
        ;
        ReportsForNavPre;
    end;

    var
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        Cust: Record Customer;
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record "Loans Register";
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        LoanBF: Decimal;
        PrincipleBF: Decimal;
        InterestBF: Decimal;
        ShowZeroBal: Boolean;
        ClosingBalSHCAP: Decimal;
        ShareCapBF: Decimal;
        RiskBF: Decimal;
        Company: Record "Company Information";
        OpenBalanceHse: Decimal;
        CLosingBalanceHse: Decimal;
        OpenBalanceDep1: Decimal;
        CLosingBalanceDep1: Decimal;
        OpenBalanceDep2: Decimal;
        CLosingBalanceDep2: Decimal;
        HseBF: Decimal;
        Dep1BF: Decimal;
        Dep2BF: Decimal;
        OpeningBalInt: Decimal;
        ClosingBalInt: Decimal;
        InterestPaid: Decimal;
        SumInterestPaid: Decimal;
        OpenBalanceRisk: Decimal;
        CLosingBalanceRisk: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516359_v6_3_0_2259;
        ReportForNavOpenDesigner: Boolean;
        [InDataSet]
        ReportForNavAllowDesign: Boolean;

    local procedure ReportsForNavInit();
    var
        ApplicationSystemConstants: Codeunit "Application System Constants";
        addInFileName: Text;
        tempAddInFileName: Text;
        path: DotNet Path;
        ReportForNavObject: Variant;
    begin
        addInFileName := ApplicationPath() + 'Add-ins\ReportsForNAV_6_3_0_2259\ForNav.Reports.6.3.0.2259.dll';
        if not File.Exists(addInFileName) then begin
            tempAddInFileName := path.GetTempPath() + '\Microsoft Dynamics NAV\Add-Ins\' + ApplicationSystemConstants.PlatformFileVersion() + '\ForNav.Reports.6.3.0.2259.dll';
            if not File.Exists(tempAddInFileName) then
                Error('Please install the ForNAV DLL version 6.3.0.2259 in your service tier Add-ins folder under the file name "%1"\\If you already have the ForNAV DLL on the server, you should move it to this folder and rename it to match this file name.', addInFileName);
        end;
        ReportForNavObject := ReportForNav.GetLatest(CurrReport.OBJECTID, CurrReport.Language, SerialNumber, UserId, CompanyName);
        ReportForNav := ReportForNavObject;
        ReportForNav.Init();
    end;

    local procedure ReportsForNavPre();
    begin
        ReportForNav.OpenDesigner := ReportForNavOpenDesigner;
        if not ReportForNav.Pre() then CurrReport.Quit();
    end;

    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
