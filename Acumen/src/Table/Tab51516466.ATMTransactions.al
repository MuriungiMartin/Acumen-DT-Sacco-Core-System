#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516466 "ATM Transactions"
{

    fields
    {
        field(1;"Trace ID";Code[20])
        {

            trigger OnValidate()
            begin
                     // ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(2;"Posting Date";Date)
        {

            trigger OnValidate()
            begin
                       //  ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(3;"Account No";Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                   //ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(4;Description;Text[200])
        {

            trigger OnValidate()
            begin
                //ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(5;Amount;Decimal)
        {

            trigger OnValidate()
            begin
                //    ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(6;"Posting S";Text[50])
        {

            trigger OnValidate()
            begin
                  //  ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(7;Posted;Boolean)
        {
        }
        field(8;"Unit ID";Code[10])
        {

            trigger OnValidate()
            begin
                Error('You are not allowed to modify anything in this table');
            end;
        }
        field(9;"Transaction Type";Text[30])
        {
        }
        field(10;"Trans Time";Text[50])
        {
        }
        field(11;"Transaction Time";Time)
        {
        }
        field(12;"Transaction Date";Date)
        {
        }
        field(13;Source;Option)
        {
            OptionCaption = 'ATM Bridge,Mobile';
            OptionMembers = "ATM Bridge",Mobile;
        }
        field(14;Reversed;Boolean)
        {
        }
        field(16;"Reversed Posted";Boolean)
        {
            Editable = true;
        }
        field(17;"Reversal Trace ID";Code[20])
        {

            trigger OnValidate()
            begin
                Error('You are not allowed to modify anything in this table');
            end;
        }
        field(18;"Transaction Description";Text[100])
        {

            trigger OnValidate()
            begin
                  //     ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(19;"Withdrawal Location";Text[150])
        {

            trigger OnValidate()
            begin
                 //               ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(20;"Entry No";Integer)
        {
            AutoIncrement = true;
            Editable = false;

            trigger OnValidate()
            begin
                             Error('You are not allowed to modify anything in this table');
            end;
        }
        field(22;"Transaction Type Charges";Option)
        {
            OptionCaption = 'Balance Enquiry,Mini Statement,Cash Withdrawal - Coop ATM,Cash Withdrawal - VISA ATM,Reversal,Utility Payment,POS - Normal Purchase,M-PESA Withdrawal,Airtime Purchase,POS - School Payment,POS - Purchase With Cash Back,POS - Cash Deposit,POS - Benefit Cash Withdrawal,POS - Cash Deposit to Card,POS - M Banking,POS - Cash Withdrawal,POS - Balance Enquiry,POS - Mini Statement,MINIMUM BALANCE';
            OptionMembers = "Balance Enquiry","Mini Statement","Cash Withdrawal - Coop ATM","Cash Withdrawal - VISA ATM",Reversal,"Utility Payment","POS - Normal Purchase","M-PESA Withdrawal","Airtime Purchase","POS - School Payment","POS - Purchase With Cash Back","POS - Cash Deposit","POS - Benefit Cash Withdrawal","POS - Cash Deposit to Card","POS - M Banking","POS - Cash Withdrawal","POS - Balance Enquiry","POS - Mini Statement","MINIMUM BALANCE";

            trigger OnValidate()
            begin
                   //         ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(23;"Card Acceptor Terminal ID";Code[20])
        {

            trigger OnValidate()
            begin
                     //       ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(24;"ATM Card No";Code[20])
        {

            trigger OnValidate()
            begin
                 //        ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(25;"Customer Names";Text[100])
        {

            trigger OnValidate()
            begin
                //ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(26;"Process Code";Code[20])
        {

            trigger OnValidate()
            begin
                 //        ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(50000;"Reference No";Text[50])
        {

            trigger OnValidate()
            begin
                //        ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(50001;"Is Coop Bank";Boolean)
        {

            trigger OnValidate()
            begin
                 //      ERROR('You are not allowed to modify anything in this table');
            end;
        }
        field(50002;"POS Vendor";Option)
        {
            OptionCaption = 'ATM Lobby,Agent Banking,Coop Branch POS,Sacco POS';
            OptionMembers = "ATM Lobby","Agent Banking","Coop Branch POS","Sacco POS";

            trigger OnValidate()
            begin
                //       ERROR('You are not allowed to modify anything in this table');
            end;
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
        }
        key(Key2;"Trace ID","Unit ID","Transaction Type","Posting S")
        {
            Clustered = true;
        }
        key(Key3;"Account No",Posted)
        {
            SumIndexFields = Amount;
        }
        key(Key4;"Transaction Date","Transaction Time")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('You are not allowed to delete anything from this table');
    end;

    trigger OnInsert()
    begin
        //ERROR('You are not allowed to manually insert anything into this table');
    end;

    trigger OnModify()
    begin
        //ERROR('You are not allowed to modify anything in this table');
    end;

    trigger OnRename()
    begin
        //ERROR('You are not allowed to edit anything from this table');
    end;
}

