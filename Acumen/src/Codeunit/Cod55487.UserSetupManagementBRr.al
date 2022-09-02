#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 55487 "User Setup Management BRr"
{
    Permissions = TableData Location=r,
                  TableData "Responsibility Center"=r;

    trigger OnRun()
    begin
    end;

    var
        Text000: label 'customer';
        Text001: label 'vendor';
        Text002: label 'This %1 is related to %2 %3. Your identification is setup to process from %2 %4.';
        Text003: label 'This document will be processed in your %2.';
        UserSetup: Record "User Setup";
        CompanyInfo: Record "Company Information";
        UserLocation: Code[10];
        UserRespCenter: Code[10];
        SalesUserRespCenter: Code[10];
        PurchUserRespCenter: Code[10];
        ServUserRespCenter: Code[10];
        HasGotSalesUserSetup: Boolean;
        HasGotPurchUserSetup: Boolean;
        HasGotServUserSetup: Boolean;
        DimensionVal: Code[20];


    procedure GetSalesFilter(): Code[10]
    begin
        exit(GetSalesFilter2(UserId));
    end;


    procedure GetPurchasesFilter(): Code[10]
    begin
        exit(GetPurchasesFilter2(UserId));
    end;


    procedure GetServiceFilter(): Code[10]
    begin
        exit(GetServiceFilter2(UserId));
    end;


    procedure GetSalesFilter2(UserCode: Code[50]): Code[10]
    begin
        if not HasGotSalesUserSetup then begin
          CompanyInfo.Get;
          SalesUserRespCenter := CompanyInfo."Responsibility Center";
          UserLocation := CompanyInfo."Location Code";
          if (UserSetup.Get(UserCode)) and (UserCode <> '') then
            if UserSetup."Sales Resp. Ctr. Filter" <> '' then
              SalesUserRespCenter := UserSetup."Sales Resp. Ctr. Filter";
          HasGotSalesUserSetup := true;
        end;
        exit(SalesUserRespCenter);
    end;


    procedure GetPurchasesFilter2(UserCode: Code[50]): Code[10]
    begin
        if not HasGotPurchUserSetup then begin
          CompanyInfo.Get;
          PurchUserRespCenter := CompanyInfo."Responsibility Center";
          UserLocation := CompanyInfo."Location Code";
          if (UserSetup.Get(UserCode)) and (UserCode <> '') then
            if UserSetup."Purchase Resp. Ctr. Filter" <> '' then
              PurchUserRespCenter := UserSetup."Purchase Resp. Ctr. Filter";
          HasGotPurchUserSetup := true;
        end;
        exit(PurchUserRespCenter);
    end;


    procedure GetServiceFilter2(UserCode: Code[50]): Code[10]
    begin
        if not HasGotServUserSetup then begin
          CompanyInfo.Get;
          ServUserRespCenter := CompanyInfo."Responsibility Center";
          UserLocation := CompanyInfo."Location Code";
          if (UserSetup.Get(UserCode)) and (UserCode <> '') then
            if UserSetup."Service Resp. Ctr. Filter" <> '' then
              ServUserRespCenter := UserSetup."Service Resp. Ctr. Filter";
          HasGotServUserSetup := true;
        end;
        exit(ServUserRespCenter);
    end;


    procedure GetRespCenter(DocType: Option Sales,Purchase,Service;AccRespCenter: Code[10]): Code[10]
    var
        AccType: Text[50];
    begin
        case DocType of
          Doctype::Sales:
            begin
              AccType := Text000;
              UserRespCenter := GetSalesFilter;
            end;
          Doctype::Purchase:
            begin
              AccType := Text001;
              UserRespCenter := GetPurchasesFilter;
            end;
          Doctype::Service:
            begin
              AccType := Text000;
              UserRespCenter := GetServiceFilter;
            end;
        end;
        /*IF (AccRespCenter <> '') AND
           (UserRespCenter <> '') AND
           (AccRespCenter <> UserRespCenter)
        THEN
          MESSAGE(
            Text002 +
            Text003,
            AccType,RespCenter.TABLECAPTION,AccRespCenter,UserRespCenter);*/
        if UserRespCenter = '' then
          exit(AccRespCenter)
        else
          exit(UserRespCenter);

    end;


    procedure CheckRespCenter(DocType: Option Sales,Purchase,Service;AccRespCenter: Code[10]): Boolean
    begin
        exit(CheckRespCenter2(DocType,AccRespCenter,UserId));
    end;


    procedure CheckRespCenter2(DocType: Option Sales,Purchase,Service;AccRespCenter: Code[20];UserCode: Code[50]): Boolean
    begin
        case DocType of
          Doctype::Sales: UserRespCenter := GetSalesFilter2(UserCode);
          Doctype::Purchase: UserRespCenter := GetPurchasesFilter2(UserCode);
          Doctype::Service: UserRespCenter := GetServiceFilter2(UserCode);
        end;
        if (UserRespCenter <> '') and
           (AccRespCenter <> UserRespCenter)
        then
          exit(false)
        else
          exit(true);
    end;


    procedure GetLocation(DocType: Option Sales,Purchase,Service;AccLocation: Code[10];RespCenterCode: Code[10]): Code[10]
    begin
        /*CASE DocType OF
          DocType::Sales: UserRespCenter := GetSalesFilter;
          DocType::Purchase: UserRespCenter := GetPurchasesFilter;
          DocType::Service: UserRespCenter := GetServiceFilter;
        END;
        IF UserRespCenter <> '' THEN
          RespCenterCode := UserRespCenter;
        IF RespCenter.GET(RespCenterCode) THEN
          IF RespCenter."Location Code" <> '' THEN
            UserLocation := RespCenter."Location Code";
        IF AccLocation <> '' THEN
          EXIT(AccLocation)
        ELSE
          EXIT(UserLocation);
        */

    end;


    procedure GetSetDimensions(UserCode: Code[50];DimensionNo: Integer): Code[50]
    begin
          DimensionVal:='';
           case DimensionNo of
           1:
           begin
           if (UserSetup.Get(UserCode)) and (UserCode <> '') then
            if UserSetup."Global Dimension 1 Code" <> '' then
              DimensionVal := UserSetup."Global Dimension 1 Code";
           exit(DimensionVal);
           end;
           2:
           begin
           if (UserSetup.Get(UserCode)) and (UserCode <> '') then
            if UserSetup.tetst <> '' then
              DimensionVal := UserSetup.tetst;
           exit(DimensionVal);
           end;
           3:
           begin
           if (UserSetup.Get(UserCode)) and (UserCode <> '') then
            if UserSetup."Shortcut Dimension 3 Code" <> '' then
              DimensionVal := UserSetup."Shortcut Dimension 3 Code";
           exit(DimensionVal);
           end;
           4:
           begin
           if (UserSetup.Get(UserCode)) and (UserCode <> '') then
            if UserSetup."Shortcut Dimension 4 Code" <> '' then
              DimensionVal := UserSetup."Shortcut Dimension 4 Code";
           exit(DimensionVal);
           end;
          end;
    end;
}

