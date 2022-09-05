// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
// Codeunit 51516119 "AdminPortal"
// {

//     trigger OnRun()
//     begin
//         // MESSAGE(Fnbanks());
//         //MESSAGE(FORMAT(fnMembers(1,4)));
//         //MESSAGE(FnApprovals('ss'));
//         //MESSAGE(LoanApplications());
//         //FnApproveData('MAP00001');
//         //MESSAGE(FnGenerateLoansAppraisal('LN00038'));
//         //MESSAGE(FORMAT(fnCurrentShare('886')));
//         //MESSAGE(FORMAT(FnGetMembersTotalDeposits(TODAY)));
//         //MESSAGE(fnCurrentShare(
//         // MESSAGE(FnGenerateOutstandingLoans('BLN156'));
//         ///MESSAGE(FnGenerateRiskByproduct('ASSET-PROM'));
//         //MESSAGE(FnApproveLoan('12498',TRUE,'LN00006','approved'));
//         //FnApproveLoan(Membno : Text;Status : Boolean;LoanNo : Text;Comment : Text) : Text
//         //MESSAGE(FnCreateUser('12498','20950305','123456'));
//         //MESSAGE(FnGenerateRisk(Perfoming));
//         //MESSAGE(FnGenerateRisk(RiskAllocation."Sasra Category"::Watch,TODAY));
//         //MESSAGE(FnGenerateMemberDeposits(TODAY,'02562'));
//         //MESSAGE(FnGenerateOutstandingLoans('02562'));
//         Message(Format(FnLoanPerproduct('NORMAL')));
//     end;

//     var
//         PortalAdmin: Record "Online Users";
//         ProductsSetup: Record "Loan Products Setup";
//         LoanApp: Record "Loans Register";
//         Banks: Record "Dimension Value";
//         Members: Record Customer;
//         Approvals: Record "Approval Entry";
//         Dimensions: Record "Dimension Value";
//         RiskAllocation: Record "FORM 4 - Risk Classification";
//         FILEFOLDER: label '\\ERP\Reports\';
//         filename: Text;
//         LoanApprovalCommitee: Record "Loans Board Approvals";
//         LoanApprovalCommiteeexisting: Record "Loans Board Approvals";
//         ReturnList: Text;
//         objMember: Record Customer;
//         Paymentheader: Record "Payments Header";
//         NewApplicationNumber: Integer;
//         OnlineUser: Record "Online Users";
//         ObjExistingOnlineUser: Record "Online Users";
//         SMSMessages: Record "SMS Messages";
//         ReturnBoolean: Boolean;
//         FAccNo: Text[250];
//         SMTPSetup: Record "SMTP Mail Setup";
//         iEntryNo: Integer;
//         CompanyInformation: Record "Company Information";
//         SMTPMail: Codeunit "SMTP Mail";
//         Perfoming: Option;
//         FILEFOLDER2: label '\\172.17.9.233\Reports\';
//         Vendor: Record Vendor;


//     procedure FnChangePassword(MemberNo: Text; OPassword: Text; HOPassword: Text; Password: Text): Text
//     begin
//         ReturnList := 'ERROR, change password failed';
//         OnlineUser.Reset;
//         OnlineUser.SetRange(OnlineUser."User Name", MemberNo);
//         if OnlineUser.Find('-') then begin
//             ReturnBoolean := true;
//             if (OnlineUser."Changed Password" = false) and (OnlineUser.Password <> OPassword) then begin
//                 ReturnBoolean := false;
//                 ReturnList := 'ERROR, old password do not match';
//             end
//             else
//                 if (OnlineUser."Changed Password" = true) and (OnlineUser.Password <> HOPassword) then begin
//                     ReturnBoolean := false;
//                     ReturnList := 'ERROR, Old password do not match';
//                 end;

//             if ReturnBoolean = true then begin
//                 OnlineUser.Password := Password;
//                 OnlineUser."Changed Password" := true;
//                 OnlineUser.Modify(true);
//                 ReturnList := 'OK,Your Board Login password change request successful';

//             end;
//         end;
//         exit(ReturnList);
//     end;


//     procedure FnChangedPassword(MemberNo: Text): Boolean
//     begin
//         OnlineUser.Reset;
//         OnlineUser.SetRange(OnlineUser."User Name", MemberNo);
//         if OnlineUser.Find('-') then
//             exit(OnlineUser."Changed Password");
//     end;


//     procedure FnCreateUser(memberNo: Text; Idnumber: Text; Password: Text) Created: Text
//     begin
//         Created := 'ERROR Account reset failed';

//         objMember.Reset;
//         objMember.SetRange("No.", memberNo);
//         if objMember.FindLast then begin

//             if (objMember.Status = objMember.Status::Active) or
//               (objMember.Status = objMember.Status::Dormant) or
//               (objMember.Status = objMember.Status::Defaulter) then begin

//                 if (objMember."Phone No." <> '') or (objMember."Mobile Phone No" <> '') or (objMember."E-Mail" <> '') then begin

