#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516049 "Cash Office Setup"
{

    fields
    {
        field(1;"Primary Key";Code[10])
        {
        }
        field(50001;"Normal Payments No";Code[10])
        {
            Caption = 'Normal Payments No';
            TableRelation = "No. Series";
        }
        field(50002;"Cheque Reject Period";DateFormula)
        {
        }
        field(50003;"Petty Cash Payments No";Code[10])
        {
            Caption = 'Petty Cash Payments No';
            TableRelation = "No. Series";
        }
        field(50004;"Current Budget";Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(50005;"Current Budget Start Date";Date)
        {
        }
        field(50006;"Current Budget End Date";Date)
        {
        }
        field(50009;"Surrender Template";Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(50010;"Surrender  Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("Surrender Template"));
        }
        field(50011;"Payroll Template";Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(50012;"Payroll  Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(50013;"Payroll Control A/C";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50014;"PV Template";Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(50015;"PV  Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(50016;"Contract No";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50017;"Receipts No";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50018;"Petty Cash Voucher  Template";Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(50019;"Petty Cash Voucher Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(50020;"Max. Petty Cash Request";Decimal)
        {
        }
        field(50022;"Imprest Req No";Code[20])
        {
            Caption = 'Receipts No';
            TableRelation = "No. Series";
        }
        field(50023;"Quotation Request No";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50024;"Tender Request No";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50025;"Transport Pay Type";Code[20])
        {
        }
        field(50026;"Minimum Chargeable Weight";Decimal)
        {
        }
        field(50027;"Imprest Surrender No";Code[20])
        {
            Caption = 'Imprest Surrender No';
            TableRelation = "No. Series";
        }
        field(50028;"Bank Deposit No.";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50029;"InterBank Transfer No.";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50030;"PA Payment Vouchers Nos";Code[20])
        {
            Caption = 'Farmers Payment Vouchers Nos.';
            TableRelation = "No. Series".Code;
        }
        field(50031;"Cash Request Nos";Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50032;"Cash Issue Nos";Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50033;"Cash Receipt Nos";Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50034;"Cash Transfer Template";Code[10])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50035;"Cash Transfer Batch";Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("Cash Transfer Template"));
        }
        field(50036;"Enable AutoTeller Monitor";Boolean)
        {
        }
        field(50037;"Alert After ?(Mins)";Integer)
        {
        }
        field(50038;"Transporter Depot";Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(50039;"Transporter Department";Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(50040;"Transporter Cashier";Code[20])
        {
            TableRelation = "Cash Office User Template";
        }
        field(50041;"Transporter PayType";Code[20])
        {
            TableRelation = "Funds Transaction Types"."Transaction Code" where ("Transaction Type"=const(Payment));
        }
        field(50042;"Cashier Transfer Nos";Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50043;"Interim Transfer Account";Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(50044;"Default Bank Deposit Slip A/C";Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50045;"Apply Cash Expenditure Limit";Boolean)
        {
        }
        field(50046;"Expenditure Limit Amount(LCY)";Decimal)
        {
        }
        field(50050;"Staff Claim No.";Code[20])
        {
            Caption = 'Staff Claim No';
            TableRelation = "No. Series";
        }
        field(50051;"Other Staff Advance No.";Code[20])
        {
            Caption = 'Other Staff Advance No';
            TableRelation = "No. Series";
        }
        field(50052;"Staff Advance Surrender No.";Code[20])
        {
            Caption = 'Staff Adv. Surrender No';
            TableRelation = "No. Series";
        }
        field(50053;"Prompt Cash Reimbursement";Boolean)
        {
        }
        field(50054;"Use Central Payment System";Boolean)
        {
        }
        field(50060;"Payment Request Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50061;"Journal Voucher Nos";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50070;"Minimum Cheque Creation Amount";Decimal)
        {
            Description = 'Starting Amount to create a check';
        }
        field(50071;"Grant Surrender Nos";Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50072;"Cash Purchases";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50073;"Board Payment Nos";Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50074;"Committee Payment Nos";Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50075;"Board PV Nos";Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50076;"Committee PV Nos";Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50077;"Cash Collection A/C";Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50078;"Cheque Collection A/C";Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50079;"MPESA Collection A/C";Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50080;"Airtel Collection A/C";Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50081;"Mobile Money Payment Nos";Code[20])
        {
        }
        field(50082;"Casual Req. No's";Code[20])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

