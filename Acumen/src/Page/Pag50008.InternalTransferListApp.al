#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50008 "Internal Transfer List(App)"
{
    CardPageID = "Sacco Transfer Card";
    Editable = false;
    PageType = List;
    SourceTable = "Sacco Transfers";
    SourceTableView = where(Posted=filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Total";"Schedule Total")
                {
                    ApplicationArea = Basic;
                }
                field(Approved;Approved)
                {
                    ApplicationArea = Basic;
                }
                field("Approved By";"Approved By")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";"No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description";"Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Type";"Source Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account No";"Source Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Source Transaction Type";"Source Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Name";"Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Source Loan No";"Source Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Created By";"Created By")
                {
                    ApplicationArea = Basic;
                }
                field(Debit;Debit)
                {
                    ApplicationArea = Basic;
                }
                field(Refund;Refund)
                {
                    ApplicationArea = Basic;
                }
                field("Guarantor Recovery";"Guarantor Recovery")
                {
                    ApplicationArea = Basic;
                }
                field("Payrol No.";"Payrol No.")
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
                field("Bosa Number";"Bosa Number")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Savings Account Type";"Savings Account Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SetRange("Created By",UserId);
    end;
}

