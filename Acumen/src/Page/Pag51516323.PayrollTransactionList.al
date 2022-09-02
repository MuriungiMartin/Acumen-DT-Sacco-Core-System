#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516323 "Payroll Transaction List."
{
    ApplicationArea = Basic;
    CardPageID = "payroll Transaction Code.";
    PageType = List;
    SourceTable = "Payroll Transaction Code.";
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
                field("Is Formulae";"Is Formulae")
                {
                    ApplicationArea = Basic;
                }
                field(Formulae;Formulae)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Taxable;Taxable)
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account";"G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account Name";"G/L Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("IsCo-Op/LnRep";"IsCo-Op/LnRep")
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

