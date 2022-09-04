#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516035 "Cash Office User Template"
{
    DataCaptionFields = UserID;
    // DrillDownPageID = UnknownPage56023;
    // LookupPageID = UnknownPage56023;

    fields
    {
        field(1; UserID; Code[100])
        {
            Description = 'Stores the reference of the user in the database';
            NotBlank = true;

            trigger OnLookup()
            begin
                LoginMgt.LookupUser(UserID);
            end;

            trigger OnValidate()
            var
                User: record User;
            begin
                LoginMgt.ValidateUserName(User, User, UserID);
            end;
        }
        field(2; "Receipt Journal Template"; Code[20])
        {
            Description = 'Stores the reference of the receipt journal template in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const("Cash Receipts"));
        }
        field(3; "Receipt Journal Batch"; Code[20])
        {
            Description = 'Stores the reference of the receipt journal batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Receipt Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/

                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."Receipt Journal Template", "Receipt Journal Template");
                UserTemp.SetRange(UserTemp."Receipt Journal Batch", "Receipt Journal Batch");
                if UserTemp.FindFirst then begin
                    repeat
                        if (UserTemp.UserID <> Rec.UserID) and ("Receipt Journal Batch" <> '') then begin
                            Error('Please note that another user has been assigned the same batch.');
                        end;
                    until UserTemp.Next = 0;
                end;

            end;
        }
        field(4; "Payment Journal Template"; Code[20])
        {
            Description = 'Stores the reference of the payment journal template in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(5; "Payment Journal Batch"; Code[20])
        {
            Description = 'Stores the reference of the payment journal batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."Payment Journal Template", "Payment Journal Template");
                UserTemp.SetRange(UserTemp."Payment Journal Batch", "Payment Journal Batch");
                if UserTemp.FindFirst then begin
                    repeat
                        if (UserTemp.UserID <> Rec.UserID) and ("Payment Journal Batch" <> '') then begin
                            Error('Please note that another user has been assigned the same batch.');
                        end;
                    until UserTemp.Next = 0;
                end;

            end;
        }
        field(6; "Petty Cash Template"; Code[20])
        {
            Description = 'Stores the reference to the petty cash payment voucher in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(7; "Petty Cash Batch"; Code[20])
        {
            Description = 'Stores the reference of the petty cash payment batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Petty Cash Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."Petty Cash Template", "Petty Cash Template");
                UserTemp.SetRange(UserTemp."Petty Cash Batch", "Petty Cash Batch");
                if UserTemp.FindFirst then begin
                    repeat
                        if (UserTemp.UserID <> Rec.UserID) and ("Petty Cash Batch" <> '') then begin
                            Error('Please note that another user has been assigned the same batch.');
                        end;
                    until UserTemp.Next = 0;
                end;

            end;
        }
        field(8; "Inter Bank Template Name"; Code[20])
        {
            Description = 'Stores the reference of the petty cash payment batch in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(9; "Inter Bank Batch Name"; Code[20])
        {
            Description = 'Stores the reference to the inter bank transfer batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Inter Bank Template Name"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/

                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."Inter Bank Template Name", "Inter Bank Template Name");
                UserTemp.SetRange(UserTemp."Inter Bank Batch Name", "Inter Bank Batch Name");
                if UserTemp.FindFirst then begin
                    repeat
                        if (UserTemp.UserID <> Rec.UserID) and ("Inter Bank Batch Name" <> '') then begin
                            Error('Please note that another user has been assigned the same batch.');
                        end;
                    until UserTemp.Next = 0;
                end;

            end;
        }
        field(10; "Default Receipts Bank"; Code[20])
        {
            Description = 'Stores the reference to the default receipts bank deposit account';

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."Default Receipts Bank", "Default Receipts Bank");
                if UserTemp.FindFirst then begin
                    repeat
                        if UserTemp.UserID <> Rec.UserID then begin
                            Error('Please note that another user has been assigned the same bank.');
                        end;
                    until UserTemp.Next = 0;
                end;

            end;
        }
        field(11; "Default Payment Bank"; Code[20])
        {
            Description = 'Stores the reference to the default payments bank deposit account';
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."Default Payment Bank", "Default Payment Bank");
                if UserTemp.FindFirst then begin
                    repeat
                        if UserTemp.UserID <> Rec.UserID then begin
                            Error('Please note that another user has been assigned the same bank.');
                        end;
                    until UserTemp.Next = 0;
                end;

            end;
        }
        field(12; "Default Petty Cash Bank"; Code[20])
        {
            Description = 'Stores the reference to the default petty cash account in the database';

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."Default Petty Cash Bank", "Default Petty Cash Bank");
                if UserTemp.FindFirst then begin
                    repeat
                        if UserTemp.UserID <> Rec.UserID then begin
                            Error('Please note that another user has been assigned the same bank.');
                        end;
                    until UserTemp.Next = 0;
                end;

            end;
        }
        field(13; "Max. Cash Collection"; Decimal)
        {
        }
        field(14; "Max. Cheque Collection"; Decimal)
        {
        }
        field(15; "Max. Deposit Slip Collection"; Decimal)
        {
        }
        field(16; "Supervisor ID"; Code[50])
        {
            Description = 'Stores the reference for the supervisor for the specific teller';

            trigger OnLookup()
            begin
                LoginMgt.LookupUser("Supervisor ID");
            end;

            trigger OnValidate()
            var
                User: record User;
            begin
                LoginMgt.ValidateUserName(User, User, "Supervisor ID");
            end;
        }
        field(17; "Bank Pay In Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(18; "Bank Pay In Journal Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Bank Pay In Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."Bank Pay In Journal Template", "Bank Pay In Journal Template");
                UserTemp.SetRange(UserTemp."Bank Pay In Journal Batch", "Bank Pay In Journal Batch");
                if UserTemp.FindFirst then begin
                    repeat
                        if UserTemp.UserID <> Rec.UserID then begin
                            Error('Please note that another user has been assigned the same batch.');
                        end;
                    until UserTemp.Next = 0;
                end;

            end;
        }
        field(19; "Imprest Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(20; "Imprest  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(21; "Claim Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(22; "Claim  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Claim Template"));
        }
        field(23; "Advance Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(24; "Advance  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Advance Template"));
        }
        field(25; "Advance Surr Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(26; "Advance Surr Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Advance Surr Template"));
        }
        field(27; "Dim Change Journal Template"; Code[20])
        {
            Description = 'Stores the reference of the Dimensions/ GL journal template in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(28; "Dim Change Journal Batch"; Code[20])
        {
            Description = 'Stores the reference of the Dimensions/GL  journal batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Dim Change Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another user*/
                UserTemp.Reset;
                UserTemp.SetRange(UserTemp."Payment Journal Template", "Payment Journal Template");
                UserTemp.SetRange(UserTemp."Payment Journal Batch", "Payment Journal Batch");
                if UserTemp.FindFirst then begin
                    repeat
                        if (UserTemp.UserID <> Rec.UserID) and ("Payment Journal Batch" <> '') then begin
                            Error('Please note that another user has been assigned the same batch.');
                        end;
                    until UserTemp.Next = 0;
                end;

            end;
        }
        field(29; "Journal Voucher Template"; Code[20])
        {
            Description = 'Stores the reference of the JV  journal Template in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(30; "Journal Voucher Batch"; Code[20])
        {
            Description = 'Stores the reference of the JV  journal Batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Voucher Template"));
        }
    }

    keys
    {
        key(Key1; UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        UserTemp: Record "Cash Office User Template";
        LoginMgt: Codeunit UserManagementCUExt;
}

