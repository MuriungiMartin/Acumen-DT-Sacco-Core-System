#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516480 "ATM Transactions 2"
{

    fields
    {
        field(1;ID;Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2;"Account No";Code[16])
        {
            Editable = false;
            NotBlank = true;
        }
        field(3;"Processing Code";Text[6])
        {
            Editable = false;
            NotBlank = true;
        }
        field(4;"Transaction Amount";Text[12])
        {
            Editable = false;
        }
        field(5;"Cardholder Billing";Text[12])
        {
            Editable = false;
        }
        field(6;"Transmission Date Time";Text[10])
        {
            Editable = false;
        }
        field(7;"Conversion Rate";Text[8])
        {
            Editable = false;
        }
        field(8;"System Trace Audit No";Text[6])
        {
            Editable = false;
        }
        field(9;"Date Time - Local";Text[12])
        {
            Editable = false;
        }
        field(10;"Expiry Date";Text[4])
        {
            Editable = false;
        }
        field(11;"POS Entry Mode";Text[12])
        {
            Editable = false;
        }
        field(12;"Function Code";Text[3])
        {
            Editable = false;
        }
        field(13;"POS Capture Code";Text[4])
        {
            Editable = false;
        }
        field(14;"Transaction Fee";Text[6])
        {
            Editable = false;
        }
        field(15;"Settlement Fee";Text[3])
        {
            Editable = false;
        }
        field(16;"Settlement Processing Fee";Text[250])
        {
            Editable = false;
        }
        field(17;"Acquiring Institution ID Code";Text[250])
        {
            Editable = false;
        }
        field(18;"Forwarding Institution ID Code";Text[250])
        {
            Editable = false;
        }
        field(19;"Transaction 2 Data";Text[250])
        {
            Editable = false;
        }
        field(20;"Retrieval Reference No";Text[12])
        {
            Editable = false;
        }
        field(21;"Authorisation ID Response";Text[6])
        {
            Editable = false;
        }
        field(22;"Response Code";Text[3])
        {
            Editable = false;
        }
        field(23;"Card Acceptor Terminal ID";Text[8])
        {
            Editable = false;
        }
        field(24;"Card Acceptor ID Code";Text[15])
        {
            Editable = false;
        }
        field(25;"Card Acceptor Name/Location";Text[250])
        {
            Editable = false;
        }
        field(26;"Additional Data - Private";Text[250])
        {
            Editable = false;
        }
        field(27;"Transaction Currency Code";Text[3])
        {
            Editable = false;
        }
        field(28;"Settlement Currency Code";Text[3])
        {
            Editable = false;
        }
        field(29;"Cardholder Billing Cur Code";Text[3])
        {
            Editable = false;
        }
        field(30;"Response Indicator";Text[250])
        {
            Editable = false;
        }
        field(31;"Service Indicator";Text[250])
        {
            Editable = false;
        }
        field(32;"Replacement Amounts";Text[250])
        {
            Editable = false;
        }
        field(33;"Receiving Institution ID Code";Text[250])
        {
            Editable = false;
        }
        field(34;"Account Identification 2";Text[250])
        {
            Editable = false;
        }
        field(35;Status;Option)
        {
            Editable = false;
            OptionMembers = Sent,Failed;
        }
        field(36;"Transaction Type";Option)
        {
            Editable = false;
            OptionCaption = 'Balance Enquiry,Mini Statement,Cash Withdrawal - Coop ATM,Cash Withdrawal - VISA ATM,Reversal,Utility Payment,POS - Normal Purchase,M-PESA Withdrawal,Airtime Purchase,POS - School Payment,POS - Purchase With Cash Back,POS - Cash Deposit,POS - Benefit Cash Withdrawal,POS - Cash Deposit to Card,POS - M Banking,POS - Cash Withdrawal,MINIMUM BALANCE';
            OptionMembers = "Balance Enquiry","Mini Statement","Cash Withdrawal - Coop ATM","Cash Withdrawal - VISA ATM",Reversal,"Utility Payment","POS - Normal Purchase","M-PESA Withdrawal","Airtime Purchase","POS - School Payment","POS - Purchase With Cash Back","POS - Cash Deposit","POS - Benefit Cash Withdrawal","POS - Cash Deposit to Card","POS - M Banking","POS - Cash Withdrawal","MINIMUM BALANCE";
        }
        field(37;"Bitmap - Hexadecimal";Text[32])
        {
            Editable = false;
        }
        field(38;"Bitmap - Binary";Text[128])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