//                     ObjExistingOnlineUser.Reset;
//                     ObjExistingOnlineUser.SetRange(ObjExistingOnlineUser."User Name", memberNo);
//                     if ObjExistingOnlineUser.Find('+') then begin
//                         ObjExistingOnlineUser.Password := objMember.Password;
//                         ObjExistingOnlineUser."User Name" := objMember."No.";
//                         ObjExistingOnlineUser."Changed Password" := false;
//                         ObjExistingOnlineUser."Date Created" := CurrentDatetime;
//                         ObjExistingOnlineUser.Modify(true);
//                         Created := 'OK, Board Login account activated successfully. You will receive SMS/Email';
//                     end else begin
//                         // MESSAGE('Member not found');
//                         OnlineUser.Reset;
//                         OnlineUser."Changed Password" := false;
//                         OnlineUser."User Name" := objMember."No.";
//                         OnlineUser.Password := objMember."No.";
//                         FAccNo := objMember."FOSA Account No.";
//                         OnlineUser."Date Created" := CurrentDatetime;
//                         OnlineUser.Insert;
//                         Created := 'OK,  Board Login account activated successfully. You will receive SMS/Email';
//                     end;

//                     ReturnList := 'Dear  Board Member, Your Default Board portal Login password is:' + objMember."No." + '. Change this after login.';


//                     if objMember."Phone No." <> '' then begin
//                         ReturnBoolean := true;
//                         SMSMessage('PORTALTRAN', FAccNo, objMember."Phone No.", ReturnList);
//                     end else
//                         if objMember."Mobile Phone No" <> '' then begin
//                             ReturnBoolean := true;
//                             SMSMessage('PORTALTRAN', FAccNo, objMember."Phone No.", ReturnList);
//                         end;

//                     //       IF objMember."E-Mail"<>'' THEN BEGIN
//                     //          ReturnBoolean :=TRUE;
//                     //          SendEmail(objMember."E-Mail",'CHUNA SACCO - Board Portal Password Change',ReturnList);
//                     //         END;



//                 end else
//                     Created := 'ERROR, Member No not available ';
//             end;
//         end;
//     end;


//     procedure FnLogin(MemberNo: Text; Password: Text; HPassword: Text) Login: Boolean
//     begin
//         Login := false;

//         objMember.Reset;
//         objMember.SetRange("No.", MemberNo);
//         if objMember.Find('-') then begin
//             if (objMember.Status = objMember.Status::Active) or
//               (objMember.Status = objMember.Status::Dormant) or
//               (objMember.Status = objMember.Status::Defaulter)
//               then begin
//                 OnlineUser.Reset;
//                 OnlineUser.SetRange(OnlineUser."User Name", MemberNo);
//                 if OnlineUser.Find('-') then begin
//                     if (OnlineUser.Password = Password) and (OnlineUser."Changed Password" = false) then
//                         Login := true
//                     else
//                         if (OnlineUser.Password = HPassword) and (OnlineUser."Changed Password" = true) then
//                             Login := true;
//                 end;
//             end;
//         end;
//     end;


//     procedure FnLoanProducts() Loans: Text
//     begin
//         ProductsSetup.Reset;
//         repeat
//             Loans := ProductsSetup.Code + '::' + ProductsSetup."Product Description" + '::::' + Loans;
//         until ProductsSetup.Next = 0;
//     end;


//     procedure FnLoanportfolio(From: Date; Todate: Date; Product: Code[10]; var Bigtext: BigText)
//     var
//         Filename: Text[100];
//         Convert: dotnet Convert;
//         Path: dotnet Path;
//         _File: dotnet File;
//         FileAccess: dotnet FileAccess;
//         FileMode: dotnet FileMode;
//         MemoryStream: dotnet MemoryStream;
//         FileStream: dotnet FileStream;
//         Outputstream: OutStream;
//     begin

//         ProductsSetup.Reset;
//         LoanApp.SetRange(LoanApp."Loan Product Type", Product);
//         // LoanApp.SETRANGE(LoanApp."Issued Date",From,Todate);
//         if LoanApp.Find('-') then begin

//             Filename := Path.GetTempPath() + Path.GetRandomFileName();
//             Report.SaveAsPdf(51516373, Filename, LoanApp);

//             FileMode := 4;
//             FileAccess := 1;

//             FileStream := _File.Open(Filename, FileMode, FileAccess);

//             MemoryStream := MemoryStream.MemoryStream();

//             MemoryStream.SetLength(FileStream.Length);
//             FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

//             Bigtext.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
//             Message(Format(Bigtext));
//             // exitString:=BigText;
//             //MESSAGE(exitString);
//             MemoryStream.Close();
//             MemoryStream.Dispose();
//             FileStream.Close();
//             FileStream.Dispose();
//             _File.Delete(Filename);

//         end;
//     end;


//     procedure FnLoanPerproduct(ProductType: Code[10]) info: Decimal
//     begin
//         info := 0;
//         LoanApp.Reset;
//         //LoanApp.SETRANGE("Loan Product Type",ProductType);
//         //LoanApp.SETFILTER("Loan Product Type",'%1',LoanApp."Loan Product Type"='SCHOOLFEE');

