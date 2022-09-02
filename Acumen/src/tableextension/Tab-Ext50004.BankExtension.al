tableextension 50004 "BankExtension" extends "Bank Account"
{
    fields
    {
        field(68000; "Cashier ID"; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(51516200; "Account Type"; Option)
        {
            OptionCaption = ' ,Cashier,Treasury,PayBill';
            OptionMembers = " ",Cashier,Treasury,PayBill;
        }
        field(51516201; "Maximum Teller Withholding"; Decimal)
        {
        }
        field(51516202; "Max Withdrawal Limit"; Decimal)
        {
        }
        field(51516203; "Max Deposit Limit"; Decimal)
        {
        }
        field(51516204; "Bank Type1"; Option)
        {
            OptionCaption = 'Normal,Petty Cash,Mobile Banking,Bank';
            OptionMembers = Normal,"Petty Cash","Mobile Banking",Bank;
        }
        field(51516205; "Bankings Balance"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance (LCY)';
            Editable = false;
        }
        field(51516206; "Treasury Balance"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" where("Bank Account No." = field("No."),
                                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                Description = const('ISSUE TO TELLER'),
                                                                                Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(51516207; "Received From Treasury"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" where("Bank Account No." = field("No."),
                                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                Description = filter('ISSUE TO TELLER')));
            FieldClass = FlowField;
        }
        field(51516208; CashierID; Code[50])
        {
            Caption = 'User ID';
            NotBlank = true;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit UserManagementCUExt;
            begin
                UserMgt.LookupUser(CashierID);
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit UserManagementCUExt;
                USer: Record User;
            begin
                UserMgt.ValidateUserName(USer, USer, CashierID);
            end;
        }
        field(51516209; "Bank Type"; Option)
        {
            OptionMembers = Normal,Cash,"Fixed Deposit",SMPA,"Chq Collection",ATM,Msacco;

            trigger OnValidate()
            begin

                // TestNoEntriesExist(FieldCaption("Bank Type")); T TODO
            end;
        }
        field(51516210; "Pending Voucher Amount"; Decimal)
        {
        }
        field(51516211; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center BR";

            trigger OnValidate()
            begin
                /*
                IF NOT UserMgt.CheckRespCenter(1,"Responsibility Center") THEN
                  ERROR(
                    Text005,
                    RespCenter.TABLECAPTION,UserMgt.GetPurchasesFilter);
                    */

            end;
        }
        field(51516212; "Bank Branch Name"; Text[250])
        {
        }
        field(51516292; Text; Code[10])
        {
        }
        field(51516293; "Cheque Clearing Bank"; Boolean)
        {
        }
        field(51516294; "Viable to Transact"; Boolean)
        {
        }
        field(51516295; "Bank Account Branch"; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(2));
        }
        field(51516296; "Teller Balance"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("No."),
                                                                        "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(51516297; "Max Cheque Deposit Limit"; Decimal)
        {
        }
        field(51516298; "Authorization Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}