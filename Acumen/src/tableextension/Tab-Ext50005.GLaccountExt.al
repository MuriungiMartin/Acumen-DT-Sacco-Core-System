tableextension 50005 "GLaccountExt" extends "G/L Account"
{
    fields
    {
        // Add changes to table fields here
        field(27001; StatementofFP; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Cashinhand,Cashatbank,GovernmentSecurities,Placement ,CommercialPapers,CollectiveInvestment,Derivatives,EquityInvestments,Investmentincompanies,GrossLoanPortfolio,AllowanceforLoanLoss,PropertyEquipment,InvestmentProperties,OtherAssets,IntangibleAssets,PrepaymentsSundryReceivables';
            OptionMembers = " ",Cashinhand,Cashatbank,GovernmentSecurities,Placement,CommercialPapers,"CollectiveInvestment ",Derivatives,EquityInvestments,Investmentincompanies,GrossLoanPortfolio,AllowanceforLoanLoss,PropertyEquipment,"InvestmentProperties ",OtherAssets,IntangibleAssets,PrepaymentsSundryReceivables;
        }
        field(27002; StatementOfFP2; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,ShareCapital,Nonwithdrawabledeposits,PriorYearsRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,ProposedDividends,AdjustmenttoEquity,OtherLiabilities,ExternalBorrowings,TaxPayable';
            OptionMembers = " ",ShareCapital,Nonwithdrawabledeposits,PriorYearsRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,ProposedDividends,AdjustmenttoEquity,OtherLiabilities,ExternalBorrowings,TaxPayable;
        }
        field(27003; StatementOFCIncome; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,InterestonLoanPortfolio,FeesCommissiononLoanPortfolio,GovernmentSecurities,PlacementinBanks,InvestmentinCompaniesshares,EquityInvestments,InterestExpenseonDeposits,CostofExternalBorrowings,DividendExpenses,OtherFinancialExpense,FeesCommissionExpense,OtherExpense';
            OptionMembers = " ",InterestonLoanPortfolio,FeesCommissiononLoanPortfolio,GovernmentSecurities,PlacementinBanks,InvestmentinCompaniesshares,EquityInvestments,InterestExpenseonDeposits,CostofExternalBorrowings,DividendExpenses,OtherFinancialExpense,FeesCommissionExpense,OtherExpense;
        }
        field(27004; StatementOFCIncome2; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,ProvisionforLoanLosses,AllowanceforLoanLoss,PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,NonOperatingIncome,NonOperatingExpense';
            OptionMembers = " ",ProvisionforLoanLosses,AllowanceforLoanLoss,PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,NonOperatingIncome,NonOperatingExpense;
        }
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
        }
        field(54248; "Old No."; Code[20])
        {
        }
        field(54249; "Date Created"; Date)
        {
        }
        field(54250; "Created By"; Code[20])
        {
        }
        field(54251; FORM2B; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Treasury,Teller,Placements,ATM & Mobile,BOSA,FOSA,Normal Bank';
            OptionMembers = " ",Treasury,Teller,Placements,"ATM & Mobile",BOSA,FOSA,"Normal Bank";
        }

    }

    var
        myInt: Integer;
}