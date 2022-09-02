#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516739 "ATM Transactions Logs"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ATM Transactions 2";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID;ID)
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Processing Code";"Processing Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Amount";"Transaction Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Cardholder Billing";"Cardholder Billing")
                {
                    ApplicationArea = Basic;
                }
                field("Transmission Date Time";"Transmission Date Time")
                {
                    ApplicationArea = Basic;
                }
                field("Conversion Rate";"Conversion Rate")
                {
                    ApplicationArea = Basic;
                }
                field("System Trace Audit No";"System Trace Audit No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Time - Local";"Date Time - Local")
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date";"Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("POS Entry Mode";"POS Entry Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Function Code";"Function Code")
                {
                    ApplicationArea = Basic;
                }
                field("POS Capture Code";"POS Capture Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Fee";"Transaction Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Settlement Fee";"Settlement Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Settlement Processing Fee";"Settlement Processing Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Acquiring Institution ID Code";"Acquiring Institution ID Code")
                {
                    ApplicationArea = Basic;
                }
                field("Forwarding Institution ID Code";"Forwarding Institution ID Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction 2 Data";"Transaction 2 Data")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieval Reference No";"Retrieval Reference No")
                {
                    ApplicationArea = Basic;
                }
                field("Authorisation ID Response";"Authorisation ID Response")
                {
                    ApplicationArea = Basic;
                }
                field("Response Code";"Response Code")
                {
                    ApplicationArea = Basic;
                }
                field("Card Acceptor Terminal ID";"Card Acceptor Terminal ID")
                {
                    ApplicationArea = Basic;
                }
                field("Card Acceptor ID Code";"Card Acceptor ID Code")
                {
                    ApplicationArea = Basic;
                }
                field("Card Acceptor Name/Location";"Card Acceptor Name/Location")
                {
                    ApplicationArea = Basic;
                }
                field("Additional Data - Private";"Additional Data - Private")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Currency Code";"Transaction Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Settlement Currency Code";"Settlement Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Cardholder Billing Cur Code";"Cardholder Billing Cur Code")
                {
                    ApplicationArea = Basic;
                }
                field("Response Indicator";"Response Indicator")
                {
                    ApplicationArea = Basic;
                }
                field("Service Indicator";"Service Indicator")
                {
                    ApplicationArea = Basic;
                }
                field("Replacement Amounts";"Replacement Amounts")
                {
                    ApplicationArea = Basic;
                }
                field("Receiving Institution ID Code";"Receiving Institution ID Code")
                {
                    ApplicationArea = Basic;
                }
                field("Account Identification 2";"Account Identification 2")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Bitmap - Hexadecimal";"Bitmap - Hexadecimal")
                {
                    ApplicationArea = Basic;
                }
                field("Bitmap - Binary";"Bitmap - Binary")
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

