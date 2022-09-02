tableextension 50005 "GLaccountExt" extends "G/L Account"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Budget Controlled"; Boolean)
        {
        }
        field(50004; "Expense Code"; Code[10])
        {
            TableRelation = "Expense Code";

            trigger OnValidate()
            begin
                //Expense code only applicable if account type is posting and Budgetary control is applicable
                TestField("Account Type", "account type"::Posting);
                TestField("Budget Controlled", true);
            end;
        }
        field(50005; "Donor defined Account"; Boolean)
        {
            Description = 'Select if the Account is donor Defined';
        }
        field(54244; test; Code[20])
        {
        }
        field(54245; "Grant Expense"; Boolean)
        {
        }
        field(54246; Status; Option)
        {
            Editable = true;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(54247; "Responsibility Center"; Code[20])
        {
            //TableRelation = Table55929.Field1;
        }
        field(54248; "Old No."; Code[20])
        {
        }
        field(54249; "Date Created"; Date)
        {
        }
        field(54250; "Created By"; Code[70])
        {
        }
        field(54251; "Capital adequecy"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,ShareCapital,StatutoryReserve,RetainedEarnings,NetSurplusaftertax,LoansandAdvances,Cash,InvestmentsinSubsidiary,Otherreserves,GovernmentSecurities,DepositsandBalancesatOtherInstitutions,OtherAssets,PropertyandEquipment,TotalDepositsLiabilities';
            OptionMembers = "  ",ShareCapital,StatutoryReserve,RetainedEarnings,NetSurplusaftertax,LoansandAdvances,Cash,InvestmentsinSubsidiary,Otherreserves,GovernmentSecurities,DepositsandBalancesatOtherInstitutions,Otherassets,PropertyandEquipment,TotalDepositsLiabilities;
        }
        field(54252; "Form2F(Statement of C Income)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,InterestonLoanPortfolio,FeesCommissiononLoanPortfolio,GovernmentSecurities,InvestmentinCompaniesshares,nterestExpenseonDeposits,DividendExpenses,OtherFinancialExpense,FeesCommissionExpense,OtherExpense,ProvisionforLoanLosses';
            OptionMembers = "  ",InterestonLoanPortfolio,FeesCommissiononLoanPortfolio,GovernmentSecurities,InvestmentinCompaniesshares,nterestExpenseonDeposits,DividendExpenses,OtherFinancialExpense,FeesCommissionExpense,OtherExpense,ProvisionforLoanLosses;
        }
        field(54253; "Form2F1(Statement of C Income)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,Donations,PlacementinBanks,CostofExternalBorrowings,EquityInvestmentsinsubsidiaries';
            OptionMembers = "  ",PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,Donations,PlacementinBanks,CostofExternalBorrowings,EquityInvestmentsinsubsidiaries;
        }
        field(54254; "Form2E(investment)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Core_Capital,Nonearningassets,totaldeposits,subsidiaryandrelatedentities,Equityinvestment,Otherinvestments,otherassets';
            OptionMembers = " ",Core_Capital,Nonearningassets,totaldeposits,subsidiaryandrelatedentities,Equityinvestment,Otherinvestments,otherassets;
        }
        field(54255; "Form2E(investment)New"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Nonearningassets';
            OptionMembers = " ",Nonearningassets;
        }
        field(54256; "Form2E(investment)Land"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,LandBuilding';
            OptionMembers = " ",LandBuilding;
        }
        field(54257; Liquidity; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,TotalOtherliabilitiesNew,TimeDeposits,balanceswithotherfinancialinsti,GovSecurities,BankBalances,LocalNotes,OverdraftsandMaturedLoans';
            OptionMembers = " ",TotalOtherliabilitiesNew,TimeDeposits,balanceswithotherfinancialinsti,GovSecurities,BankBalances,LocalNotes,OverdraftsandMaturedLoans;
        }
        field(54258; StatementOfFP; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Cashinhand,Cashatbank,GrossLoanPortfolio,PropertyEquipment,AllowanceforLoanLoss,PrepaymentsSundryReceivables,Investmentincompanies,Other Assets,IntangibleAssets,ExternalBorrowings,Placement,EquityInvestments,DividendPayable,CurrentYearSurplus';
            OptionMembers = "  ",Cashinhand,Cashatbank,GrossLoanPortfolio,PropertyEquipment,AllowanceforLoanLoss,PrepaymentsSundryReceivables,Investmentincompanies,"Other Assets",IntangibleAssets,ExternalBorrowings,Placement,EquityInvestments,DividendPayable,CurrentYearSurplus;
        }
        field(54259; StatementOfFP2; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Nonwithdrawabledeposits,ShareCapital,PrioryarRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,TaxPayable,OtherLiabilities';
            OptionMembers = " ",Nonwithdrawabledeposits,ShareCapital,PrioryarRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,TaxPayable,OtherLiabilities;
        }
        field(54260; "Form 2H other disc"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Core_Cpital,Liquidity,Depositliabilites,Otherliablilities,CoreCapitalDeduction,AllowanceForLoanLoss';
            OptionMembers = " ",Core_Cpital,Liquidity,Depositliabilites,Otherliablilities,CoreCapitalDeduction,AllowanceForLoanLoss;
        }

    }

    var
        myInt: Integer;
}