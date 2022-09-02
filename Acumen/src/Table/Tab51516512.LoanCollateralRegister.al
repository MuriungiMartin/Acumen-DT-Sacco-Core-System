#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516512 "Loan Collateral Register"
{
    DrillDownPageID = "Loan Collateral Register List";
    LookupPageID = "Loan Collateral Register List";

    fields
    {
        field(1;"Document No";Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                  SalesSetup.Get;
                  NoSeriesmgt.TestManual(SalesSetup."Collateral Register No");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Registered Owner";Code[30])
        {
        }
        field(3;"Member No.";Code[20])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Member No.") then begin
                  "Member Name":=Cust.Name;
                  "ID No.":=Cust."ID No.";
                  "Charge Account":=Cust."FOSA Account No.";
                  end;
            end;
        }
        field(4;"Member Name";Code[40])
        {
        }
        field(5;"ID No.";Code[20])
        {
        }
        field(6;"Collateral Type";Option)
        {
            OptionMembers = Cash;
        }
        field(7;"Collateral Description";Code[20])
        {
        }
        field(8;"Date Received";Date)
        {

            trigger OnValidate()
            begin
                "Received By":=UserId;
            end;
        }
        field(9;"Received By";Code[20])
        {
            Editable = false;
        }
        field(10;"Date Released";Date)
        {
        }
        field(11;"Released By";Code[20])
        {
        }
        field(12;Picture;Blob)
        {
            SubType = Bitmap;
        }
        field(13;"No. Series";Code[20])
        {
        }
        field(14;"Reference No";Code[20])
        {
        }
        field(22;"Insurance Effective Date";Date)
        {
            Caption = 'Effective Date';
        }
        field(23;"Insurance Expiration Date";Date)
        {
            Caption = 'Expiration Date';
        }
        field(24;"Insurance Policy No.";Text[30])
        {
            Caption = 'Policy No.';
        }
        field(25;"Insurance Annual Premium";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Annual Premium';
            MinValue = 0;
        }
        field(26;"Policy Coverage";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Policy Coverage';
            MinValue = 0;
        }
        field(27;"Total Value Insured";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Value Insured';
        }
        field(28;Comment;Boolean)
        {
            Caption = 'Comment';
        }
        field(29;"Insurance Type";Code[10])
        {
            Caption = 'Insurance Type';
            TableRelation = "Insurance Type";
        }
        field(31;"Insurance Vendor No.";Code[20])
        {
            Caption = 'Insurance Vendor No.';
            TableRelation = Vendor;
        }
        field(32;"Asset Value";Decimal)
        {
        }
        field(33;"Depreciation Completion Date";Date)
        {
        }
        field(34;"Asset Depreciation Amount";Decimal)
        {
            CalcFormula = sum("Collateral Depr Register"."Depreciation Amount" where ("Document No"=field("Document No")));
            FieldClass = FlowField;
        }
        field(35;"Asset Value @Loan Completion";Decimal)
        {
            CalcFormula = min("Collateral Depr Register"."Collateral NBV" where ("Document No"=field("Document No")));
            FieldClass = FlowField;
        }
        field(36;"Depreciation Percentage";Decimal)
        {
        }
        field(37;"Collateral Posting Group";Code[20])
        {
            TableRelation = "FA Posting Group".Code;

            trigger OnValidate()
            begin
                ObjFAPostingGroup.Reset;
                ObjFAPostingGroup.SetRange(ObjFAPostingGroup.Code,"Collateral Posting Group");
                if ObjFAPostingGroup.FindSet then begin
                  "Collateral Depreciation Method":=ObjFAPostingGroup."Depreciation Method";
                  "Depreciation Percentage":=ObjFAPostingGroup."Depreciation %";
                  end;
            end;
        }
        field(38;"Collateral Depreciation Method";Option)
        {
            OptionCaption = 'Straight-Line,Declining-Balance 1,Declining-Balance 2,DB1/SL,DB2/SL,User-Defined,Manual';
            OptionMembers = "Straight-Line","Declining-Balance 1","Declining-Balance 2","DB1/SL","DB2/SL","User-Defined",Manual;
        }
        field(39;"Action";Option)
        {
            OptionCaption = ' ,Receive at HQ,Lodge to Strong Room,Retrieve From Strong Room,Issue to Lawyer,Issue to Insurance Agent,Release to Member,Dispatch to Branch,Receive at Branch,Receive From Lawyer,Issue to Auctioneer,Booked to Safe Custody';
            OptionMembers = " ","Receive at HQ","Lodge to Strong Room","Retrieve From Strong Room","Issue to Lawyer","Issue to Insurance Agent","Release to Member","Dispatch to Branch","Receive at Branch","Receive From Lawyer","Issue to Auctioneer","Booked to Safe Custody";

            trigger OnValidate()
            begin
                if Confirm('Are you sure you want to'+Format(Action)+' this Collateral',false)=true then begin

                if Action=Action::"Receive at HQ" then begin
                  "Received to HQ By":=UserId;
                  "Received to HQ On":=Today;
                  FnUpdateCollateralMovement(Action::"Receive at HQ",Today,UserId,"Document No");
                  end;
                  if (Action=Action::"Dispatch to Branch")  then begin
                    "Dispatched to Branch By":=UserId;
                    "Dispatched to Branch On":=Today;
                    FnUpdateCollateralMovement(Action::"Dispatch to Branch",Today,UserId,"Document No");
                    end;
                    if  (Action=Action::"Receive at Branch") then begin
                    "Received at Branch By":=UserId;
                    "Received at Branch On":=Today;
                    FnUpdateCollateralMovement(Action::"Receive at Branch",Today,UserId,"Document No");
                    end;
                    if (Action=Action::"Issue to Lawyer")  then begin
                      "Issued to Lawyer By":=UserId;
                      "Issued to Lawyer On":=Today;
                      FnUpdateCollateralMovement(Action::"Issue to Lawyer",Today,UserId,"Document No");
                      end;
                    if (Action=Action::"Receive From Lawyer") then begin
                      "Received From Lawyer By":=UserId;
                      "Received From Lawyer On":=Today;
                      FnUpdateCollateralMovement(Action::"Receive From Lawyer",Today,UserId,"Document No");
                      end;
                      if Action=Action::"Issue to Auctioneer" then begin
                        "Issued to Auctioneer By":=UserId;
                        "Issued to Auctioneer On":=Today;
                        FnUpdateCollateralMovement(Action::"Issue to Auctioneer",Today,UserId,"Document No");
                        end;
                        if Action=Action::"Issue to Insurance Agent" then begin
                          "Issued to Insurance Agent By":=UserId;
                          "Issued to Insurance Agent On":=Today;
                          FnUpdateCollateralMovement(Action::"Issue to Insurance Agent",Today,UserId,"Document No");
                          end;
                          if Action=Action::"Release to Member" then begin
                            "Released to Member By":=UserId;
                            "Released to Member on":=Today;
                            FnUpdateCollateralMovement(Action::"Release to Member",Today,UserId,"Document No");
                            end;
                            if Action=Action::"Retrieve From Strong Room" then begin
                              "Retrieved From Strong Room By":=UserId;
                              "Retrieved From Strong Room On":=Today;
                              FnUpdateCollateralMovement(Action::"Retrieve From Strong Room",Today,UserId,"Document No");
                              end;
                end;
            end;
        }
        field(40;"Received to HQ By";Code[20])
        {
        }
        field(41;"Received to HQ On";Date)
        {
        }
        field(42;"Lodged to Strong Room By";Code[20])
        {
        }
        field(43;"Lodged to Strong Room On";Date)
        {
        }
        field(44;"Retrieved From Strong Room By";Code[20])
        {
        }
        field(45;"Retrieved From Strong Room On";Date)
        {
        }
        field(46;"Issued to Lawyer By";Code[20])
        {
        }
        field(47;"Issued to Lawyer On";Date)
        {
        }
        field(48;"Lawyer Code";Code[20])
        {
            TableRelation = Vendor."No." where ("Sacco Lawyer"=filter(true));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Lawyer Code") then begin
                  "Lawyer Name":=ObjAccount.Name;
                  end;
            end;
        }
        field(49;"Lawyer Name";Code[50])
        {
        }
        field(50;"Issued to Insurance Agent By";Code[20])
        {
        }
        field(51;"Issued to Insurance Agent On";Date)
        {
        }
        field(52;"Insurance Agent Code";Code[20])
        {
        }
        field(53;"Insurance Agent Name";Code[50])
        {
        }
        field(54;"Released to Member By";Code[20])
        {
        }
        field(55;"Released to Member on";Date)
        {
        }
        field(56;"Dispatched to Branch By";Code[20])
        {
        }
        field(57;"Dispatched to Branch On";Date)
        {
        }
        field(58;"Dispatch to Branch";Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=filter(2));
        }
        field(59;"Received at Branch By";Code[20])
        {
        }
        field(60;"Received at Branch On";Date)
        {
        }
        field(61;"Received From Lawyer By";Code[20])
        {
        }
        field(62;"Received From Lawyer On";Date)
        {
        }
        field(63;"Issued to Auctioneer By";Code[20])
        {
        }
        field(64;"Issued to Auctioneer On";Date)
        {
        }
        field(65;"Booked to Safe Custody By";Code[20])
        {
        }
        field(66;"Booked to Safe Custody On";Date)
        {
        }
        field(67;"Last Collateral Action";Option)
        {
            CalcFormula = max("Collateral Movement Register"."Current Location" where ("Document No"=field("Document No")));
            FieldClass = FlowField;
            OptionCaption = ' ,Receive at HQ,Lodge to Strong Room,Retrieve From Strong Room,Issue to Lawyer,Issue to Insurance Agent,Release to Member,Dispatch to Branch,Receive at Branch,Receive From Lawyer,Issue to Auctioneer,Booked to Safe Custody';
            OptionMembers = " ","Receive at HQ","Lodge to Strong Room","Retrieve From Strong Room","Issue to Lawyer","Issue to Insurance Agent","Release to Member","Dispatch to Branch","Receive at Branch","Receive From Lawyer","Issue to Auctioneer","Booked to Safe Custody";
        }
        field(68;"Lodged By(Custodian 1)";Code[20])
        {
        }
        field(69;"Lodged By(Custodian 2)";Code[20])
        {
        }
        field(70;"Date Lodged";Date)
        {
        }
        field(71;"Time Lodged";Time)
        {
        }
        field(72;"Released By(Custodian 1)";Code[20])
        {
        }
        field(73;"Released By(Custodian 2)";Code[20])
        {
        }
        field(74;"Date Released from SafeCustody";Date)
        {
        }
        field(75;"Time Released from SafeCustody";Time)
        {
        }
        field(76;"Charge Account";Code[20])
        {
            TableRelation = Vendor."No." where ("BOSA Account No"=field("Member No."));
        }
        field(77;"Package Type";Code[20])
        {
            TableRelation = "Package Types".Code;
        }
        field(78;"Last Collateral Action Entry";Code[20])
        {
            CalcFormula = max("Collateral Movement Register"."Entry No" where ("Document No"=field("Document No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Document No","Registered Owner","Collateral Description","Collateral Type")
        {
        }
    }

    trigger OnInsert()
    begin

        if "Document No" = '' then begin
          SalesSetup.Get;
          SalesSetup.TestField(SalesSetup."Collateral Register No");
          NoSeriesmgt.InitSeries(SalesSetup."Collateral Register No",xRec."No. Series",0D,"Document No","No. Series");
        end;


        "Date Received":=Today;
    end;

    var
        NoSeriesmgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sacco No. Series";
        Cust: Record "Member Register";
        ObjFAPostingGroup: Record "FA Posting Group";
        ObjCollMovement: Record "Collateral Movement Register";
        ObjAccount: Record Vendor;

    local procedure FnUpdateCollateralMovement(VarAction: Option;VarActionDate: Date;VarActionedBy: Code[20];VarDocNo: Code[10])
    begin
        ObjCollMovement.Reset;
        ObjCollMovement.SetCurrentkey("Entry No");
        if ObjCollMovement.FindLast then begin
          ObjCollMovement.Init;
          ObjCollMovement."Entry No":=IncStr(ObjCollMovement."Entry No");
          ObjCollMovement."Document No":=VarDocNo;
          ObjCollMovement."Current Location":=VarAction;
          ObjCollMovement."Date Actioned":=VarActionDate;
          ObjCollMovement."Action By":=VarActionedBy;
          ObjCollMovement.Insert;
          end;
    end;
}

