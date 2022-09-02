#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516109_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516109 "Stock Summary"
{
	RDLCLayout = './Layouts/StockSummary.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem(Item;Item)
		{
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			column(No; Item."No.")
			{
			}
			column(Description; Item.Description)
			{
			}
			column(Quantity; Item.Inventory)
			{
			}
			column(UOM; Item."Base Unit of Measure")
			{
			}
			column(Unit_cost; Item."Unit Cost")
			{
			}
			column(Item_Group; Item."Location Code")
			{
			}
			column(Company_Name; UpperCase(CompInfo.Name))
			{
			}
			column(Amount; TAmout)
			{
			}
			column(LIssueDate; LIssueD)
			{
			}
			column(LRecptDate; LRcptD)
			{
			}
			column(pic; CompInfo.Picture)
			{
			}
			column(TDate; TDate)
			{
			}
			trigger OnPreDataItem();
			begin
				if CompInfo.Get then CompInfo.CalcFields(CompInfo.Picture);
				CompName:=CompInfo.Name;
			end;
			
			trigger OnAfterGetRecord();
			begin
				if Inventory=0 then
				CurrReport.Skip;
				//CLEAR(LIssueD);
				//CLEAR(LRcptD);
				Sreq.Reset;
				Sreq.SetRange(Sreq."No.",Items."No.");
				Sreq.SetRange(Sreq."Request Status",Sreq."request status"::Closed);
				if Sreq.Find('+') then
				LIssueD:=Sreq."Posting Date";
				ItemEnt.Reset;
				ItemEnt.SetRange (ItemEnt."Item No.",Item."No.");
				ItemEnt.SetRange (ItemEnt."Entry Type",ItemEnt."entry type"::"Positive Adjmt.");
				ItemEnt.SetRange (ItemEnt."Document Type",ItemEnt."document type"::"Purchase Receipt");
				if ItemEnt.Find ('+') then
				LRcptD:=ItemEnt."Posting Date";
				Items.Reset;
				Items.SetRange(Items."No.",Item."No.");
				if Items.Find('-') then
				begin
				Items.CalcFields(Items.Inventory);
				TAmout:=Items.Inventory*Items."Unit Cost";
				end;
			end;
			
		}
	}

	requestpage
	{

  
		SaveValues = false;	  layout
		{
			area(content)
			{
				field(TDate;TDate)
				{
					ApplicationArea = Basic;
					Caption = 'Enter Date';
				}
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
		TAmout: Decimal;
		Items: Record Item;
		LIssueDate: Date;
		LRecptDate: Date;
		TDate: Date;
		Sreq: Record "Store Requistion Lines";
		LIssueD: Date;
		LRcptD: Date;
		ItemEnt: Record "Item Ledger Entry";

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516109_v6_3_0_2259;
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