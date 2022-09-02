#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516345 "Cheque Truncation Card"
{
    PageType = Card;
    SourceTable = "Cheque Issue Lines-Family";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(test;test)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Serial No";"Cheque Serial No")
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
                field("Branch Code";"Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Refference";"Transaction Refference")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No";"Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Balance";"Account Balance")
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
                field("Verification Status";"Verification Status")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000015;"Products Signatories Details")
            {
                SubPageLink = "Account No"=field(Field3);
            }
        }
    }

    actions
    {
    }
}

