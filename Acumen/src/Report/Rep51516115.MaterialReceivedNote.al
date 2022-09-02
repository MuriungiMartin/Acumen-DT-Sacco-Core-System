#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.6.3.0.2259")
	{
		type(ForNav.Report_6_3_0_2259; ForNavReport51516115_v6_3_0_2259){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516115 "Material Received Note"
{
	RDLCLayout = './Layouts/MaterialReceivedNote.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Purch. Rcpt. Line";"Purch. Rcpt. Line")
		{
			RequestFilterFields = "No.","Document No.";
			column(ReportForNavId_1; 1) {} // Autogenerated by ForNav - Do not delete
			column(No; "Purch. Rcpt. Line"."No.")
			{
			}
			column(Desc; "Purch. Rcpt. Line".Description)
			{
			}
			column(Supplier; "Purch. Rcpt. Line"."Buy-from Vendor No.")
			{
			}
			column(Quantity; "Purch. Rcpt. Line".Quantity)
			{
			}
			column(UOM; "Purch. Rcpt. Line"."Unit of Measure")
			{
			}
			column(Unit_Price; "Purch. Rcpt. Line"."Unit Cost (LCY)")
			{
			}
			column(Total; "Purch. Rcpt. Line"."VAT Base Amount")
			{
			}
			column(Pic; iNFO.Picture)
			{
			}
			column(VAT_Amount; AmtVat)
			{
			}
			column(TodayFormatted; Format(Today,0,4))
			{
			}
			column(VAT; VAT)
			{
			}
			column(TAmt; TAmt)
			{
			}
			column(OrdNo; OrdNo)
			{
			}
			column(DocNo; DocNo)
			{
			}
			column(userid; UserId)
			{
			}
			trigger OnPreDataItem();
			begin
				 if iNFO.Get then  iNFO.CalcFields(iNFO.Picture);
				// CLEAR(AmtVat)
				Clear(DocNo);
				Clear(OrdNo);
			end;
			
			trigger OnAfterGetRecord();
			begin
				DocNo:="Purch. Rcpt. Line"."Document No.";
				OrdNo:="Purch. Rcpt. Line"."Order No.";
				if "Purch. Rcpt. Line".Quantity=0 then CurrReport.Skip;
				Clear(AmtVat);
				Clear(  VAT);
				Clear( TAmt);
				PurchLine.Reset;
				 PurchLine.SetRange(PurchLine."Document No.","Purch. Rcpt. Line"."Document No.");
				  PurchLine.SetRange(PurchLine."Line No.","Purch. Rcpt. Line"."Line No.");
				  if PurchLine.Find ('-')  then
				  begin
				  TAmt:=PurchLine.Quantity*"Purch. Rcpt. Line"."Unit Cost (LCY)";
				  AmtVat:=((PurchLine."VAT %"/100)*TAmt )+TAmt;
				  VAT:=  AmtVat-TAmt;
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
		iNFO: Record "Company Information";
		PurchLine: Record "Purch. Rcpt. Line";
		AmtVat: Decimal;
		VAT: Decimal;
		TAmt: Decimal;
		OrdNo: Code[20];
		DocNo: Code[20];

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport51516115_v6_3_0_2259;
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