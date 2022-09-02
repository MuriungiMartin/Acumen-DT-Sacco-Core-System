#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516529 "Cheque Receipt Lines"
{
    PageType = List;
    SourceTable = "Cheque Issue Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Serial No";"Cheque Serial No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Un pay Code";"Un pay Code")
                {
                    ApplicationArea = Basic;
                }
                field(Interpretation;Interpretation)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unpay Date";"Unpay Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Un Pay Charge Amount";"Un Pay Charge Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Family Account No.";"Family Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co-op Account No';
                    Editable = false;
                }
                field("Date _Refference No.";"Date _Refference No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Code";"Transaction Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Branch Code";"Branch Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Currency;Currency)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date-1";"Date-1")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date-2";"Date-2")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Coop  Routing No.";"Coop  Routing No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Fillers;Fillers)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Refference";"Transaction Refference")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

