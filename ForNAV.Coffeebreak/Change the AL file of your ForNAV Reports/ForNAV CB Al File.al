dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.5.2.0.1917")
	{
		type(ForNav.Report_5_2_0_1917; ForNavReport80100_v5_2_0_1917){}   
	}
	assembly("mscorlib")
	{
		Version='4.0.0.0';
		type("System.IO.Stream"; SystemIOStream80100){}   
		type("System.IO.Path"; System_IO_Path80100) {}
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 80100 "ForNAV CB Al File"
{
	Caption = 'Coffeebreak Edit AL';
	RDLCLayout = '.\Layouts\ForNAV CB Al File.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem(Header;"Sales Invoice Header")
		{
			column(ReportForNavId_2; 2) {} // Autogenerated by ForNav - Do not delete
			dataitem(Line;"Sales Invoice Line")
			{
				DataItemLinkReference = Header;
				DataItemLink = "Document No."=field("No.");
				DataItemTableView = sorting("Document No.","Line No.");
				column(ReportForNavId_3; 3) {} // Autogenerated by ForNav - Do not delete
			}
		}
	}


	requestpage
	{

		layout
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
						Visible = ReportForNavAllowDesign;						trigger OnValidate()
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
		}		trigger OnOpenPage()
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

	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport80100_v5_2_0_1917;
		[RunOnClient]
		ReportForNavClient : DotNet ForNavReport80100_v5_2_0_1917;
		ReportForNavDialog : Dialog;
		ReportForNavOpenDesigner : Boolean;
		[InDataSet]
		ReportForNavAllowDesign : Boolean;

	local procedure ReportsForNavInit();
	var
		addInFileName : Text;
		tempAddInFileName : Text;
		path: DotNet System_IO_Path80100;
		ApplicationSystemConstants: Codeunit "Application System Constants";
	begin
		addInFileName := ApplicationPath + 'Add-ins\ReportsForNAV_5_2_0_1917\ForNav.Reports.5.2.0.1917.dll';
		if not File.Exists(addInFileName) then begin
			tempAddInFileName := path.GetTempPath() + '\Microsoft Dynamics NAV\Add-Ins\' + ApplicationSystemConstants.PlatformFileVersion() + '\ForNav.Reports.5.2.0.1917.dll';
			if not File.Exists(tempAddInFileName) then
				Error('Please install the ForNAV DLL version 5.2.0.1917 in your service tier Add-ins folder under the file name "%1"\\If you already have the ForNAV DLL on the server, you should move it to this folder and rename it to match this file name.', addInFileName);
		end;
		ReportForNav:= ReportForNav.Report_5_2_0_1917(CurrReport.OBJECTID, CurrReport.Language, SerialNumber, UserId, CompanyName);
		ReportForNav.Init;
	end;

	local procedure ReportsForNavPre();
	begin
		ReportForNav.OpenDesigner:=ReportForNavOpenDesigner;
		if not ReportForNav.Pre then CurrReport.Quit;
	end;


	trigger ReportForNav::OnInit();
	var
		reportLayoutSelection: Record "Report Layout Selection";
	begin
		ReportForNav.OData := GETURL(CLIENTTYPE::OData, CompanyName, OBJECTTYPE::Page, 7702);
		if ReportForNav.IsWindowsClient then begin
			ReportForNav.CheckClientAddIn();
			ReportForNavClient := ReportForNavClient.Report_5_2_0_1917(ReportForNav.Definition);
			ReportForNavAllowDesign := ReportForNavClient.HasDesigner and not ReportForNav.ParameterMode;
		end else
			ReportForNavAllowDesign := reportLayoutSelection.GetTempLayoutSelected() = '';
	end;

	trigger ReportForNav::OnParameters(Parameters : Text);
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		ReportForNav.Parameters := REPORT.RUNREQUESTPAGE(ReportForNav.ReportID, Parameters);
		; // Remove AL(AA0005) warning
	end;

	trigger ReportForNav::OnPreview(Parameters : Text;FileName : Text);
	var
		PdfFile : File;
		InStream : InStream;
		OutStream : OutStream;
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		COMMIT;
		PdfFile.CREATETEMPFILE;
		PdfFile.CREATEOUTSTREAM(OutStream);
		REPORT.SAVEAS(ReportForNav.ReportID, Parameters, REPORTFORMAT::Pdf, OutStream);
		PdfFile.CREATEINSTREAM(InStream);
		ReportForNavClient.ShowDesigner;
		if ReportForNav.IsValidPdf(PdfFile.NAME) then DOWNLOADFROMSTREAM(InStream, '', '', '', FileName);
		PdfFile.CLOSE;
	end;

	trigger ReportForNav::OnSelectPrinter();
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		ReportForNav.PrinterSettings.PageSettings := ReportForNavClient.SelectPrinter(ReportForNav.PrinterSettings.PrinterName,ReportForNav.PrinterSettings.ShowPrinterDialog,ReportForNav.PrinterSettings.PageSettings);
		; // Remove AL(AA0005) warning
	end;

	trigger ReportForNav::OnPrint(InStream : DotNet SystemIOStream80100);
	var
		ClientFileName : Text[255];
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		DOWNLOADFROMSTREAM(InStream, '', '<TEMP>', '', ClientFileName);
		ReportForNavClient.Print(ClientFileName); 
	end;

	trigger ReportForNav::OnDesign(Data : Text);
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		ReportForNavClient.Data := Data;
		while ReportForNavClient.DesignReport do begin
			ReportForNav.HandleRequest(ReportForNavClient.GetRequest());
			SLEEP(100);
		end;
	end;

	trigger ReportForNav::OnView(ClientFileName : Text;Parameters : Text;ServerFileName : Text);
	var
		ServerFile : File;
		ServerInStream : InStream;
		"Filter" : Text;
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		ServerFile.OPEN(ServerFileName);
		ServerFile.CREATEINSTREAM(ServerInStream);
		if STRLEN(ClientFileName) >= 4 then
			if LOWERCASE(COPYSTR(ClientFileName, STRLEN(ClientFileName) - 3, 4)) = '.pdf' then Filter := 'PDF (*.pdf)|*.pdf';
		if STRLEN(ClientFileName) >= 4 then
			if LOWERCASE(COPYSTR(ClientFileName, STRLEN(ClientFileName) - 3, 4)) = '.doc' then Filter := 'Microsoft Word (*.doc)|*.doc';
		if STRLEN(ClientFileName) >= 5 then
			if LOWERCASE(COPYSTR(ClientFileName, STRLEN(ClientFileName) - 4, 5)) = '.xlsx' then Filter := 'Microsoft Excel (*.xlsx)|*.xlsx';
		DOWNLOADFROMSTREAM(ServerInStream,'Export','',Filter,ClientFileName);
	end;

	trigger ReportForNav::OnMessage(Operation : Text;Parameter : Text;ParameterNo : Integer);
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		case Operation of
			'Open'	: ReportForNavDialog.Open(Parameter);
			'Update'  : ReportForNavDialog.Update(ParameterNo,Parameter);
			'Close'   : ReportForNavDialog.Close();
			'Message' : Message(Parameter);
			'Error'   : Error(Parameter);
		end;
		; // Remove AL(AA0005) warning
	end;

	trigger ReportForNav::OnPrintPreview(InStream : DotNet SystemIOStream80100;Preview : Boolean);
	var
		ClientFileName : Text[255];
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		CurrReport.Language := System.GlobalLanguage;
		DownloadFromStream(InStream, '', '<TEMP>', '', ClientFileName);
		ReportForNavClient.PrintPreviewDialog(ClientFileName,ReportForNav.PrinterSettings.PrinterName,Preview);
	end;

	trigger ReportForNav::OnTotals(DataItemId: Text; Operation: Text; GroupTotalFieldNo: Integer)
	begin
		// Do not change (Autogenerated by Reports ForNAV) - Instead change the Create Totals, Total Fields or Group Total Fields properties on the Data item in the ForNAV designer
		case DataItemId of
			'Line':
				with Line do
					case Operation of
						'Add': begin
							ReportForNav.AddTotal(DataItemId,0,Amount);
						end;
						'Restore': begin
							Amount := ReportForNav.RestoreTotal(DataItemId,0,GroupTotalFieldNo);
						end;
					end;
			end;
			; // Remove AL(AA0005) warning
	end;
	// Reports ForNAV Autogenerated code - do not delete or modify -->
}
