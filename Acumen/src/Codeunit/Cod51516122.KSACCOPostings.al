#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516122 "KSACCO Postings"
{

    trigger OnRun()
    begin
    end;

    var
        SurestepFactory: Codeunit "SURESTEP Factory.";

    local procedure FnRebookSPackage()
    var
        SPackageRegister: Record "Safe Custody Package Register";
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        JTemplate: Code[30];
        JBatch: Code[30];
        DocNo: Code[30];
        GenSetup: Record "Sacco General Set-Up";
        LineNo: Integer;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        ObjPackageTypes: Record "Package Types";
        LodgeFee: Decimal;
        LodgeFeeAccount: Code[20];
        ExciseDuty: Decimal;
        ExciseDutyAccount: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
    begin
        if (SPackageRegister."Maturity Date" = Today) and (SPackageRegister."Maturity Instruction" = SPackageRegister."maturity instruction"::Rebook) then begin


            ObjVendors.Reset;
            ObjVendors.SetRange(ObjVendors."No.", SPackageRegister."Charge Account");
            if ObjVendors.Find('-') then begin
                ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                ObjAccTypes.Reset;
                ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                if ObjAccTypes.Find('-') then
                    AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
            end;




            JTemplate := 'GENERAL';
            JBatch := 'SCUSTODY';
            DocNo := 'Lodge_' + Format(SPackageRegister."Package ID");
            GenSetup.Get();
            LineNo := LineNo + 10000;
            SurestepFactory.FnClearGnlJournalLine(JTemplate, JBatch);//Clear Journal Batch=============================
            TransType := Transtype::" ";
            AccountType := Accounttype::Vendor;
            BalAccountType := Balaccounttype::"G/L Account";

            ObjPackageTypes.Reset;
            ObjPackageTypes.SetRange(ObjPackageTypes.Code, SPackageRegister."Package Type");
            if ObjPackageTypes.FindSet then begin
                LodgeFee := ObjPackageTypes."Package Charge";
                LodgeFeeAccount := ObjPackageTypes."Package Charge Account";
            end;
            GenSetup.Get();
            if AvailableBal >= (LodgeFee + (LodgeFee * (GenSetup."Excise Duty(%)" / 100))) then begin


                //Lodge Fee=============================================================================
                LineNo := LineNo + 10000;
                SurestepFactory.FnCreateGnlJournalLineBalanced(JTemplate, JBatch, DocNo, LineNo, TransType, AccountType, SPackageRegister."Charge Account", Today, 'Package Rebook Charge_' + Format(SPackageRegister."Package ID"), BalAccountType,
 LodgeFeeAccount,
                LodgeFee, 'BOSA', '');
                //Lodge Fee=============================================================================
                GenSetup.Get();
                ExciseDuty := (LodgeFee * (GenSetup."Excise Duty(%)" / 100));
                ExciseDutyAccount := GenSetup."Excise Duty Account";

                GenSetup.Get();
                //Excise On Lodge Fee=============================================================================
                LineNo := LineNo + 10000;
                SurestepFactory.FnCreateGnlJournalLineBalanced(JTemplate, JBatch, DocNo, LineNo, TransType, AccountType, SPackageRegister."Charge Account", Today, 'Excise Rebook Charge_' + Format(SPackageRegister."Package ID"), BalAccountType, ExciseDutyAccount
   ,
                ExciseDuty, 'BOSA', '');
                //Excise On Lodge Fee=============================================================================

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'SCUSTODY');
                if GenJournalLine.Find('-') then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                SPackageRegister."Package Re_Lodge Fee Charged" := true;
                SPackageRegister."Package Re_Booked On" := Today;
                SPackageRegister."Package Rebooked By" := UserId;
                SPackageRegister."Maturity Date" := CalcDate('1Y', SPackageRegister."Maturity Date");
                SPackageRegister.Modify;
            end;
        end;
    end;
}

