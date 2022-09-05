#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516351 "Checkoff Processing Header-Dp"
{
    SourceTable = "CheckoffHeader-Distribut poly";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date"; "Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; "Scheduled Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Interest Amount"; "Interest Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Checkoff Disstributed")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff Distributed';
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = XMLport "Import Checkoff Distributed";
            }
            group(ActionGroup25)
            {
            }
            action("Validate Checkoff")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Checkoff';
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                //RunObject = Report UnknownReport50052;

                trigger OnAction()
                var
                    ObjCheckOffLines: Record "Checkoff Lines-Distributed";
                    Cust: record Customer;
                begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Personal No", checkoffLine."Member No.");
                    if Cust.Find('-') then begin
                        repeat
                            Cust.CalcFields(Cust."Current Shares");
                            checkoffLine."Member No." := Cust."No.";
                            checkoffLine.Name := Cust.Name;
                            checkoffLine."FOSA Account" := Cust."FOSA Account No.";
                            Modify;
                        until Cust.Next = 0;
                    end;

                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange("Client Code", checkoffLine."Member No.");
                    ObjLoans.SetFilter("Loan Product Type", '%1', 'CARLON');
                    ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                        checkoffLine."Car loan Staff LOAN No." := ObjLoans."Loan  No.";
                        checkoffLine.Modify;
                    end;
                    //******************************************************************************DEV
                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange("Client Code", checkoffLine."Member No.");
                    ObjLoans.SetFilter("Loan Product Type", '%1', 'DEV');
                    ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                        checkoffLine."DEVELOPMENT LOAN NO." := ObjLoans."Loan  No.";
                        checkoffLine.Modify;
                    end;
                    //***********************************************************************DIVADV

                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange("Client Code", checkoffLine."Member No.");
                    ObjLoans.SetFilter("Loan Product Type", '%1', 'DIVADV');
                    ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                        checkoffLine."Dividend Advance LOAN No." := ObjLoans."Loan  No.";
                        checkoffLine.Modify;
                    end;
                    //*******************************************************************************************E-LOAN
                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange("Client Code", checkoffLine."Member No.");
                    ObjLoans.SetFilter("Loan Product Type", '%1', 'E-LOAN');
                    ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                        checkoffLine."Mobile Loan No." := ObjLoans."Loan  No.";
                        checkoffLine.Modify;
                    end;
                    ///****************************************************************************************************EMERGENCY
                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange("Client Code", checkoffLine."Member No.");
                    ObjLoans.SetFilter("Loan Product Type", '%1', 'EMERGENCY');
                    ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                        checkoffLine."EMERGENCY LOAN No." := ObjLoans."Loan  No.";
                        checkoffLine.Modify;
                    end;

                    //**********************************************************************************************************INUKA
                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange("Client Code", checkoffLine."Member No.");
                    ObjLoans.SetFilter("Loan Product Type", '%1', 'INUKA');
                    ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                        checkoffLine."Inuka Loan No." := ObjLoans."Loan  No.";
                        checkoffLine.Modify;
                    end;

                    //*88888888************************************************************************************JSORT LOAN
                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange("Client Code", checkoffLine."Member No.");
                    ObjLoans.SetFilter("Loan Product Type", '%1', 'JSORT LOAN');
                    ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                        checkoffLine."J-SORT LOAN No." := ObjLoans."Loan  No.";
                        checkoffLine.Modify;
                    end;
                    //************************************************************************************MORGAGE

                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange("Client Code", checkoffLine."Member No.");
                    ObjLoans.SetFilter("Loan Product Type", '%1', 'MORGAGE');
                    ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                        checkoffLine."Staff Morgage No." := ObjLoans."Loan  No.";
                        checkoffLine.Modify;
                    end;
                    //*******************************************************************************************SALADV1

                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange("Client Code", checkoffLine."Member No.");
                    ObjLoans.SetFilter("Loan Product Type", '%1', 'SALADV1');
                    ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                        checkoffLine."SALARY ADVANCE No." := ObjLoans."Loan  No.";
                        checkoffLine.Modify;
                    end;
                    //******************************************************************************************8SALADV2

                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange("Client Code", checkoffLine."Member No.");
                    ObjLoans.SetFilter("Loan Product Type", '%1', 'SALADV2');
                    ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                        checkoffLine."Salary Advance PLUS No." := ObjLoans."Loan  No.";
                        checkoffLine.Modify;
                    end;
                    //**********************************************************************SAMBAZA
                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange("Client Code", checkoffLine."Member No.");
                    ObjLoans.SetFilter("Loan Product Type", '%1', 'SAMBAZA');
                    ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                        checkoffLine."Sambaza Loan No." := ObjLoans."Loan  No.";
                        checkoffLine.Modify;
                    end;
                    //******************SCHOOL

                    ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange("Client Code", checkoffLine."Member No.");
                    ObjLoans.SetFilter("Loan Product Type", '%1', 'SCHOOL');
                    ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                        checkoffLine."School Fees Loan no." := ObjLoans."Loan  No.";
                        checkoffLine.Modify;
                    end;
                end;
            }
            group(ActionGroup23)
            {
            }
            action("Process Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Process Checkoff Distributed';
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ObjGenBatch: Record "Gen. Journal Batch";
                begin
                    //  IF Amount<> "ALL TOTAL AMOUNT" THEN
                    Error('Amount must equal Group Total');


                    JBatchs := 'CHECKOFF';

                    FnClearBatch();

                    FnPostchechoff();

                    FnPostBalancing();

                    Message('Processing Complete');
                end;
            }
            action("Mark As posted")
            {
                ApplicationArea = Basic;
                Image = Archive;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Posted.Once Marked as posted it will go to posted. ?', false) = true then begin
                        Posted := true;
                        "Posted By" := UserId;
                        "Posting date" := Today;
                        Modify;
                    end;
                end;
            }
            action("Mark As postedS")
            {
                ApplicationArea = Basic;
                Caption = 'Reflesh';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
            }
        }
    }

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "CheckoffLinesDistributed poly";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "CheckoffHeader-Distribut poly";
        Cust: Record Customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "CheckoffLinesDistributed poly";
        LoanType: Record "Loan Product Charges";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "CheckoffLinesDistributed poly";
        JBatchs: Code[10];
        VarAmounttodeduct: Decimal;
        VarLoanNo: Code[30];
        ObjLoans: Record "Loans Register";
        VarRunningBalance: Decimal;
        checkheadreg: Record "CheckoffHeader-Distribut poly";
        LoansApp: Record "Loans Register";
        Varp: Decimal;
        VarINT: Decimal;
        TotalAmt: Decimal;
        InterestBal: Decimal;
        outbal: Decimal;
        checkoffLine: Record "CheckoffLinesDistributed poly";

    local procedure FnClearBatch()
    var
        ObjGenBatch: Record "Gen. Journal Batch";
    begin
        ObjGenBatch.Reset;
        ObjGenBatch.SetRange(ObjGenBatch."Journal Template Name", 'GENERAL');
        ObjGenBatch.SetRange(ObjGenBatch.Name, JBatchs);
        if ObjGenBatch.Find('-') = false then begin
            ObjGenBatch.Init;
            ObjGenBatch."Journal Template Name" := 'GENERAL';
            ObjGenBatch.Name := JBatchs;
            ObjGenBatch.Description := 'CHECKOFF PROCESSING';
            ObjGenBatch.Validate(ObjGenBatch."Journal Template Name");
            ObjGenBatch.Validate(ObjGenBatch.Name);
            ObjGenBatch.Insert;
        end;

        Gnljnline.Reset;
        Gnljnline.SetRange("Journal Template Name", 'GENERAL');
        Gnljnline.SetRange("Journal Batch Name", JBatchs);
        Gnljnline.DeleteAll;
    end;

    local procedure FnPostchechoff()
    var
        ObjCheckOffLines: Record "CheckoffLinesDistributed poly";
    begin
        TestField("Posting date");
        TestField("Account No");
        TestField("Document No");
        TestField(Remarks);
        TestField(Amount);


        //================ registration fee contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Registration Fee", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Registration Fee";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Registration Fee";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ Registraation fee contribution end========================



        //================ insurance fund contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Insurance Fee", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Insurance Fee";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Insurance Contribution";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ Insurance fund contribution end========================


        //================ benevolent fund contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Benevolent Fund", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Benevolent Fund";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Benevolent Fund";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ benevolent fund contribution end========================
        //================ share capital contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Share Capital", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Share Capital";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Share Capital";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ share capital contribution end========================


        //================ deposit contribution start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        ObjCheckOffLines.SetFilter(ObjCheckOffLines."Deposit Contribution", '>%1', 0);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'538');
        if ObjCheckOffLines.FindSet then begin
            repeat
                VarRunningBalance := 0;
                VarRunningBalance := ObjCheckOffLines."Deposit Contribution";

                if VarRunningBalance > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -VarRunningBalance;
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Deposit Contribution";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    //VarRunningBalance:=VarRunningBalance-VarAmounttodeduct;
                end;


            until ObjCheckOffLines.Next = 0;
        end;


        //================ deposit contribution end========================

        //polytech start loans

        //================ development loan amount cal start========================1


        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        // ObjCheckOffLines.SETFILTER(ObjCheckOffLines."DEVELOPMENT LOAN Principal",'>%1',0);
        if ObjCheckOffLines.FindSet then begin
            repeat
                if ObjCheckOffLines."DEVELOPMENT LOAN Principal" > 0 then begin
                    //=====================================================================================interest paid

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."DEVELOPMENT LOAN Principal";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."DEVELOPMENT LOAN NO.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
                //=====================================================================================principal repayment
                if ObjCheckOffLines."DEVELOPMENT LOAN Int" > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."DEVELOPMENT LOAN Int";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."DEVELOPMENT LOAN NO.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;

            until ObjCheckOffLines.Next = 0;
        end;

        //================ development loan amount cal end========================

        //................................................................................... Development loan 1
        //================ development loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat
                if ObjCheckOffLines."Car loan Staff LOAN Int" > 0 then begin

                    //===================================================================================interest paid

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Car loan Staff LOAN Int";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."Car loan Staff LOAN No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
                //=====================================================================================principal repayment
                if ObjCheckOffLines."Car loan Staff LOAN Principal" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Car loan Staff LOAN Principal";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."Car loan Staff LOAN No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
            until ObjCheckOffLines.Next = 0;
        end;


        //================ emergency loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat
                //=====================================================================================interest paid
                if ObjCheckOffLines."Dividend Advance LOAN Int" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Dividend Advance LOAN Int";
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Loan No" := ObjCheckOffLines."Dividend Advance LOAN No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
                //=====================================================================================principal repayment

                if ObjCheckOffLines."Dividend AdvanceLOAN Principal" > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Dividend AdvanceLOAN Principal";
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Loan No" := ObjCheckOffLines."Dividend Advance LOAN No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;


            until ObjCheckOffLines.Next = 0;
        end;

        //================ div loan amount cal end========================

        //================  Mobile loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat
                if ObjCheckOffLines."Mobile Loan Int" > 0 then begin
                    //=====================================================================================interest paid

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Mobile Loan Int";
                    Gnljnline.Validate(Gnljnline.Amount);
                    //Gnljnline."Loan No":=VarLoanNo;
                    Gnljnline."Loan No" := ObjCheckOffLines."Mobile Loan No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
                //=====================================================================================principal repayment
                if ObjCheckOffLines."Mobile Loan Princilal" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Mobile Loan Princilal";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := VarLoanNo;
                    Gnljnline."Loan No" := ObjCheckOffLines."Mobile Loan No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
            until ObjCheckOffLines.Next = 0;
        end;

        //================ Mobile fees loan amount cal end========================




        //================  inuka  loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat
                if ObjCheckOffLines."Inuka Loan Int" > 0 then begin

                    //=====================================================================================interest paid

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Inuka Loan Int";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."Inuka Loan No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
                if ObjCheckOffLines."Inuka Loan Principal" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Inuka Loan Principal";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."Inuka Loan No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
            until ObjCheckOffLines.Next = 0;
        end;

        //================ inuka loan amount cal end========================



        //================  Emerg loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat

                if ObjCheckOffLines."EMERGENCY LOAN Int" > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."EMERGENCY LOAN Int";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."EMERGENCY LOAN No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
                if ObjCheckOffLines."EMERGENCY LOAN Principal" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."EMERGENCY LOAN Principal";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."EMERGENCY LOAN No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;

            until ObjCheckOffLines.Next = 0;
        end;

        //================ emerg amount cal end========================



        //================ j-sort loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat
                //=====================================================================================interest paid
                if ObjCheckOffLines."J-SORT LOAN Int" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."J-SORT LOAN Int";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."J-SORT LOAN No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
                //=====================================================================================principal repayment
                if ObjCheckOffLines."J-SORT LOAN Principal" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."J-SORT LOAN Principal";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."J-SORT LOAN No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
            until ObjCheckOffLines.Next = 0;
        end;

        //===============j-sort loan amount cal end========================


        //================  staff mar school fees loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat

                //=====================================================================================interest paid
                if ObjCheckOffLines."Staff Morgage Int" > 0 then begin

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Staff Morgage Int";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."Staff Morgage No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
                //=====================================================================================principal repayment
                if ObjCheckOffLines."Staff Morgage Principal" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Staff Morgage Principal";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."Staff Morgage No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;

            until ObjCheckOffLines.Next = 0;
        end;

        //================ staff mar loan amount cal end========================



        //================  salary 1 loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat

                //=====================================================================================interest paid
                if ObjCheckOffLines."SALARY ADVANCE Int" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."SALARY ADVANCE Int";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."SALARY ADVANCE No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
                //=====================================================================================principal repayment
                if ObjCheckOffLines."SALARY ADVANCE Principal" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."SALARY ADVANCE Principal";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."SALARY ADVANCE No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
            until ObjCheckOffLines.Next = 0;
        end;

        //================salary 1loan amount cal end========================




        ////////////////////////////////////////kip

        //================ salary 2 loan amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat
                //=====================================================================================interest paid
                if ObjCheckOffLines."Salary Advance PLUS Int" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Salary Advance PLUS Int";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."Salary Advance PLUS No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
                //=====================================================================================principal repayment
                if ObjCheckOffLines."Salary Advance PLUS Principal" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Salary Advance PLUS Principal";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."Salary Advance PLUS No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
            until ObjCheckOffLines.Next = 0;
        end;

        //================salary 2 loan amount cal end========================


        //================ sambaza  loan 1 amount cal start========================1
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat

                //=====================================================================================interest paid
                if ObjCheckOffLines."Sambaza Loan Int" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Sambaza Loan Int";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."Sambaza Loan No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
                //=====================================================================================principal repayment
                if ObjCheckOffLines."Sambaza Loan Principal" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."Sambaza Loan Principal";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."Sambaza Loan No.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
            until ObjCheckOffLines.Next = 0;
        end;

        //================sch loan 1 loan amount cal end========================

        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat

                //=====================================================================================interest paid
                if ObjCheckOffLines."School Fees Int" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."School Fees Int";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."School Fees Loan no.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
                //=====================================================================================principal repayment
                if ObjCheckOffLines."School Fees Principal" > 0 then begin
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := JBatchs;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Member;
                    Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := ObjCheckOffLines."Loan Type";
                    Gnljnline.Amount := -ObjCheckOffLines."School Fees Principal";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No" := ObjCheckOffLines."School Fees Loan no.";
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                    Gnljnline.Validate(Gnljnline."Transaction Type");
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                end;
            until ObjCheckOffLines.Next = 0;
        end;



        ///////////////////acumen loans
    end;

    local procedure FnPostBalancing()
    begin
        LineN := LineN + 10000;
        Gnljnline.Init;
        Gnljnline."Journal Template Name" := 'GENERAL';
        Gnljnline."Journal Batch Name" := JBatchs;
        Gnljnline."Line No." := LineN;
        Gnljnline."Account Type" := Gnljnline."account type"::Customer;
        Gnljnline."Account No." := "Account No";
        Gnljnline.Validate(Gnljnline."Account No.");
        Gnljnline."Document No." := "Document No";
        Gnljnline."Posting Date" := "Posting date";
        Gnljnline.Description := No + '-' + "Document No";
        Gnljnline.Amount := Amount;
        Gnljnline.Validate(Gnljnline.Amount);
        Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
        //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
        if Gnljnline.Amount <> 0 then
            Gnljnline.Insert;
    end;
}

