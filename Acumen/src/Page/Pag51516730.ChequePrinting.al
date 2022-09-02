#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516730 "Cheque Printing"
{
    ApplicationArea = Basic;
    SourceTable = "Cheque Printing Register";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Reference No";"Reference No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Bank";"Cheque Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name";"Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Payment to";"Payment to")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Naration";"Payment Naration")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No";"Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Date";"Cheque Date")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Printing Status";"Cheque Printing Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By";"Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup16)
            {
                action(Issue)
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        if Confirm('ARE YOU SURE YOU WANT TO ISSUE OUT THIS CHEQUE?',false)=true then begin
                        if Amount>1000000 then begin
                        Error('YOU CAN NOT ISSUE A CHEQUE OF MORE THAN 999,999');
                        end else
                        "Cheque Printing Status":="cheque printing status"::Issued;
                        "Cheque Date":=Today;
                        "Created By":=UserId;
                        Modify;
                        end;
                    end;
                }
                action("Print Cheque")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        if Amount>1000000 then begin
                        Error('YOU CAN NOT PRINT A CHEQUE OF MORE THAN 999,999');
                        end else

                        //Print Cheque
                        Reset;
                        SetFilter("Reference No","Reference No");
                        //IF CONFIRM(Text003,TRUE) THEN  BEGIN

                        Report.Run(51516137,true,true,Rec);
                        Reset;
                        //END;
                        CurrPage.Update;
                        //CurrForm.UPDATE;
                        //CurrForm.SAVERECORD;
                        CurrPage.SaveRecord;
                        Reset;
                    end;
                }
            }
        }
    }

    var
        BankName: Text[30];
}

