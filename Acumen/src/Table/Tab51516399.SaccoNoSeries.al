#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516399 "Sacco No. Series"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "FOSA Loans Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(3; "Members Nos"; Code[10])
        {
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                /*CustMemb.RESET;
                CustMemb.SETRANGE(CustMemb."No. Series","Members Nos");
                IF CustMemb.FIND('-') = FALSE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more entries');
                END;
                  */

            end;
        }
        field(4; "BOSA Loans Nos"; Code[10])
        {
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                /*LoanApps.RESET;
                LoanApps.SETRANGE(LoanApps."No. Series","BOSA Loans Nos");
                IF LoanApps.FIND('-') = FALSE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more transactions');
                END;
                    */

            end;
        }
        field(5; "Loans Batch Nos"; Code[10])
        {
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                /*LoanApps.RESET;
                LoanApps.SETRANGE(LoanApps."Batch No.","Loans Batch Nos");
                IF LoanApps.FIND('-') = FALSE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more transactions');
                END;
                         */

            end;
        }
        field(6; "Investors Nos"; Code[10])
        {
        }
        field(7; "Property Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(8; "BOSA Receipts Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(9; "Investment Project Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(10; "BOSA Transfer Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(11; "SMS Request Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(12; "Withholding Tax %"; Decimal)
        {
        }
        field(13; "Withholding Tax Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(14; "VAT %"; Decimal)
        {
        }
        field(15; "VAT Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(16; "PV No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(17; "Receipts Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(18; "Petty Cash  No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(19; "Member Application Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;

            trigger OnValidate()
            begin
                /*
             CustMembApp.RESET;
             CustMembApp.SETRANGE(CustMembApp."No. Series","Member Application Nos");
             IF CustMembApp.FIND('-') = FALSE THEN BEGIN
              ERROR('You cannot Delete/Modify since Series has been used in one or more entries');
             END;
                   */

            end;
        }
        field(20; "Closure  Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;

            trigger OnValidate()
            begin
                /*AccClosure.RESET;
                AccClosure.SETRANGE(AccClosure."No. Series","Closure  Nos");
                IF AccClosure.FIND('-') = TRUE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more entries');
                END;
                    */

            end;
        }
        field(21; "Bosa Transaction Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(22; "Transaction Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(23; "Treasury Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(24; "Standing Orders Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(25; "FOSA Current Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(26; "BOSA Current Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(27; "Teller Transactions No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(28; "Treasury Transactions No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(29; "Applicants Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(30; "STO Register No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(31; "EFT Header Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(32; "EFT Details Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(33; "Salaries Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(34; "Requisition No"; Code[10])
        {
            Caption = 'Requisition No';
            TableRelation = "No. Series";
        }
        field(35; "Internal Requisition No."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(36; "Internal Purchase No."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(37; "Quatation Request No"; Code[10])
        {
            Caption = 'Quatation Request No';
            TableRelation = "No. Series";
        }
        field(38; "ATM Applications"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(39; "Stores Requisition No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(40; "Requisition Default Vendor"; Code[10])
        {
        }
        field(41; "Use Procurement limits"; Boolean)
        {
        }
        field(42; "Request for Quotation Nos"; Code[20])
        {
        }
        field(43; "Teller Bulk Trans Nos."; Code[10])
        {
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                /*RcptBuffer.RESET;
                RcptBuffer.SETRANGE(RcptBuffer."No. Series","Receipt Buffer Nos.");
                IF RcptBuffer.FIND('-') = FALSE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more transactions');
                END;
                 */

            end;
        }
        field(44; "Micro Loans"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(45; "Micro Transactions"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(46; "Micro Finance Transactions"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(47; "Micro Group Nos."; Code[10])
        {
        }
        field(48; "MPESA Change Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(49; "MPESA Application Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50; "Change MPESA PIN Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(51; "Change MPESA Application Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(52; "Last Memb No."; Code[30])
        {
        }
        field(53; BosaNumber; Code[30])
        {
        }
        field(54; "Investor Application Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(55; "Investor Nos"; Code[30])
        {
        }
        field(56; "Paybill Processing"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(57; "Checkoff-Proc Distributed Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(58; "Salary Processing Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(59; "Cheque Clearing Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(60; "Checkoff Proc Block Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(61; "Cheque Application Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(62; "Cheque Receipts Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(63; "Customer Care Log Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(64; "Trunch Disbursment Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516000; "S_Mobile Registration Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516001; "Loan PayOff Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516002; "E-Loan Nos"; Code[20])
        {
        }
        field(51516003; "Funeral Expense Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516004; "Change Request No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516005; "Microfinance Last No Used"; Code[20])
        {
        }
        field(51516006; "MicroFinance Account Prefix"; Code[20])
        {
        }
        field(51516007; "Collateral Register No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516008; "Agent Serial Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516009; "Cloudpesa Reg No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516010; "Paybill No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516011; "Deposits Account No(HQ)"; Code[20])
        {
        }
        field(51516012; "Share Capital Account No(HQ)"; Code[20])
        {
        }
        field(51516013; "BenFund Account No(HQ)"; Code[20])
        {
        }
        field(51516014; "Deposits Account No(NAIV)"; Code[20])
        {
        }
        field(51516015; "Share Capital Account No(NAIV)"; Code[20])
        {
        }
        field(51516016; "BenFund Account No(NAIV)"; Code[20])
        {
        }
        field(51516017; "Deposits Account No(ELD)"; Code[20])
        {
        }
        field(51516018; "Share Capital Account No(ELD)"; Code[20])
        {
        }
        field(51516019; "BenFund Account No(ELD)"; Code[20])
        {
        }
        field(51516020; "Deposits Account No(MSA)"; Code[20])
        {
        }
        field(51516021; "Share Capital Account No(MSA)"; Code[20])
        {
        }
        field(51516022; "BenFund Account No(MSA)"; Code[20])
        {
        }
        field(51516023; "Deposits Account No(NKR)"; Code[20])
        {
        }
        field(51516024; "Share Capital Account No(NKR)"; Code[20])
        {
        }
        field(51516025; "BenFund Account No(NKR)"; Code[20])
        {
        }
        field(51516026; "Corporate Deposits Acc No(HQ)"; Code[20])
        {
        }
        field(51516027; "Corporate Deposit Acc No(NAIV)"; Code[20])
        {
        }
        field(51516028; "Corporate Deposit Acc No(ELD)"; Code[20])
        {
        }
        field(51516029; "Corporate Deposit Acc No(MSA)"; Code[20])
        {
        }
        field(51516030; "Corporate Deposit Acc No(NKR)"; Code[20])
        {
        }
        field(51516031; "FOSA Shares Account No(HQ)"; Code[20])
        {
        }
        field(51516032; "FOSA Shares Account No(NAIV)"; Code[20])
        {
        }
        field(51516033; "FOSA Shares Account No(ELD)"; Code[20])
        {
        }
        field(51516034; "FOSA Shares Account No(MSA)"; Code[20])
        {
        }
        field(51516035; "FOSA Shares Account No(NKR)"; Code[20])
        {
        }
        field(51516036; "Additional Shares Acc No(HQ)"; Code[20])
        {
        }
        field(51516037; "Additional Shares Acc No(NAIV)"; Code[20])
        {
        }
        field(51516038; "Additional Shares Acc No(ELD)"; Code[20])
        {
        }
        field(51516039; "Additional Shares Acc No(MSA)"; Code[20])
        {
        }
        field(51516040; "Additional Shares Acc No(NKR)"; Code[20])
        {
        }
        field(51516041; "Membership Acc No(HQ)"; Code[20])
        {
        }
        field(51516042; "Membership Acc No(NAIV)"; Code[20])
        {
        }
        field(51516043; "Membership Acc No(ELD)"; Code[20])
        {
        }
        field(51516044; "Membership Acc No(MSA)"; Code[20])
        {
        }
        field(51516045; "Membership Acc No(NKR)"; Code[20])
        {
        }
        field(51516046; "Safe Custody Package Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516047; "Safe Custody Agent Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516048; "Safe Custody Item Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516049; "Package Retrieval Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516050; "ATM Card Batch Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516051; "Member Cell Group Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516052; "Demand Notice Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516053; "House Change Request No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516054; "BD Training Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516055; "Member Agent/NOK Change"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516056; "House Group Application"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516057; "House Group Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516058; "Fixed Deposit Placement"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516059; "Guarantor Substitution"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516060; "Feedback nos"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51516061; "Check Off Advisor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(51516062; "Loan Recovery Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LoanApps: Record "Loans Register";
        CustMemb: Record Customer;
        CustMembApp: Record "Membership Applications";
        AccClosure: Record "Membership Exit";


    procedure TestNoEntriesExist(CurrentFieldName: Text[100])
    var
        LoanApps: Record "Loans Register";
    begin
        /*
        //To prevent change of field
         LoanApps.SETCURRENTKEY(LoanApps."No. Series");
         LoanApps.SETRANGE(LoanApps."No. Series","No.");
        IF LoanApps.FIND('-') THEN
          ERROR(
          Text000,
           CurrentFieldName);
        */

    end;
}

