#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516020 "Mobile Payment Line"
{
    PageType = ListPart;
    SourceTable = "Payment Line.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Funds Transaction Types"."Transaction Code" where ("Transaction Type"=const(Payment),
                                                                                        "Meeting Transaction"=const(false));
                }
                field("Posted By";"Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted";"Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted";"Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name";"Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Code";"VAT Code")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Code";"Withholding Tax Code")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Amount";"VAT Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Amount";"Withholding Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount";"Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank Account";"Paying Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("PO/INV No";"PO/INV No")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No";"Bank Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Total Allocation";"Total Allocation")
                {
                    ApplicationArea = Basic;
                }
                field("Total Expenditure";"Total Expenditure")
                {
                    ApplicationArea = Basic;
                }
                field("Total Commitments";"Total Commitments")
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

