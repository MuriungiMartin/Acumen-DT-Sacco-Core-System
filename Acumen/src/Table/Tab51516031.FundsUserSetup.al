#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516031 "Funds User Setup"
{

    fields
    {
        field(10;UserID;Code[50])
        {
            NotBlank = true;

            trigger OnLookup()
            begin
                UserManager.LookupUser(UserID);
            end;

            trigger OnValidate()
            var
             User: record User;
            begin
                UserManager.ValidateUserName(User,User,UserID);
            end;
        }
        field(11;"Receipt Journal Template";Code[20])
        {
            TableRelation = "Gen. Journal Template".Name where (Type=const("Cash Receipts"));
        }
        field(12;"Receipt Journal Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("Receipt Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."Receipt Journal Template","Receipt Journal Template");
                UserTemp.SetRange(UserTemp."Receipt Journal Batch","Receipt Journal Batch");
                if UserTemp.FindFirst then begin
                  repeat
                    if (UserTemp.UserID<>UserID) and ("Receipt Journal Batch"<>'') then begin
                          Error(SameBatch,"Receipt Journal Batch");
                    end;
                  until UserTemp.Next=0;
                end;

            end;
        }
        field(13;"Payment Journal Template";Code[20])
        {
            TableRelation = "Gen. Journal Template".Name where (Type=const(Payments));
        }
        field(14;"Payment Journal Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("Payment Journal Template"));

            trigger OnValidate()
            begin
                //Check if the batch has been allocated to another user
                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."Payment Journal Template","Payment Journal Template");
                UserTemp.SetRange(UserTemp."Payment Journal Batch","Payment Journal Batch");
                if UserTemp.FindFirst then begin
                   repeat
                    if (UserTemp.UserID<>Rec.UserID) and ("Payment Journal Batch"<>'') then begin
                       Error(SameBatch,"Receipt Journal Batch","Payment Journal Batch");
                    end;
                   until UserTemp.Next=0;
                end;
            end;
        }
        field(15;"Petty Cash Template";Code[20])
        {
            TableRelation = "Gen. Journal Template".Name where (Type=const(Payments));
        }
        field(16;"Petty Cash Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("Petty Cash Template"));

            trigger OnValidate()
            begin
                //Check if the batch has been allocated to another user
                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."Petty Cash Template","Petty Cash Template");
                UserTemp.SetRange(UserTemp."Petty Cash Batch","Petty Cash Batch");
                if UserTemp.FindFirst then begin
                   repeat
                    if (UserTemp.UserID<>Rec.UserID) and ("Petty Cash Batch"<>'') then begin
                       Error(SameBatch,"Receipt Journal Batch","Petty Cash Batch");
                    end;
                   until UserTemp.Next=0;
                end;
            end;
        }
        field(17;"FundsTransfer Template Name";Code[20])
        {
            TableRelation = "Gen. Journal Template".Name where (Type=const(Payments));
        }
        field(18;"FundsTransfer Batch Name";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("FundsTransfer Template Name"));

            trigger OnValidate()
            begin
                //Check if the batch has been allocated to another user
                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."FundsTransfer Template Name","FundsTransfer Template Name");
                UserTemp.SetRange(UserTemp."FundsTransfer Batch Name","FundsTransfer Batch Name");
                if UserTemp.FindFirst then begin
                   repeat
                    if(UserTemp.UserID<>Rec.UserID) and ("FundsTransfer Batch Name"<>'') then begin
                         Error(SameBatch,"Receipt Journal Batch","Petty Cash Batch");
                    end;
                   until UserTemp.Next=0;
                end;
            end;
        }
        field(19;"Default Receipts Bank";Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                /*UserTemp.RESET;
                UserTemp.SETRANGE(UserTemp."Default Receipts Bank","Default Receipts Bank");
                IF UserTemp.FINDFIRST THEN
                  BEGIN
                    REPEAT
                      IF UserTemp.UserID<>Rec.UserID THEN
                        BEGIN
                          ERROR('Please note that another user has been assigned the same bank.');
                        END;
                    UNTIL UserTemp.NEXT=0;
                  END;
                 */

            end;
        }
        field(20;"Default Payment Bank";Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                /*UserTemp.RESET;
                UserTemp.SETRANGE(UserTemp."Default Payment Bank","Default Payment Bank");
                IF UserTemp.FINDFIRST THEN
                  BEGIN
                    REPEAT
                      IF UserTemp.UserID<>Rec.UserID THEN
                        BEGIN
                          ERROR('Please note that another user has been assigned the same bank.');
                        END;
                    UNTIL UserTemp.NEXT=0;
                  END;
                 */

            end;
        }
        field(21;"Default Petty Cash Bank";Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                /*UserTemp.RESET;
                UserTemp.SETRANGE(UserTemp."Default Petty Cash Bank","Default Petty Cash Bank");
                IF UserTemp.FINDFIRST THEN
                  BEGIN
                    REPEAT
                      IF UserTemp.UserID<>Rec.UserID THEN
                        BEGIN
                          ERROR('Please note that another user has been assigned the same bank.');
                        END;
                    UNTIL UserTemp.NEXT=0;
                  END;
                 */

            end;
        }
        field(22;"Max. Cash Collection";Decimal)
        {
        }
        field(23;"Max. Cheque Collection";Decimal)
        {
        }
        field(24;"Max. Deposit Slip Collection";Decimal)
        {
        }
        field(25;"Supervisor ID";Code[50])
        {

            trigger OnLookup()
            begin
                /*LoginMgt.LookupUserID("Supervisor ID");*/

            end;

            trigger OnValidate()
            begin
                /*LoginMgt.ValidateUserID("Supervisor ID");*/

            end;
        }
        field(26;"Bank Pay In Journal Template";Code[20])
        {
            TableRelation = "Gen. Journal Template".Name where (Type=const(General));
        }
        field(27;"Bank Pay In Journal Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("Bank Pay In Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                /*UserTemp.RESET;
                UserTemp.SETRANGE(UserTemp."Bank Pay In Journal Template","Bank Pay In Journal Template");
                UserTemp.SETRANGE(UserTemp."Bank Pay In Journal Batch","Bank Pay In Journal Batch");
                IF UserTemp.FINDFIRST THEN
                  BEGIN
                    REPEAT
                      IF UserTemp.UserID<>Rec.UserID THEN
                        BEGIN
                          ERROR('Please note that another user has been assigned the same batch.');
                        END;
                    UNTIL UserTemp.NEXT=0;
                  END;
                 */

            end;
        }
        field(28;"Imprest Template";Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(29;"Imprest  Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(30;"Claim Template";Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(31;"Claim  Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("Claim Template"));
        }
        field(32;"Advance Template";Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(33;"Advance  Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("Advance Template"));
        }
        field(34;"Advance Surr Template";Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(35;"Advance Surr Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("Advance Surr Template"));
        }
        field(36;"Dim Change Journal Template";Code[20])
        {
            TableRelation = "Gen. Journal Template".Name where (Type=const(General));
        }
        field(37;"Dim Change Journal Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("Dim Change Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                /*UserTemp.RESET;
                UserTemp.SETRANGE(UserTemp."Payment Journal Template","Payment Journal Template");
                UserTemp.SETRANGE(UserTemp."Payment Journal Batch","Payment Journal Batch");
                IF UserTemp.FINDFIRST THEN
                  BEGIN
                    REPEAT
                IF (UserTemp.UserID<>Rec.UserID) AND ("Payment Journal Batch"<>'') THEN
                        BEGIN
                          ERROR('Please note that another user has been assigned the same batch.');
                        END;
                    UNTIL UserTemp.NEXT=0;
                  END;
                 */

            end;
        }
        field(38;"Journal Voucher Template";Code[20])
        {
            TableRelation = "Gen. Journal Template".Name where (Type=const(General));
        }
        field(39;"Journal Voucher Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("Journal Voucher Template"));
        }
        field(40;"Post Payment Voucher";Boolean)
        {
        }
        field(41;"Post Cash Voucher";Boolean)
        {
        }
        field(42;"Post Money Voucher";Boolean)
        {
        }
        field(43;"Post Petty Cash";Boolean)
        {
        }
        field(44;"Post Receipt";Boolean)
        {
        }
        field(45;"Post Funds Withdrawal";Boolean)
        {
        }
        field(46;"Post Funds Transfer";Boolean)
        {
        }
        field(47;"Post Imprest";Boolean)
        {
        }
        field(48;"Post Imprest Accounting";Boolean)
        {
        }
        field(49;"Post Claims";Boolean)
        {
        }
        field(50;"Post Member Bills";Boolean)
        {
        }
        field(51;"Post CPD Bills";Boolean)
        {
        }
        field(70;"Reverse Payment Voucher";Boolean)
        {
        }
        field(71;"Reverse Cash Voucher";Boolean)
        {
        }
        field(72;"Reverse Money Voucher";Boolean)
        {
        }
        field(73;"Reverse Petty Cash";Boolean)
        {
        }
        field(74;"Reverse Receipt";Boolean)
        {
        }
        field(75;"Reverse Funds Withdrawal";Boolean)
        {
        }
        field(76;"Reverse Funds Transfer";Boolean)
        {
        }
        field(77;"Reverse Imprest";Boolean)
        {
        }
        field(78;"Reverse Imprest Accounting";Boolean)
        {
        }
        field(79;"Reverse Claims";Boolean)
        {
        }
        field(80;"Reverse Member Bills";Boolean)
        {
        }
        field(81;"Reverse CPD Bills";Boolean)
        {
        }
        field(82;"FosaTrans Journal Template";Code[20])
        {
            TableRelation = "Gen. Journal Template".Name where (Type=const(General));
        }
        field(83;"FosaTrans Journal Batch";Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("FosaTrans Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."Receipt Journal Template","Receipt Journal Template");
                UserTemp.SetRange(UserTemp."Receipt Journal Batch","Receipt Journal Batch");
                if UserTemp.FindFirst then begin
                  repeat
                    if (UserTemp.UserID<>UserID) and ("Receipt Journal Batch"<>'') then begin
                          Error(SameBatch,"Receipt Journal Batch");
                    end;
                  until UserTemp.Next=0;
                end;

            end;
        }
    }

    keys
    {
        key(Key1;UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        UserTemp: Record "Funds User Setup";
        UserManager: Codeunit UserManagementCUExt;
        SameBatch: label 'Another User has been assign to the batch:%1';
}