//         if LoanApp.Find('-') then begin

//             repeat
//                 // LoanApp."Loan Product Type":='SCHOOLFEE';
//                 LoanApp.CalcFields("Outstanding Balance");
//                 LoanApp.SetRange("Loan Product Type", ProductType);
//                 info := info + LoanApp."Outstanding Balance";
//             until
//             LoanApp.Next = 0;
//         end;
//         exit(info);
//     end;


//     procedure FnLoansRegister(Status: Option; SourceLoan: Option; Bank: Code[30]; Producttype: Code[30]; var Bigtext: BigText)
//     var
//         Filename: Text[100];
//         Convert: dotnet Convert;
//         Path: dotnet Path;
//         _File: dotnet File;
//         FileAccess: dotnet FileAccess;
//         FileMode: dotnet FileMode;
//         MemoryStream: dotnet MemoryStream;
//         FileStream: dotnet FileStream;
//         Outputstream: OutStream;
//     begin
//         if SourceLoan <> 0 then
//             LoanApp.SetFilter(Source, '%1', SourceLoan);
//         if Bank <> '' then
//             LoanApp.SetFilter("Bank code", '%1', Bank);
//         if Producttype <> '' then
//             LoanApp.SetFilter("Loan Product Type", '%1', Producttype);
//         if Status <> 0 then
//             LoanApp.SetFilter("Loan Status", '%1', Status);

//         Filename := Path.GetTempPath() + Path.GetRandomFileName();
//         Report.SaveAsPdf(51516868, Filename, LoanApp);

//         FileMode := 4;
//         FileAccess := 1;

//         FileStream := _File.Open(Filename, FileMode, FileAccess);

//         MemoryStream := MemoryStream.MemoryStream();

//         MemoryStream.SetLength(FileStream.Length);
//         FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

//         Bigtext.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
//         Message(Format(Bigtext));
//         // exitString:=BigText;
//         //MESSAGE(exitString);
//         MemoryStream.Close();
//         MemoryStream.Dispose();
//         FileStream.Close();
//         FileStream.Dispose();
//         _File.Delete(Filename);
//         //END;
//     end;


//     procedure Fnbanks() Loans: Text
//     begin
//         Banks.Reset;
//         repeat
//             Loans := Banks.Code + '::' + Banks.Name + '::::' + Loans;
//         until Banks.Next = 0;
//     end;


//     procedure FnAppraisalReports(LoanNo: Code[20]; var Bigtext: BigText)
//     var
//         Filename: Text[100];
//         Convert: dotnet Convert;
//         Path: dotnet Path;
//         _File: dotnet File;
//         FileAccess: dotnet FileAccess;
//         FileMode: dotnet FileMode;
//         MemoryStream: dotnet MemoryStream;
//         FileStream: dotnet FileStream;
//         Outputstream: OutStream;
//     begin
//         //ProductsSetup.RESET;
//         LoanApp.Reset;
//         LoanApp.SetRange(LoanApp."Loan  No.", LoanNo);
//         // LoanApp.SETRANGE(LoanApp."Issued Date",From,Todate);
//         if LoanApp.Find('-') then begin

//             Filename := Path.GetTempPath() + Path.GetRandomFileName();
//             Report.SaveAsPdf(51516384, Filename, LoanApp);

//             FileMode := 4;
//             FileAccess := 1;

//             FileStream := _File.Open(Filename, FileMode, FileAccess);

//             MemoryStream := MemoryStream.MemoryStream();

//             MemoryStream.SetLength(FileStream.Length);
//             FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

//             Bigtext.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
//             Message(Format(Bigtext));
//             // exitString:=BigText;
//             //MESSAGE(exitString);
//             MemoryStream.Close();
//             MemoryStream.Dispose();
//             FileStream.Close();
//             FileStream.Dispose();
//             _File.Delete(Filename);

//         end;
//     end;


//     procedure fnMembers(var Gender: Text; var Location: Text) Total: Integer
//     var
//         TotalLocationCounter: Integer;
//         TotalMale: Integer;
//         TotalFemale: Integer;
//     begin
//         Dimensions.Reset;
//         Dimensions.SetFilter("Dimension Code", 'BRANCH');

//         repeat
//             Members.Reset;
//             Members.SetRange(City, Dimensions.Code);
//             if Members.Find('-') then begin
//                 repeat
//                     TotalLocationCounter := TotalLocationCounter + 1;
//                 until Members.Next = 0;
//             end;
//             Location := Format(TotalLocationCounter) + '::' + Dimensions.Code + '::::' + Location;
//         until Dimensions.Next = 0;
//         Members.Reset;
//         repeat
//             Members.SetFilter(Members.Gender, '%1', 2);
//             //IF Members.FIND('-') THEN begin
//             TotalMale := TotalMale + 1;
//         until Members.Next = 0;
//         //END;
//         Members.Reset;
//         repeat
//             Members.SetFilter(Gender, '%1', 1);
//             // IF Members.FIND('-') THEN begin
//             TotalFemale := TotalFemale + 1;
//         until Members.Next = 0;
//         //END;
//         Gender := 'FEMALE' + '::' + Format(TotalFemale) + '::::' + 'MALE' + '::' + Format(TotalMale) + '::::';
//     end;

