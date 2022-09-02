#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Query 50042 "myGuarantorsRequest"
{

    elements
    {
        dataitem(Loans_Guarantee_Details;"Loans Guarantee Details")
        {
            column(Loan_No;"Loan No")
            {
            }
            column(Amont_Guaranteed;"Amont Guaranteed")
            {
            }
            column(Loanees_Name;"Loanees  Name")
            {
            }
            column(Loan_Application_Date;"Loan Application Date")
            {
            }
            column(Member_No;"Member No")
            {
            }
            column(Loanees_No;"Loanees  No")
            {
            }
            column(Name;Name)
            {
            }
            dataitem(Loans_Register;"Loans Register")
            {
                DataItemLink = "Loan  No."=Loans_Guarantee_Details."Loan No";
                column(Requested_Amount;"Requested Amount")
                {
                }
                column(Loan_Product_Type_Name;"Loan Product Type Name")
                {
                }
                dataitem(Loans_Purpose;"Loans Purpose")
                {
                    DataItemLink = Code=Loans_Register."Loan Purpose";
                    column(LoanPurpose;Description)
                    {
                    }
                }
            }
        }
    }
}

