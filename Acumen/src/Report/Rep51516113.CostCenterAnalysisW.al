#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516113_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516113 "Cost Center Analysis W"
{
	RDLCLayout = './Layouts/CostCenterAnalysisW.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Store Requistion Lines";"Store Requistion Lines")
		{
			DataItemTableView = where("Request Status"=filter(Closed));
			RequestFilterFields = "Product Group","Issuing Store","No.","Shortcut Dimension 1 Code","Posting Date";
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			column(No; "Store Requistion Lines"."No.")
			{
			}
			column(Description; "Store Requistion Lines".Description)
			{
			}
			column(Quantity; "Store Requistion Lines".Quantity)
			{
			}
			column(UOM; "Store Requistion Lines"."Unit of Measure")
			{
			}
			column(Unit_cost; "Store Requistion Lines"."Unit Cost")
			{
				DecimalPlaces = 2:2;
			}
			column(Amount; "Store Requistion Lines"."Line Amount")
			{
				DecimalPlaces = 2:2;
			}
			column(Branch; Branch)
			{
			}
			column(Cost_center; CostCenter)
			{
			}
			column(Item_Category; "Store Requistion Lines"."Product Group")
			{
			}
			column(Start_Date; StartDate)
			{
			}
			column(End_Date; EndDate)
			{
			}
			column(Product_Group; ProdGroup)
			{
			}
			column(Location; Location)
			{
			}
			column(Company_Name; UpperCase(CompInfo.Name))
			{
			}
			column(MR_No; "Store Requistion Lines"."Requistion No")
			{
			}
			column(posting_date; "Store Requistion Lines"."Posting Date")
			{
			}
			column(IssStore; "Store Requistion Lines"."Issuing Store")
			{
			}
			column(CostC; "Store Requistion Lines"."Shortcut Dimension 2 Code")
			{
			}
			trigger OnPreDataItem();
			begin
				"Store Requistion Lines".CalcFields("Store Requistion Lines"."Product Group");
				if CompInfo.Get then
				CompName:=CompInfo.Name;
				Clear("Store Requistion Lines"."Issuing Store");
				//if EndDate=0d then EndDate:=workdate;
			end;
			
			trigger OnAfterGetRecord();
			begin
				if( "Store Requistion Lines".Quantity =0 ) or
				("Store Requistion Lines"."Request Status"="Store Requistion Lines"."request status"::Pending)
				then CurrReport.Skip;
				//RESET;
				//IF StartDate<>0D THEN
				//SETRANGE("Store Requistion Lines"."Posting Date",StartDate,EndDate);
				 DimValue.Reset;
				 DimValue.SetRange(DimValue.Code,"Store Requistion Lines"."Shortcut Dimension 1 Code");
				 if DimValue.Find ('-') then
				 Branch:=DimValue.Name;
				 DimValue.Reset;
				 DimValue.SetRange(DimValue.Code,"Store Requistion Lines"."Shortcut Dimension 2 Code");
				 if DimValue.Find ('-') then
				CostCenter:=DimValue.Name;
			end;
			
		}
	}

	requestpage
	{

  
		SaveValues = false;	  layout
		{
			area(content)
			{
				group(Options)
				{
					Caption = 'Options';
					field(ForNavOpenDesigner;ReportForNavOpenDesigner)
					{
						ApplicationArea = Basic;
						Caption = 'Design';
						Visible = ReportForNavAllowDesign;
						trigger OnValidate()
						begin
							ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
							CurrReport.RequestOptionsPage.Close();
						end;

					}
				}
			}
		}

		actions
		{
		}
		trigger OnOpenPage()
		begin
			ReportForNavOpenDesigner := false;
		end;
	}

	trigger OnInitReport()
	begin
		;ReportsForNavInit;

	end;

	trigger OnPostReport()
	begin
		;ReportForNav.Post;
	end;

	trigger OnPreReport()
	begin
		//IF StartDate=0D THEN ERROR('Please Enter the start date!');
		;ReportsForNavPre;
	end;
	var
		Location: Code[20];
		Product: Code[20];
		StartDate: Date;
		EndDate: Date;
		ProdGroup: Code[20];
		Value: Decimal;
		PostDate: Date;
		DimValue: Record "Dimension Value";
		CostCenter: Text[100];
		Branch: Text[100];
		CompInfo: Record "Company Information";
		CompName: Text[100];
		Dept: Code[10];

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516113_v6_3_0_2259;
		ReportForNavOpenDesigner : Boolean;
		[InDataSet]
		ReportForNavAllowDesign : Boolean;

	local procedure ReportsForNavInit();
	var
		ApplicationSystemConstants: Codeunit "Application System Constants";
		addInFileName : Text;
		tempAddInFileName : Text;
		path: DotNet Path;
		ReportForNavObject: Variant;
	begin
		addInFileName := ApplicationPath() + 'Add-ins\ReportsForNAV_6_3_0_2259\ForNav.Reports.6.3.0.2259.dll';
		if not File.Exists(addInFileName) then begin
			tempAddInFileName := path.GetTempPath() + '\Microsoft Dynamics NAV\Add-Ins\' + ApplicationSystemConstants.PlatformFileVersion() + '\ForNav.Reports.6.3.0.2259.dll';
			if not File.Exists(tempAddInFileName) then
				Error('Please install the ForNAV DLL version 6.3.0.2259 in your service tier Add-ins folder under the file name "%1"\\If you already have the ForNAV DLL on the server, you should move it to this folder and rename it to match this file name.', addInFileName);
		end;
		ReportForNavObject := ReportForNav.GetLatest(CurrReport.OBJECTID, CurrReport.Language, SerialNumber, UserId, CompanyName);
		ReportForNav := ReportForNavObject;
		ReportForNav.Init();
	end;

	local procedure ReportsForNavPre();
	begin
		ReportForNav.OpenDesigner:=ReportForNavOpenDesigner;
		if not ReportForNav.Pre() then CurrReport.Quit();
	end;

	// Reports ForNAV Autogenerated code - do not delete or modify -->
}
