#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516541 "Agent Applications"
{

    fields
    {
        field(1;"Agent Code";Code[30])
        {
            Editable = false;
        }
        field(2;"Date Entered";Date)
        {
        }
        field(3;"Time Entered";Time)
        {
        }
        field(4;"Entered By";Code[30])
        {
        }
        field(5;"Document Serial No";Text[50])
        {
        }
        field(6;"Document Date";Date)
        {
        }
        field(7;"Customer ID No";Code[50])
        {
        }
        field(8;Name;Text[200])
        {
        }
        field(9;"Mobile No";Text[50])
        {
        }
        field(11;Status;Option)
        {
            OptionMembers = Pending,"1st Approval",Approved,Rejected;
        }
        field(12;Comments;Text[200])
        {
        }
        field(13;"Rejection Reason";Text[30])
        {
        }
        field(14;"Date Approved";Date)
        {
        }
        field(15;"Time Approved";Time)
        {
        }
        field(16;"Approved By";Code[30])
        {
        }
        field(17;"Date Rejected";Date)
        {
        }
        field(18;"Time Rejected";Time)
        {
        }
        field(19;"Rejected By";Code[30])
        {
        }
        field(20;"Sent To Server";Option)
        {
            OptionMembers = No,Yes;
        }
        field(21;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(22;"1st Approval By";Code[30])
        {
        }
        field(23;"Date 1st Approval";Date)
        {
        }
        field(24;"Time First Approval";Time)
        {
        }
        field(25;"Withdrawal Limit Code";Code[20])
        {
            TableRelation = "Agent Withdrawal Limits".Code;

            trigger OnValidate()
            begin
                WithdrawLimit.Reset;
                WithdrawLimit.SetRange(WithdrawLimit.Code,"Withdrawal Limit Code");
                if WithdrawLimit.Find('-') then begin
                WithdrawLimit.TestField(WithdrawLimit."Limit Amount");
                "Withdrawal Limit Amount":=WithdrawLimit."Limit Amount";
                end;
            end;
        }
        field(26;"Withdrawal Limit Amount";Decimal)
        {
        }
        field(27;Account;Code[30])
        {
            TableRelation = Vendor."No." where ("Account Type"=const('FS151'));

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.",Account);
                if Vend.Find ('-') then begin
                "Customer ID No":=Vend."ID No.";
                 Name:=Vend.Name;
                "Mobile No":=Vend."Mobile Phone No";
                "Date of Birth":=Vend."Date of Birth";
                Modify;
                end;
            end;
        }
        field(28;"Name of the Proposed Agent";Text[200])
        {
        }
        field(29;"Date of Birth";Date)
        {
        }
        field(30;"Type of Business";Text[200])
        {
        }
        field(31;"Place of Business";Text[50])
        {
        }
        field(32;"Business/Work Experience";Text[100])
        {
        }
        field(33;"Name of Banker";Text[50])
        {
        }
        field(34;"PIN(KRA)";Code[30])
        {
        }
        field(35;Branch;Boolean)
        {
        }
        field(36;NewApps;Integer)
        {
        }
        field(37;"Comm Account";Code[30])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                /*Vend.RESET;
                Vend.SETRANGE(Vend."No.",Account);
                IF Vend.FIND ('-') THEN BEGIN
                "Customer ID No":=Vend."ID No.";
                Name:=Vend.Name;
                "Mobile No":=Vend."Mobile Phone No";
                "Date of Birth":=Vend."Date of Birth";
                MODIFY;
                END;*/

            end;
        }
        field(38;"Branch Registered at";Text[50])
        {
        }
    }

    keys
    {
        key(Key1;"Agent Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        if Status<>Status::Pending then begin
        Error('You cannot delete this application.');
        end;
    end;

    trigger OnInsert()
    begin

          if "Agent Code" = '' then begin
          NoSetup.Get;
          NoSetup.TestField(NoSetup."Agency Application Nos");
          NoSeriesMgt.InitSeries(NoSetup."Agency Application Nos",xRec."No. Series",0D,"Agent Code","No. Series");
          end;

          "Entered By":=UserId;
          "Date Entered":=Today;
          "Time Entered":=Time;
    end;

    trigger OnModify()
    begin
        /*
        IF Status<>Status::Approved THEN BEGIN
        ERROR('You cannot Approve the application.');
        END;
           */

    end;

    var
        NoSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        WithdrawLimit: Record "Agent Withdrawal Limits";
        Vend: Record Vendor;
        Member: Record "Member Register";
}