//     local procedure Totalaccounts(CurrentSahre: Boolean; Deposits: Boolean) Total: Decimal
//     begin
//     end;


//     procedure FnApprovals(UserId: Code[30]) approvalentry: Text
//     begin
//         Approvals.Reset;
//         // Approvals.SETFILTER("Approver ID", 'EMMANUEL/SURESTEP23');
//         Approvals.SetFilter(Status, '%1', Approvals.Status::Open);

//         repeat
//             if Approvals."Sender ID" <> '' then
//                 approvalentry := approvalentry + Format(Approvals."Document No.") + '::' + Format(Approvals."Document Type") + '::' +
//               Format(Approvals."Approval Code") + '::' + Format(Approvals."Approval Type") + '::' + Format(Approvals."Sequence No.") + '::' + Format(Approvals."Date-Time Sent for Approval") + '::'
//               + Approvals."Sender ID" + '::' +
//                 Format(Approvals."Due Date") + '::' + Format(Approvals."Amount (LCY)") + '::' + Format(Approvals."Approver ID") + '::::';

//         until Approvals.Next = 0;
//     end;


//     procedure FnAccounts(var Deposits: Decimal; var Shares: Decimal; var OutstandingLoans: Decimal)
//     begin
//         Members.Reset;
//         repeat
//             Members.CalcFields("Current Shares", "Outstanding Balance", "Share Capital B Class");
//             Deposits := Deposits + Members."Current Shares";
//             Shares := Shares + Members."Share Capital B Class";
//             OutstandingLoans := OutstandingLoans + Members."Outstanding Balance";
//         until Members.Next = 0;
//     end;


//     procedure FnApproveData(USerID: Code[20])
//     var
//         ApprovalEntry: Record "Approval Entry";
//         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     begin
//         ApprovalEntry.Reset;
//         ApprovalEntry.SetRange("Document No.", USerID);
//         if ApprovalEntry.Find('-') then begin
//             ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
//         end;
//     end;


//     procedure FnReject(USerID: Code[20])
//     var
//         ApprovalEntry: Record "Approval Entry";
//         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     begin
//         ApprovalEntry.Reset;
//         ApprovalEntry.SetRange("Document No.", USerID);
//         if ApprovalEntry.Find('-') then begin
//             ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
//         end;
//     end;


//     procedure FnDelegate(USerID: Code[20])
//     var
//         ApprovalEntry: Record "Approval Entry";
//         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     begin
//         ApprovalEntry.Reset;
//         ApprovalEntry.SetRange("Document No.", USerID);
//         if ApprovalEntry.Find('-') then begin
//             ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
//         end;
//     end;


//     procedure FnAccountsProgression(datefileter: Text; TotalLoans: Decimal; TotalDepposits: Decimal; TotalIntrest: Decimal)
//     begin
//         Members.Reset;
//         Members.SetFilter("Date Filter", datefileter);
//         repeat
//             Members.CalcFields("Current Shares");
//             TotalDepposits := TotalDepposits + Members."Current Shares";
//         until Members.Next = 0;

//         LoanApp.Reset;
//         LoanApp.SetFilter("Date filter", datefileter);
//         LoanApp.SetFilter(Posted, '%1', true);
//         repeat
//             LoanApp.CalcFields("Oustanding Interest", "Outstanding Balance");

//             TotalIntrest := TotalIntrest + LoanApp."Oustanding Interest";
//             if TotalIntrest < 0 then
//                 TotalIntrest := TotalIntrest * -1;
//             TotalLoans := TotalLoans + LoanApp."Outstanding Balance";
//         until LoanApp.Next = 0;
//     end;


//     procedure FnLoansProgression(var FosaLoans: Text; var BosaLoans: Text)
//     begin
//         LoanApp.Reset;
//         LoanApp.SetFilter(Posted, '%1', false);
//         LoanApp.SetFilter(Source, 'FOSA');
//         repeat
//             FosaLoans := LoanApp."Client Name" + '::' + Format(LoanApp."Requested Amount") + '::' + LoanApp."Loan Product Type Name" + '::' + Format(LoanApp.Interest) + '::' + LoanApp."Loan  No." + '::::';
//         until LoanApp.Next = 0;
//         LoanApp.Reset;
//         LoanApp.SetFilter(Posted, '%1', false);
//         LoanApp.SetFilter(Source, 'BOSA');
//         repeat
//             BosaLoans := LoanApp."Client Name" + '::' + Format(LoanApp."Requested Amount") + '::' + LoanApp."Loan Product Type Name" + '::' + Format(LoanApp.Interest) + '::' + LoanApp."Loan  No." + '::::';
//         until LoanApp.Next = 0;
//     end;


