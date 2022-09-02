#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516522 "Loan Trunch Disburesment List"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Trunch Disburesment";
    Editable = false;
    PageType = List;
    SourceTable = "Loan trunch Disburesment";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No";"Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Issue Date";"Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount";"Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Disbursed Amount";"Disbursed Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Outstanding";"Balance Outstanding")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount";"Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Disburse";"Amount to Disburse")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Account";"FOSA Account")
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Disbursement";"Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No/Reference No";"Cheque No/Reference No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";"Posting Date")
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

