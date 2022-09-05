#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516027 "IPRS Details"
{

    trigger OnRun()
    begin
        //MESSAGE(PostTransactionsFB('2246423'));
        Message(GnSendIdDetails());
    end;

    var
        Vendor: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        miniBalance: Decimal;
        accBalance: Decimal;
        minimunCount: Integer;
        VendorLedgEntry: Record "Vendor Ledger Entry";
        amount: Decimal;
        Loans: Integer;
        LoansRegister: Record "Loans Register";
        LoanProductsSetup: Record "Loan Products Setup";
        Members: Record Customer;
        dateExpression: Text[20];
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        dashboardDataFilter: Date;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        MemberLedgerEntry: Record "Cust. Ledger Entry";
        SurePESAApplications: Record "CloudPESA Applications";
        GenJournalLine: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        LineNo: Integer;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        SurePESATrans: Record "CloudPESA Transactions";
        GenLedgerSetup: Record "General Ledger Setup";
        Charges: Record Charges;
        MobileCharges: Decimal;
        MobileChargesACC: Text[20];
        SurePESACommACC: Code[20];
        SurePESACharge: Decimal;
        ExcDuty: Decimal;
        TempBalance: Decimal;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        msg: Text[250];
        accountName1: Text[40];
        accountName2: Text[40];
        fosaAcc: Text[30];
        LoanGuaranteeDetails: Record "Loans Guarantee Details";
        bosaNo: Text[20];
        MPESARecon: Text[20];
        TariffDetails: Record "Tariff Details";
        MPESACharge: Decimal;
        TotalCharges: Decimal;
        ExxcDuty: label '01-1-0275';
        PaybillTrans: Record "CloudPESA MPESA Trans";
        PaybillRecon: Code[30];
        fosaConst: label 'SAVINGS';
        accountsFOSA: Text[1023];
        interestRate: Integer;
        LoanAmt: Decimal;
        Dimension: Record "Dimension Value";
        DimensionFOSA: label 'FOSA';
        DimensionBRANCH: label 'NAIROBI';
        DimensionBOSA: label 'BOSA';
        FamilyBankacc: Code[50];
        equityAccount: Code[50];
        coopacc: Code[50];
        AccountLength: Integer;
        fosaAccNo: Code[50];
        MembApp: Record "Membership Applications";
        Idtype: Code[50];
        IDLength: Integer;
        ImportFile: File;
        PASSPORTl: Integer;
        IDDoc: Code[50];


    procedure FnGetIprsDetails(dateOfBirth: Date; firstName: Code[250]; otherName: Code[250]; surname: Code[250]; gender: Code[250]; idNumber: Code[250])
    begin

        MembApp.Reset;
        MembApp.SetRange("ID No.", idNumber);
        if MembApp.Find('-') then begin
            if firstName = '' then begin
            end
            else begin
                MembApp."Date of Birth" := dateOfBirth;
                MembApp."First Name" := firstName;
                MembApp."Middle Name" := otherName;
                MembApp."Last Name" := surname;
                MembApp.Name := firstName + ' ' + otherName + ' ' + surname;

                if gender = 'M' then begin
                    MembApp.Gender := MembApp.Gender::Male;
                end
                else begin
                    MembApp.Gender := MembApp.Gender::Female;
                end;

                MembApp."IPRS Details" := true;


                // ImportFile.

                //MembApp.MODIFY;
                if MembApp.Modify = true then
                    IPRSPHOTOS()

            end;
        end;
    end;


    procedure GnSendIdDetails() Result: Code[250]
    begin
        MembApp.Reset;
        MembApp.SetRange(MembApp."IPRS Details", false);
        MembApp.SetRange(MembApp.Status, MembApp.Status::Open);
        //MembApp.SETRANGE(MembApp."ID No.",'<>','');
        if MembApp.Find('-') then begin
            repeat
                IDLength := StrLen(MembApp."ID No.");
                PASSPORTl := StrLen(MembApp."Passport No.");
                if (IDLength > 6) or (PASSPORTl > 6) then begin

                    if MembApp."Application Category" = MembApp."application category"::"New Application" then begin

                        // if MembApp."Identification Document" = MembApp."identification document"::"0" then begin
                        //     Idtype := 'NATIONAL_ID';
                        //     IDDoc := MembApp."ID No.";
                        // end;
                        // if MembApp."Identification Document" = MembApp."identification document"::"1" then begin
                        //     Idtype := 'PASSPORT';
                        //     IDDoc := MembApp."Passport No.";
                        // end;

                        Result := Idtype + ':::' + 'ID' + ':::' + Format(IDDoc);
                    end;

                end;
            until MembApp.Next = 0;
        end;
    end;


    procedure GetErrorCodes(errocode: Code[50]; IdNumber: Code[50]; errorDescription: Text[100])
    begin

        MembApp.Reset;
        MembApp.SetRange(MembApp."ID No.", IdNumber);
        if MembApp.Find('-') then begin
            MembApp."IPRS Error Description" := errocode + ': ' + errorDescription;
            MembApp."IPRS Details" := true;
            MembApp.Modify;
        end;
    end;


    procedure IPRSPHOTOS()
    begin
        MembApp.Picture.ImportFile('D:\IPRS\Photo\' + MembApp."ID No." + '.jpg', 'PHOTO ');
        MembApp.Signature.ImportFile('D:\IPRS\Signature\' + MembApp."ID No." + '.jpg', 'SIGNATURE ');
    end;
}