//     procedure FnapprovalEach(ID: Code[20]) approvalentry: Text
//     begin
//         Approvals.Reset;
//         // Approvals.SETFILTER("Approver ID", 'EMMANUEL/SURESTEP23');
//         // Approvals.SETFILTER(Status, '%1',Approvals.Status::Open);

//         Approvals.Reset;
//         Approvals.SetRange("Document No.", ID);
//         if Approvals.Find('-') then begin

//             if Approvals."Sender ID" <> '' then
//                 approvalentry := Format(Approvals."Document No.") + '::' + Format(Approvals."Document Type") + '::' +
//               Format(Approvals."Approval Code") + '::' + Format(Approvals."Approval Type") + '::' + Format(Approvals."Sequence No.") + '::' + Format(Approvals."Date-Time Sent for Approval") + '::'
//               + Approvals."Sender ID" + '::' +
//                 Format(Approvals."Due Date") + '::' + Format(Approvals."Amount (LCY)") + '::' + Format(Approvals."Approver ID");
//         end;
//     end;


//     procedure FnDepostiReturns(var Bigtext: BigText)
//     var
//         Filename: Text[100];
//         Convert: dotnet Convert;
//         Path: dotnet Path;
//         _File: dotnet File;
//         FileAccess: dotnet FileAccess;
//         FileMode: dotnet FileMode;
//         MemoryStream: dotnet MemoryStream;
//         FileStream: dotnet FileStream;
//         Outputstream: OutStream;
//     begin
//         Filename := Path.GetTempPath() + Path.GetRandomFileName();
//         Report.SaveAsPdf(51516426, Filename, Members);

//         FileMode := 4;
//         FileAccess := 1;

//         FileStream := _File.Open(Filename, FileMode, FileAccess);

//         MemoryStream := MemoryStream.MemoryStream();

//         MemoryStream.SetLength(FileStream.Length);
//         FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

//         Bigtext.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
//         Message(Format(Bigtext));
//         // exitString:=BigText;
//         //MESSAGE(exitString);
//         MemoryStream.Close();
//         MemoryStream.Dispose();
//         FileStream.Close();
//         FileStream.Dispose();
//         _File.Delete(Filename);
//     end;


//     procedure FnRiskClassification(var Bigtext: BigText)
//     var
//         Filename: Text[100];
//         Convert: dotnet Convert;
//         Path: dotnet Path;
//         _File: dotnet File;
//         FileAccess: dotnet FileAccess;
//         FileMode: dotnet FileMode;
//         MemoryStream: dotnet MemoryStream;
//         FileStream: dotnet FileStream;
//         Outputstream: OutStream;
//     begin
//         Filename := Path.GetTempPath() + Path.GetRandomFileName();
//         Report.SaveAsPdf(50014, Filename, RiskAllocation);
//     end;


//     procedure FnRiskClassificationByPro(var Bigtext: BigText)
//     var
//         Filename: Text[100];
//         Convert: dotnet Convert;
//         Path: dotnet Path;
//         _File: dotnet File;
//         FileAccess: dotnet FileAccess;
//         FileMode: dotnet FileMode;
//         MemoryStream: dotnet MemoryStream;
//         FileStream: dotnet FileStream;
//         Outputstream: OutStream;
//     begin
//         Filename := Path.GetTempPath() + Path.GetRandomFileName();
//         Report.SaveAsPdf(50013, Filename, ProductsSetup);

//         FileMode := 4;
//         FileAccess := 1;

//         FileStream := _File.Open(Filename, FileMode, FileAccess);

//         MemoryStream := MemoryStream.MemoryStream();

//         MemoryStream.SetLength(FileStream.Length);
//         FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

//         Bigtext.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
//         Message(Format(Bigtext));
//         // exitString:=BigText;
//         //MESSAGE(exitString);
//         MemoryStream.Close();
//         MemoryStream.Dispose();
//         FileStream.Close();
//         FileStream.Dispose();
//         _File.Delete(Filename);

//         //END;
//     end;


//     procedure OutstadningLoans(var Bigtext: BigText)
//     var
//         Filename: Text[100];
//         Convert: dotnet Convert;
//         Path: dotnet Path;
//         _File: dotnet File;
//         FileAccess: dotnet FileAccess;
//         FileMode: dotnet FileMode;
//         MemoryStream: dotnet MemoryStream;
//         FileStream: dotnet FileStream;
//         Outputstream: OutStream;
//     begin
//         Filename := Path.GetTempPath() + Path.GetRandomFileName();
//         Report.SaveAsPdf(51516545, Filename, LoanApp);

//         FileMode := 4;
//         FileAccess := 1;

//         FileStream := _File.Open(Filename, FileMode, FileAccess);

//         MemoryStream := MemoryStream.MemoryStream();

//         MemoryStream.SetLength(FileStream.Length);
//         FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

//         Bigtext.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
//         Message(Format(Bigtext));
//         // exitString:=BigText;
//         //MESSAGE(exitString);
//         MemoryStream.Close();
//         MemoryStream.Dispose();
//         FileStream.Close();
//         FileStream.Dispose();
//         _File.Delete(Filename);

