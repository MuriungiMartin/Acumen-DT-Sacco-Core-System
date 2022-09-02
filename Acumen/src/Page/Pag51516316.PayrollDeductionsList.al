#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516316 "Payroll Deductions List."
{
    ApplicationArea = Basic;
    CardPageID = "HR Leave Types Card";
    PageType = List;
    SourceTable = "Payroll Transaction Code.";
    SourceTableView = where("Transaction Type"=const(Deduction));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code";"Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name";"Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Taxable;Taxable)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
          "Transaction Type":="transaction type"::Deduction;
    end;
}

