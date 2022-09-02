tableextension 50000 "VendorExtension" extends Vendor
{
    fields
    {
        // Add changes to table fields here
        field(68000; "Creditor Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,FOSA Account,Supplier';
            OptionMembers = " ","FOSA Account",Supplier;
        }
        field(68001; "Personal No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(68002; "ID No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(68003; "Last Maintenance Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68004; "Activate Sweeping Arrangement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68005; "Sweeping Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(68006; "Sweep To Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(68007; "Fixed Deposit Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Active,Matured,Closed,Not Matured';
            OptionMembers = " ",Active,Matured,Closed,"Not Matured";
        }
        field(68008; "Call Deposit"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                AccountTypes: Record "Account Types-Saving Products";
            begin
                IF AccountTypes.GET("Account Type") THEN BEGIN
                    IF AccountTypes."Fixed Deposit" = FALSE THEN
                        ERROR('Call deposit only applicable for Fixed Deposits.');
                END;
            end;
        }
        field(68009; "Mobile Phone No"; Code[35])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                vend: Record Vendor;
            begin

                Vend.RESET;
                Vend.SETRANGE(Vend."Personal No.", "Personal No.");
                IF Vend.FIND('-') THEN
                    Vend.MODIFYALL(Vend."Mobile Phone No", "Mobile Phone No");

                /*Cust.RESET;
                Cust.SETRANGE(Cust."Staff No","Staff No");
                IF Cust.FIND('-') THEN
                Cust.MODIFYALL(Cust."Mobile Phone No","Mobile Phone No");*/

            end;
        }
        field(68010; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single,Married,Devorced,Widower,Separated';
            OptionMembers = " ",Single,Married,Devorced,Widower,Separated;
        }
        field(68011; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Account Type" = '503' THEN BEGIN
                    TESTFIELD("Registration Date");
                    "FD Maturity Date" := CALCDATE("Fixed Duration", "Registration Date");
                END;
            end;
        }
        field(68012; "BOSA Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(68013; Signature; MediaSet)
        {
            Caption = 'Signature';
            DataClassification = ToBeClassified;
        }
        field(68014; "Passport No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(68015; "Employer Code"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(68016; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Closed,Dormant,Frozen,Deceased';
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;

            trigger OnValidate()
            begin
                IF (Status = Status::Active) OR (Status = Status::Deceased) THEN
                    Blocked := Blocked::" "
                ELSE
                    Blocked := Blocked::All
            end;
        }
        field(68017; "Account Type"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Account Types-Saving Products".Code;

            trigger OnValidate()
            var
                AccountTypes: Record "Account Types-Saving Products";
            begin
                IF AccountTypes.GET("Account Type") THEN BEGIN
                    AccountTypes.TESTFIELD(AccountTypes."Posting Group");
                    "Vendor Posting Group" := AccountTypes."Posting Group";
                    "Call Deposit" := FALSE;
                    "Account Type Name" := AccountTypes.Description;
                END;
            end;
        }
        field(68018; "Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Single,Joint,Corporate,Group,Branch,Project';
            OptionMembers = Single,Joint,Corporate,Group,Branch,Project;
        }
        field(68019; "FD Marked for Closure"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68020; "Last Withdrawal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68021; "Last Overdraft Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68022; "Last Min. Balance Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68023; "Last Deposit Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68024; "Last Transaction Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68025; "Date Closed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68026; "Uncleared Cheques"; Decimal)
        {
            FieldClass = FlowField;

            CalcFormula = Sum(Transactions.Amount WHERE("Account No" = FIELD("No."),
                                                             Posted = CONST(true),
                                                             "Cheque Processed" = CONST(false),
                                                             "Type _Transactions" = CONST("Cheque Deposit")));
        }
        field(68027; "Expected Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68028; "ATM Transactions"; Decimal)
        {
            //TODO
            FieldClass = FlowField;

            CalcFormula = Sum("ATM Transactions".Amount WHERE("Account No" = FIELD("No."),
                                                               Posted = CONST(false)));
            Editable = false;
        }
        field(68029; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /* IF "Date of Birth" > TODAY THEN
                 ERROR('Date of birth cannot be greater than today');
                 */

            end;
        }
        field(68030; "Last Transaction Date"; Date)
        {
            FieldClass = FlowField;

            AutoFormatType = 1;
            CalcFormula = Max("Detailed Vendor Ledg. Entry"."Posting Date" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Document No." = FILTER(<> 'BALB/F9THNOV2018')));
            Caption = 'Last Transaction Date';
            Editable = false;
        }
        field(68032; "E-Mail (Personal)"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(68033; Section; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Section"."No.";
        }
        field(68034; "Card No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(68035; "Home Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(68036; Location; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(68037; "Sub-Location"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(68038; District; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(68039; "Resons for Status Change"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(68040; "Closure Notice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68041; "Fixed Deposit Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Deposit Type".Code;

            trigger OnValidate()
            var
                FDType: Record "Fixed Deposit Type";
                interestCalc: Record "FD Interest Calculation Crite";
            begin
                IF "Account Type" = '503' THEN BEGIN
                    IF "Account Type" = 'FIXED' THEN BEGIN
                        IF FDType.GET("Fixed Deposit Type") THEN
                            "FD Maturity Date" := CALCDATE(FDType.Duration, TODAY);
                        "FD Duration" := FDType."No. of Months";
                        "Fixed Deposit Status" := "Fixed Deposit Status"::Active;
                    END;

                    IF "Account Type" = '503' THEN BEGIN
                        IF interestCalc.GET(interestCalc.Code) THEN
                            "Interest rate" := interestCalc."Interest Rate"
                    END;

                    IF "Account Type" = 'CALLDEPOSIT' THEN BEGIN
                        IF interestCalc.GET(interestCalc.Code) THEN
                            "Interest rate" := interestCalc."On Call Interest Rate";
                    END;
                END;
            end;
        }
        field(68042; "Interest Earned"; Decimal)
        {
            //TODO
            CalcFormula = Sum("Interest Buffer"."Interest Amount" WHERE("Account No" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68043; "Untranfered Interest"; Decimal)
        {
            //TODO
            CalcFormula = Sum("Interest Buffer"."Interest Amount" WHERE("Account No" = FIELD("No."),
                                                                         Transferred = FILTER(false
                                                                         )));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68044; "FD Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*"FD Duration":="FD Maturity Date"-"Registration Date";
                 "FD Duration":=ROUND("FD Duration"/30,1);
                MODIFY;
                */

            end;
        }
        field(68045; "Savings Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(68046; "Old Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(68047; "Salary Processing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68048; "Amount to Transfer"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                interestCalc: Record "FD Interest Calculation Crite";
                GenSetUp: Record "Sacco General Set-Up";
                FDDuration: Integer;
            begin
                CALCFIELDS(Balance);
                //TESTFIELD("Registration Date");
                /*
                
                IF AccountTypes.GET("Account Type") THEN BEGIN
                IF "Account Type" = 'MUSTARD' THEN BEGIN
                IF "Last Withdrawal Date" = 0D THEN BEGIN
                "Last Withdrawal Date" :="Registration Date";
                MODIFY;
                END;
                
                IF (CALCDATE(AccountTypes."Savings Duration","Last Withdrawal Date") > TODAY) THEN BEGIN
                ERROR('You can only withdraw from this account once in %1.',AccountTypes."Savings Duration")
                END ELSE BEGIN
                IF "Amount to Transfer" > (Balance*0.25) THEN
                ERROR('Amount cannot be more than 25 Percent of the balance. i.e. %1',(Balance*0.25));
                
                END;
                
                END ELSE BEGIN
                IF AccountTypes."Savings Withdrawal penalty" > 0 THEN BEGIN
                IF (CALCDATE(AccountTypes."Savings Duration","Registration Date") > TODAY) THEN BEGIN
                IF ("Amount to Transfer"+ROUND(("Amount to Transfer"*(AccountTypes."Savings Withdrawal penalty")),1,'>')) > Balance THEN
                ERROR('You cannot transfer more than %1.',Balance-ROUND((Balance*(AccountTypes."Savings Withdrawal penalty")),1,'>'));
                
                END;
                
                END ELSE BEGIN
                IF "Amount to Transfer" > Balance THEN
                MESSAGE('Amount cannot be more than the balance.');
                
                END;
                END;
                END;
                  */
                //"Expected Interest On Term Dep":=ROUND((("Amount to Transfer"*"Interest rate"/100)/12)*FDDuration,1);

                IF "Account Type" = '503' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc.Duration, "Fixed Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        GenSetUp.GET();
                        "Interest rate" := interestCalc."Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("Amount to Transfer" * "Interest rate" / 100) / 365) * FDDuration, 1);
                        "Expected Interest On Term Dep" := "Expected Interest On Term Dep" - ("Expected Interest On Term Dep" * (GenSetUp."Withholding Tax (%)" / 100));
                        //"FD Maturity Date":=CALCDATE(FDDuration,"Fixed Deposit Start Date");
                        IF ("Amount to Transfer" < interestCalc."Minimum Amount") OR ("Amount to Transfer" > interestCalc."Maximum Amount") THEN
                            ERROR('You Cannot Deposit More OR less than the limits');
                    END;
                END;

            end;
        }
        field(68049; Proffesion; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(68050; "Signing Instructions"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Any to Sign,Two to Sign,Three to Sign,All to Sign,Four to Sign,Sole Signatory';
            OptionMembers = " ","Any to Sign","Two to Sign","Three to Sign","All to Sign","Four to Sign","Sole Signatory";
        }
        field(68051; Hide; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68052; "Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(68053; "Not Qualify for Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68054; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(68055; "Fixed Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
            TableRelation = "FD Interest Calculation Crite".Duration WHERE(Code = FIELD("Fixed Deposit Type"));

            trigger OnValidate()
            var
                interestCalc: Record "FD Interest Calculation Crite";
                FDDuration: integer;
            begin
                IF "Account Type" = '503' THEN BEGIN
                    //TESTFIELD("Registration Date");
                    //"FD Maturity Date":=CALCDATE("Fixed Duration","Registration Date");
                    "FD Maturity Date" := CALCDATE("Fixed Duration", "Fixed Deposit Start Date");
                END;



                IF "Account Type" = '503' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc.Duration, "Fixed Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        "Interest rate" := interestCalc."Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("Amount to Transfer" * interestCalc."Interest Rate" / 100) / 12) * interestCalc."No of Months", 1);
                    END;
                END;

                IF "Account Type" = 'CALLDEPOSIT' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc."No of Months", "FD Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        "Interest rate" := interestCalc."On Call Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("Amount to Transfer" * interestCalc."On Call Interest Rate" / 100) / 12) * interestCalc."No of Months", 1);
                    END;
                END;
            end;
        }
        field(68056; "System Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68057; "External Account No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(68058; "Bank Code"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(68059; Enabled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68060; "Current Salary"; Decimal)
        {
            //TODO
            CalcFormula = Sum("Salary Processing Lines".Amount WHERE("Account No." = FIELD("No."),
                                                                      Date = FIELD("Date Filter"),
                                                                      Processed = CONST(false)));
            FieldClass = FlowField;
        }
        field(68061; "Defaulted Loans Recovered"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68062; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(68063; "EFT Transactions"; Decimal)
        {
            //TODO
            CalcFormula = Sum("EFT/RTGS Details".Amount WHERE("Account No" = FIELD("No."),
                                                               "Not Available" = CONST(true),
                                                               Transferred = CONST(false)));
            FieldClass = FlowField;
        }
        field(68064; "Formation/Province"; Code[15])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Vend: Record vendor;
            begin
                Vend.RESET;
                Vend.SETRANGE(Vend."Personal No.", "Personal No.");
                IF Vend.FIND('-') THEN BEGIN
                    REPEAT
                        Vend."Formation/Province" := "Formation/Province";
                        Vend.MODIFY;
                    UNTIL Vend.NEXT = 0;
                END;
            end;
        }
        field(68065; "Division/Department"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Departments"."No.";
        }
        field(68066; "Station/Sections"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Section"."No.";
        }
        field(68067; "Neg. Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(68068; "Date Renewed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68069; "Last Interest Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Check the flowfield';
        }
        field(68070; "Don't Transfer to Savings"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68071; "Type Of Organisation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Club,Association,Partnership,Investment,Merry go round,Other';
            OptionMembers = " ",Club,Association,Partnership,Investment,"Merry go round",Other;
        }
        field(68072; "Source Of Funds"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Business Receipts,Income from Investment,Salary,Other';
            OptionMembers = " ","Business Receipts","Income from Investment",Salary,Other;
        }
        field(68073; "S-Mobile No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(68074; "FOSA Default Dimension"; Integer)
        {
            CalcFormula = Count("Default Dimension" WHERE("Table ID" = CONST(23),
                                                           "No." = FIELD("No."),
                                                           "Dimension Value Code" = CONST('FOSA')));
            FieldClass = FlowField;
        }
        field(68094; "ATM Prov. No"; Code[18])
        {
            DataClassification = ToBeClassified;
        }
        field(68095; "ATM Approve"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                StatusPermissions: Record "Status Change Permision";
            begin
                IF "ATM Approve" = TRUE THEN BEGIN
                    StatusPermissions.RESET;
                    StatusPermissions.SETRANGE(StatusPermissions."User ID", USERID);
                    StatusPermissions.SETRANGE(StatusPermissions."Function", StatusPermissions."Function"::"ATM Approval");
                    IF StatusPermissions.FIND('-') = FALSE THEN
                        ERROR('You do not have permissions to do an Atm card approval');
                    "Card No." := "ATM Prov. No";
                    "Atm card ready" := FALSE;
                    MODIFY;
                END;
            end;
        }
        field(68096; "Dividend Paid"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter"),
                                                                                   //"Document No."=CONST("DIVIDEND"),
                                                                                   "Posting Date" = CONST(20110403D)));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68120; "Force No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(68121; "Card Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68122; "Card Valid From"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68123; "Card Valid To"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69002; Service; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(69005; Reconciled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69009; "FD Duration"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                interestCalc: Record "FD Interest Calculation Crite";
                FDDuration: Integer;
            begin
                /* IF "Account Type"='FIXED' THEN
                  "FD Maturity Date":="Registration Date"+("FD Duration"*30);
                  MODIFY;*/
                /*
               interestCalc.RESET;
               interestCalc.SETRANGE(interestCalc.Code,"Fixed Deposit Type");
               interestCalc.SETRANGE(interestCalc."No of Months","FD Duration");
               IF interestCalc.FIND('-') THEN BEGIN
               "Interest rate":=interestCalc."Interest Rate";
               END;
               */
                IF "Account Type" = '503' THEN BEGIN
                    TESTFIELD("Registration Date");
                    "FD Maturity Date" := CALCDATE(format("FD Duration") + 'M', TODAY);
                    //"FD Maturity Date":=CALCDATE("FD Duration",TODAY);
                END;


                IF "Account Type" = '503' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc."No of Months", "FD Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        "Interest rate" := interestCalc."Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("Amount to Transfer" * interestCalc."Interest Rate" / 100) / 12) * interestCalc."No of Months", 1);
                    END;
                END;

                IF "Account Type" = 'CALLDEPOSIT' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc."No of Months", "FD Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        "Interest rate" := interestCalc."On Call Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        //"Expected Interest On Term Dep":=ROUND((("Amount to Transfer"*interestCalc."On Call Interest Rate"/100)/12)*interestCalc."No of Months",1);
                    END;
                END;

            end;
        }
        field(69010; "Employer P/F"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(69017; "Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69018; "Atm card ready"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var

                StatusPermissions: Record "Status Change Permision";

            begin
                IF "Atm card ready" = TRUE THEN BEGIN
                    StatusPermissions.RESET;
                    StatusPermissions.SETRANGE(StatusPermissions."User ID", USERID);
                    StatusPermissions.SETRANGE(StatusPermissions."Function", StatusPermissions."Function"::"Atm card ready");
                    IF StatusPermissions.FIND('-') = FALSE THEN
                        ERROR('You do not have permission to change atm status');
                END;
            end;
        }
        field(69019; "Current Shares"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69020; "Debtor Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'FOSA Account,Micro Finance';
            OptionMembers = "FOSA Account","Micro Finance";
        }
        field(69021; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69022; "Group Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69023; "Shares Recovered"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69024; "Group Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69025; "Old Bosa Acc no"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69026; "Group Loan Balance"; Decimal)
        {
            CalcFormula = - Sum("Cust. Ledger Entry".Amount WHERE("Transaction Type" = FILTER("Junior Savings" | "FOSA Shares"), "Group Code" = FIELD("Group Code")));
            FieldClass = FlowField;
        }
        field(69027; CodeDelete; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69028; "ContactPerson Occupation"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69029; "ContacPerson Phone"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69031; "ClassB Shares"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69032; "Date ATM Linked"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69033; "ATM No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69034; "Reason For Blocking Account"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69035; "Uncleared Loans"; Decimal)
        {
            //todo
            CalcFormula = Sum("Loans Register"."Net Payment to FOSA" WHERE("Account No" = FIELD("No."),
                                                                            Posted = FILTER(true),
                                                                            "Processed Payment" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(69036; NetDis; Decimal)
        {
            //todo
            CalcFormula = Sum("Loans Register"."Net Payment to FOSA" WHERE("Account No" = FIELD("No."),
                                                                                "Processed Payment" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(69037; "Transfer Amount to Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69038; "Notice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69039; "Account Frozen"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(69040; "Interest rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69041; "Fixed duration2"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(69042; "FDR Deposit Status Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,New,Renewed,Terminated';
            OptionMembers = " ",New,Renewed,Terminated;
        }
        field(69043; "ATM Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69044; "ATM Issued"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69045; "ATM Self Picked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69046; "ATM Collector Name"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69047; "ATM Collector's ID"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69048; "ATM Collector's Mobile"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69049; Test; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(69050; "Outstanding Loans"; Decimal)
        {
            CalcFormula = Sum("Cust. Ledger Entry".Amount WHERE("FOSA Account No." = FIELD("No."),
                                                                  "Transaction Type" = FILTER("Share Capital" | "Interest Paid" | "FOSA Shares"),
                                                                  "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(69051; "Outstanding Interest"; Decimal)
        {
            CalcFormula = Sum("Cust. Ledger Entry".Amount WHERE("FOSA Account No." = FIELD("No."),
                                                                  "Transaction Type" = FILTER("Deposit Contribution" | "Insurance Contribution"),
                                                                  "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(69052; "Cheque Book Account No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69053; "Home Postal Code"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
        }
        field(69090; "Postal Code 2"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
        }
        field(69091; "Town 2"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69092; "Passport 2"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69093; "Member Parish 2"; Code[15])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(69094; "Member Parish Name 2"; Text[15])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(69095; "Name of the Group/Corporate"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69096; "Date of Registration"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69097; "No of Members"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(69098; "Group/Corporate Trade"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69099; "Certificate No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69100; "ID No.2"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69101; "Picture 2"; BLOB)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            SubType = Bitmap;
        }
        field(69102; "Signature  2"; BLOB)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            SubType = Bitmap;
        }
        field(69103; Title2; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69104; "Mobile No. 3"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69105; "Date of Birth2"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                GenSetUp: Record "Sacco General Set-Up";
            begin
                IF "Date of Birth" > TODAY THEN
                    ERROR('Date of birth cannot be greater than today');


                IF "Date of Birth" <> 0D THEN BEGIN
                    IF GenSetUp.GET() THEN BEGIN
                        IF CALCDATE(GenSetUp."Min. Member Age", "Date of Birth") > TODAY THEN
                            ERROR('Applicant bellow the mininmum membership age of %1', GenSetUp."Min. Member Age");
                    END;
                END;
            end;
        }
        field(69106; "Marital Status2"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69107; Gender2; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(69108; "Address3-Joint"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69109; "Home Postal Code2"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                /*PostCode.RESET;
                PostCode.SETRANGE(PostCode.Code,"Home Postal Code2");
                IF PostCode.FIND('-') THEN BEGIN
                "Home Town":=PostCode.City
                END;
                */

            end;
        }
        field(69110; "Home Town2"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69111; "Payroll/Staff No2"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(69112; "Employer Code2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                /*Employer.GET("Employer Code");
                "Employer Name":=Employer.Description;
                */

            end;
        }
        field(69113; "Employer Name2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69114; "E-Mail (Personal2)"; Text[25])
        {
            DataClassification = ToBeClassified;
        }
        field(69115; "Contact Person Phone"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69116; "ContactPerson Relation"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Relationship Types";
        }
        field(69117; "Recruited By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                /*ve.RESET;
                Cust.SETRANGE(Cust."No.","Recruited By");
                IF Cust.FIND('-') THEN BEGIN
                "Recruiter Name":=Cust.Name;
               END;
               */

            end;
        }
        field(69119; Dioces; Code[10])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(69120; "Mobile No. 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69121; "Employer Name"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69122; Title; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69123; Town; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(69124; "Received 1 Copy Of ID"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69125; "Received 1 Copy Of Passport"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69126; "Specimen Signature"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69128; Created; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69129; "Incomplete Application"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69130; "Created By"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69131; "Assigned No."; Code[20])
        {
            CalcFormula = Lookup(Customer."No." WHERE("ID No." = FIELD("ID No.")));
            FieldClass = FlowField;
        }
        field(69132; "Home Town"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69133; "Recruiter Name"; Text[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(69134; "Copy of Current Payslip"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69135; "Member Registration Fee Receiv"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69137; "Copy of KRA Pin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69138; "Contact person age"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /* IF "Contact person age" > TODAY THEN
                 ERROR('Age cannot be greater than today');
                
                
                IF "Contact person age" <> 0D THEN BEGIN
                IF GenSetUp.GET() THEN BEGIN
                IF CALCDATE(GenSetUp."Min. Member Age","Contact person age") > TODAY THEN
                ERROR('Contact person should be atleast 18years and above %1',GenSetUp."Min. Member Age");
                END;
                END;  */

            end;
        }
        field(69139; "First member name"; Text[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(69140; "Date Establish"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69141; "Registration No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69142; "Self Recruited"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69143; "Relationship With Recruiter"; Code[15])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(69144; "Application Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New Application,Rejoining,Transfer';
            OptionMembers = "New Application",Rejoining,Transfer;
        }
        field(69145; "Members Parish"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            TableRelation = "Member's Parishes".Code;

            trigger OnValidate()
            var
                Parishes: Record "Member's Parishes";
                GenSetUp: Record "Sacco General Set-Up";
            begin
                Parishes.RESET;
                Parishes.SETRANGE(Parishes.Code, "Members Parish");
                IF Parishes.FIND('-') THEN BEGIN
                    "Parish Name" := Parishes.Description;
                END;
            end;
        }
        field(69146; "Parish Name"; Text[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(69147; "Employment Info"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Employed,UnEmployed,Contracting,Others';
            OptionMembers = " ",Employed,UnEmployed,Contracting,Others;
        }
        field(69148; "Contracting Details"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69149; "Others Details"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69150; "Contact Person"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69151; "Office Telephone No."; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(69152; "Extension No."; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(69153; "On Term Deposit Maturity"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Pay to FOSA Account_ Deposit+Interest,Roll Back Deposit+Interest,Roll Back Deposit Only';
            OptionMembers = " ","Pay to FOSA Account_ Deposit+Interest","Roll Back Deposit+Interest","Roll Back Deposit Only";
        }
        field(69154; "Member's Residence"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(69155; "Joint Account Name"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(69156; "Postal Code 3"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
        }
        field(69157; "Town 3"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69158; "Passport 3"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69159; "Member Parish 3"; Code[10])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(69160; "Member Parish Name 3"; Text[15])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(69161; "Picture 3"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(69162; "Signature  3"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(69163; Title3; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69164; "Mobile No. 3-Joint"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69165; "Date of Birth3"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                GenSetUp: Record "Sacco General Set-Up";

            begin
                IF "Date of Birth" > TODAY THEN
                    ERROR('Date of birth cannot be greater than today');


                IF "Date of Birth" <> 0D THEN BEGIN
                    IF GenSetUp.GET() THEN BEGIN
                        IF CALCDATE(GenSetUp."Min. Member Age", "Date of Birth") > TODAY THEN
                            ERROR('Applicant bellow the mininmum membership age of %1', GenSetUp."Min. Member Age");
                    END;
                END;
            end;
        }
        field(69166; "Marital Status3"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69167; Gender3; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(69168; Address3; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69169; "Home Postal Code3"; Code[15])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Post Code";

            trigger OnValidate()
            begin
                // PostCode.RESET;
                // PostCode.SETRANGE(PostCode.Code,"Home Postal Code");
                // IF PostCode.FIND('-') THEN BEGIN
                // "Home Town":=PostCode.City
                // END;
            end;
        }
        field(69170; "Home Town3"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69171; "Payroll/Staff No3"; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(69172; "Employer Code3"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                /*Employer.GET("Employer Code");
                "Employer Name":=Employer.Description;
                */

            end;
        }
        field(69173; "Employer Name3"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69174; "E-Mail (Personal3)"; Text[25])
        {
            DataClassification = ToBeClassified;
        }
        field(69175; "Name 3"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(69176; "ID No.3"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69177; "Mobile No. 4"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69178; Address4; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69179; "Expected Interest On Term Dep"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69180; "Current Account Balance"; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("Savings Account No."),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter")));
            FieldClass = FlowField;
        }
        field(69181; "Allowable Cheque Discounting %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69182; "Cheque Discounted"; Decimal)
        {
            //todo
            CalcFormula = Sum(Transactions."Cheque Discounted Amount" WHERE("Account No" = FIELD("No."),
                                                                             Posted = CONST(true),
                                                                             "Cheque Processed" = CONST(false),
                                                                             "Type _Transactions" = CONST("Cheque Deposit")));
            FieldClass = FlowField;
        }
        field(69183; "Mobile Transactions"; Decimal)
        {
            CalcFormula = Sum("CloudPESA Transactions".Amount WHERE(Posted = CONST(false),
                                                                     Status = CONST(Pending)));
            FieldClass = FlowField;
        }
        field(69184; "Staff Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69185; "Debt Collector"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69186; "Debt Collector %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69187; "Comission On Cheque Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69188; "Fixed Deposit Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69189; "Prevous Fixed Deposit Type"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69190; "Prevous FD Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69191; "Prevous Fixed Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(69192; "Prevous Expected Int On FD"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69193; "Prevous FD Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69194; "Prevous FD Deposit Status Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Matured;
        }
        field(69195; "Prevous Interest Rate FD"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69196; "Last Interest Earned Date"; Date)
        {
            //todo
            CalcFormula = Max("Interest Buffer"."Interest Date" WHERE("Account No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(69197; "Last Salary Earned"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69198; "Reason for Freezing Account"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69199; "Account Frozen By"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69200; "Fixed Deposit Certificate No."; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69201; "E-Loan Qualification Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69202; "Pension No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69203; "Doublicate Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69204; "Assigned System ID"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(69205; "Prevous Blocked Status"; enum "Vendor Blocked")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,Payment,All';
            // OptionMembers = " ",Payment,All;
        }
        field(69206; "Untransfered interest Savings"; Decimal)
        {
            // CalcFormula = Sum("Interest Buffer Savings"."Interest Amount" WHERE ("Account No"=FIELD("No."),
            //                                                                      Transferred=FILTER(false)));
            // FieldClass = FlowField;
        }
        field(69207; "Sacco No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69208; "Account Book Balance"; Decimal)
        {
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                          "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(69209; "Account Special Instructions"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69210; "Cheque Discounted Amount"; Decimal)
        {
            //todo"
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Cheque Discounted Amount" where("Account No." = field("No."), Posted = const(true),
            Type = const('Cheque Deposit'),
            "Cheque Processed" = filter(false)));
        }

        field(69211; "Bulk Withdrawal Appl Done"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69212; "Bulk Withdrawal Appl Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69213; "Bulk Withdrawal Appl Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69214; "Bulk Withdrawal Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69215; "Bulk Withdrawal App Done By"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69216; "Bulk Withdrawal App Date For W"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69217; "Referee Member No"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                IF Cust.GET("Referee Member No") THEN BEGIN
                    "Referee Name" := Cust.Name;
                    "Referee Mobile Phone No" := Cust."Mobile Phone No";
                    "Referee ID No" := Cust."ID No.";
                END;
            end;
        }
        field(69218; "Referee Name"; Code[25])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(69219; "Referee ID No"; Code[15])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(69220; "Referee Mobile Phone No"; Code[15])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(69221; "Email Indemnified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69222; "Send E-Statements"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69223; "Sacco Lawyer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69224; "ATM Withdrawal Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69225; "No Of Signatories"; Integer)
        {
            CalcFormula = Count("FOSA Account Sign. Details" WHERE("Account No" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69226; "Cheque Clearing No"; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(69227; "Excess Repayment Rule"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Exempt From Excess Rule,Biggest Loan,Smallest Loan,Oldest Loan,Newest Loan';
            OptionMembers = " ","Exempt From Excess Rule","Biggest Loan","Smallest Loan","Oldest Loan","Newest Loan";
        }
        field(69228; "Insurance Company"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69229; "Over Draft Limit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(69230; "Over Draft Limit Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69231; Auctioneer; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69232; "Account Type Name"; Text[50])
        {
            CalcFormula = Lookup("Account Types-Saving Products".Description WHERE(Code = FIELD("Account Type")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69233; "Balance For Reporting"; Decimal)
        {
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                          "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                          "Currency Code" = FIELD("Currency Filter"),
                                                                          "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(69234; "Frozen Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(69235; "Operating Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Self,Jointly';
            OptionMembers = Self,Jointly;
        }
        field(69236; "Account Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69237; "Modified By"; Code[18])
        {
            DataClassification = ToBeClassified;
        }
        field(69238; "Modified On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69239; "Supervised On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69240; "Supervised By"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69241; "Account Closed On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69242; "Account Closed By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69243; "Balance Historical"; Decimal)
        {
            CalcFormula = Sum("Member Historical Ledger Entry".Amount WHERE("Account No." = FIELD("No."),
                                                                             "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(69244; "Transaction Alerts"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,All Debit Transactions,All Credit Transactions,All Transactions';
            OptionMembers = " ","All Debit Transactions","All Credit Transactions","All Transactions";
        }
        field(69245; Dormancy; Boolean)
        {
            CalcFormula = Exist("Detailed Vendor Ledg. Entry" WHERE("Posting Date" = FIELD("Date Filter"),
                                                                     "Vendor No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(69246; "Account Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69247; "KRA Pin"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69248; "Exempt BOSA Penalty"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69249; "Exemption Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69250; "Send To Family Bank"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69251; "Overdraft Sweeping Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'All FOSA Accounts,Specific FOSA Account';
            OptionMembers = "All FOSA Accounts","Specific FOSA Account";
        }
        field(69252; "Specific OD Sweeping Account"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." WHERE("BOSA Account No" = FIELD("BOSA Account No"));
        }
        field(69253; "Minimum Balance"; Decimal)
        {
            CalcFormula = Sum("Account Types-Saving Products"."Minimum Balance" WHERE(Code = FIELD("Account Type")));
            FieldClass = FlowField;
        }
        field(69254; "Deposits Contributed Ver1"; Decimal)
        {
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69255; "OD Under Debt Collection"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69256; "OD Debt Collector"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." WHERE("Debt Collector" = FILTER(true));

            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                Vend.RESET;
                Vend.CALCFIELDS(Vend.Balance);
                Vend.SETRANGE(Vend."No.", "OD Debt Collector");
                IF Vend.FIND('-') THEN BEGIN
                    "OD Debt Collector Interest %" := Vend."Debt Collector %";
                    "OD Under Debt Collection" := TRUE;
                    "Debt Collector Name" := Vend.Name;
                    "Debt Collection date Assigned" := WORKDATE;
                    "OD Bal As At Debt Collection" := Vend.Balance;
                END;
            end;
        }
        field(69257; "OD Debt Collector Interest %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69258; "Debt Collection date Assigned"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69259; "Debt Collector Name"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(69260; "OD Bal As At Debt Collection"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69261; "Dormant Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69262; "Account Dormancy Period"; Boolean)
        {
            CalcFormula = Exist("Account Types-Saving Products" WHERE(Code = FIELD("Account Type"),
                                                                       "Dormancy Period (-M)" = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(69263; "Last Transaction Date_H"; Date)
        {
            AutoFormatType = 1;
            CalcFormula = Max("Member Historical Ledger Entry"."Posting Date" WHERE("Account No." = FIELD("No.")));
            Caption = 'Last Transaction Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(69264; "Last Transaction Date VerII"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69265; "Silver Account No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(69266; piccture; MediaSet)
        {
            DataClassification = ToBeClassified;
        }


    }

    // Global Variables

    var
        AccountTypes: Record "Account Types-Saving Products";
        FDType: Record "Fixed Deposit Type";
        ReplCharge: Decimal;
        Vends: Record Vendor;
        gnljnlLine: Record "Gen. Journal Line";
        FOSAAccount: Record Vendor;
        Member: Record Customer;
        Vend: Record Vendor;
        Loans: Record "Loans Register";
        // StatusPermissions: Record "Status Change Permision";
        interestCalc: Record "FD Interest Calculation Crite";
        GenSetUp: Record "Sacco General Set-Up";
        Parishes: Record "Member's Parishes";
        FDDuration: Integer;
        Cust: Record Customer;


}