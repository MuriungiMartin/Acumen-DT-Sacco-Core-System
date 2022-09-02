#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516036 "Posted FD Processing List"
{
    ApplicationArea = Basic;
    CardPageID = "Posted FD Processing Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "FD Processing";
    SourceTableView = order(ascending)
                      where("FDR Deposit Status Type"=const(Running),
                            "FDR Deposit Status Type"=const(Terminated));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No.";"Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.";"Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Filter";"Global Dimension 1 Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Filter";"Global Dimension 2 Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Personal No.";"Personal No.")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Status";"Fixed Deposit Status")
                {
                    ApplicationArea = Basic;
                }
                field("Call Deposit";"Call Deposit")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No";"Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account No";"BOSA Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category";"Account Category")
                {
                    ApplicationArea = Basic;
                }
                field("FD Marked for Closure";"FD Marked for Closure")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Maturity Date";"Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail (Personal)";"E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Type";"Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Earned";"Interest Earned")
                {
                    ApplicationArea = Basic;
                }
                field("Untranfered Interest";"Untranfered Interest")
                {
                    ApplicationArea = Basic;
                }
                field("FD Maturity Date";"FD Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Account No.";"Savings Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Transfer";"Amount to Transfer")
                {
                    ApplicationArea = Basic;
                }
                field("Neg. Interest Rate";"Neg. Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Duration";"Fixed Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Date Renewed";"Date Renewed")
                {
                    ApplicationArea = Basic;
                }
                field("Last Interest Date";"Last Interest Date")
                {
                    ApplicationArea = Basic;
                }
                field("Don't Transfer to Savings";"Don't Transfer to Savings")
                {
                    ApplicationArea = Basic;
                }
                field("S-Mobile No";"S-Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("Transfer Amount to Savings";"Transfer Amount to Savings")
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate";"Interest rate")
                {
                    ApplicationArea = Basic;
                }
                field("FDR Deposit Status Type";"FDR Deposit Status Type")
                {
                    ApplicationArea = Basic;
                }
                field("On Term Deposit Maturity";"On Term Deposit Maturity")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Interest On Term Dep";"Expected Interest On Term Dep")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Start Date";"Fixed Deposit Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Last Interest Earned Date";"Last Interest Earned Date")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Nos";"Fixed Deposit Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account";"Destination Account")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Current Account Balance";"Current Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted";"Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

