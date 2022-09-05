Codeunit 50162 "WorkflowIntegration"
{
    trigger OnRun()
    begin

    end;


    procedure CheckPaymentApprovalsWorkflowEnabled(var PaymentHeader: Record "Payments Header"): Boolean
    begin
        if not IsPaymentApprovalsWorkflowEnabled(PaymentHeader) then
            Error(NoWorkflowEnabledErr);

        exit(true);
    end;


    procedure IsPaymentApprovalsWorkflowEnabled(var PaymentHeader: Record "Payments Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PaymentHeader, SurestepWFEvents.RunWorkflowOnSendPaymentDocForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendPaymentDocForApproval(var PaymentHeader: Record "Payments Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelPaymentApprovalRequest(var PaymentHeader: Record "Payments Header")
    begin
    end;


    procedure CheckMembershipApplicationApprovalsWorkflowEnabled(var MembershipApplication: Record "Membership Applications"): Boolean
    begin
        if not IsMembershipApplicationApprovalsWorkflowEnabled(MembershipApplication) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsMembershipApplicationApprovalsWorkflowEnabled(var MembershipApplication: Record "Membership Applications"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(MembershipApplication, SurestepWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendMembershipApplicationForApproval(var MembershipApplication: Record "Membership Applications")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelMembershipApplicationApprovalRequest(var MembershipApplication: Record "Membership Applications")
    begin
    end;


    procedure CheckLoanApplicationApprovalsWorkflowEnabled(var LoanApplication: Record "Loans Register"): Boolean
    begin

        if not IsLoanApplicationApprovalsWorkflowEnabled(LoanApplication) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsLoanApplicationApprovalsWorkflowEnabled(var LoanApplication: Record "Loans Register"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LoanApplication, SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendLoanApplicationForApproval(var LoanApplication: Record "Loans Register")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelLoanApplicationApprovalRequest(var LoanApplication: Record "Loans Register")
    begin
    end;


    procedure CheckGuarantorSubstitutionApprovalsWorkflowEnabled(var GuarantorshipSubstitution: Record "Guarantorship Substitution H"): Boolean
    begin

        if not IsGuarantorSubstitutionApprovalsWorkflowEnabled(GuarantorshipSubstitution) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsGuarantorSubstitutionApprovalsWorkflowEnabled(var GuarantorshipSubstitution: Record "Guarantorship Substitution H"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(GuarantorshipSubstitution, SurestepWFEvents.RunWorkflowOnSendGuarantorSubstitutionForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendGuarantorSubstitutionForApproval(var GuarantorshipSubstitution: Record "Guarantorship Substitution H")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelGuarantorSubstitutionApprovalRequest(var GuarantorshipSubstitution: Record "Guarantorship Substitution H")
    begin
    end;


    procedure CheckLoanDisbursementApprovalsWorkflowEnabled(var LoanDisbursement: Record "Loan Disburesment-Batching"): Boolean
    begin
        if not IsLoanDisbursementApprovalsWorkflowEnabled(LoanDisbursement) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsLoanDisbursementApprovalsWorkflowEnabled(var LoanDisbursement: Record "Loan Disburesment-Batching"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LoanDisbursement, SurestepWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendLoanDisbursementForApproval(var LoanDisbursement: Record "Loan Disburesment-Batching")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelLoanDisbursementApprovalRequest(var LoanDisbursement: Record "Loan Disburesment-Batching")
    begin
    end;


    procedure CheckStandingOrderApprovalsWorkflowEnabled(var StandingOrder: Record "Standing Orders"): Boolean
    begin
        if not IsStandingOrderApprovalsWorkflowEnabled(StandingOrder) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsStandingOrderApprovalsWorkflowEnabled(var StandingOrder: Record "Standing Orders"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(StandingOrder, SurestepWFEvents.RunWorkflowOnSendStandingOrderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendStandingOrderForApproval(var StandingOrder: Record "Standing Orders")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelStandingOrderApprovalRequest(var StandingOrder: Record "Standing Orders")
    begin
    end;


    procedure CheckMWithdrawalApprovalsWorkflowEnabled(var MWithdrawal: Record "Membership Exit"): Boolean
    begin
        if not IsMWithdrawalApprovalsWorkflowEnabled(MWithdrawal) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsMWithdrawalApprovalsWorkflowEnabled(var MWithdrawal: Record "Membership Exit"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(MWithdrawal, SurestepWFEvents.RunWorkflowOnSendMWithdrawalForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendMWithdrawalForApproval(var MWithdrawal: Record "Membership Exit")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelMWithdrawalApprovalRequest(var MWithdrawal: Record "Membership Exit")
    begin
    end;


    procedure CheckATMCardApprovalsWorkflowEnabled(var ATMCard: Record "ATM Card Applications"): Boolean
    begin
        if not IsATMCardApprovalsWorkflowEnabled(ATMCard) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsATMCardApprovalsWorkflowEnabled(var ATMCard: Record "ATM Card Applications"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ATMCard, SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendATMCardForApproval(var ATMCard: Record "ATM Card Applications")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelATMCardApprovalRequest(var ATMCard: Record "ATM Card Applications")
    begin
    end;


    procedure CheckGuarantorRecoveryApprovalsWorkflowEnabled(var GuarantorRecovery: Record "Loan Recovery Header"): Boolean
    begin
        if not IsGuarantorRecoveryApprovalsWorkflowEnabled(GuarantorRecovery) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsGuarantorRecoveryApprovalsWorkflowEnabled(var GuarantorRecovery: Record "Loan Recovery Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(GuarantorRecovery, SurestepWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendGuarantorRecoveryForApproval(var GuarantorRecovery: Record "Loan Recovery Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelGuarantorRecoveryApprovalRequest(var GuarantorRecovery: Record "Loan Recovery Header")
    begin
    end;


    procedure CheckChangeRequestApprovalsWorkflowEnabled(var ChangeRequest: Record "Change Request"): Boolean
    begin
        if not IsChangeRequestApprovalsWorkflowEnabled(ChangeRequest) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsChangeRequestApprovalsWorkflowEnabled(var ChangeRequest: Record "Change Request"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ChangeRequest, SurestepWFEvents.RunWorkflowOnSendChangeRequestForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendChangeRequestForApproval(var ChangeRequest: Record "Change Request")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelChangeRequestApprovalRequest(var ChangeRequest: Record "Change Request")
    begin
    end;


    procedure CheckTTransactionsApprovalsWorkflowEnabled(var TTransactions: Record "Treasury Transactions"): Boolean
    begin
        if not IsTTransactionsApprovalsWorkflowEnabled(TTransactions) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsTTransactionsApprovalsWorkflowEnabled(var TTransactions: Record "Treasury Transactions"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(TTransactions, SurestepWFEvents.RunWorkflowOnSendTTransactionsForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendTTransactionsForApproval(var TTransactions: Record "Treasury Transactions")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelTTransactionsApprovalRequest(var TTransactions: Record "Treasury Transactions")
    begin
    end;


    procedure CheckFAccountApplicationApprovalsWorkflowEnabled(var FAccount: Record "FOSA Account Applicat. Details"): Boolean
    begin
        if not IsFAccountApplicationApprovalsWorkflowEnabled(FAccount) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsFAccountApplicationApprovalsWorkflowEnabled(var FAccount: Record "FOSA Account Applicat. Details"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(FAccount, SurestepWFEvents.RunWorkflowOnSendFAccountApplicationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendFAccountApplicationForApproval(var FAccount: Record "FOSA Account Applicat. Details")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelFAccountApplicationApprovalRequest(var FAccount: Record "FOSA Account Applicat. Details")
    begin
    end;


    // procedure CheckSReqApplicationApprovalsWorkflowEnabled(var SReq: Record "Store Requistion Header"): Boolean
    // begin
    //     if not IsSReqApplicationApprovalsWorkflowEnabled(SReq) then
    //         Error(NoWorkflowEnabledErr);
    //     exit(true);
    // end;


    // procedure IsSReqApplicationApprovalsWorkflowEnabled(var SReq: Record "Store Requistion Header"): Boolean
    // begin
    //     exit(WorkflowManagement.CanExecuteWorkflow(SReq, SurestepWFEvents.RunWorkflowOnSendSReqApplicationForApprovalCode));
    // end;

    // [IntegrationEvent(false, false)]

    // procedure OnSendSReqApplicationForApproval(var SReq: Record "Store Requistion Header")
    // begin
    // end;

    // [IntegrationEvent(false, false)]

    // procedure OnCancelSReqApplicationApprovalRequest(var SReq: Record "Store Requistion Header")
    // begin
    // end;


    procedure CheckSaccoTransferApprovalsWorkflowEnabled(var SaccoTransfer: Record "Sacco Transfers"): Boolean
    begin
        if not IsSaccoTransferApprovalsWorkflowEnabled(SaccoTransfer) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsSaccoTransferApprovalsWorkflowEnabled(var SaccoTransfer: Record "Sacco Transfers"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(SaccoTransfer, SurestepWFEvents.RunWorkflowOnSendSaccoTransferForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendSaccoTransferForApproval(var SaccoTransfer: Record "Sacco Transfers")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelSaccoTransferApprovalRequest(var SaccoTransfer: Record "Sacco Transfers")
    begin
    end;


    procedure CheckChequeDiscountingApprovalsWorkflowEnabled(var ChequeDiscounting: Record "Cheque Discounting"): Boolean
    begin
        if not IsChequeDiscountingApprovalsWorkflowEnabled(ChequeDiscounting) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsChequeDiscountingApprovalsWorkflowEnabled(var ChequeDiscounting: Record "Cheque Discounting"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ChequeDiscounting, SurestepWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendChequeDiscountingForApproval(var ChequeDiscounting: Record "Cheque Discounting")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelChequeDiscountingApprovalRequest(var ChequeDiscounting: Record "Cheque Discounting")
    begin
    end;


    procedure CheckImprestRequisitionApprovalsWorkflowEnabled(var ImprestRequisition: Record "Imprest Header"): Boolean
    begin
        if not IsImprestRequisitionApprovalsWorkflowEnabled(ImprestRequisition) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsImprestRequisitionApprovalsWorkflowEnabled(var ImprestRequisition: Record "Imprest Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ImprestRequisition, SurestepWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendImprestRequisitionForApproval(var ImprestRequisition: Record "Imprest Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelImprestRequisitionApprovalRequest(var ImprestRequisition: Record "Imprest Header")
    begin
    end;


    procedure CheckImprestSurrenderApprovalsWorkflowEnabled(var ImprestSurrender: Record "Imprest Surrender Header"): Boolean
    begin
        if not IsImprestSurrenderApprovalsWorkflowEnabled(ImprestSurrender) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsImprestSurrenderApprovalsWorkflowEnabled(var ImprestSurrender: Record "Imprest Surrender Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ImprestSurrender, SurestepWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendImprestSurrenderForApproval(var ImprestSurrender: Record "Imprest Surrender Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelImprestSurrenderApprovalRequest(var ImprestSurrender: Record "Imprest Surrender Header")
    begin
    end;


    procedure CheckLeaveApplicationApprovalsWorkflowEnabled(var LeaveApplication: Record "HR Leave Application"): Boolean
    begin
        if not IsLeaveApplicationApprovalsWorkflowEnabled(LeaveApplication) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsLeaveApplicationApprovalsWorkflowEnabled(var LeaveApplication: Record "HR Leave Application"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LeaveApplication, SurestepWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendLeaveApplicationForApproval(var LeaveApplication: Record "HR Leave Application")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelLeaveApplicationApprovalRequest(var LeaveApplication: Record "HR Leave Application")
    begin
    end;


    procedure CheckPVApprovalsWorkflowEnabled(var PaymentsHeader: Record "Payments Header"): Boolean
    begin
        if not IsPVApprovalsWorkflowEnabled(PaymentsHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsPVApprovalsWorkflowEnabled(var PaymentsHeader: Record "Payments Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PaymentsHeader, SurestepWFEvents.RunWorkflowOnSendPVForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendPVForApproval(var PaymentsHeader: Record "Payments Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelPVApprovalRequest(var PaymentsHeader: Record "Payments Header")
    begin
    end;


    procedure CheckBulkWithdrawalApprovalsWorkflowEnabled(var BulkWithdrawal: Record "Bulk Withdrawal Application"): Boolean
    begin
        if not IsBulkWithdrawalApprovalsWorkflowEnabled(BulkWithdrawal) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsBulkWithdrawalApprovalsWorkflowEnabled(var BulkWithdrawal: Record "Bulk Withdrawal Application"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(BulkWithdrawal, SurestepWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendBulkWithdrawalForApproval(var BulkWithdrawal: Record "Bulk Withdrawal Application")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelBulkWithdrawalApprovalRequest(var BulkWithdrawal: Record "Bulk Withdrawal Application")
    begin
    end;


    procedure CheckPackageLodgeApprovalsWorkflowEnabled(var PackageLodge: Record "Safe Custody Package Register"): Boolean
    begin
        if not IsPackageLodgeApprovalsWorkflowEnabled(PackageLodge) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsPackageLodgeApprovalsWorkflowEnabled(var PackageLodge: Record "Safe Custody Package Register"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PackageLodge, SurestepWFEvents.RunWorkflowOnSendPackageLodgeForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendPackageLodgeForApproval(var PackageLodge: Record "Safe Custody Package Register")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelPackageLodgeApprovalRequest(var PackageLodge: Record "Safe Custody Package Register")
    begin
    end;


    procedure CheckPackageRetrievalApprovalsWorkflowEnabled(var PackageRetrieval: Record "Package Retrieval Register"): Boolean
    begin
        if not IsPackageRetrievalApprovalsWorkflowEnabled(PackageRetrieval) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsPackageRetrievalApprovalsWorkflowEnabled(var PackageRetrieval: Record "Package Retrieval Register"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PackageRetrieval, SurestepWFEvents.RunWorkflowOnSendPackageRetrievalForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendPackageRetrievalForApproval(var PackageRetrieval: Record "Package Retrieval Register")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelPackageRetrievalApprovalRequest(var PackageRetrieval: Record "Package Retrieval Register")
    begin
    end;


    procedure CheckPurchaseRequisitionApprovalsWorkflowEnabled(var PRequest: Record "Purchase Header"): Boolean
    begin
        if not IsPurchaseRequisitionApprovalsWorkflowEnabled(PRequest) then
            //ERROR(NoWorkflowEnabledErr);
            exit(true);
    end;


    procedure IsPurchaseRequisitionApprovalsWorkflowEnabled(var PRequest: Record "Purchase Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PRequest, SurestepWFEvents.RunWorkflowOnSendPurchaseRequisitionForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendPurchaseRequisitionForApproval(var PRequest: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelPurchaseRequisitionApprovalRequest(var PRequest: Record "Purchase Header")
    begin
    end;


    procedure CheckHouseChangeApprovalsWorkflowEnabled(var HouseChange: Record "House Group Change Request"): Boolean
    begin
        if not IsHouseChangeApprovalsWorkflowEnabled(HouseChange) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsHouseChangeApprovalsWorkflowEnabled(var HouseChange: Record "House Group Change Request"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HouseChange, SurestepWFEvents.RunWorkflowOnSendHouseChangeForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendHouseChangeForApproval(var HouseChange: Record "House Group Change Request")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelHouseChangeApprovalRequest(var HouseChange: Record "House Group Change Request")
    begin
    end;


    procedure CheckCRMTrainingApprovalsWorkflowEnabled(var CRMTraining: Record "CRM Trainings"): Boolean
    begin
        if not IsCRMTrainingApprovalsWorkflowEnabled(CRMTraining) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsCRMTrainingApprovalsWorkflowEnabled(CRMTraining: Record "CRM Trainings"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(CRMTraining, SurestepWFEvents.RunWorkflowOnSendCRMTrainingForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendCRMTrainingForApproval(var CRMTraining: Record "CRM Trainings")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelCRMTrainingApprovalRequest(var CRMTraining: Record "CRM Trainings")
    begin
    end;


    procedure CheckPettyCashApprovalsWorkflowEnabled(var PettyCash: Record "Payment Header."): Boolean
    begin
        if not IsPettyCashApprovalsWorkflowEnabled(PettyCash) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsPettyCashApprovalsWorkflowEnabled(var PettyCash: Record "Payment Header."): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PettyCash, SurestepWFEvents.RunWorkflowOnSendPettyCashForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendPettyCashForApproval(var PettyCash: Record "Payment Header.")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelPettyCashApprovalRequest(var PettyCash: Record "Payment Header.")
    begin
    end;


    procedure CheckStaffClaimsApprovalsWorkflowEnabled(var StaffClaims: Record "Staff Claims Header"): Boolean
    begin
        if not IsStaffClaimsApprovalsWorkflowEnabled(StaffClaims) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsStaffClaimsApprovalsWorkflowEnabled(var StaffClaims: Record "Staff Claims Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(StaffClaims, SurestepWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendStaffClaimsForApproval(var StaffClaims: Record "Staff Claims Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelStaffClaimsApprovalRequest(var StaffClaims: Record "Staff Claims Header")
    begin
    end;


    procedure CheckMemberAgentNOKChangeApprovalsWorkflowEnabled(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang"): Boolean
    begin
        if not IsMemberAgentNOKChangeApprovalsWorkflowEnabled(MemberAgentNOKChange) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsMemberAgentNOKChangeApprovalsWorkflowEnabled(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(MemberAgentNOKChange, SurestepWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendMemberAgentNOKChangeForApproval(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelMemberAgentNOKChangeApprovalRequest(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang")
    begin
    end;


    procedure CheckHouseRegistrationApprovalsWorkflowEnabled(var HouseRegistration: Record "House Groups Registration"): Boolean
    begin
        if not IsHouseRegistrationApprovalsWorkflowEnabled(HouseRegistration) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsHouseRegistrationApprovalsWorkflowEnabled(var HouseRegistration: Record "House Groups Registration"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(HouseRegistration, SurestepWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendHouseRegistrationForApproval(var HouseRegistration: Record "House Groups Registration")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelHouseRegistrationApprovalRequest(var HouseRegistration: Record "House Groups Registration")
    begin
    end;


    procedure CheckLoanPayOffApprovalsWorkflowEnabled(var LoanPayOff: Record "Loan PayOff"): Boolean
    begin
        if not IsLoanPayOffApprovalsWorkflowEnabled(LoanPayOff) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsLoanPayOffApprovalsWorkflowEnabled(var LoanPayOff: Record "Loan PayOff"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LoanPayOff, SurestepWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendLoanPayOffForApproval(var LoanPayOff: Record "Loan PayOff")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelLoanPayOffApprovalRequest(var LoanPayOff: Record "Loan PayOff")
    begin
    end;


    procedure CheckFixedDepositApprovalsWorkflowEnabled(var FixedDeposit: Record "Fixed Deposit Placement"): Boolean
    begin
        if not IsFixedDepositApprovalsWorkflowEnabled(FixedDeposit) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsFixedDepositApprovalsWorkflowEnabled(var FixedDeposit: Record "Fixed Deposit Placement"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(FixedDeposit, SurestepWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendFixedDepositForApproval(var FixedDeposit: Record "Fixed Deposit Placement")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelFixedDepositApprovalRequest(var FixedDeposit: Record "Fixed Deposit Placement")
    begin
    end;


    procedure CheckEFTRTGSApprovalsWorkflowEnabled(var EFTRTGS: Record "EFT Details"): Boolean
    begin
        if not IsEFTRTGSApprovalsWorkflowEnabled(EFTRTGS) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsEFTRTGSApprovalsWorkflowEnabled(var EFTRTGS: Record "EFT Details"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(EFTRTGS, SurestepWFEvents.RunWorkflowOnSendEFTRTGSForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendEFTRTGSForApproval(var EFTRTGS: Record "EFT Details")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelEFTRTGSApprovalRequest(var EFTRTGS: Record "EFT Details")
    begin
    end;


    procedure CheckDemandNoticeApprovalsWorkflowEnabled(var LDemand: Record "Default Notices Register"): Boolean
    begin
        if not IsDemandNoticeApprovalsWorkflowEnabled(LDemand) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsDemandNoticeApprovalsWorkflowEnabled(var LDemand: Record "Default Notices Register"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LDemand, SurestepWFEvents.RunWorkflowOnSendDemandNoticeForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendDemandNoticeForApproval(var LDemand: Record "Default Notices Register")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelDemandNoticeApprovalRequest(var LDemand: Record "Default Notices Register")
    begin
    end;


    // procedure CheckOverDraftApprovalsWorkflowEnabled(var OverDraft: Record "OverDraft Application"): Boolean
    // begin
    //     if not IsOverDraftApprovalsWorkflowEnabled(OverDraft) then
    //         Error(NoWorkflowEnabledErr);
    //     exit(true);
    // end;


    // procedure IsOverDraftApprovalsWorkflowEnabled(var OverDraft: Record "OverDraft Application"): Boolean
    // begin
    //     exit(WorkflowManagement.CanExecuteWorkflow(OverDraft, SurestepWFEvents.RunWorkflowOnSendOverDraftForApprovalCode));
    // end;

    // [IntegrationEvent(false, false)]

    // procedure OnSendOverDraftForApproval(var OverDraft: Record "OverDraft Application")
    // begin
    // end;

    // [IntegrationEvent(false, false)]

    // procedure OnCancelOverDraftApprovalRequest(var OverDraft: Record "OverDraft Application")
    // begin
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure PopulateSurestepEntries(RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance"; var ApprovalEntryArgument: Record "Approval Entry")
    var
        Customer: Record Customer;
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        PurchaseHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        IncomingDocument: Record "Incoming Document";
        ApprovalAmount: Decimal;
        ApprovalAmountLCY: Decimal;
        PaymentHeader: Record "Payments Header";
        MembershipApplication: Record "Membership Applications";
        LoanApplication: Record "Loans Register";
        LoanDisbursement: Record "Loan Disburesment-Batching";
        StandingOrder: Record "Standing Orders";
        MWithdrawal: Record "Membership Exit";
        ATMCard: Record "ATM Card Applications";
        GuarantorR: Record "Loan Recovery Header";
        ChangeRequest: Record "Change Request";
        TTransactions: Record "Treasury Transactions";
        FAccount: Record "FOSA Account Applicat. Details";
        // SReq: Record "Store Requistion Header";
        SaccoTransfer: Record "Sacco Transfers";
        ChequeDiscounting: Record "Cheque Discounting";
        ImprestRequisition: Record "Imprest Header";
        ImprestSurrender: Record "Imprest Surrender Header";
        LeaveApplication: Record "HR Leave Application";
        BulkWithdrawal: Record "Bulk Withdrawal Application";
        PackageLodge: Record "Safe Custody Package Register";
        PackageRetrieval: Record "Package Retrieval Register";
        HouseChange: Record "House Group Change Request";
        CRMTraining: Record "CRM Trainings";
        PettyCash: Record "Payment Header.";
        StaffClaims: Record "Staff Claims Header";
        MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang";
        HouseRegistration: Record "House Groups Registration";
        LoanPayOff: Record "Loan PayOff";
        FixedDeposit: Record "Fixed Deposit Placement";
        EFTRTGS: Record "EFT Details";
        LDemand: Record "Default Notices Register";
        // OverDraft: Record "OverDraft Application";
        // LoanRestructure: Record "Loan Restructure";
        // SweepingInstructions: Record "Member Sweeping Instructions";
        ChequeBook: Record "Cheque Book Application";
        LoanTrunch: Record "Loan trunch Disburesment";
        InwardChequeClearing: Record "Cheque Receipts-Family";
        InvalidPaybillTransactions: Record "Paybill Processing Header";
        // InternalPV: Record "Internal PV Header";
        SProcessing: Record "Salary Processing Headerr";
    begin
        case RecRef.Number of
            //--------------------------Add Surestep Populate Approval Entry Argument---------------------------------------------
            //Payment Document
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    PaymentHeader.CalcFields(PaymentHeader."Total Payment Amount", PaymentHeader."Total Payment Amount LCY");
                    ApprovalAmount := PaymentHeader."Total Payment Amount";
                    ApprovalAmountLCY := PaymentHeader."Total Payment Amount LCY";
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::"Payment Voucher";
                    ApprovalEntryArgument."Document No." := PaymentHeader."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := PaymentHeader."Bank Account Name";
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := PaymentHeader."Currency Code";
                end;

            //Membership Applications
            Database::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApplication);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::MembershipApplication;
                    ApprovalEntryArgument."Document No." := MembershipApplication."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := MembershipApplication.Name;
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := '';
                end;
            //Loan Application
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoanApplication);
                    ApprovalAmount := LoanApplication."Requested Amount";
                    ApprovalAmountLCY := LoanApplication."Requested Amount";
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::LoanApplication;
                    ApprovalEntryArgument."Document No." := LoanApplication."Loan  No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := LoanApplication."Client Name";
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := LoanApplication."Product Currency Code";
                end;
            //Standing Orders
            Database::"Standing Orders":
                begin
                    RecRef.SetTable(StandingOrder);
                    ApprovalAmount := StandingOrder.Amount;
                    ApprovalAmountLCY := StandingOrder.Amount;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::StandingOrder;
                    ApprovalEntryArgument."Document No." := StandingOrder."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := StandingOrder."Account Name";
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := '';
                end;
            //Loan Disbursement
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanDisbursement);
                    ApprovalAmount := LoanDisbursement."Total Loan Amount";
                    ApprovalAmountLCY := LoanDisbursement."Total Loan Amount";
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::LoanDisbursement;
                    ApprovalEntryArgument."Document No." := LoanDisbursement."Batch No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := LoanDisbursement."Description/Remarks";
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Membership Withdrawal
            Database::"Membership Exit":
                begin
                    RecRef.SetTable(MWithdrawal);
                    ApprovalAmount := MWithdrawal."Net Payable to the Member";
                    ApprovalAmountLCY := MWithdrawal."Net Payable to the Member";
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::MembershipWithdrawal;
                    ApprovalEntryArgument."Document No." := MWithdrawal."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := MWithdrawal."Member Name";
                    ApprovalEntryArgument.Amount := MWithdrawal."Net Payable to the Member";
                    ApprovalEntryArgument."Amount (LCY)" := MWithdrawal."Net Payable to the Member";
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //ATM Card Applications
            Database::"ATM Card Applications":
                begin
                    RecRef.SetTable(ATMCard);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::ATMCard;
                    ApprovalEntryArgument."Document No." := ATMCard."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := ATMCard."Account Name";
                    ApprovalEntryArgument.Amount := 0;
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Guarantors Recovery
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(GuarantorR);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::GuarantorRecovery;
                    ApprovalEntryArgument."Document No." := GuarantorR."Document No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := GuarantorR."Member Name";
                    /*IF GuarantorR."Recovery Type"=GuarantorR."Recovery Type"::"Recover From Loanee Deposits" THEN
                     ApprovalEntryArgument.Amount := GuarantorR."Deposits Recovered Amount";
                    IF GuarantorR."Recovery Type"=GuarantorR."Recovery Type"::"Recover From Guarantors Deposits" THEN
                      ApprovalEntryArgument.Amount := GuarantorR."Total Guarantor Allocation";
                    IF GuarantorR."Recovery Type"=GuarantorR."Recovery Type"::"5" THEN
                      ApprovalEntryArgument.Amount := GuarantorR."Share Capital to Sell";*/
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;
            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::ChangeRequest;
                    ApprovalEntryArgument."Document No." := ChangeRequest.No;
                    ApprovalEntryArgument."Salespers./Purch. Code" := ChangeRequest.Name;
                    ApprovalEntryArgument.Amount := 0;
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;
            //Treasury Transactions
            Database::"Treasury Transactions":
                begin
                    RecRef.SetTable(TTransactions);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::TreasuryTransactions;
                    ApprovalEntryArgument."Document No." := TTransactions.No;
                    ApprovalEntryArgument."Salespers./Purch. Code" := TTransactions."From Account Name" + ' to ' + TTransactions."To Account Name";
                    ApprovalEntryArgument.Amount := 0;
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //FOSA Account Applications
            Database::"FOSA Account Applicat. Details":
                begin
                    RecRef.SetTable(FAccount);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::ProductApplication;
                    ApprovalEntryArgument."Document No." := FAccount."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := FAccount.Name;
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Stores Requisition
            // Database::"Store Requistion Header":
            //     begin
            //         RecRef.SetTable(SReq);
            //         ApprovalAmount := 0;
            //         ApprovalAmountLCY := 0;
            //         ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::"Store Requisition";
            //         ApprovalEntryArgument."Document No." := SReq."No.";
            //         ApprovalEntryArgument."Salespers./Purch. Code" := SReq."Request Description";
            //         ApprovalEntryArgument.Amount := SReq.TotalAmount;
            //         ApprovalEntryArgument."Amount (LCY)" := SReq.TotalAmount;
            //         ApprovalEntryArgument."Currency Code" := '';
            //     end;
            // //Sacco Transfers
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfer);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::SaccoTransfers;
                    ApprovalEntryArgument."Document No." := SaccoTransfer.No;
                    ApprovalEntryArgument."Salespers./Purch. Code" := SaccoTransfer."Source Account Name";
                    ApprovalEntryArgument.Amount := SaccoTransfer."Schedule Total";
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;
            //Cheque Discounting
            Database::"Cheque Discounting":
                begin
                    RecRef.SetTable(ChequeDiscounting);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::ChequeDiscounting;
                    ApprovalEntryArgument."Document No." := ChequeDiscounting."Transaction No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := ChequeDiscounting."Account Name";
                    ApprovalEntryArgument.Amount := ChequeDiscounting."Amount Discounted";
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;
            //Imprest Requisition
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::ImprestRequisition;
                    ApprovalEntryArgument."Document No." := ImprestRequisition."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := ImprestRequisition.Payee;
                    ApprovalEntryArgument.Amount := ImprestRequisition."Total Net Amount";
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;
            //Imprest Surrender
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::ImprestSurrender;
                    ApprovalEntryArgument."Document No." := ImprestSurrender.No;
                    ApprovalEntryArgument."Salespers./Purch. Code" := ImprestSurrender."Received From";
                    ApprovalEntryArgument.Amount := ImprestSurrender."Net Amount";
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;
            //Leave Application
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::LeaveApplication;
                    ApprovalEntryArgument."Document No." := LeaveApplication."Application Code";
                    ApprovalEntryArgument."Salespers./Purch. Code" := LeaveApplication."Employee Name";
                    ApprovalEntryArgument.Amount := LeaveApplication."Leave Allowance Amount";
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Bulk Withdrawal
            Database::"Bulk Withdrawal Application":
                begin
                    RecRef.SetTable(BulkWithdrawal);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::BulkWithdrawal;
                    ApprovalEntryArgument."Document No." := BulkWithdrawal."Transaction No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := BulkWithdrawal."Account Name";
                    ApprovalEntryArgument.Amount := BulkWithdrawal."Amount to Withdraw";
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Package Lodge
            Database::"Safe Custody Package Register":
                begin
                    RecRef.SetTable(PackageLodge);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::PackageLodging;
                    ApprovalEntryArgument."Document No." := PackageLodge."Package ID";
                    ApprovalEntryArgument."Salespers./Purch. Code" := PackageLodge."Member Name";
                    ApprovalEntryArgument.Amount := 0;
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Package Retrieval
            Database::"Package Retrieval Register":
                begin
                    RecRef.SetTable(PackageRetrieval);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::PackageRetrieval;
                    ApprovalEntryArgument."Document No." := PackageRetrieval."Request No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := PackageRetrieval."Member Name";
                    ApprovalEntryArgument.Amount := 0;
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //House Change
            Database::"House Group Change Request":
                begin
                    RecRef.SetTable(HouseChange);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::HouseChange;
                    ApprovalEntryArgument."Document No." := HouseChange."Document No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := HouseChange."Member Name";
                    ApprovalEntryArgument.Amount := 0;
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //CRM Training
            Database::"CRM Trainings":
                begin
                    RecRef.SetTable(CRMTraining);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::CRMTraining;
                    ApprovalEntryArgument."Document No." := CRMTraining.Code;
                    ApprovalEntryArgument."Salespers./Purch. Code" := CRMTraining.Description;
                    ApprovalEntryArgument.Amount := CRMTraining."Cost Of Training";
                    ApprovalEntryArgument."Amount (LCY)" := CRMTraining."Cost Of Training";
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Petty Cash
            Database::"Payment Header.":
                begin
                    RecRef.SetTable(PettyCash);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::PettyCash;
                    ApprovalEntryArgument."Document No." := PettyCash."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := PettyCash.Payee;
                    ApprovalEntryArgument.Amount := PettyCash.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := PettyCash."Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Staff Claims
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::StaffClaims;
                    ApprovalEntryArgument."Document No." := StaffClaims."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := StaffClaims.Payee;
                    ApprovalEntryArgument.Amount := StaffClaims."Total Net Amount";
                    ApprovalEntryArgument."Amount (LCY)" := StaffClaims."Total Net Amount LCY";
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Member Agent/NOK Change
            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::MemberAgentNOKChange;
                    ApprovalEntryArgument."Document No." := MemberAgentNOKChange."Document No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := MemberAgentNOKChange."Member Name";
                    ApprovalEntryArgument.Amount := 0;
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;


            //House Registration
            Database::"House Groups Registration":
                begin
                    RecRef.SetTable(HouseRegistration);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::HouseRegistration;
                    ApprovalEntryArgument."Document No." := HouseRegistration."Cell Group Code";
                    ApprovalEntryArgument."Salespers./Purch. Code" := HouseRegistration."Cell Group Name";
                    ApprovalEntryArgument.Amount := 0;
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Loan PayOff
            Database::"Loan PayOff":
                begin
                    RecRef.SetTable(LoanPayOff);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::LoanPayOff;
                    ApprovalEntryArgument."Document No." := LoanPayOff."Document No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := LoanPayOff."Member Name";
                    ApprovalEntryArgument.Amount := LoanPayOff."Requested PayOff Amount";
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Fixed Deposit
            Database::"Fixed Deposit Placement":
                begin
                    RecRef.SetTable(FixedDeposit);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::FixedDeposit;
                    ApprovalEntryArgument."Document No." := FixedDeposit."Document No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := FixedDeposit."Member Name";
                    ApprovalEntryArgument.Amount := FixedDeposit."Amount to Fix";
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //EFTRTGS
            Database::"EFT Details":
                begin
                    RecRef.SetTable(EFTRTGS);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::RTGS;
                    ApprovalEntryArgument."Document No." := EFTRTGS.No;
                    ApprovalEntryArgument."Salespers./Purch. Code" := EFTRTGS."Destination Account Name";
                    ApprovalEntryArgument.Amount := EFTRTGS.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Loan Demand Notices
            Database::"Default Notices Register":
                begin
                    RecRef.SetTable(LDemand);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::DemandNotice;
                    ApprovalEntryArgument."Document No." := LDemand."Document No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := LDemand."Member Name";
                    ApprovalEntryArgument.Amount := LDemand."Amount In Arrears";
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Over Draft
            // Database::"OverDraft Application":
            //     begin
            //         RecRef.SetTable(OverDraft);
            //         ApprovalAmount := 0;
            //         ApprovalAmountLCY := 0;
            //         ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::OverDraft;
            //         ApprovalEntryArgument."Document No." := OverDraft."Document No";
            //         ApprovalEntryArgument."Salespers./Purch. Code" := OverDraft."Over Draft Account Name";
            //         ApprovalEntryArgument.Amount := OverDraft."Qualifying Overdraft Amount";
            //         ApprovalEntryArgument."Amount (LCY)" := 0;
            //         ApprovalEntryArgument."Currency Code" := '';
            //     end;

            // //Loan Restructure
            // Database::"Loan Restructure":
            //     begin
            //         RecRef.SetTable(LoanRestructure);
            //         ApprovalAmount := 0;
            //         ApprovalAmountLCY := 0;
            //         ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::LoanRestructure;
            //         ApprovalEntryArgument."Document No." := LoanRestructure."Document No";
            //         ApprovalEntryArgument."Salespers./Purch. Code" := LoanRestructure."Member Name";
            //         ApprovalEntryArgument.Amount := LoanRestructure."Current Payoff Amount";
            //         ApprovalEntryArgument."Amount (LCY)" := 0;
            //         ApprovalEntryArgument."Currency Code" := '';
            //     end;

            // //Sweeping Instructions
            // Database::"Member Sweeping Instructions":
            //     begin
            //         RecRef.SetTable(SweepingInstructions);
            //         ApprovalAmount := 0;
            //         ApprovalAmountLCY := 0;
            //         ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::SweepingInstructions;
            //         ApprovalEntryArgument."Document No." := SweepingInstructions."Document No";
            //         ApprovalEntryArgument."Salespers./Purch. Code" := SweepingInstructions."Member Name";
            //         ApprovalEntryArgument.Amount := SweepingInstructions."Maximum Account Threshold";
            //         ApprovalEntryArgument."Amount (LCY)" := 0;
            //         ApprovalEntryArgument."Currency Code" := '';
            //     end;

            //Cheque Book Application
            Database::"Cheque Book Application":
                begin
                    RecRef.SetTable(ChequeBook);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::ChequeBookApplication;
                    ApprovalEntryArgument."Document No." := ChequeBook."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := ChequeBook.Name;
                    ApprovalEntryArgument.Amount := 0;
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;


            //Loan Trunch
            Database::"Loan trunch Disburesment":
                begin
                    RecRef.SetTable(LoanTrunch);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::LoanTrunchDisbursement;
                    ApprovalEntryArgument."Document No." := LoanTrunch."Document No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := LoanTrunch."Member Name";
                    ApprovalEntryArgument.Amount := LoanTrunch."Amount to Disburse";
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Inward Cheque Clearing
            Database::"Cheque Receipts-Family":
                begin
                    RecRef.SetTable(InwardChequeClearing);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::InwardChequeClearing;
                    ApprovalEntryArgument."Document No." := InwardChequeClearing."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := Format(InwardChequeClearing."Transaction Date", 0, '<Day,2> <Month Text,3> <Year4>') + ' Inwards';
                    ApprovalEntryArgument.Amount := 0;
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            //Invalid Paybill Transactions
            Database::"Paybill Processing Header":
                begin
                    RecRef.SetTable(InvalidPaybillTransactions);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::InValidPaybillTransactions;
                    ApprovalEntryArgument."Document No." := InvalidPaybillTransactions.No;
                    ApprovalEntryArgument."Salespers./Purch. Code" := InvalidPaybillTransactions.Remarks;
                    ApprovalEntryArgument.Amount := InvalidPaybillTransactions."Scheduled Amount";
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;

            // //Internal PV
            // Database::"Internal PV Header":
            //     begin
            //         RecRef.SetTable(InternalPV);
            //         ApprovalAmount := 0;
            //         ApprovalAmountLCY := 0;
            //         ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::InternalPV;
            //         ApprovalEntryArgument."Document No." := InternalPV.No;
            //         ApprovalEntryArgument."Salespers./Purch. Code" := InternalPV."Transaction Description";
            //         ApprovalEntryArgument.Amount := InternalPV."Total Credits";
            //         ApprovalEntryArgument."Amount (LCY)" := 0;
            //         ApprovalEntryArgument."Currency Code" := '';
            //     end;

            //Salary Processing
            Database::"Salary Processing Headerr":
                begin
                    RecRef.SetTable(SProcessing);
                    ApprovalAmount := 0;
                    ApprovalAmountLCY := 0;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."document type"::SalaryProcessing;
                    ApprovalEntryArgument."Document No." := SProcessing.No;
                    ApprovalEntryArgument."Salespers./Purch. Code" := SProcessing."Document No";
                    ApprovalEntryArgument.Amount := SProcessing.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := 0;
                    ApprovalEntryArgument."Currency Code" := '';
                end;


        //--------------------------End Add
        end;


    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'SetStatusToPendingApproval','',true,true)]
    // local procedure SetSurestepStatusestoPendingApproval() begin

    // end;


    // procedure CheckLoanRestructureApprovalsWorkflowEnabled(var LoanRestructure: Record "Loan Rescheduling"): Boolean
    // begin
    //     if not IsLoanRestructureApprovalsWorkflowEnabled(LoanRestructure) then
    //         Error(NoWorkflowEnabledErr);
    //     exit(true);
    // end;


    // procedure IsLoanRestructureApprovalsWorkflowEnabled(var LoanRestructure: Record "Loan Rescheduling"): Boolean
    // begin
    //     exit(WorkflowManagement.CanExecuteWorkflow(LoanRestructure, SurestepWFEvents.RunWorkflowOnSendLoanRestructureForApprovalCode));
    // end;

    // [IntegrationEvent(false, false)]

    // procedure OnSendLoanRestructureForApproval(var LoanRestructure: Record "Loan Rescheduling")
    // begin
    // end;

    // [IntegrationEvent(false, false)]

    // procedure OnCancelLoanRestructureApprovalRequest(var LoanRestructure: Record "Loan Rescheduling")
    // begin
    // end;

    // local procedure FnApproveRecordsWithSameSequenceNumber(ObjRec: Record "Approval Entry")
    // var
    //     ApprovalEntry: Record "Approval Entry";
    //     ObjApprovalEntries: Record "Approval Entry";
    // begin
    //     ObjApprovalEntries.Reset;
    //     ObjApprovalEntries.SetRange("Sequence No.",ObjRec."Sequence No.");
    //     ObjApprovalEntries.SetRange("Document No.",ObjRec."Document No.");
    //     //ObjApprovalEntries.SETRANGE("Approve All",TRUE);
    //     if ObjApprovalEntries.Find('-') then
    //       begin
    //         repeat
    //           if (ObjApprovalEntries.Status<>ObjApprovalEntries.Status::Canceled) or (ObjApprovalEntries.Status<>ObjApprovalEntries.Status::Rejected) then
    //             begin
    //               ObjApprovalEntries.Validate(Status,ApprovalEntry.Status::Approved);
    //               ObjApprovalEntries.Modify(true);
    //               OnApproveApprovalRequest(ObjApprovalEntries);
    //               end;
    //         until ObjApprovalEntries.Next=0;
    //       end;
    // end;


    // procedure CheckSweepingInstructionsApprovalsWorkflowEnabled(var SweepingInstructions: Record "Member Sweeping Instructions"): Boolean
    // begin
    //     if not IsSweepingInstructionsApprovalsWorkflowEnabled(SweepingInstructions) then
    //         Error(NoWorkflowEnabledErr);
    //     exit(true);
    // end;


    // procedure IsSweepingInstructionsApprovalsWorkflowEnabled(var SweepingInstructions: Record "Member Sweeping Instructions"): Boolean
    // begin
    //     exit(WorkflowManagement.CanExecuteWorkflow(SweepingInstructions, SurestepWFEvents.RunWorkflowOnSendSweepingInstructionsForApprovalCode));
    // end;

    // [IntegrationEvent(false, false)]

    // procedure OnSendSweepingInstructionsForApproval(var SweepingInstructions: Record "Member Sweeping Instructions")
    // begin
    // end;

    // [IntegrationEvent(false, false)]

    // procedure OnCancelSweepingInstructionsApprovalRequest(var SweepingInstructions: Record "Member Sweeping Instructions")
    // begin
    // end;


    procedure CheckChequeBookApprovalsWorkflowEnabled(var ChequeBook: Record "Cheque Book Application"): Boolean
    begin
        if not IsChequeBookApprovalsWorkflowEnabled(ChequeBook) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsChequeBookApprovalsWorkflowEnabled(var ChequeBook: Record "Cheque Book Application"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ChequeBook, SurestepWFEvents.RunWorkflowOnSendChequeBookForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendChequeBookForApproval(var ChequeBook: Record "Cheque Book Application")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelChequeBookApprovalRequest(var ChequeBook: Record "Cheque Book Application")
    begin
    end;


    procedure CheckLoanTrunchDisbursementApprovalsWorkflowEnabled(var LoanTrunchDisbursement: Record "Loan trunch Disburesment"): Boolean
    begin
        if not IsLoanTrunchDisbursementApprovalsWorkflowEnabled(LoanTrunchDisbursement) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsLoanTrunchDisbursementApprovalsWorkflowEnabled(var LoanTrunchDisbursement: Record "Loan trunch Disburesment"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LoanTrunchDisbursement, SurestepWFEvents.RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendLoanTrunchDisbursementForApproval(var LoanTrunchDisbursement: Record "Loan trunch Disburesment")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelLoanTrunchDisbursementApprovalRequest(var LoanTrunchDisbursement: Record "Loan trunch Disburesment")
    begin
    end;


    procedure CheckInwardChequeClearingApprovalsWorkflowEnabled(var InwardChequeClearing: Record "Cheque Receipts-Family"): Boolean
    begin
        if not IsInwardChequeClearingApprovalsWorkflowEnabled(InwardChequeClearing) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsInwardChequeClearingApprovalsWorkflowEnabled(var InwardChequeClearing: Record "Cheque Receipts-Family"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(InwardChequeClearing, SurestepWFEvents.RunWorkflowOnSendInwardChequeClearingForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendInwardChequeClearingForApproval(var InwardChequeClearing: Record "Cheque Receipts-Family")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelInwardChequeClearingApprovalRequest(var InwardChequeClearing: Record "Cheque Receipts-Family")
    begin
    end;


    procedure CheckInvalidPaybillTransactionApprovalsWorkflowEnabled(var InvalidPaybillTransaction: Record "Paybill Processing Header"): Boolean
    begin
        if not IsInvalidPaybillTransactionApprovalsWorkflowEnabled(InvalidPaybillTransaction) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsInvalidPaybillTransactionApprovalsWorkflowEnabled(var InvalidPaybillTransaction: Record "Paybill Processing Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(InvalidPaybillTransaction, SurestepWFEvents.RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendInvalidPaybillTransactionForApproval(var InvalidPaybillTransaction: Record "Paybill Processing Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelInvalidPaybillTransactionApprovalRequest(var InvalidPaybillTransaction: Record "Paybill Processing Header")
    begin
    end;


    // procedure CheckInternalPVApprovalsWorkflowEnabled(var InternalPV: Record "Internal PV Header"): Boolean
    // begin
    //     if not IsInternalPVApprovalsWorkflowEnabled(InternalPV) then
    //         Error(NoWorkflowEnabledErr);
    //     exit(true);
    // end;


    // procedure IsInternalPVApprovalsWorkflowEnabled(var InternalPV: Record "Internal PV Header"): Boolean
    // begin
    //     exit(WorkflowManagement.CanExecuteWorkflow(InternalPV, SurestepWFEvents.RunWorkflowOnSendInternalPVForApprovalCode));
    // end;

    // [IntegrationEvent(false, false)]

    // procedure OnSendInternalPVForApproval(var InternalPV: Record "Internal PV Header")
    // begin
    // end;

    // [IntegrationEvent(false, false)]

    // procedure OnCancelInternalPVApprovalRequest(var InternalPV: Record "Internal PV Header")
    // begin
    // end;


    procedure CheckSalaryProcessingApprovalsWorkflowEnabled(var SProcessing: Record "Salary Processing Headerr"): Boolean
    begin
        if not IsSalaryProcessingApprovalsWorkflowEnabled(SProcessing) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;


    procedure IsSalaryProcessingApprovalsWorkflowEnabled(var SProcessing: Record "Salary Processing Headerr"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(SProcessing, SurestepWFEvents.RunWorkflowOnSendSalaryProcessingForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendSalaryProcessingForApproval(var SProcessing: Record "Salary Processing Headerr")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelSalaryProcessingApprovalRequest(var SProcessing: Record "Salary Processing Headerr")
    begin
    end;

    var
        SurestepWFEvents: Codeunit "Custom Workflow Events";
        NoWorkflowEnabledErr: Label 'No Approval workflow for this record type is enabled';
        WorkflowManagement: Codeunit "Workflow Management";
}
