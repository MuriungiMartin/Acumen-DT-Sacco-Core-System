#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516056 "Funds Transfer Header"
{

    fields
    {
        field(10;"No.";Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                  Setup.Get;
                  NoSeriesMgt.TestManual(Setup."Funds Transfer Nos");
                  "No. Series" := '';
                end;
            end;
        }
        field(11;"Document Date";Date)
        {
            Editable = false;
        }
        field(12;"Posting Date";Date)
        {
            Editable = false;
        }
        field(13;"Paying Bank Account";Code[20])
        {
            TableRelation = "Bank Account"."No." where ("Bank Type"=const(Normal));

            trigger OnValidate()
            begin
                 BankAcc.Reset;
                 BankAcc.SetRange(BankAcc."No.","Paying Bank Account");
                 if BankAcc.FindFirst then begin
                  "Paying Bank Name":=BankAcc.Name;
                 end;
            end;
        }
        field(14;"Paying Bank Name";Text[50])
        {
            Editable = false;
        }
        field(15;"Bank Balance";Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where ("Bank Account No."=field("Paying Bank Account")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16;"Bank Balance(LCY)";Decimal)
        {
        }
        field(17;"Bank Account No.";Code[20])
        {
        }
        field(18;"Currency Code";Code[20])
        {
            TableRelation = Currency;
        }
        field(19;"Currency Factor";Decimal)
        {
        }
        field(20;"Amount to Transfer";Decimal)
        {

            trigger OnValidate()
            begin
                 if "Currency Code"='' then
                  "Amount to Transfer(LCY)":="Amount to Transfer";
                
                 /*IF "Amount to Transfer">"Bank Balance" THEN
                ERROR('You cannot Transfer more  than what is in the Bank');
                
                 IF "Amount to Transfer"<0 THEN
                ERROR('You cannot Transfer Negative Amount');
                */

            end;
        }
        field(21;"Amount to Transfer(LCY)";Decimal)
        {
            Editable = false;
        }
        field(22;"Total Line Amount";Decimal)
        {
            CalcFormula = sum("Funds Transfer Line"."Amount to Receive" where ("Document No"=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23;"Total Line Amount(LCY)";Decimal)
        {
            CalcFormula = sum("Funds Transfer Line"."Amount to Receive (LCY)" where ("Document No"=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24;"Pay Mode";Option)
        {
            Editable = true;
            OptionCaption = ' ,Cash,Cheque,Standing Order';
            OptionMembers = " ",Cash,Cheque,"Bank Slip","Standing Order";
        }
        field(25;Status;Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Cancelled,Posted';
            OptionMembers = New,"Pending Approval",Approved,Cancelled,Posted;
        }
        field(26;"Cheque/Doc. No";Code[20])
        {
        }
        field(27;Description;Text[50])
        {
        }
        field(28;"No. Series";Code[20])
        {
        }
        field(29;Posted;Boolean)
        {
        }
        field(30;"Posted By";Code[60])
        {
        }
        field(31;"Date Posted";Date)
        {
        }
        field(32;"Time Posted";Time)
        {
        }
        field(33;"Created By";Code[80])
        {
            Editable = false;
        }
        field(34;"Date Created";Date)
        {
            Editable = false;
        }
        field(35;"Time Created";Time)
        {
            Editable = false;
        }
        field(36;"Transfer Type";Option)
        {
            OptionCaption = ' ,Bank Withdrawal,InterBank';
            OptionMembers = " ","Bank Withdrawal",InterBank;
        }
        field(37;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1),
                                                          "Dimension Value Type"=const(Standard));
        }
        field(38;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2),
                                                          "Dimension Value Type"=const(Standard));
        }
        field(39;"Shortcut Dimension 3 Code";Code[20])
        {
        }
        field(40;"Shortcut Dimension 4 Code";Code[20])
        {
        }
        field(41;"Shortcut Dimension 5 Code";Code[20])
        {
        }
        field(42;"Shortcut Dimension 6 Code";Code[20])
        {
        }
        field(43;"Shortcut Dimension 7 Code";Code[20])
        {
        }
        field(44;"Shortcut Dimension 8 Code";Code[20])
        {
        }
        field(45;"Transfer To";Text[50])
        {
        }
        field(46;Reversed;Boolean)
        {
        }
        field(47;"Reversed By";Code[60])
        {
        }
        field(48;"Reversal Date";Date)
        {
        }
        field(49;"Reversal Time";Time)
        {
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
          Setup.Get;
          Setup.TestField(Setup."Funds Transfer Nos");
          NoSeriesMgt.InitSeries(Setup."Funds Transfer Nos",xRec."No. Series",0D,"No.","No. Series");
        end;
        
        "Document Date":=Today;
        "Posting Date":=Today;
        "Created By":=UserId;
        "Date Created":=Today;
        "Time Created":=Time;
        
        /*IF "No." = '' THEN BEGIN
          IF "Transfer Type"="Transfer Type"::"Bank Withdrawal" THEN BEGIN   //Bank Withdrawals
            Setup.GET;
            Setup.TESTFIELD(Setup."Funds Withdrawal Nos");
            NoSeriesMgt.InitSeries(Setup."Funds Withdrawal Nos",xRec."No. Series",0D,"No.","No. Series");
          END ELSE BEGIN
            Setup.GET;
            Setup.TESTFIELD(Setup."Funds Transfer Nos");
            NoSeriesMgt.InitSeries(Setup."Funds Transfer Nos",xRec."No. Series",0D,"No.","No. Series");
          END;
        END;*/

    end;

    var
        Setup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankAcc: Record "Bank Account";
}

