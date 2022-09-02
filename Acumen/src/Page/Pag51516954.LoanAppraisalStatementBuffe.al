#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516954 "Loan Appraisal Statement Buffe"
{
    PageType = ListPart;
    SourceTable = "Loan Appraisal Statement Buffe";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No";"Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description";"Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Out";"Amount Out")
                {
                    ApplicationArea = Basic;
                }
                field("Amount In";"Amount In")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //Get Statement Avarage Credits
        ObjStatementB.Reset;
        ObjStatementB.SetRange(ObjStatementB."Loan  No.","Loan No");
        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'<%1',0);
        if ObjStatementB.FindSet then begin
          repeat
          VerStatementAvCredits:=VerStatementAvCredits+"Amount In";
          ObjStatementB."Bank Statement Avarage Credits":=VerStatementAvCredits/6;
          ObjStatementB.Modify;
          until ObjStatementB.Next=0;
          end;

        //Get Statement Avarage Debits
        ObjStatementB.Reset;
        ObjStatementB.SetRange(ObjStatementB."Loan  No.","Loan No");
        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'>%1',0);
        if ObjStatementB.FindSet then begin
          repeat
          VerStatementsAvDebits:=VerStatementsAvDebits+"Amount Out";
          ObjStatementB."Bank Statement Avarage Debits":=VerStatementsAvDebits/6;
          ObjStatementB.Modify;
          until ObjStatementB.Next=0;
          end;

        ObjStatementB."Bank Statement Net Income":=ObjStatementB."Bank Statement Avarage Credits"-ObjStatementB."Bank Statement Avarage Debits";
        ObjStatementB.Modify;
    end;

    var
        ObjStatementB: Record "Loans Register";
        VerStatementAvCredits: Decimal;
        VerStatementsAvDebits: Decimal;
}

