#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516391 "Loans Rejected List"
{
    CardPageID = "Loans Rejected Card";
    Editable = false;
    PageType = List;
    SourceTable = "Loans Register";
    SourceTableView = where("Loan Status"=filter(Rejected),
                            "Approval Status"=filter(Rejected));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No.";"Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code";"Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount";"Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount";"Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Interest;Interest)
                {
                    ApplicationArea = Basic;
                }
                field(Insurance;Insurance)
                {
                    ApplicationArea = Basic;
                }
                field("Source of Funds";"Source of Funds")
                {
                    ApplicationArea = Basic;
                }
                field("Client Cycle";"Client Cycle")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name";"Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status";"Loan Status")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date";"Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field(Installments;Installments)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date";"Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Disbursement";"Mode of Disbursement")
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

