#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516103_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516103 "Counter Requisition Form"
{
	RDLCLayout = './Layouts/CounterRequisitionForm.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Store Requistion Header P";"Store Requistion Header P")
		{
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			column(DocumentNo; "Store Requistion Header P"."No.")
			{
			}
			column(PointOfIssue; "Store Requistion Header P"."Issuing Store")
			{
			}
			column(PointofUse; "Store Requistion Header P"."Responsibility Center")
			{
			}
			column(Date; "Store Requistion Header P"."Request date")
			{
			}
			column(CompName; CompName)
			{
			}
			column(Pic; CompInfo.Picture)
			{
			}
			column(Address; CompInfo."Address 2"+',')
			{
			}
			column(City; CompInfo.City)
			{
			}
			column(Picture; Logos.Picture)
			{
			}
			column(USER; "Store Requistion Header P"."User ID")
			{
			}
			column(Dept; Dept)
			{
			}
			dataitem("Store Requistion Lines";"Store Requistion Lines")
			{
				DataItemLink = "Requistion No"=field("No.");
				column(ReportForNavId_5; 5) {} // Autogenerated by ForNav - Do not delete
				column(ItemNo; "Store Requistion Lines"."No.")
				{
				}
				column(Description; "Store Requistion Lines".Description)
				{
				}
				column(UnitofIssue; "Store Requistion Lines"."Unit of Measure")
				{
				}
				column(QuantitiyIssued; "Store Requistion Lines".Quantity)
				{
				}
				column(QuantityRequested; "Store Requistion Lines"."Quantity Requested")
				{
				}
				column(LastDateofIssue; "Store Requistion Lines"."Last Date of Issue")
				{
				}
				column(LastQuantityIssued; "Store Requistion Lines"."Last Quantity Issued")
				{
				}
				column(Remarks; "Store Requistion Lines".Remarks)
				{
				}
			}
			trigger OnPreDataItem();
			begin
				 if CompInfo.Get then
				 CompInfo.CalcFields(CompInfo.Picture);
				 CompName:=CompInfo.Name;
			end;
			
			trigger OnAfterGetRecord();
			begin
				Logos.Reset;
				Logos.SetRange(Logos.Code,"Store Requistion Header P"."Global Dimension 1 Code");
				if Logos.Find('-') then begin
				   Logos.CalcFields(Logos.Picture);
				end else begin
				   Logos.Reset;
				   Logos.SetRange(Logos.Default,true);
				   Logos.CalcFields(Logos.Picture);
				end;
				DimValue.Reset;
				DimValue.SetRange(DimValue.Code,"Store Requistion Header P"."Shortcut Dimension 2 Code");
				if DimValue.Find ('-') then
				Dept:=DimValue.Name;
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
		;ReportsForNavPre;
	end;
	var
		Logos: Record Logos;
		CompInfo: Record "Company Information";
		CompName: Text[100];
		DimValue: Record "Dimension Value";
		Dept: Text[100];

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516103_v6_3_0_2259;
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
