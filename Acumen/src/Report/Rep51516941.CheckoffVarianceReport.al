#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 51516941 "Checkoff Variance Report"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Checkoff Lines-Distributed"; "Checkoff Lines-Distributed")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(MemberNo_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Member No.")
            {
            }
            column(StaffPayrollNo_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Staff/Payroll No")
            {
            }
            column(TransactionDate_CheckoffLinesDistributed; "Checkoff Lines-Distributed"."Transaction Date")
            {
            }
            column(Amount_CheckoffLinesDistributed; "Checkoff Lines-Distributed".Amount)
            {
            }
            dataitem("Checkoff Header-Distributed"; "Checkoff Header-Distributed")
            {
                column(ReportForNavId_6; 6)
                {
                }
                column(Amount_CheckoffHeaderDistributed; "Checkoff Header-Distributed".Amount)
                {
                }
                column(No_CheckoffHeaderDistributed; "Checkoff Header-Distributed".No)
                {
                }
                dataitem("Data Sheet Lines-Dist"; "Data Sheet Lines-Dist")
                {
                    column(ReportForNavId_9; 9)
                    {
                    }
                    column(Amount_DataSheetLinesDist; "Data Sheet Lines-Dist".Amount)
                    {
                    }
                    column(PayrollNo_DataSheetLinesDist; "Data Sheet Lines-Dist"."Payroll No")
                    {
                    }
                }
            }
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
        ObjGensetup: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory.";
        VarShareCapVariance: Decimal;
        VarAmountPosted: Decimal;
        VarBenfundVariance: Decimal;
        ObjMemberLedger: Record "Cust. Ledger Entry";
        VarDateFilter: Text;
        VarStartofMonthDate: Integer;
        VarCurrMonth: Integer;
        VarCurrYear: Integer;
        VarFirstDayofMonth: Date;
        VarMemberContributionMade: Decimal;
        ObjAccount: Record Vendor;
        VarMonthlyContributionDefecit: Decimal;
        VarFOSAAccountDebited: Code[30];
}

