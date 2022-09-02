#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516100_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516100 "Purchase Requisition"
{
	RDLCLayout = './Layouts/PurchaseRequisition.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Purchase Header";"Purchase Header")
		{
			column(ReportForNavId_1102755000; 1102755000) {} // Autogenerated by ForNav - Do not delete
			column(No_PurchaseHeader; "Purchase Header"."No.")
			{
			}
			column(ExpectedReceiptDate_PurchaseHeader; "Purchase Header"."Expected Receipt Date")
			{
			}
			column(DocumentDate_PurchaseHeader; "Purchase Header"."Document Date")
			{
			}
			column(CompanyINfoName; CompanyINfo.Name)
			{
			}
			column(CompanyINfoAdd; CompanyINfo.Address)
			{
			}
			column(CompanyINfoPicture; CompanyINfo.Picture)
			{
			}
			column(ShortcutDimension1Code_PurchaseHeader; "Purchase Header"."Shortcut Dimension 1 Code")
			{
			}
			column(ShortcutDimension2Code_PurchaseHeader; "Purchase Header"."Shortcut Dimension 2 Code")
			{
			}
			column(LocationCode_PurchaseHeader; "Purchase Header"."Location Code")
			{
			}
			column(dim1name; Dim1Name)
			{
			}
			column(dim2name; Dim2Name)
			{
			}
			dataitem("Purchase Line";"Purchase Line")
			{
				DataItemLink = "Document No."=field("No.");
				column(ReportForNavId_1102755001; 1102755001) {} // Autogenerated by ForNav - Do not delete
				column(Type_PurchaseLine; "Purchase Line".Type)
				{
				}
				column(No_PurchaseLine; "Purchase Line"."No.")
				{
				}
				column(Description_PurchaseLine; "Purchase Line".Description)
				{
				}
				column(Description2_PurchaseLine; "Purchase Line"."Description 2")
				{
				}
				column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
				{
				}
				column(Quantity_PurchaseLine; "Purchase Line".Quantity)
				{
				}
				column(ExpectedReceiptDate_PurchaseLine; "Purchase Line"."Expected Receipt Date")
				{
				}
				column(sno; SNo)
				{
				}
				column(inventory; Inventory)
				{
				}
				trigger OnAfterGetRecord();
				begin
					SNo+=1;
					if Type=Type::Item then begin
					Item.Get("No.");
					Item.CalcFields(Inventory);
					Inventory:=Item.Inventory;
					end else
					Inventory:=0;
				end;
				
			}
			dataitem("Approval Entry";"Approval Entry")
			{
				DataItemLink = "Document No."=field("No.");
				DataItemTableView = where("Document Type"=const(Quote),Status=const(Approved));
				column(ReportForNavId_1102755002; 1102755002) {} // Autogenerated by ForNav - Do not delete
				column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
				{
				}
				column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
				{
				}
				column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
				{
				}
				column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
				{
				}
				column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
				{
				}
			}
			trigger OnAfterGetRecord();
			begin
				DimVal.Reset;
				DimVal.SetRange(Code,"Shortcut Dimension 1 Code");
				if DimVal.FindFirst then
				Dim1Name:=DimVal.Name;
				DimVal.Reset;
				DimVal.SetRange(Code,"Shortcut Dimension 2 Code");
				if DimVal.FindFirst then
				Dim2Name:=DimVal.Name;
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
		CompanyINfo.Get;
		CompanyINfo.CalcFields(Picture);
		SNo:=0;
		Dim1Name:='';
		Dim2Name:='';
		;ReportsForNavPre;
	end;
	var
		CompanyINfo: Record "Company Information";
		Inventory: Decimal;
		SNo: Integer;
		Item: Record Item;
		DimVal: Record "Dimension Value";
		Dim1Name: Text;
		Dim2Name: Text;

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516100_v6_3_0_2259;
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
