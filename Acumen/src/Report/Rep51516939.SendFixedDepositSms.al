#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 51516939 "Send Fixed Deposit Sms"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Fixed Deposit Placement"; "Fixed Deposit Placement")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ObjAccount.Reset;
                ObjAccount.SetRange(ObjAccount."No.", "Fixed Deposit Account No");
                if ObjAccount.FindSet then begin
                    VarMobileNo := ObjAccount."Mobile Phone No";
                end;

                ObjFDPlacement.Reset;
                ObjFDPlacement.SetRange(ObjFDPlacement."Document No", "Document No");
                if ObjFDPlacement.FindSet then begin
                    if CalcDate('5D', WorkDate) = ObjFDPlacement."FD Maturity Date" then begin
                        VarSmsBody := 'Your Fixed Deposit of Ksh.' + ' ' + Format(ObjFDPlacement."Amount to Fix") + ' ' + 'will mature on' + ' '
                        + Format(ObjFDPlacement."FD Maturity Date") + '.Contact the Sacco For Further Instructions.';
                        SurestpFactory.FnSendSMS('FDMaturity', VarSmsBody, ObjFDPlacement."Fixed Deposit Account No", VarMobileNo);
                    end;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ObjAccount: Record Vendor;
        SurestpFactory: Codeunit "SURESTEP Factory.";
        VarMobileNo: Code[30];
        ObjFDPlacement: Record "Fixed Deposit Placement";
        VarSmsBody: Text[100];
}