//         //END;
//     end;


//     procedure MemberDeposits(var Bigtext: BigText)
//     var
//         Filename: Text[100];
//         Convert: dotnet Convert;
//         Path: dotnet Path;
//         _File: dotnet File;
//         FileAccess: dotnet FileAccess;
//         FileMode: dotnet FileMode;
//         MemoryStream: dotnet MemoryStream;
//         FileStream: dotnet FileStream;
//         Outputstream: OutStream;
//     begin
//         Filename := Path.GetTempPath() + Path.GetRandomFileName();
//         Report.SaveAsPdf(51516873, Filename, Members);

//         FileMode := 4;
//         FileAccess := 1;

//         FileStream := _File.Open(Filename, FileMode, FileAccess);

//         MemoryStream := MemoryStream.MemoryStream();

//         MemoryStream.SetLength(FileStream.Length);
//         FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

//         Bigtext.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
//         Message(Format(Bigtext));
//         // exitString:=BigText;
//         //MESSAGE(exitString);
//         MemoryStream.Close();
//         MemoryStream.Dispose();
//         FileStream.Close();
//         FileStream.Dispose();
//         _File.Delete(Filename);

//         //END;
//     end;


//     procedure FnGenerateLoansAppraisal(LoanNo: Text): Text
//     begin

//         filename := FILEFOLDER + LoanNo;
//         filename += '.pdf';
//         if Exists(filename) then
//             Erase(filename);

//         LoanApp.Reset;
//         LoanApp.SetRange(LoanApp."Loan  No.", LoanNo);
//         if LoanApp.Find('-') then
//             Report.SaveAsPdf(Report::"Loan Appraisal Draft", filename, LoanApp);

//         exit(filename);
//     end;


//     procedure FnApproveLoan(Membno: Text; Status: Boolean; LoanNo: Text; Comment: Text): Text
//     begin
//         ReturnList := 'Error, action failed';

//         LoanApp.Init;
//         LoanApp.SetRange("Loan  No.", LoanNo);
//         if LoanApp.Find('-') then begin

//             LoanApprovalCommiteeexisting.Reset;
//             LoanApprovalCommiteeexisting.SetRange("Loan No.", LoanNo);
//             LoanApprovalCommiteeexisting.SetRange("Committee Member No.", Membno);
//             if LoanApprovalCommiteeexisting.Find('-') then
//                 ReturnList := 'Error,you have already reviewed this loan'
//             else begin
//                 LoanApprovalCommitee.Init;
//                 LoanApprovalCommitee."Loan No." := LoanNo;
//                 LoanApprovalCommitee.Comments := Comment;
//                 if Status <> false then
//                     LoanApprovalCommitee.Status := LoanApprovalCommitee.Status::Approved

//                 else
//                     LoanApprovalCommitee.Status := LoanApprovalCommitee.Status::Rejected;
//                 LoanApprovalCommitee."Committee Member No." := Membno;
//                 LoanApprovalCommitee."Action Date" := CurrentDatetime;
//                 LoanApprovalCommitee.Insert(true);


//                 //copy data to Loans table & clear from list
//                 LoanApp."Loan  No." := LoanApprovalCommitee."Loan No.";
//                 LoanApp."Board Approval Status" := LoanApprovalCommitee.Status;
//                 LoanApp."Board Approved By" := LoanApprovalCommitee.Name;
//                 LoanApp."Board Approval Comment" := LoanApprovalCommitee.Comments;

//                 LoanApp.Modify;

//                 ReturnList := 'OKAY, loan successfully reviewed';
//             end;

//         end;
//         exit(ReturnList);
//     end;


//     procedure FnGetMembersTotalDeposits(datefileter: Date) TotalDeposits: Decimal
//     begin
//         Members.Reset;
//         Members.SetRange("Date Filter", datefileter);
//         if Members.Find('-') then
//             repeat
//                 Members.CalcFields("Current Shares");
//                 TotalDeposits := TotalDeposits + Members."Current Shares";
//                 Message('total deposits %1', TotalDeposits);
//             until Members.Next = 0;



//         // Members.RESET;
//         // Members.SETFILTER("Date Filter" ,datefileter);
//         // REPEAT
//         //  Members.CALCFIELDS( "Current Shares");
//         //  TotalDeposits:=TotalDeposits+Members."Current Shares";
//         //  MESSAGE('total deposits %1',TotalDeposits);
//         //  UNTIL Members.NEXT=0;
//     end;


//     procedure fnCurrentShare(Mno: Code[30]) total: Decimal
//     begin
//         objMember.Reset;
//         objMember.SetRange("No.", Mno);
//         if objMember.Find('-') then begin
//             objMember.CalcFields("Current Shares");
//             total := objMember."Current Shares";
//             Message('current shares is %1', total);
//         end;
//     end;


//     procedure fnTotalDeposits(Mno: Code[10]) total: Decimal
//     begin
//         objMember.Reset;
//         objMember.SetRange("No.", Mno);
//         if objMember.Find('-') then begin
//             objMember.CalcFields("Shares Retained");
//             total := objMember."Shares Retained";
//             Message('current deposits is %1', total);
//         end;
//     end;


