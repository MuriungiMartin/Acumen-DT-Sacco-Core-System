#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516121 "Recover Dividend Loans"
{

    trigger OnRun()
    begin
        //Delete journal
        PostingDate:=20171102D;
        Gnljnline.Reset;
        Gnljnline.SetRange("Journal Template Name",'GENERAL');
        Gnljnline.SetRange("Journal Batch Name",'SHARELOANS');
        if Gnljnline.Find('-') then
        Gnljnline.DeleteAll;
        LineNo:=10;
        FnRunOutstandingLoanBalance();
        Message('DONE');
    end;

    var
        LineNo: Integer;
        Gnljnline: Record "Gen. Journal Line";
        PostingDate: Date;
        Cust: Record "Member Register";

    local procedure FnRunOutstandingLoanBalance()
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        LoanApp: Record "Loans Register";
    begin
        varTotalRepay:=0;
        varMultipleLoan:=0;
        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
        //LoanApp.SETRANGE(LoanApp."Client Code",MemberNo);
        LoanApp.SetFilter(LoanApp."Issued Date",'..%1',PostingDate);
        LoanApp.SetFilter(LoanApp."Loan Product Type",'%1|%2','FL354','FL364');


        if LoanApp.Find('-') then begin
          repeat
                LoanApp.CalcFields(LoanApp."Outstanding Balance");
                if (LoanApp."Outstanding Balance" > 0) and (LoanApp."Issued Date" <PostingDate) then
                  begin
                    varLRepayment:=0;
                    varLRepayment:=LoanApp."Outstanding Balance";
                    if varLRepayment >0 then
                      begin
                          LineNo:=LineNo+10;
                          Gnljnline.Init;
                          Gnljnline."Journal Template Name":='GENERAL';
                          Gnljnline."Journal Batch Name":='SHARELOANS';
                          Gnljnline."Document No.":='DIVIDENDLoans';

                          Gnljnline."Line No.":=LineNo;

                          Gnljnline."Account Type":=Gnljnline."account type"::Member;
                          Gnljnline."Account No.":=LoanApp."BOSA No";
                          Gnljnline.Validate(Gnljnline."Account No.");

                          Gnljnline."Posting Date":=PostingDate;
                          Gnljnline.Description:=LoanApp."Loan Product Type"+'-Loan Repayment-from dividend';
                          Gnljnline.Amount:=varLRepayment*-1;

                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Interest Paid";
                        Gnljnline."Loan No":=LoanApp."Loan  No.";
                        Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                        Gnljnline."Shortcut Dimension 2 Code":=FnGetMemberBranch(LoanApp."Client Code");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                        if Gnljnline.Amount<>0 then
                        Gnljnline.Insert;

                        LineNo:=LineNo+1;
                          Gnljnline.Init;
                          Gnljnline."Journal Template Name":='GENERAL';
                          Gnljnline."Journal Batch Name":='SHARELOANS';
                          Gnljnline."Document No.":='DIVIDENDLoans';
                          Gnljnline."Line No.":=LineNo;

                          Gnljnline."Account Type":=Gnljnline."account type"::Vendor;
                         // MESSAGE(LoanApp."Account No");
                          //ERROR(FnGetFosaAccountNo(LoanApp."BOSA No"));
                          Gnljnline."Account No.":=FnGetFosaAccountNo(LoanApp."BOSA No");
                          Gnljnline.Validate(Gnljnline."Account No.");

                          Gnljnline."Posting Date":=PostingDate;
                          Gnljnline.Description:=LoanApp."Loan Product Type"+'-Loan Repayment-from dividend';
                          Gnljnline.Amount:=varLRepayment;
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Shortcut Dimension 1 Code":='FOSA';
                        Gnljnline."Shortcut Dimension 2 Code":=FnGetMemberBranch(LoanApp."Client Code");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                        if Gnljnline.Amount<>0 then
                        Gnljnline.Insert;



                      end;
                 end;
        until LoanApp.Next = 0;
        end;
    end;

    local procedure FnGetMemberBranch(MemberNo: Code[50]): Code[100]
    var
        MemberBranch: Code[100];
    begin
        Cust.Reset;
        Cust.SetRange(Cust."No.",MemberNo);
        if Cust.Find('-') then begin
          MemberBranch:=Cust."Global Dimension 2 Code";
          end;
        exit(MemberBranch);
    end;

    local procedure FnGetFosaAccountNo(MNO: Code[50]) FosaAcc: Code[50]
    var
        ObjVendor: Record Vendor;
    begin
        Cust.Reset;
        Cust.SetRange(Cust."No.",MNO);
        //Cust.SETFILTER(ObjVendor."Account Type",'ORDINARY');
        if Cust.Find('-') then begin
          FosaAcc:=Cust."FOSA Account No.";
          end;
          exit(FosaAcc);
    end;
}

