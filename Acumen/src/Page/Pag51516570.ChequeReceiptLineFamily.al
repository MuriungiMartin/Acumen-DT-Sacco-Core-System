#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516570 "Cheque Receipt Line-Family"
{
    CardPageID = "Cheque Truncation Card";
    Editable = true;
    PageType = List;
    SourceTable = "Cheque Issue Lines-Family";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Serial No";"Cheque Serial No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No";"Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Account Balance";"Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Un pay Code";"Un pay Code")
                {
                    ApplicationArea = Basic;
                }
                field(Interpretation;Interpretation)
                {
                    ApplicationArea = Basic;
                }
                field(dert;dert)
                {
                    ApplicationArea = Basic;
                }
                field("Un Pay Charge Amount";"Un Pay Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Family Account No.";"Family Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Date _Refference No.";"Date _Refference No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Code";"Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code";"Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Date-1";"Date-1")
                {
                    ApplicationArea = Basic;
                }
                field("Date-2";"Date-2")
                {
                    ApplicationArea = Basic;
                }
                field("Family Routing No.";"Family Routing No.")
                {
                    ApplicationArea = Basic;
                }
                field(Fillers;Fillers)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Refference";"Transaction Refference")
                {
                    ApplicationArea = Basic;
                }
                field("Unpay Date";"Unpay Date")
                {
                    ApplicationArea = Basic;
                }
                field(FrontImage;FrontImage)
                {
                    ApplicationArea = Basic;
                }
                field(FrontGrayImage;FrontGrayImage)
                {
                    ApplicationArea = Basic;
                }
                field(BackImages;BackImages)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
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

