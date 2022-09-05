#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 51516473 "Loans Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loans Statement.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") where("Customer Type" = const(FOSA));
            RequestFilterFields = "No.", "Loan Product Filter", "Outstanding Balance";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(No; "Members Register"."No.")
            {
            }
            column(Name; "Members Register".Name)
            {
            }
            dataitem("Loans Register"; "Loans Register")
            {
                DataItemLink = "Client Code" = field("No."), "Loan Product Type" = field("Loan Product Filter");
                column(ReportForNavId_1000000003; 1000000003)
                {
                }
                column(Loan_No; "Loans Register"."Loan  No.")
                {
                }
                column(Loan_Type; "Loans Register"."Loan Product Type")
                {
                }
                column(Approved_Amount; "Loans Register"."Approved Amount")
                {
                }
                dataitem(CustL2; "Cust. Ledger Entry")
                {
                    DataItemLink = "Member No." = field("Client Code"), "Posting Date" = field("Date filter"), "Loan No" = field("Loan  No.");
                    column(ReportForNavId_1000000012; 1000000012)
                    {
                    }
                    column(Posting_Date; CustL2."Posting Date")
                    {
                    }
                    column(Document_No; CustL2."Document No.")
                    {
                    }
                    column(Description; CustL2.Description)
                    {
                    }
                    column(Amount; CustL2.Amount)
                    {
                    }
                    column(OpeningBal; OpeningBal)
                    {
                    }
                    column(DataItem1000000013; CustL2.Amount)
                    {
                    }
                    column(ClosingBal; ClosingBal)
                    {
                    }
                }
                dataitem(CustL3; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Posting Date" = field("Date filter"), "Loan No" = field("Loan  No.");
                    DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("Interest Due" | "Interest Paid"));
                    column(ReportForNavId_1000000022; 1000000022)
                    {
                    }
                    column(DataItem1000000021; CustL2."Posting Date")
                    {
                    }
                    column(DataItem1000000020; CustL2."Document No.")
                    {
                    }
                    column(DataItem1000000019; CustL2.Description)
                    {
                    }
                    column(DataItem1000000018; CustL2.Amount)
                    {
                    }
                    column(DataItem1000000017; OpeningBal)
                    {
                    }
                    column(DataItem1000000016; CustL2.Amount)
                    {
                    }
                    column(DataItem1000000015; ClosingBal)
                    {
                    }
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
}

