tableextension 50007 "customertableEXT" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(68000; "Customer Type"; Option)
        {
            OptionCaption = ' ,Member,FOSA,Investments,Property,MicroFinance';
            OptionMembers = " ",Member,FOSA,Investments,Property,MicroFinance;
        }
        field(68001; "Registration Date"; Date)
        {
        }
        field(68002; "Current Loan"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                  "Transaction Type" = const("Share Capital"),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68003; "Current Shares"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Deposit Contribution"),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68004; "Total Repayments"; Decimal)
        {
            Editable = false;
        }
        field(68005; "Principal Balance"; Decimal)
        {
        }
        field(68006; "Principal Repayment"; Decimal)
        {
        }
        field(68008; "Debtors Type"; Option)
        {
            OptionCaption = ' ,Staff,Client,Others';
            OptionMembers = " ",Staff,Client,Others;
        }
        field(68011; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Loan Repayment" | Loan)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68012; Status; Option)
        {
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New,Awaiting Withdrawal,Archived';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New,"Awaiting Withdrawal",Archived;

            trigger OnValidate()
            begin
                //Advice:=TRUE;
                //"Status Change Date" := TODAY;
                //"Last Marking Date" := TODAY;
                //MODIFY;
                /*
                IF xRec.Status=xRec.Status::Deceased THEN
                ERROR('Deceased status cannot be changed');
                
                Vend2.RESET;
                Vend2.SETRANGE(Vend2."Staff No","Payroll/Staff No");
                Vend2.SETRANGE(Vend2."Account Type",'PRIME');
                IF Vend2.FIND('-') THEN BEGIN
                REPEAT
                IF Status = Status::Deceased THEN BEGIN
                IF (Vend2."Account Type"<>'JUNIOR') THEN BEGIN
                Vend2.Status:=Vend2.Status::"6";
                Vend2.Blocked:=Vend2.Blocked::All;
                Vend2.MODIFY;
                END;
                END;
                UNTIL Vend2.NEXT = 0;
                END;
                
                //Charge Entrance fee on reinstament
                IF Status=Status::"Re-instated" THEN BEGIN
                GenSetUp.GET(0);
                "Registration Fee":=GenSetUp."Registration Fee";
                MODIFY;
                END;
                
                IF (Status<>Status::Active) OR (Status<>Status::Dormant) THEN
                Blocked:=Blocked::All;
                 */

            end;
        }
        field(68013; "FOSA Account No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(68015; "Old Account No."; Code[10])
        {
        }
        field(68016; "Loan Product Filter"; Code[15])
        {
            FieldClass = FlowFilter;
            TableRelation = "Loan Products Setup".Code;
        }
        field(68017; "Employer Code"; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                Vend2.Reset;
                Vend2.SetRange(Vend2."Personal No.", "Personal No");
                if Vend2.Find('-') then begin
                    repeat
                        Vend2."Employer Code" := "Employer Code";
                        Vend2.Modify;
                    until Vend2.Next = 0;
                end;

                Employer.Reset;
                Employer.SetRange(Code, "Employer Code");
                if Employer.Find('-') then begin
                    "Employer Name" := Employer.Description;
                end
            end;
        }
        field(68018; "Date of Birth"; Date)
        {

            trigger OnValidate()
            begin
                /*IF "Date of Birth" <> 0D THEN BEGIN
                IF GenSetUp.GET(0) THEN BEGIN
                IF CALCDATE(GenSetUp."Min. Member Age","Date of Birth") > TODAY THEN
                ERROR('Applicant bellow the mininmum membership age of %1',GenSetUp."Min. Member Age");
                END;
                END;*/
                /*
              IF "Date of Birth" > TODAY THEN
              ERROR('Date of birth cannot be greater than today');
               */

            end;
        }
        field(68019; "E-Mail (Personal)"; Text[70])
        {
        }
        field(68020; "Station/Department"; Code[20])
        {
            TableRelation = "Member Section"."No.";
        }
        field(68021; "Home Address"; Text[20])
        {
        }
        field(68022; Location; Text[20])
        {
        }
        field(68023; "Sub-Location"; Text[2])
        {
        }
        field(68024; District; Text[25])
        {
        }
        field(68025; "Resons for Status Change"; Text[20])
        {
        }
        field(68026; "Personal No"; Code[20])
        {

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange("BOSA Account No", "No.");
                if Vend.Find('-') then begin
                    Vend."Personal No." := "Personal No";
                    Vend.Modify;
                end
            end;
        }
        field(68027; "ID No."; Code[40])
        {

            trigger OnValidate()
            begin
                if "ID No." <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."ID No.", "ID No.");
                    Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                    if Cust.Find('-') then begin
                        // IF Cust."No." <> "No." THEN
                        //  // ERROR('ID No. /exists');
                    end;
                end;

                Vend2.Reset;
                Vend2.SetRange(Vend2."BOSA Account No", "No.");
                if Vend2.Find('-') then begin
                    repeat
                        Vend2."ID No." := "ID No.";
                        Vend2.Modify;
                    until Vend2.Next = 0;
                end;
            end;
        }
        field(68028; "Mobile Phone No"; Code[12])
        {
        }
        field(68029; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Divorced,Widower,Separated';
            OptionMembers = " ",Single,Married,Divorced,Widower,Separated;
        }
        field(68030; Signature; MediaSet)
        {
            Caption = 'Signature';
            Editable = false;
        }
        field(68031; "Passport No."; Code[10])
        {
        }
        field(68032; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;

            trigger OnValidate()
            begin
                Vend2.Reset;
                Vend2.SetRange(Vend2."Personal No.", "Personal No");
                if Vend2.Find('-') then begin
                    repeat
                        Vend2.Gender := Gender;
                        Vend2.Modify;
                    until Vend2.Next = 0;
                end;
            end;
        }
        field(68033; "Withdrawal Date"; Date)
        {
        }
        field(68034; "Withdrawal Fee"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(68035; "Status - Withdrawal App."; Option)
        {
            CalcFormula = lookup("Membership Exit".Status where("Member No." = field("No.")));
            FieldClass = FlowField;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;

            trigger OnValidate()
            begin
                //"Approval Date":=TODAY;


                /*IF "Status - Withdrawal App." = "Status - Withdrawal App."::Approved THEN BEGIN
                TESTFIELD("Closure Remarks");
                
                CALCFIELDS("Outstanding Balance","Accrued Interest","Current Shares","Insurance Fund","FOSA Outstanding Balance",
                           "FOSA Oustanding Interest");
                
                CALCFIELDS("Outstanding Balance");
                IF ("Outstanding Balance"+"Accrued Interest"+"FOSA Outstanding Balance"+"FOSA Oustanding Interest") +
                   ("Current Shares"+"Insurance Fund") > 0 THEN
                IF CONFIRM('Member shares deposits and insurance fund not enough to clear loan. Do you wish to continue') = FALSE THEN
                ERROR('Approval terminated.');
                
                END; */

            end;
        }
        field(68036; "Withdrawal Application Date"; Date)
        {

            trigger OnValidate()
            begin
                // IF "Withdrawal Application Date" <> 0D THEN
                // "Withdrawal Date":=CALCDATE('2M',"Withdrawal Application Date");
                //
                // GenSetUp.GET();
                // "Withdrawal Fee":=GenSetUp."Withdrawal Fee";
                // Status:=Status::"Awaiting Withdrawal";
                // Blocked:=Blocked::All;
                CDays := 60;

                EMaturity := "Withdrawal Application Date";
                if i < CDays then begin
                    repeat
                        EMaturity := CalcDate('1D', EMaturity);
                        if (Date2dwy(EMaturity, 1) <> 6) and (Date2dwy(EMaturity, 1) <> 7) then
                            i := i + 1;

                    until i = CDays;
                end;

                "Withdrawal Date" := EMaturity
            end;
        }
        field(68037; "Investment Monthly Cont"; Decimal)
        {
        }
        field(68038; "Investment Max Limit."; Decimal)
        {
        }
        field(68039; "Current Investment Total"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Loan Insurance Charged"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68040; "Document No. Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(68041; "Shares Retained"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Share Capital"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68043; "Registration Fee Paid"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                           "Transaction Type" = const("Registration Fee")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68044; "Registration Fee"; Decimal)
        {
        }
        field(68045; "Society Code"; Code[10])
        {
        }
        field(68046; "Insurance Fund"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Insurance Contribution"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68047; "Monthly Contribution"; Decimal)
        {

            trigger OnValidate()
            begin
                //SURESTEP - Check Min Contractual Shares
                /*IF GenSetUp."Contactual Shares (%)" <> 0 THEN BEGIN
                IF "Monthly Contribution" <> 0 THEN BEGIN
                GenSetUp.GET(0);
                
                Loans.RESET;
                Loans.SETRANGE(Loans."Client Code","No.");
                IF Loans.FIND('-') THEN BEGIN
                REPEAT
                Loans.CALCFIELDS(Loans."Outstanding Balance");
                IF (Loans."Outstanding Balance" > 0) THEN BEGIN
                IF MinShares < ((Loans."Approved Amount"* GenSetUp."Contactual Shares (%)")*0.01) THEN
                MinShares:=(Loans."Approved Amount"* GenSetUp."Contactual Shares (%)")*0.01;
                END;
                UNTIL Loans.NEXT = 0;
                END;
                
                IF MinShares > GenSetUp."Max. Contactual Shares" THEN
                MinShares := GenSetUp."Max. Contactual Shares";
                
                
                IF MinShares < GenSetUp."Min. Contribution" THEN
                MinShares := GenSetUp."Min. Contribution";
                
                IF "Monthly Contribution" <  MinShares THEN
                ERROR('Monthly contribution cannot be less than the contractual shares i.e. %1',MinShares);
                
                END;
                END;
                
                IF xRec."Monthly Contribution" <> 0 THEN BEGIN
                Advice:=TRUE;
                "Advice Type":="Advice Type"::"Shares Adjustment";
                END;
                
                //SURESTEP - Check Min Contractual Shares
                
                "Previous Share Contribution":=xRec."Monthly Contribution"; */


                "Previous Share Contribution" := xRec."Monthly Contribution";



                Advice := true;
                //"Advice Type":="Advice Type"::Adjustment;
                /*
                
                DataSheet.INIT;
                DataSheet."PF/Staff No":="Personal No";
                DataSheet."Type of Deduction":='Shares/Deposits';
                DataSheet."Remark/LoanNO":='ADJ FORM';
                DataSheet.Name:=Name;
                DataSheet."ID NO.":="ID No.";
                DataSheet."Amount ON":="Monthly Contribution";
                DataSheet."REF.":='2026';
                DataSheet."New Balance":="Current Shares"*-1;
                DataSheet.Date:=TODAY;
                DataSheet."Amount OFF":=xRec."Monthly Contribution";
                DataSheet.Employer:="Employer Code";
                DataSheet."Transaction Type":=DataSheet."Transaction Type"::ADJUSTMENT;
                //DataSheet."Sort Code":=PTEN;
                DataSheet.INSERT;
                */

            end;
        }
        field(68048; "Investment B/F"; Decimal)
        {
        }
        field(68049; "Dividend Amount"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const(Dividend),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            FieldClass = FlowField;
        }
        field(68050; "Name of Chief"; Text[10])
        {
        }
        field(68051; "Office Telephone No."; Code[10])
        {
        }
        field(68052; "Extension No."; Code[10])
        {
        }
        field(68053; "Welfare Contribution"; Decimal)
        {

            trigger OnValidate()
            begin
                //Advice:=TRUE;
            end;
        }
        field(68054; Advice; Boolean)
        {
        }
        field(68055; Province; Code[10])
        {
            Enabled = false;
        }
        field(68056; "Previous Share Contribution"; Decimal)
        {
        }
        field(68057; "Un-allocated Funds"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Unallocated Funds"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68058; "Refund Request Amount"; Decimal)
        {
            Editable = false;
        }
        field(68059; "Refund Issued"; Boolean)
        {
            Editable = false;
        }
        field(68060; "Batch No."; Code[15])
        {
            Enabled = false;

            trigger OnValidate()
            begin
                /*IF "Refund Issued"=TRUE THEN BEGIN
                RefundsR.RESET;
                RefundsR.SETRANGE(RefundsR."Member No.","No.");
                IF RefundsR.FIND('-') THEN
                RefundsR.DELETEALL;
                
                "Refund Issued":=FALSE;
                END;
                
                IF "Batch No." <> '' THEN BEGIN
                MovementTracker.RESET;
                MovementTracker.SETRANGE(MovementTracker."Document No.","Batch No.");
                MovementTracker.SETRANGE(MovementTracker."Current Location",TRUE);
                IF MovementTracker.FIND('-') THEN BEGIN
                ApprovalsUsers.RESET;
                ApprovalsUsers.SETRANGE(ApprovalsUsers."Approval Type",MovementTracker."Approval Type");
                ApprovalsUsers.SETRANGE(ApprovalsUsers.Stage,MovementTracker.Stage);
                ApprovalsUsers.SETRANGE(ApprovalsUsers."User ID",USERID);
                IF ApprovalsUsers.FIND('-') = FALSE THEN
                ERROR('You cannot assign a batch which is in %1.',MovementTracker.Station);
                
                END;
                END; */

            end;
        }
        field(68061; "Current Status"; Option)
        {
            OptionMembers = Approved,Rejected;
        }
        field(68062; "Cheque No."; Code[10])
        {
        }
        field(68063; "Cheque Date"; Date)
        {
        }
        field(68064; "Accrued Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Deposit Contribution")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68065; "Defaulted Loans Recovered"; Boolean)
        {
        }
        field(68066; "Withdrawal Posted"; Boolean)
        {
        }
        field(68069; "Loan No. Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("No."));
        }
        field(68070; "Currect File Location"; Code[10])
        {
            CalcFormula = max("File Movement Tracker".Station where("Member No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68071; "Move To1"; Integer)
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));
        }
        field(68073; "File Movement Remarks"; Text[10])
        {
        }
        field(68076; "Status Change Date"; Date)
        {
        }
        field(68077; "Last Payment Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No."),
                                                                          "Credit Amount" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(68078; "Discounted Amount"; Decimal)
        {
        }
        field(68079; "Current Savings"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(68080; "Payroll Updated"; Boolean)
        {
        }
        field(68081; "Last Marking Date"; Date)
        {
        }
        field(68082; "Dividends Capitalised %"; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF ("Dividends Capitalised %" < 0) OR ("Dividends Capitalised %" > 100) THEN
                ERROR('Invalied Entry.');*/

            end;
        }
        field(68083; "FOSA Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Share Capital" | "Interest Paid" | "FOSA Shares")));
            FieldClass = FlowField;
        }
        field(68084; "FOSA Oustanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(68085; "Formation/Province"; Code[10])
        {

            trigger OnValidate()
            begin
                /*Vend.RESET;
                Vend.SETRANGE(Vend."Staff No","Payroll/Staff No");
                IF Vend.FIND('-') THEN BEGIN
                REPEAT
                Vend."Formation/Province":="Formation/Province";
                Vend.MODIFY;
                UNTIL Vend.NEXT=0;
                END;*/

            end;
        }
        field(68086; "Division/Department"; Code[10])
        {
            TableRelation = "Member Departments"."No.";
        }
        field(68087; "Station/Section"; Code[10])
        {
            // TableRelation = "prTax Law".Field1;
        }
        field(68088; "Closing Deposit Balance"; Decimal)
        {
        }
        field(68089; "Closing Loan Balance"; Decimal)
        {
        }
        field(68090; "Closing Insurance Balance"; Decimal)
        {
        }
        field(68091; "Dividend Progression"; Decimal)
        {
        }
        field(68092; "Closing Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68093; "Welfare Fund"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Transaction Type" = filter("School Fees"),
                                                                   "Customer No." = field("No."),
                                                                   "Transaction Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68094; "Discounted Dividends"; Decimal)
        {
        }
        field(68095; "Mode of Dividend Payment"; Option)
        {
            OptionCaption = ' ,FOSA,EFT,Cheque,Defaulted Loan (Capitalised)';
            OptionMembers = " ",FOSA,EFT,Cheque,"Defaulted Loan";
        }
        field(68096; "Qualifying Shares"; Decimal)
        {
        }
        field(68097; "Defaulter Overide Reasons"; Text[10])
        {
        }
        field(68098; "Defaulter Overide"; Boolean)
        {

            trigger OnValidate()
            begin
                /*TESTFIELD("Defaulter Overide Reasons");
                
                StatusPermissions.RESET;
                StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Loan External EFT");
                IF StatusPermissions.FIND('-') = FALSE THEN
                ERROR('You do not have permissions to overide defaulters.'); */

            end;
        }
        field(68099; "Closure Remarks"; Text[10])
        {
        }
        field(68100; "Bank Account No."; Code[10])
        {
        }
        field(68101; "Bank Code"; Code[10])
        {
            TableRelation = "Member App Signatories"."Account No";
            ValidateTableRelation = false;
        }
        field(68102; "Dividend Processed"; Boolean)
        {
        }
        field(68103; "Dividend Error"; Boolean)
        {
        }
        field(68104; "Dividend Capitalized"; Decimal)
        {
        }
        field(68105; "Dividend Paid FOSA"; Decimal)
        {
        }
        field(68106; "Dividend Paid EFT"; Decimal)
        {
        }
        field(68107; "Dividend Withholding Tax"; Decimal)
        {
        }
        field(68109; "Loan Last Payment Date"; Date)
        {
            FieldClass = Normal;
        }
        field(68110; "Outstanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(68111; "Last Transaction Date"; Date)
        {
            FieldClass = Normal;
        }
        field(68112; "Account Category"; Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Parish,Church,Church Department,Staff';
            OptionMembers = Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff;
        }
        field(68113; "Type Of Organisation"; Option)
        {
            OptionCaption = ' ,Club,Association,Partnership,Investment,Merry go round,Other,Group';
            OptionMembers = " ",Club,Association,Partnership,Investment,"Merry go round",Other,Group;
        }
        field(68114; "Source Of Funds"; Option)
        {
            OptionCaption = ' ,Business Receipts,Income from Investment,Salary,Other';
            OptionMembers = " ","Business Receipts","Income from Investment",Salary,Other;
        }
        field(68115; "MPESA Mobile No"; Code[15])
        {
        }
        field(68120; "Force No."; Code[10])
        {
            Enabled = false;
        }
        field(68121; "Last Advice Date"; Date)
        {
        }
        field(68122; "Advice Type"; Option)
        {
            OptionMembers = " ","New Member","Shares Adjustment","ABF Adjustment","Registration Fees",Withdrawal,Reintroduction,"Reintroduction With Reg Fees";
        }
        field(68137; "Signing Instructions"; Option)
        {
            OptionCaption = 'Any to Sign,Two to Sign,Three to Sign,All to Sign';
            OptionMembers = "Any to Sign","Two to Sign","Three to Sign","All to Sign";
        }
        field(68140; "Share Balance BF"; Decimal)
        {
        }
        field(68143; "Move to"; Integer)
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));

            trigger OnValidate()
            begin
                Approvalsetup.Reset;
                Approvalsetup.SetRange(Approvalsetup.Stage, "Move to");
                if Approvalsetup.Find('-') then begin
                    "Move to description" := Approvalsetup.Station;
                end;
            end;
        }
        field(68144; "File Movement Remarks1"; Option)
        {
            OptionCaption = ' ,Reconciliation purposes,Auditing purposes,Refunds,Loan & Signatories,Withdrawal,Risks payment,Cheque Payment,Custody,Document Filing,Passbook,Complaint Letters,Defaulters,Dividends,Termination,New Members Details,New Members Verification';
            OptionMembers = " ","Reconciliation purposes","Auditing purposes",Refunds,"Loan & Signatories",Withdrawal,"Risks payment","Cheque Payment",Custody,"Document Filing",Passbook,"Complaint Letters",Defaulters,Dividends,Termination,"New Members Details","New Members Verification";
        }
        field(68145; "File MVT User ID"; Code[10])
        {
            Enabled = false;
        }
        field(68146; "File MVT Time"; Time)
        {
        }
        field(68147; "File Previous Location"; Code[10])
        {
            Enabled = false;
        }
        field(68148; "File MVT Date"; Date)
        {
        }
        field(68149; "file received date"; Date)
        {
        }
        field(68150; "File received Time"; Time)
        {
        }
        field(68151; "File Received by"; Code[10])
        {
        }
        field(68152; "file Received"; Boolean)
        {
        }
        field(68153; User; Code[20])
        {
            TableRelation = "User Setup";
        }
        field(68154; "Change Log"; Integer)
        {
            CalcFormula = count("Change Log Entry" where("Primary Key Field 1 Value" = field("No.")));
            FieldClass = FlowField;
        }
        field(68155; Section; Code[10])
        {
            TableRelation = if (Section = const('')) "HR Leave Carry Allocation".Status;
        }
        field(68156; rejoined; Boolean)
        {
        }
        field(68157; "Job title"; Code[10])
        {
        }
        field(68158; Pin; Code[20])
        {
        }
        field(68160; "Remitance mode"; Option)
        {
            OptionCaption = ',Check off,Cash,Standing Order';
            OptionMembers = ,"Check off",Cash,"Standing Order";
        }
        field(68161; "Terms of Service"; Option)
        {
            OptionCaption = ',Permanent,Temporary,Contract';
            OptionMembers = ,Permanent,"Temporary",Contract;
        }
        field(68162; Comment1; Text[10])
        {
        }
        field(68163; Comment2; Text[10])
        {
        }
        field(68164; "Current file location"; Code[10])
        {
        }
        field(68165; "Work Province"; Code[10])
        {
            Enabled = false;
        }
        field(68166; "Work District"; Code[10])
        {
            Enabled = false;
        }
        field(68167; "Sacco Branch"; Code[10])
        {
        }
        field(68168; "Bank Branch Code"; Code[20])
        {
        }
        field(68169; "Customer Paypoint"; Code[10])
        {
        }
        field(68170; "Date File Opened"; Date)
        {
        }
        field(68171; "File Status"; Code[10])
        {
        }
        field(68172; "Customer Title"; Code[10])
        {
        }
        field(68173; "Folio Number"; Code[10])
        {
        }
        field(68174; "Move to description"; Text[20])
        {
        }
        field(68175; Filelocc; Integer)
        {
            CalcFormula = max("File Movement Tracker"."Entry No." where("Member No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68176; "S Card No."; Code[10])
        {
        }
        field(68177; "Reason for file overstay"; Text[10])
        {
        }
        field(68179; "Loc Description"; Text[10])
        {
        }
        field(68180; "Current Balance"; Decimal)
        {
        }
        field(68181; "Member Transfer Date"; Date)
        {
        }
        field(68182; "Contact Person"; Code[20])
        {
        }
        field(68183; "Member withdrawable Deposits"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Document No." = field("Document No. Filter"),
                                                                  "Transaction Type" = const(Holiday)));
            FieldClass = FlowField;
        }
        field(68184; "Current Location"; Text[10])
        {
        }
        field(68185; "Group Code"; Code[10])
        {
        }
        field(68186; "Xmas Contribution"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const(Holiday),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68187; "Risk Fund"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Benevolent Fund"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68188; "Office Branch"; Code[10])
        {
        }
        field(68189; Department; Code[15])
        {
            TableRelation = "Member Departments"."No.";
        }
        field(68190; Occupation; Text[20])
        {
        }
        field(68191; Designation; Text[20])
        {
        }
        field(68192; "Village/Residence"; Text[20])
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));
        }
        field(68194; "Contact Person Phone"; Code[20])
        {
        }
        field(68195; "Development Shares"; Decimal)
        {
            // CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
            //                                                       "Transaction Type" = filter(devel),
            //                                                       "Posting Date" = field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(68198; "Recruited By"; Code[20])
        {
            Editable = false;
        }
        field(68200; "ContactPerson Relation"; Code[15])
        {
            TableRelation = "Relationship Types";
        }
        field(68201; "ContactPerson Occupation"; Code[15])
        {
        }
        field(68206; "Insurance on Shares"; Decimal)
        {
        }
        field(68207; Disabled; Boolean)
        {
        }
        field(68212; "Mobile No. 2"; Code[15])
        {
        }
        field(68213; "Employer Name"; Code[50])
        {
        }
        field(68214; Title; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.,Rev.,Capt.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.","Rev.","Capt.";
        }
        field(68215; Town; Code[10])
        {
            Editable = false;
            TableRelation = "Post Code".City;
        }
        field(68222; "Home Town"; Code[10])
        {
            Editable = false;
        }
        field(69038; "Loans Defaulter Status"; Option)
        {
            CalcFormula = lookup("Loans Register"."Loans Category-SASRA" where("Client Code" = field("No.")));
            FieldClass = FlowField;
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(69039; "Home Postal Code"; Code[10])
        {
            TableRelation = "Post Code".Code;
        }
        field(69040; "Total Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment" | "Interest Paid")));
            FieldClass = FlowField;
        }
        field(69041; "No of Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(<> 0),
                                                                 Substituted = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69046; "Member Can Guarantee  Loan"; Boolean)
        {
        }
        field(69047; "FOSA  Account Bal"; Decimal)
        {
            FieldClass = FlowFilter;
            TableRelation = Vendor.Balance where("No." = field("FOSA Account No."));

            trigger OnValidate()
            begin
                if Rec.Get(Rec."FOSA Account No.") then
                    Rec.Reset;
                Rec.SetRange(Rec."FOSA Account No.", Vend."No.");
                Vend.CalcFields(Vend.Balance);
                Rec."FOSA  Account Bal" := Vend.Balance;
                Rec.Modify;
            end;
        }
        field(69048; "Rejoining Date"; Date)
        {
        }
        field(69049; "Active Loans Guarantor"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(> 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69050; "Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Substituted Guarantor" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69051; "Member Deposit Mult 3"; Decimal)
        {
        }
        field(69052; "New loan Eligibility"; Decimal)
        {
        }
        field(69053; "Share Certificate No"; Integer)
        {
        }
        field(69054; "Last Share Certificate No"; Integer)
        {
            CalcFormula = max(Customer."Share Certificate No");
            FieldClass = FlowField;
        }
        field(69055; "No Of Days"; Integer)
        {
        }
        field(69056; "Application No."; Code[10])
        {
        }
        field(69057; "Member Category"; Option)
        {
            OptionCaption = 'New Application,Account Reactivation,Transfer';
            OptionMembers = "New Application","Account Reactivation",Transfer;
        }
        field(69058; "Terms Of Employment"; Option)
        {
            OptionCaption = ' ,Permanent,Temporary,Contract,Private,Probation';
            OptionMembers = " ",Permanent,"Temporary",Contract,Private,Probation;
        }
        field(69059; "Nominee Envelope No."; Code[20])
        {
        }
        field(69060; Defaulter; Boolean)
        {
        }
        field(69061; "Shares Variance"; Decimal)
        {
        }
        field(69062; "Net Dividend Payable"; Decimal)
        {
        }
        field(69063; "Tax on Dividend"; Decimal)
        {
        }
        field(69064; "Div Amount"; Decimal)
        {
        }
        field(69065; "Payroll Agency"; Code[10])
        {
        }
        field(69066; "Introduced By"; Code[20])
        {
            Editable = true;
        }
        field(69067; "Introducer Name"; Text[20])
        {
            Editable = false;
        }
        field(69068; "Introducer Staff No"; Code[20])
        {
        }
        field(69069; BoostedDate; Date)
        {
        }
        field(69070; BoostedAmount; Decimal)
        {
        }
        field(69071; "Bridge Amount Release"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details"."Monthly Repayment" where("Client Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(69072; "Repayment Method"; Option)
        {
            OptionCaption = ' ,Amortised,Reducing Balance,Straight Line,Constants,Ukulima Flat';
            OptionMembers = " ",Amortised,"Reducing Balance","Straight Line",Constants,"Ukulima Flat";
        }
        field(69073; Staff; Boolean)
        {
        }
        field(69074; "Death date"; Date)
        {
        }
        field(69075; "Edit Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(69076; "Deposit Boosted Date"; Date)
        {
        }
        field(69077; "Deposit Boosted Amount"; Decimal)
        {
        }
        field(69078; "Investment Account"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Document No." = field("Document No. Filter"),
                                                                  "Transaction Type" = const("Loan Insurance Charged")));
            FieldClass = FlowField;
        }
        field(69079; "Mobile No 3"; Code[15])
        {
        }
        field(69080; "Share Capital B Class"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        "Document No." = field("Document No. Filter"),
            //                                                        "Transaction Type" = const("41")));
            // FieldClass = FlowField;
        }
        field(69081; "Normal Shares B Class"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        "Document No." = field("Document No. Filter"),
            //                                                        "Transaction Type" = const("42")));
            // FieldClass = FlowField;
        }
        field(69082; "FOSA Shares"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Transaction Type" = const("FOSA Shares")));
            FieldClass = FlowField;
        }
        field(69083; "Members Parish"; Code[10])
        {
            TableRelation = "Member's Parishes".Code;

            trigger OnValidate()
            begin
                Parishes.Reset;
                Parishes.SetRange(Parishes.Code, "Members Parish");
                if Parishes.Find('-') then begin
                    "Parish Name" := Parishes.Description;
                    "Member Share Class" := Parishes."Share Class";
                end;
            end;
        }
        field(69084; "Parish Name"; Text[20])
        {
        }
        field(69085; "Employment Info"; Option)
        {
            OptionCaption = ' ,Employed,UnEmployed,Contracting,Others';
            OptionMembers = " ",Employed,UnEmployed,Contracting,Others;
        }
        field(69086; "Contracting Details"; Text[20])
        {
        }
        field(69087; "Others Details"; Text[15])
        {
        }
        field(69088; Products; Option)
        {
            OptionCaption = 'BOSA Account,BOSA+Current Account,BOSA+Smart Saver,BOSA+Fixed Deposit,Smart Saver Only,Current Only,Fixed  Deposit Only,Fixed+Smart Saver,Fixed+Current,Current+Smart Saver';
            OptionMembers = "BOSA Account","BOSA+Current Account","BOSA+Smart Saver","BOSA+Fixed Deposit","Smart Saver Only","Current Only","Fixed  Deposit Only","Fixed+Smart Saver","Fixed+Current","Current+Smart Saver";
        }
        field(69089; "Joint Account Name"; Text[30])
        {
        }
        field(69090; "Postal Code 2"; Code[10])
        {
            TableRelation = "Post Code";
        }
        field(69091; "Town 2"; Code[20])
        {
        }
        field(69092; "Passport 2"; Code[20])
        {
        }
        field(69093; "Member Parish 2"; Code[10])
        {
            Enabled = false;
        }
        field(69094; "Member Parish Name 2"; Text[10])
        {
            Enabled = false;
        }
        field(69095; "Name of the Group/Corporate"; Text[20])
        {
        }
        field(69096; "Date of Registration"; Date)
        {
        }
        field(69097; "No of Members"; Integer)
        {
        }
        field(69098; "Group/Corporate Trade"; Code[20])
        {
        }
        field(69099; "Certificate No"; Code[20])
        {
        }
        field(69100; "ID No.2"; Code[15])
        {
        }
        field(69101; "Picture 2"; Blob)
        {
            SubType = Bitmap;
        }
        field(69102; "Signature  2"; Blob)
        {
            SubType = Bitmap;
        }
        field(69103; Title2; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69104; "Mobile No. Three"; Code[15])
        {
        }
        field(69105; "Date of Birth2"; Date)
        {

            trigger OnValidate()
            begin
                if "Date of Birth" > Today then
                    Error('Date of birth cannot be greater than today');


                if "Date of Birth" <> 0D then begin
                    if GenSetUp.Get() then begin
                        if CalcDate(GenSetUp."Min. Member Age", "Date of Birth") > Today then
                            Error('Applicant bellow the mininmum membership age of %1', GenSetUp."Min. Member Age");
                    end;
                end;
            end;
        }
        field(69106; "Marital Status2"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69107; Gender2; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(69108; "Address3-Joint"; Code[15])
        {
        }
        field(69109; "Home Postal Code2"; Code[15])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                PostCode.Reset;
                PostCode.SetRange(PostCode.Code, "Home Postal Code");
                if PostCode.Find('-') then begin
                    "Home Town" := PostCode.City
                end;
            end;
        }
        field(69110; "Home Town2"; Text[15])
        {
        }
        field(69111; "Payroll/Staff No2"; Code[15])
        {
        }
        field(69112; "Employer Code2"; Code[15])
        {
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                Employer.Get("Employer Code");
                "Employer Name" := Employer.Description;
            end;
        }
        field(69113; "Employer Name2"; Code[20])
        {
        }
        field(69114; "E-Mail (Personal2)"; Text[20])
        {
        }
        field(69115; "Member Share Class"; Option)
        {
            OptionCaption = ' ,Class A,Class B';
            OptionMembers = " ","Class A","Class B";
        }
        field(69116; "Member's Residence"; Code[25])
        {
        }
        field(69117; "Postal Code 3"; Code[15])
        {
            TableRelation = "Post Code";
        }
        field(69118; "Town 3"; Code[15])
        {
        }
        field(69119; "Passport 3"; Code[15])
        {
        }
        field(69120; "Member Parish 3"; Code[10])
        {
        }
        field(69121; "Member Parish Name 3"; Text[10])
        {
        }
        field(69122; "Picture 3"; Blob)
        {
            SubType = Bitmap;
        }
        field(69123; "Signature  3"; Blob)
        {
            SubType = Bitmap;
        }
        field(69124; Title3; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69125; "Middle Name"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Middle Name" := Memb."Middle Name";
            end;
        }
        field(69126; "Last Name"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Last Name" := Memb."Last Name";
            end;
        }
        field(69127; "Marital Status3"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69128; Gender3; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(69129; Address3; Code[10])
        {
        }
        field(69130; "Home Postal Code3"; Code[10])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                PostCode.Reset;
                PostCode.SetRange(PostCode.Code, "Home Postal Code");
                if PostCode.Find('-') then begin
                    "Home Town" := PostCode.City
                end;
            end;
        }
        field(69131; "Home Town3"; Text[10])
        {
        }
        field(69132; "Payroll/Staff No3"; Code[15])
        {
        }
        field(69133; "Employer Code3"; Code[10])
        {
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                Employer.Get("Employer Code");
                "Employer Name" := Employer.Description;
            end;
        }
        field(69134; "Employer Name3"; Code[20])
        {
        }
        field(69135; "E-Mail (Personal3)"; Text[20])
        {
        }
        field(69136; "Name 3"; Code[20])
        {
        }
        field(69137; "ID No.3"; Code[10])
        {
        }
        field(69138; "Mobile No. 4"; Code[15])
        {
        }
        field(69139; Address4; Code[15])
        {
        }
        field(69140; "Assigned System ID"; Code[15])
        {
            TableRelation = User."User Name";
        }
        field(69141; "Risk Fund Arrears"; Decimal)
        {
            // CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
            //                                                       "Transaction Type" = filter("45" | "44"),
            //                                                       "Posting Date" = field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(69143; "Pension No"; Code[15])
        {
        }
        field(69144; "Benevolent Fund"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Benevolent Fund"),
                                                                   "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69145; "Risk Fund Paid"; Decimal)
        {
            // CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
            //                                                       "Transaction Type" = filter("45"),
            //                                                       "Posting Date" = field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(69146; "BRID No"; Code[15])
        {
        }
        field(69147; "Gross Dividend Amount Payable"; Decimal)
        {
        }
        field(69148; "Card No"; Code[15])
        {
        }
        field(69149; "Funeral Rider"; Decimal)
        {
            // CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
            //                                                       "Transaction Type" = filter("48"),
            //                                                       "Posting Date" = field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(69150; "Loan Liabilities"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter("Share Capital" | "Interest Paid" | "Deposit Contribution" | "Insurance Contribution")));
            FieldClass = FlowField;
        }
        field(69151; "Last Deposit Contribution Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No."),
                                                                          "Transaction Type" = filter("Deposit Contribution"),
                                                                          Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(69153; "Member House Group"; Code[15])
        {
            TableRelation = "Member House Groups"."Cell Group Code";

            trigger OnValidate()
            begin
                if ObjCellGroup.Get("Member House Group") then begin
                    "Member House Group Name" := ObjCellGroup."Cell Group Name";
                end;
                /*CellGroups.RESET;
                CellGroups.SETRANGE(CellGroups."Cell Group Code","Member Cell Group");
                IF CellGroups.FIND('-') THEN BEGIN
                "Member Cell Group Name":=CellGroups."Cell Group Name";
                END;*/

            end;
        }
        field(69154; "Member House Group Name"; Code[1])
        {
        }
        field(69155; "No Of Group Members."; Integer)
        {
        }
        field(69156; "Group Account Name"; Code[20])
        {
        }
        field(69157; "Business Loan Officer"; Code[2])
        {
        }
        field(69158; "Group Account"; Boolean)
        {
        }
        field(69159; "Group Account No"; Code[15])
        {
            TableRelation = Customer."No." where("Group Account" = filter(true));
        }
        field(69160; "FOSA Account"; Code[15])
        {
        }
        field(69161; "Micro Group Code"; Code[10])
        {
        }
        field(69162; "Loan Officer Name"; Code[15])
        {
        }
        field(69163; "BOSA Account No."; Code[15])
        {
        }
        field(69164; "Any Other Sacco"; Text[10])
        {
        }
        field(69165; "Member class"; Option)
        {
            OptionCaption = ',Class A,Class B';
            OptionMembers = ,"Class A","Class B";
        }
        field(69166; "Employment Terms"; Option)
        {
            OptionCaption = ' ,Permanent,Casual';
            OptionMembers = " ",Permanent,Casual;
        }
        field(69167; "Group Deposits"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Group Code" = field("No."),
                                                                   "Transaction Type" = filter("Deposit Contribution"),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69168; "Group Loan Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Group Code" = field("No."),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69169; "No of Group Members"; Integer)
        {
            CalcFormula = count(Customer where("Group Account No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69170; "No of Active Group Members"; Integer)
        {
            CalcFormula = count(Customer where("Group Account No" = field("No."),
                                                         Status = filter(Active)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69171; "No of Dormant Group Members"; Integer)
        {
            CalcFormula = count(Customer where("Group Account No" = field("No."),
                                                         Status = filter(Dormant)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69172; "Khoja Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("49"),
            //                                                        "Posting Date" = field("Date Filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(69173; "Group Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("50"),
            //                                                        "Posting Date" = field("Date Filter")));
            // FieldClass = FlowField;
        }
        field(69174; "Member Of a Group"; Boolean)
        {
        }
        field(69175; TLoansGuaranteed; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("No."),
                                                                                  "Outstanding Balance" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(69176; "Total Committed Shares"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("No."),
                                                                                  "Outstanding Balance" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(69177; "Existing Loan Repayments"; Decimal)
        {
            CalcFormula = sum("Loans Register".Repayment where("Client Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(69178; "Existing Fosa Loan Repayments"; Decimal)
        {
            CalcFormula = sum("Loans Register".Repayment where("Client Code" = field("FOSA Account No.")));
            FieldClass = FlowField;
        }
        field(69179; "Employer Address"; Code[15])
        {
        }
        field(69180; "Date of Employment"; Date)
        {
        }
        field(69181; "Position Held"; Code[20])
        {
        }
        field(69182; "Expected Monthly Income"; Decimal)
        {
        }
        field(69183; "Nature Of Business"; Option)
        {
            OptionCaption = 'Sole Proprietorship, Partnership';
            OptionMembers = "Sole Proprietorship"," Partnership";
        }
        field(69184; Industry; Code[15])
        {
        }
        field(69185; "Business Name"; Code[20])
        {
        }
        field(69186; "Physical Business Location"; Code[15])
        {
        }
        field(69187; "Year of Commence"; Date)
        {
        }
        field(69188; "Identification Document"; Option)
        {
            OptionCaption = 'Nation ID Card,Passport Card,Aliens Card,Birth Certificate,Company Reg. No,Driving License';
            OptionMembers = "Nation ID Card","Passport Card","Aliens Card","Birth Certificate","Company Reg. No","Driving License";
        }
        field(69189; "Referee Member No"; Code[15])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Referee Member No") then begin
                    "Referee Name" := Cust.Name;
                    "Referee Mobile Phone No" := Cust."Mobile Phone No";
                    "Referee ID No" := Cust."ID No.";
                end;
            end;
        }
        field(69190; "Referee Name"; Code[30])
        {
            Editable = false;
        }
        field(69191; "Referee ID No"; Code[15])
        {
            Editable = false;
        }
        field(69192; "Referee Mobile Phone No"; Code[15])
        {
            Editable = false;
        }
        field(69193; "Email Indemnified"; Boolean)
        {
        }
        field(69194; "Send E-Statements"; Boolean)
        {
        }
        field(69195; "Reason For Membership Withdraw"; Option)
        {
            OptionCaption = 'Relocation,Financial Constraints,House/Group Challages,Join another Institution,Personal Reasons,Other';
            OptionMembers = Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other;
        }
        field(69196; "Action On Dividend Earned"; Option)
        {
            OptionCaption = 'Pay to FOSA Account,Capitalize On Deposits,Repay Loans';
            OptionMembers = "Pay to FOSA Account","Capitalize On Deposits","Repay Loans";
        }
        field(69197; "Deposits Account No"; Code[15])
        {
        }
        field(69198; "Share Capital No"; Code[15])
        {
        }
        field(69199; "Benevolent Fund No"; Code[15])
        {
        }
        field(69200; "Loans Recoverd from Guarantors"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Recovery Transaction Type" = filter("Guarantor Recoverd"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69201; "Loan Recovered From Guarantors"; Code[20])
        {
            CalcFormula = lookup("Cust. Ledger Entry"."Recoverd Loan" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(69202; "ID Date of Issue"; Date)
        {
        }
        field(69203; "Literacy Level"; Code[10])
        {
        }
        field(69204; "Created By"; Code[20])
        {
        }
        field(69205; "Modified By"; Code[15])
        {
        }
        field(69206; "Modified On"; Date)
        {
        }
        field(69207; "Approved By"; Code[15])
        {
        }
        field(69208; "Approved On"; Date)
        {
        }
        field(69210; "Additional Shares"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Transaction Type" = const("Additional Shares")));
            FieldClass = FlowField;
        }
        field(69211; "FOSA Shares Account No"; Code[15])
        {
        }
        field(69212; "Additional Shares Account No"; Code[13])
        {
        }
        field(69213; "No of House Group Changes"; Integer)
        {
            CalcFormula = count("House Group Change Request" where("Member No" = field("No."),
                                                                    "Change Effected" = filter(true)));
            FieldClass = FlowField;
        }
        field(69215; "Last Contribution Entry No"; Integer)
        {
            CalcFormula = max("Cust. Ledger Entry"."Entry No." where("Customer No." = field("No."),
                                                                       "Transaction Type" = filter("Deposit Contribution"),
                                                                       Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(69216; "House Group Status"; Option)
        {
            OptionCaption = 'Active,Exiting the Group';
            OptionMembers = Active,"Exiting the Group";
        }
        field(69217; "Member Residency Status"; Option)
        {
            Description = 'What is the customer''s residency status?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 ´┐¢ 1 Year,1 ´┐¢ 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ´┐¢ 1 Year","1 ´┐¢ 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69218; "Individual Category"; Option)
        {
            Description = 'What is the customer category?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 ´┐¢ 1 Year,1 ´┐¢ 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ´┐¢ 1 Year","1 ´┐¢ 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69219; Entities; Option)
        {
            Description = 'What is the Entity Type?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 ´┐¢ 1 Year,1 ´┐¢ 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ´┐¢ 1 Year","1 ´┐¢ 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69220; "Industry Type"; Option)
        {
            Description = 'What Is the Industry Type?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 ´┐¢ 1 Year,1 ´┐¢ 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ´┐¢ 1 Year","1 ´┐¢ 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69221; "Lenght Of Relationship"; Option)
        {
            Description = 'What Is the Lenght Of the Relationship';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 to 1 Year,1 to 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ´┐¢ 1 Year","1 ´┐¢ 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69222; "International Trade"; Option)
        {
            Description = 'Is the customer involved in International Trade?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 ´┐¢ 1 Year,1 ´┐¢ 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ´┐¢ 1 Year","1 ´┐¢ 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69223; "Electronic Payment"; Option)
        {
            Description = 'Does the customer engage in electronic payments?';
            OptionCaption = 'International Wire Transfers,Local Wire Transfers,Mobile Transfers,None of the Above,Fixed/Call Deposit Accounts,FOSA(KSA,Imara, MJA,Heritage),Account with Sealed Safe deposit,Account with  Open Safe Deposit,All Loan Accounts,BOSA, Ufalme,ATM Debit,Credit,Both,None,Non-face to face channels,Unsolicited Account Origination e.g. Walk-Ins,Cheque book,Others';
            OptionMembers = "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        }
        field(69224; "Accounts Type Taken"; Option)
        {
            Description = 'Which account type is the customer taking?';
            OptionCaption = 'International Wire Transfers,Local Wire Transfers,Mobile Transfers,None of the Above,Fixed/Call Deposit Accounts,FOSA(KSA,Imara, MJA,Heritage),Account with Sealed Safe deposit,Account with  Open Safe Deposit,All Loan Accounts,BOSA, Ufalme,ATM Debit,Credit,Both,None,Non-face to face channels,Unsolicited Account Origination e.g. Walk-Ins,Cheque book,Others';
            OptionMembers = "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        }
        field(69225; "Cards Type Taken"; Option)
        {
            Description = 'Which card is the customer taking?';
            OptionCaption = 'International Wire Transfers,Local Wire Transfers,Mobile Transfers,None of the Above,Fixed/Call Deposit Accounts,FOSA(KSA,Imara, MJA,Heritage),Account with Sealed Safe deposit,Account with  Open Safe Deposit,All Loan Accounts,BOSA, Ufalme,ATM Debit,Credit,Both,None,Non-face to face channels,Unsolicited Account Origination e.g. Walk-Ins,Cheque book,Others';
            OptionMembers = "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        }
        field(69226; "Others(Channels)"; Option)
        {
            Description = 'Which products or channels is the customer taking?';
            OptionCaption = 'International Wire Transfers,Local Wire Transfers,Mobile Transfers,None of the Above,Fixed/Call Deposit Accounts,FOSA(KSA,Imara, MJA,Heritage),Account with Sealed Safe deposit,Account with  Open Safe Deposit,All Loan Accounts,BOSA, Ufalme,ATM Debit,Credit,Both,None,Non-face to face channels,Unsolicited Account Origination e.g. Walk-Ins,Cheque book,Others';
            OptionMembers = "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        }
        field(69227; "No of BD Trainings Attended"; Integer)
        {
            CalcFormula = count("CRM Traineees" where("Member No" = field("No."),
                                                       Attended = filter(true)));
            FieldClass = FlowField;
        }
        field(69228; "Member Needs House Group"; Boolean)
        {
        }
        field(69229; "Old Payrol Number"; Code[18])
        {
        }
        field(69230; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69231; Password; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69232; "Password Reset Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(69233; "FOSA Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69234; "Captital Reserve"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Capital Reserve"),
                                                                   "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69235; colleges; Code[2])
        {
            DataClassification = ToBeClassified;
            TableRelation = "College List".Code;
        }
        field(69236; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69237; Dioces; Code[1])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Dioces := Memb."Member Dioces";
            end;
        }
        field(69238; "Arch Dioces"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Arch Dioces" := Memb."Member Arch Dioces";
            end;
        }
        field(69239; "First Name"; Text[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "First Name" := Memb."First Name";
            end;
        }
        field(69240; Commission; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Transaction Type" = filter(Commission),
                                                                   "Customer No." = field("No."),
                                                                   "Transaction Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            FieldClass = FlowField;
        }
        field(69241; "Commission Paid"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69242; "Children Savings"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Transaction Amount" where("Transaction Type" = filter(Children),
                                                                   "Customer No." = field("No."),
                                                                   "Transaction Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            FieldClass = FlowField;
        }
        field(69243; "Reg Fee Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69244; "Reg Fee Paid."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69245; ELoanApplicationNotAllowed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69246; Piccture; MediaSet)
        {

        }
    }

    keys
    {

        key(Key55; "Country/Region Code")
        {
        }
        key(Key56; "Gen. Bus. Posting Group")
        {
        }
        key(Key57; Name, Address, City)
        {
        }
        key(Key58; "VAT Registration No.")
        {
            Enabled = false;
        }
        key(Key59; Name)
        {
        }
        key(Key510; City)
        {
        }
        key(Key511; "Post Code")
        {
        }
        key(Key512; "Phone No.")
        {
        }
        key(Key513; Contact)
        {
        }
        key(Key14; "Employer Code")
        {
        }
        key(Key15; "Personal No", "Customer Type")
        {
        }
        key(Key16; "Personal No")
        {
        }
        key(Key17; "ID No.")
        {
        }
        key(Key18; "Mobile Phone No")
        {
        }
        key(Key19; "FOSA Account No.")
        {
        }
    }


    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        CalcFields("Current Shares", "Shares Retained");
    end;

    var
        myInt: Integer;
        MembersRec: Record Customer;
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.';
        Text002: label 'Do you wish to create a contact for %1 %2?';
        SalesSetup: Record "Sacco No. Series";
        CommentLine: Record "Comment Line";
        SalesOrderLine: Record "Sales Line";
        CustBankAcc: Record "Customer Bank Account";
        ShipToAddr: Record "Ship-to Address";
        PostCode: Record "Post Code";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ShippingAgentService: Record "Shipping Agent Services";
        ItemCrossReference: Record "Item Cross Reference";
        RMSetup: Record "Marketing Setup";
        SalesPrice: Record "Sales Price";
        SalesLineDisc: Record "Sales Line Discount";
        SalesPrepmtPct: Record "Sales Prepayment %";
        ServContract: Record "Service Contract Header";
        ServHeader: Record "Service Header";
        ServiceItem: Record "Service Item";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromCust: Codeunit "CustCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        Text003: label 'Contact %1 %2 is not related to customer %3 %4.';
        Text004: label 'post';
        Text005: label 'create';
        Text006: label 'You cannot %1 this type of document when Customer %2 is blocked with type %3';
        Text007: label 'You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.';
        Text008: label 'Deleting the %1 %2 will cause the %3 to be deleted for the associated Service Items. Do you want to continue?';
        Text009: label 'Cannot delete customer.';
        Text010: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.';
        Text011: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text012: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text013: label 'You cannot delete %1 %2 because there is at least one outstanding Service %3 for this customer.';
        Text014: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text015: label 'You cannot delete %1 %2 because there is at least one %3 associated to this customer.';
        Loans: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        MinShares: Decimal;
        MovementTracker: Record "Movement Tracker";
        Cust: Record Customer;
        Vend: Record Vendor;
        CustFosa: Code[20];
        Vend2: Record Vendor;
        FOSAAccount: Record Vendor;
        StatusPermissions: Record "Status Change Permision";
        RefundsR: Record Refunds;
        Text001: label 'You cannot delete %1 %2 because there is at least one transaction %3 for this customer.';
        Approvalsetup: Record "Approvals Set Up";
        DataSheet: Record "Data Sheet Main";
        Employer: Record "Sacco Employers";
        Parishes: Record "Member's Parishes";
        SurestepFactory: Codeunit "SURESTEP Factory.";
        ObjCellGroup: Record "Member House Groups";
        CDays: Integer;
        EMaturity: Date;
        i: Integer;
        Memb: Record "Membership Applications";


}