//     procedure FnGeneratePaymentVoucher(No: Text): Text
//     begin

//         filename := FILEFOLDER + No;
//         filename += '.pdf';
//         if Exists(filename) then
//             Erase(filename);

//         Paymentheader.Reset;
//         Paymentheader.SetRange("No.", No);
//         if Paymentheader.Find('-') then
//             Report.SaveAsPdf(Report::"Payment Voucher New", filename, Paymentheader);
//         exit(filename);
//     end;


//     procedure FnGenerateDepositReturnSASRA(No: Text; DateFilter: Date): Text
//     begin
//         filename := FILEFOLDER + No;
//         filename += '.pdf';
//         if Exists(filename) then
//             Erase(filename);
//         Members.Reset;
//         Members.SetRange(Members."No.", No);
//         Members.SetRange(Members."Date Filter", DateFilter);
//         if Members.Find('-') then
//             Report.SaveAsPdf(Report::"FORM 3 - DEPOSITS Return", filename, Members);
//         exit(filename);
//     end;


//     procedure fnGenerateLoans(LoanNo: Code[50]; DateFilter: Date; var BigText: BigText) exitString: Text
//     var
//         Filename: Text[100];
//         Convert: dotnet Convert;
//         Path: dotnet Path;
//         _File: dotnet File;
//         FileAccess: dotnet FileAccess;
//         FileMode: dotnet FileMode;
//         MemoryStream: dotnet MemoryStream;
//         FileStream: dotnet FileStream;
//         Outputstream: OutStream;
//     begin
//         LoanApp.Reset;
//         LoanApp.SetRange("Loan  No.", LoanNo);
//         if LoanApp.Find('-') then begin

//             Filename := Path.GetTempPath() + Path.GetRandomFileName();
//             Report.SaveAsPdf(51516545, Filename, LoanApp);

//             FileMode := 4;
//             FileAccess := 1;

//             FileStream := _File.Open(Filename, FileMode, FileAccess);

//             MemoryStream := MemoryStream.MemoryStream();

//             MemoryStream.SetLength(FileStream.Length);
//             FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

//             BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
//             Message(Format(BigText));
//             // exitString:=BigText;
//             //MESSAGE(exitString);
//             MemoryStream.Close();
//             MemoryStream.Dispose();
//             FileStream.Close();
//             FileStream.Dispose();
//             _File.Delete(Filename);

//         end;
//     end;


//     procedure FnGenerateMemberDeposits(DateFilter: Date; No: Code[10]; CurrentShares: Code[10]): Text
//     begin
//         filename := FILEFOLDER + No;//FORMAT(DateFilter);
//         filename += '.pdf';
//         if Exists(filename) then
//             Erase(filename);
//         Members.Reset;
//         Message('test1');
//         Members.SetRange("No.", No);
//         //Members.SETFILTER("Current Shares",'%1',Members."Current Shares">3000000);
//         Members.SetRange(Members."Date Filter", DateFilter);
//         Message('test2');

//         if Members.Find('-') then begin
//             Message('test3');
//             Report.SaveAsPdf(Report::"ANNEX 3 - MEMBER Deposits", filename, Members);
//             Message('test4');
//         end;
//         exit(filename);
//     end;


//     procedure FnGenerateOutstandingLoan(LoanNo: Text): Text
//     begin
//         filename := FILEFOLDER + LoanNo;
//         filename += '.pdf';
//         if Exists(filename) then
//             Erase(filename);

//         LoanApp.Reset;
//         LoanApp.SetRange(LoanApp."Loan  No.", LoanNo);
//         Message('test %1', LoanApp."Loan  No.");
//         //LoanApp.SETRANGE("Date filter",DateFilter);
//         if LoanApp.Find('-') then
//             Report.SaveAsPdf(51516545, filename, LoanApp);
//         Message('test 2 %1', filename);
//         exit(filename);
//     end;


//     procedure FnGenerateshares(No: Code[10]): Text
//     begin
//         filename := FILEFOLDER + No;
//         filename += '.pdf';
//         if Exists(filename) then
//             Erase(filename);
//         if Members.Find('-') then
//             Report.SaveAsPdf(51516872, filename, Members);
//         Message('test');
//         exit(filename);
//         Message('test');
//     end;


//     procedure FnGenerateFosaDeposits(No: Code[10]): Text
//     begin
//         filename := FILEFOLDER + No;
//         filename += '.pdf';
//         if Exists(filename) then
//             Erase(filename);
//         if Vendor.Find('-') then
//             Report.SaveAsPdf(51516877, filename, Vendor);
//         Message('test');
//         exit(filename);
//         Message('test');
//     end;


//     procedure FnGenerateOutstandingLoans(No: Code[10]): Text
//     begin
//         filename := FILEFOLDER + No;
//         filename += '.pdf';
//         if Exists(filename) then
//             Erase(filename);

