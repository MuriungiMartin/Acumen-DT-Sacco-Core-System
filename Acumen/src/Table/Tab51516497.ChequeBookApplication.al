#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516497 "Cheque Book Application"
{
    DrillDownPageID = UnknownPage52018532;
    LookupPageID = UnknownPage52018532;

    fields
    {
        field(1;"No.";Code[10])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                  SalesSetup.Get;
                  Noseriesmgt.TestManual(SalesSetup."Cheque Application Nos");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Account No.";Code[20])
        {
            TableRelation = Vendor."No." where (Status=const(Active));

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.","Account No.");
                //Vend.SETFILTER(Vend."Account Type",'502|504|509');
                if Vend.Find('-') then begin
                //"Account No.":=Vend."No.";
                Name:=Vend.Name;
                "ID No.":= Vend."ID No.";//Vend."Identification No.";
                "Staff No.":=Vend."Personal No.";
                "Member No.":=Vend."BOSA Account No";
                "Cheque Account No.":=Vend."Cheque Acc. No";
                
                end else begin
                Error('Member no. not found');
                end;
                /*
                IF Vend.GET("Account No.")  THEN BEGIN
                IF Vend."ChqAcount Number" = '' THEN BEGIN
                IF acctypes.GET(Vend."Account Type") THEN BEGIN
                //LASTNUMBER:=acctypes.ChqNumbers;
                acctypes.ChqNumbers:=INCSTR(acctypes.ChqNumbers);
                acctypes.MODIFY;
                END;
                Vend."ChqAcount Number":=LASTNUMBER;
                IF "Cheque Account No." = '' THEN BEGIN
                "Cheque Account No.":=Vend."ChqAcount Number";
                MODIFY;
                END;
                Vend.MODIFY;
                END;
                END;
                 */

            end;
        }
        field(3;Name;Text[50])
        {
        }
        field(4;"ID No.";Code[20])
        {
        }
        field(5;"Application Date";Date)
        {
        }
        field(6;"Cheque Account No.";Code[20])
        {
        }
        field(7;"Staff No.";Code[20])
        {
        }
        field(8;"Export Format";Code[10])
        {
        }
        field(9;"No. Series";Code[10])
        {
        }
        field(10;"Member No.";Code[10])
        {
        }
        field(11;"Responsibility Centre";Code[10])
        {
        }
        field(12;"Begining Cheque No.";Code[60])
        {

            trigger OnValidate()
            begin
                ChequeSetUp.Reset;
                ChequeSetUp.SetRange(ChequeSetUp."Cheque Code","Cheque Book Type");
                if ChequeSetUp.Find('-') then begin

                Evaluate(BeginNo,"Begining Cheque No.");
                Evaluate(NoofLF,ChequeSetUp."Number Of Leaf");
                "End Cheque No.":=Format(BeginNo+NoofLF-1);
                end;
            end;
        }
        field(13;"End Cheque No.";Code[60])
        {
        }
        field(14;"Application Exported";Boolean)
        {
        }
        field(15;"Cheque Register Generated";Boolean)
        {
            Editable = false;
        }
        field(16;Select;Boolean)
        {

            trigger OnValidate()
            begin
                if "Cheque Book charges Posted"=false then
                Error('Please Post Cheque book charges before exporting');
            end;
        }
        field(17;"Cheque Book charges Posted";Boolean)
        {
            Editable = false;
        }
        field(18;"Cheque Book Type";Code[10])
        {
            TableRelation = "Cheque Set Up";

            trigger OnValidate()
            begin
                 ChApp.Reset;
                 ChApp.SetRange(ChApp."Account No.","Account No.");
                 ChApp.SetRange(ChApp.Status,ChApp.Status::Approved);
                if ChApp.Find('+') then begin
                "Begining Cheque No.":=IncStr(ChApp."End Cheque No.");

                end;


                //VALIDATE("Begining Cheque No.");
            end;
        }
        field(68005;Status;Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(68006;"Last check";Code[30])
        {
            CalcFormula = max("Cheques Register"."Cheque No." where ("Account No."=field("Account No.")));
            FieldClass = FlowField;
        }
        field(68007;"Requested By";Code[20])
        {

            trigger OnValidate()
            begin
                "Requested By":= UserId;
            end;
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
          SalesSetup.Get;
          SalesSetup.TestField(SalesSetup."Cheque Application Nos");
          Noseriesmgt.InitSeries(SalesSetup."Cheque Application Nos",xRec."No. Series",0D,"No.","No. Series");
        end;



        "Application Date":=Today;
        "Requested By":=UserId;
    end;

    trigger OnModify()
    begin

         if Status=Status::Approved then begin
        if "Cheque Register Generated"=true then
        Error('Cheque register has already been generated.');
         end;
    end;

    var
        Vend: Record Vendor;
        Noseriesmgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sacco No. Series";
        acctypes: Record "Account Types-Saving Products";
        LASTNUMBER: Code[60];
        ChequeSetUp: Record "Cheque Set Up";
        "number of leafs": Code[20];
        ChApp: Record "Cheque Book Application";
        BeginNo: Integer;
        NoofLF: Integer;
}

