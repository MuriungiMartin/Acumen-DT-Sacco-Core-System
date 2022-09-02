#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516424 "Loan Charges"
{
    PageType = List;
    SourceTable = "Loan Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Percentage;Percentage)
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account";"G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Use Perc";"Use Perc")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Excise";"Charge Excise")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Type";"Charge Type")
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