//         if LoanApp.Find('-') then
//             Report.SaveAsPdf(51516545, filename, LoanApp);
//         Message('test');
//         exit(filename);
//         Message('test');
//     end;


//     procedure FnGenerateRiskByproduct(No: Text): Text
//     begin
//         /*filename :=FILEFOLDER+No;
//           filename += '.pdf';
//            IF EXISTS(filename) THEN
//             ERASE(filename);
//            LoanApp.RESET;
//            LoanApp.SETRANGE("Product Code",No);
//            IF LoanApp.FIND('-') THEN
//              REPORT.SAVEASPDF(REPORT::"FORM 4 - Loan Classification",filename,LoanApp);
//            EXIT(filename);*/

//     end;


//     procedure FnApprovePv(USerID: Code[20]; Comment: Text[250])
//     var
//         ApprovalEntry: Record "Approval Entry";
//         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     begin
//         ApprovalEntry.Reset;
//         ApprovalEntry.SetRange("Document No.", USerID);
//         if ApprovalEntry.Find('-') then begin
//             ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
//         end;
//     end;


//     procedure FnRejectPv(USerID: Code[20])
//     var
//         ApprovalEntry: Record "Approval Entry";
//         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     begin
//         ApprovalEntry.Reset;
//         ApprovalEntry.SetRange("Document No.", USerID);
//         if ApprovalEntry.Find('-') then begin
//             ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);
//         end;
//     end;


//     procedure SMSMessage(documentNo: Text[30]; accfrom: Text[30]; phone: Text[20]; message: Text[1024])
//     begin
//         SMSMessages.Reset;
//         if SMSMessages.Find('+') then begin
//             iEntryNo := SMSMessages."Entry No";
//             iEntryNo := iEntryNo + 1;
//         end
//         else begin
//             iEntryNo := 1;
//         end;
//         SMSMessages.Init;
//         SMSMessages."Entry No" := iEntryNo;
//         SMSMessages."Batch No" := documentNo;
//         SMSMessages."Document No" := documentNo;
//         SMSMessages."Account No" := accfrom;
//         SMSMessages."Date Entered" := Today;
//         SMSMessages."Time Entered" := Time;
//         SMSMessages.Source := 'PORTALTRAN';
//         SMSMessages."Entered By" := UserId;
//         SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
//         SMSMessages."SMS Message" := message;
//         SMSMessages."Telephone No" := phone;
//         if SMSMessages."Telephone No" <> '' then
//             SMSMessages.Insert;
//     end;


//     procedure SendEmail(ToEmail: Text[250]; EmailSubject: Text[250]; EmailBody: Text[250])
//     begin
//         if ToEmail <> '' then begin
//             CompanyInformation.Get;
//             SMTPSetup.Get;
//             SMTPMail.CreateMessage(CompanyInformation.Name, CompanyInformation."E-Mail", ToEmail, EmailSubject, '', true);
//             //SMTPMail.AppendBody('************DO NOT REPLY*************');
//             SMTPMail.AppendBody('<br><br>');
//             SMTPMail.AppendBody('Dear Sir/Madam');
//             SMTPMail.AppendBody('<br><br>');
//             SMTPMail.AppendBody(EmailBody);
//             SMTPMail.AppendBody('<br>');
//             SMTPMail.AppendBody('CHUNA SACCO SOCIETY LTD.');
//             SMTPMail.AppendBody('<br><br>');
//             SMTPMail.AppendBody('Thanks & Regards');
//             SMTPMail.AppendBody('<br><br>');

//             SMTPMail.AppendBody('<br><br>');
//             // SMTPMail.AppendBody(SMTPSetup.sen);
//             SMTPMail.AppendBody('<br><br>');
//             SMTPMail.AppendBody('<HR>');
//             SMTPMail.AppendBody('This is a system generated mail. For any complains/ compliments kindly  reply to this email ID or call ' + CompanyInformation."Phone No." + '.');
//             SMTPMail.Send;

//         end;
//     end;


//     procedure FnGenerateRisk(SasraCategory: Option; DateFilter: Date): Text
//     begin
//         filename := FILEFOLDER;
//         filename += '.pdf';
//         if Exists(filename) then
//             Erase(filename);
//         //RiskAllocation.RESET;
//         Message('test');
//         LoanApp.Reset;
//         LoanApp.SetRange("Loans Category", RiskAllocation."Sasra Category");
//         // RiskAllocation.SETFILTER("Sasra Category",'%1|%2|%3|%4',RiskAllocation."Sasra Category"::Perfoming,RiskAllocation."Sasra Category"::Watch,RiskAllocation."Sasra Category"::Loss,RiskAllocation."Sasra Category"::Doubtful);

//         Message('test');
//         LoanApp.SetFilter(LoanApp."Date filter", '..' + Format(DateFilter));
//         Message('testt%1', LoanApp."Date filter");
//         if LoanApp.Find('-') then
//             Message('test');
//         Report.SaveAsPdf(Report::"FORM 4 - Loan Classifications", filename, RiskAllocation);
//         Message('test');
//         exit(filename);

//     end;
// }

