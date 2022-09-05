#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50004 "Custom Workflow Events"
{

    trigger OnRun()
    begin
    end;

    var
        WFHandler: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        WFEventHandler: Codeunit "Workflow Event Handling";
        SurestepWFEvents: Codeunit "Custom Workflow Events";
        WFResponseHandler: Codeunit "Workflow Response Handling";

    procedure AddEventsToLib()
    begin

        //---------------------------------------------1. Approval Events--------------------------------------------------------------
        //Payment Header
        WFHandler.AddEventToLibrary(RunWorkflowOnSendPaymentDocForApprovalCode,
                                    Database::"Payments Header", 'Approval of a Payment Document is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPaymentApprovalRequestCode,
                                    Database::"Payments Header", 'An Approval request for a Payment Document is Canceled.', 0, false);

        //Membership Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMembershipApplicationForApprovalCode,
                                    Database::"Membership Applications", 'Approval of Membership Application is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode,
                                    Database::"Membership Applications", 'An Approval request for  Membership Application is canceled.', 0, false);
        //Loan Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanApplicationForApprovalCode,
                                    Database::"Loans Register", 'Approval of a Loan Application is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanApplicationApprovalRequestCode,
                                    Database::"Loans Register", 'An Approval request for a Loan Application is canceled.', 0, false);
        //Guarantor Substitution
        WFHandler.AddEventToLibrary(RunWorkflowOnSendGuarantorSubstitutionForApprovalCode,
                                    Database::"Guarantorship Substitution H", 'Approval of a Guarantor Substitution is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelGuarantorSubstitutionApprovalRequestCode,
                                    Database::"Guarantorship Substitution H", 'An Approval request for a Guarantor Substitution is Canceled.', 0, false);

        //Loan Disbursement
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanDisbursementForApprovalCode,
                                    Database::"Loan Disburesment-Batching", 'Approval of a Loan Disbursement is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanDisbursementApprovalRequestCode,
                                    Database::"Loan Disburesment-Batching", 'An Approval request for a Loan Disbursement is canceled.', 0, false);

        //Standing Orders
        WFHandler.AddEventToLibrary(RunWorkflowOnSendStandingOrderForApprovalCode,
                                    Database::"Standing Orders", 'Approval of a Standing Order is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelStandingOrderApprovalRequestCode,
                                    Database::"Standing Orders", 'An Approval request for a Standing Order is canceled.', 0, false);

        //Membership Withdrawal
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMWithdrawalForApprovalCode,
                                    Database::"Membership Exit", 'Approval of a Membership Withdrawal is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMWithdrawalApprovalRequestCode,
                                    Database::"Membership Exit", 'An Approval request for a Membership Withdrawal is canceled.', 0, false);
        //ATM Card Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendATMCardForApprovalCode,
                                    Database::"ATM Card Applications", 'Approval of  ATM Card is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelATMCardApprovalRequestCode,
                                    Database::"ATM Card Applications", 'An Approval request for  ATM Card is canceled.', 0, false);
        //Guarantor Recovery
        WFHandler.AddEventToLibrary(RunWorkflowOnSendGuarantorRecoveryForApprovalCode,
                                    Database::"Loan Recovery Header", 'Approval of Guarantor Recovery is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode,
                                    Database::"Loan Recovery Header", 'An Approval request for Guarantor Recovery is canceled.', 0, false);

        //Change Request
        WFHandler.AddEventToLibrary(RunWorkflowOnSendChangeRequestForApprovalCode,
                                    Database::"Change Request", 'Approval of Change Request is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelChangeRequestApprovalRequestCode,
                                    Database::"Change Request", 'An Approval request for Change Request is canceled.', 0, false);

        //Treasury Transactions
        WFHandler.AddEventToLibrary(RunWorkflowOnSendTTransactionsForApprovalCode,
                                    Database::"Treasury Transactions", 'Approval of Treasury Transaction is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelTTransactionsApprovalRequestCode,
                                    Database::"Treasury Transactions", 'An Approval request for Treasury Transaction is canceled.', 0, false);

        //FOSA Account Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendFAccountApplicationForApprovalCode,
                                    Database::"FOSA Account Applicat. Details", 'Approval of FOSA Account Application is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelFAccountApplicationApprovalRequestCode,
                                    Database::"FOSA Account Applicat. Details", 'An Approval request for FOSA Account Application is canceled.', 0, false);
        //Stores Requisition
        // WFHandler.AddEventToLibrary(RunWorkflowOnSendSReqApplicationForApprovalCode,
        //                             Database::"Store Requistion Header", 'Approval of Stores Requisition Application is Requested.', 0, false);
        // WFHandler.AddEventToLibrary(RunWorkflowOnCancelSReqApplicationApprovalRequestCode,
        //                             Database::"Store Requistion Header", 'An Approval request for Stores Requisition Application is canceled.', 0, false);

        //Sacco Transfer
        WFHandler.AddEventToLibrary(RunWorkflowOnSendSaccoTransferForApprovalCode,
                                    Database::"Sacco Transfers", 'Approval of Sacco Transfer is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelSaccoTransferApprovalRequestCode,
                                    Database::"Sacco Transfers", 'An Approval request for Sacco Transfer is canceled.', 0, false);

        //Cheque Discounting
        WFHandler.AddEventToLibrary(RunWorkflowOnSendChequeDiscountingForApprovalCode,
                                    Database::"Cheque Discounting", 'Approval of Cheque Discounting is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelChequeDiscountingApprovalRequestCode,
                                    Database::"Cheque Discounting", 'An Approval request for Cheque Discounting is canceled.', 0, false);
        //Imprest Requisition
        WFHandler.AddEventToLibrary(RunWorkflowOnSendImprestRequisitionForApprovalCode,
                                    Database::"Imprest Header", 'Approval of Imprest Requisition is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelImprestRequisitionApprovalRequestCode,
                                    Database::"Imprest Header", 'An Approval request for Imprest Requisition is canceled.', 0, false);
        //Imprest Surrender
        WFHandler.AddEventToLibrary(RunWorkflowOnSendImprestSurrenderForApprovalCode,
                                    Database::"Imprest Surrender Header", 'Approval of Imprest Surrender is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelImprestSurrenderApprovalRequestCode,
                                    Database::"Imprest Surrender Header", 'An Approval request for Imprest Surrender is canceled.', 0, false);
        //Leave Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLeaveApplicationForApprovalCode,
                                    Database::"HR Leave Application", 'Approval of Leave Application is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLeaveApplicationApprovalRequestCode,
                                    Database::"HR Leave Application", 'An Approval request for Leave Application is canceled.', 0, false);

        //Bulk Withdrawal
        WFHandler.AddEventToLibrary(RunWorkflowOnSendBulkWithdrawalForApprovalCode,
                                    Database::"Bulk Withdrawal Application", 'Approval of  Bulk Withdrawal is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode,
                                    Database::"Bulk Withdrawal Application", 'An Approval request for  Bulk Withdrawal is canceled.', 0, false);

        //Package Lodging
        WFHandler.AddEventToLibrary(RunWorkflowOnSendPackageLodgeForApprovalCode,
                                    Database::"Safe Custody Package Register", 'Approval of  Package Lodging is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPackageLodgeApprovalRequestCode,
                                    Database::"Safe Custody Package Register", 'An Approval request for  Package Lodging is canceled.', 0, false);

        //Package Retrieval
        WFHandler.AddEventToLibrary(RunWorkflowOnSendPackageRetrievalForApprovalCode,
                                    Database::"Package Retrieval Register", 'Approval of  Package Retrieval is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPackageRetrievalApprovalRequestCode,
                                    Database::"Package Retrieval Register", 'An Approval request for  Package Retrieval is canceled.', 0, false);

        //House Change
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHouseChangeForApprovalCode,
                                    Database::"House Group Change Request", 'Approval of  House Change is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHouseChangeApprovalRequestCode,
                                    Database::"House Group Change Request", 'An Approval request for  House Change is canceled.', 0, false);

        //CRM Training
        WFHandler.AddEventToLibrary(RunWorkflowOnSendCRMTrainingForApprovalCode,
                                    Database::"CRM Trainings", 'Approval of  CRM Training is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelCRMTrainingApprovalRequestCode,
                                    Database::"CRM Trainings", 'An Approval request for  CRM Training is canceled.', 0, false);

        //Petty Cash
        WFHandler.AddEventToLibrary(RunWorkflowOnSendPettyCashForApprovalCode,
                                    Database::"Payment Header.", 'Approval of  Petty Cash is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPettyCashApprovalRequestCode,
                                    Database::"Payment Header.", 'An Approval request for  Petty Cash is canceled.', 0, false);

        //Staff Claims
        WFHandler.AddEventToLibrary(RunWorkflowOnSendStaffClaimsForApprovalCode,
                                    Database::"Staff Claims Header", 'Approval of  Staff Claims is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelStaffClaimsApprovalRequestCode,
                                    Database::"Staff Claims Header", 'An Approval request for  Staff Claims is canceled.', 0, false);

        //Member Agent/NOK Change
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode,
                                    Database::"Member Agent/Next Of Kin Chang", 'Approval of  Member Agent/NOK Change is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode,
                                    Database::"Member Agent/Next Of Kin Chang", 'An Approval request for  Member Agent/NOK Change is canceled.', 0, false);

        //House Registration
        WFHandler.AddEventToLibrary(RunWorkflowOnSendHouseRegistrationForApprovalCode,
                                    Database::"House Groups Registration", 'Approval of  House Registration is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelHouseRegistrationApprovalRequestCode,
                                    Database::"House Groups Registration", 'An Approval request for House Registration is canceled.', 0, false);

        //Loan PayOff
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanPayOffForApprovalCode,
                                    Database::"Loan PayOff", 'Approval of  Loan PayOff is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanPayOffApprovalRequestCode,
                                    Database::"Loan PayOff", 'An Approval request for Loan PayOff  is canceled.', 0, false);

        //Fixed Deposit Placement
        WFHandler.AddEventToLibrary(RunWorkflowOnSendFixedDepositForApprovalCode,
                                    Database::"Fixed Deposit Placement", 'Approval of  Fixed Deposit is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelFixedDepositApprovalRequestCode,
                                    Database::"Fixed Deposit Placement", 'An Approval request for Fixed Deposit  is canceled.', 0, false);

        //EFT/RTGS Approval
        WFHandler.AddEventToLibrary(RunWorkflowOnSendEFTRTGSForApprovalCode,
                                    Database::"EFT Details", 'Approval of  EFT/RTGS is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelEFTRTGSApprovalRequestCode,
                                    Database::"EFT Details", 'An Approval request for EFT/RTGS   is canceled.', 0, false);
        //Loan Demand Notice
        WFHandler.AddEventToLibrary(RunWorkflowOnSendDemandNoticeForApprovalCode,
                                    Database::"Default Notices Register", 'Approval of  Loan Demand Notice is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCanceDemandNoticeApprovalRequestCode,
                                    Database::"Default Notices Register", 'An Approval request for Loan Demand Notice is canceled.', 0, false);

        //Over Draft
        // WFHandler.AddEventToLibrary(RunWorkflowOnSendOverDraftForApprovalCode,
        //                             Database::"OverDraft Application", 'Approval of  Over Draft is Requested.', 0, false);
        // WFHandler.AddEventToLibrary(RunWorkflowOnCancelOverDraftApprovalRequestCode,
        //                             Database::"OverDraft Application", 'An Approval request for Over Draft is canceled.', 0, false);

        //Loan Restructure
        // WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanRestructureForApprovalCode,
        //                             Database::"Loan Restructure", 'Approval of  Loan Restructure is Requested.', 0, false);
        // WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanRestructureApprovalRequestCode,
        //                             Database::"Loan Restructure", 'An Approval request for Loan Restructure is canceled.', 0, false);

        //Sweeping Instructions
        // WFHandler.AddEventToLibrary(RunWorkflowOnSendSweepingInstructionsForApprovalCode,
        //                             Database::"Member Sweeping Instructions", 'Approval of  Sweeping Instructions is Requested.', 0, false);
        // WFHandler.AddEventToLibrary(RunWorkflowOnCancelSweepingInstructionsApprovalRequestCode,
        //                             Database::"Member Sweeping Instructions", 'An Approval request for Sweeping Instructions is canceled.', 0, false);

        //Cheque Book
        WFHandler.AddEventToLibrary(RunWorkflowOnSendChequeBookForApprovalCode,
                                    Database::"Cheque Book Application", 'Approval of  Cheque Book is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelChequeBookApprovalRequestCode,
                                    Database::"Cheque Book Application", 'An Approval request for Cheque Book is canceled.', 0, false);

        //Loan Trunch Disbursement
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode,
                                    Database::"Loan trunch Disburesment", 'Approval of  Loan Trunch is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode,
                                    Database::"Loan trunch Disburesment", 'An Approval request for Loan Trunch is canceled.', 0, false);

        //Inward Cheque Clearing
        WFHandler.AddEventToLibrary(RunWorkflowOnSendInwardChequeClearingForApprovalCode,
                                    Database::"Cheque Receipts-Family", 'Approval of  Inward Cheque Clearing is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelInwardChequeClearingApprovalRequestCode,
                                    Database::"Cheque Receipts-Family", 'An Approval request for Inward Cheque Clearing is canceled.', 0, false);

        //Invalid Paybill Transactions
        WFHandler.AddEventToLibrary(RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode,
                                    Database::"Paybill Processing Header", 'Approval of  Invalid Paybill Deposit is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequestCode,
                                    Database::"Paybill Processing Header", 'An Approval request for Invalid Paybill Deposit is canceled.', 0, false);

        //Internal PV
        // WFHandler.AddEventToLibrary(RunWorkflowOnSendInternalPVForApprovalCode,
        //                             Database::"Internal PV Header", 'Approval of  Internal PV  is Requested.', 0, false);
        // WFHandler.AddEventToLibrary(RunWorkflowOnCancelInternalPVApprovalRequestCode,
        //                             Database::"Internal PV Header", 'An Approval request for Internal PV is canceled.', 0, false);

        //Salary Processing
        WFHandler.AddEventToLibrary(RunWorkflowOnSendSalaryProcessingForApprovalCode,
                                    Database::"Salary Processing Headerr", 'Approval of  Salary Processing  is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelSalaryProcessingApprovalRequestCode,
                                    Database::"Salary Processing Headerr", 'An Approval request for Salary Processing is canceled.', 0, false);

        //-------------------------------------------End Approval Events-------------------------------------------------------------
    end;


    procedure AddEventsPredecessor()
    begin
        //--------------------------------------1.Approval,Rejection,Delegation Predecessors------------------------------------------------
        //Payment Header
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPaymentDocForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPaymentDocForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPaymentDocForApprovalCode);

        //Membership Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);

        //Loan Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanApplicationForApprovalCode);

        //Guarantor Substitution
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);

        //Loan Disbursement
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanDisbursementForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanDisbursementForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanDisbursementForApprovalCode);

        //Standing Order
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendStandingOrderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendStandingOrderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendStandingOrderForApprovalCode);

        //Membership Withdrawal
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMWithdrawalForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMWithdrawalForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMWithdrawalForApprovalCode);

        //ATM Card Applications
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendATMCardForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendATMCardForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendATMCardForApprovalCode);

        //Guarantor Recovery
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendGuarantorRecoveryForApprovalCode);

        //Change Request
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendChangeRequestForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendChangeRequestForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendChangeRequestForApprovalCode);

        //Treasury Transaction
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendTTransactionsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendTTransactionsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendTTransactionsForApprovalCode);

        //FOSA Account Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendFAccountApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendFAccountApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendFAccountApplicationForApprovalCode);

        //Stores Requisition
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSReqApplicationForApprovalCode);
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSReqApplicationForApprovalCode);
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendSReqApplicationForApprovalCode);

        //Sacco Transfer
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSaccoTransferForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSaccoTransferForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendSaccoTransferForApprovalCode);

        //Cheque Discounting
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendChequeDiscountingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendChequeDiscountingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendChequeDiscountingForApprovalCode);

        //Imprest Requisition
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendImprestRequisitionForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendImprestRequisitionForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendImprestRequisitionForApprovalCode);

        //Imprest Surrender
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendImprestSurrenderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendImprestSurrenderForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendImprestSurrenderForApprovalCode);

        //Leave Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLeaveApplicationForApprovalCode);

        //Bulk Withdrawal
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendBulkWithdrawalForApprovalCode);

        //Package Lodging
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPackageLodgeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPackageLodgeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPackageLodgeForApprovalCode);

        //Package Retrieval
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPackageRetrievalForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPackageRetrievalForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPackageRetrievalForApprovalCode);

        //House Change
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHouseChangeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHouseChangeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHouseChangeForApprovalCode);

        //CRM Training
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendCRMTrainingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendCRMTrainingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendCRMTrainingForApprovalCode);

        //Petty Cash
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPettyCashForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPettyCashForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPettyCashForApprovalCode);

        //Staff Claims
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendStaffClaimsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendStaffClaimsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendStaffClaimsForApprovalCode);

        //Member Agent/NOK Change
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);

        //House Registration
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHouseRegistrationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHouseRegistrationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHouseRegistrationForApprovalCode);

        //Loan Payoff
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanPayOffForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanPayOffForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanPayOffForApprovalCode);

        //Fixed Deposit
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendFixedDepositForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendFixedDepositForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendFixedDepositForApprovalCode);

        //EFT/RTGS
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendEFTRTGSForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendEFTRTGSForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendEFTRTGSForApprovalCode);

        //Loan Demand Notice
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendDemandNoticeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendDemandNoticeForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendDemandNoticeForApprovalCode);

        //Over Draft
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendOverDraftForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendOverDraftForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendOverDraftForApprovalCode);

        //Loan Restructure
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanRestructureForApprovalCode);
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanRestructureForApprovalCode);
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanRestructureForApprovalCode);

        // //Sweeping Instructions
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSweepingInstructionsForApprovalCode);
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSweepingInstructionsForApprovalCode);
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendSweepingInstructionsForApprovalCode);

        //Cheque Book Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendChequeBookForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendChequeBookForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendChequeBookForApprovalCode);

        //Loan Trunch Disbursement
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);

        //Inward Cheque Clearing
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendInwardChequeClearingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendInwardChequeClearingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendInwardChequeClearingForApprovalCode);

        //Invalid Paybill Deposits
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);

        //Internal PV
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendInternalPVForApprovalCode);
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendInternalPVForApprovalCode);
        // WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendInternalPVForApprovalCode);

        //Salary Processing
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSalaryProcessingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSalaryProcessingForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendSalaryProcessingForApprovalCode);



        //---------------------------------------End Approval,Rejection,Delegation Predecessors---------------------------------------------
    end;


    procedure RunWorkflowOnSendPaymentDocForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPaymentDocForApproval'));
    end;


    procedure RunWorkflowOnCancelPaymentApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPaymentApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendPaymentDocForApproval', '', false, false)]

    procedure RunWorkflowOnSendPaymentDocForApproval(var PaymentHeader: Record "Payments Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPaymentDocForApprovalCode, PaymentHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPaymentApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPaymentApprovalRequest(var PaymentHeader: Record "Payments Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPaymentApprovalRequestCode, PaymentHeader);
    end;


    procedure RunWorkflowOnSendMembershipApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMembershipApplicationForApproval'));
    end;


    procedure RunWorkflowOnCancelMembershipApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMembershipApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendMembershipApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendMembershipApplicationForApproval(var MembershipApplication: Record "Membership Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMembershipApplicationForApprovalCode, MembershipApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelMembershipApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelMembershipApplicationApprovalRequest(var MembershipApplication: Record "Membership Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode, MembershipApplication);
    end;


    procedure RunWorkflowOnSendLoanApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanApplicationForApproval'));
    end;


    procedure RunWorkflowOnCancelLoanApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLoanApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanApplicationForApproval(var LoanApplication: Record "Loans Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanApplicationForApprovalCode, LoanApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLoanApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanApplicationApprovalRequest(var LoanApplication: Record "Loans Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanApplicationApprovalRequestCode, LoanApplication);
    end;


    procedure RunWorkflowOnSendGuarantorSubstitutionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendGuarantorSubstitutionForApproval'));
    end;


    procedure RunWorkflowOnCancelGuarantorSubstitutionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelGuarantorSubstitutionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendGuarantorSubstitutionForApproval', '', false, false)]

    procedure RunWorkflowOnSendGuarantorSubstitutionForApproval(var GuarantorshipSubstitution: Record "Guarantorship Substitution H")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendGuarantorSubstitutionForApprovalCode, GuarantorshipSubstitution);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelGuarantorSubstitutionApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelGuarantorSubstitutionApprovalRequest(var GuarantorshipSubstitution: Record "Guarantorship Substitution H")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelGuarantorSubstitutionApprovalRequestCode, GuarantorshipSubstitution);
    end;


    procedure RunWorkflowOnSendLoanDisbursementForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanDisbursementForApproval'));
    end;


    procedure RunWorkflowOnCancelLoanDisbursementApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanDisbursementApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLoanDisbursementForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanDisbursementForApproval(var LoanDisbursement: Record "Loan Disburesment-Batching")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanDisbursementForApprovalCode, LoanDisbursement);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLoanDisbursementApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanDisbursementApprovalRequest(var LoanDisbursement: Record "Loan Disburesment-Batching")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanDisbursementApprovalRequestCode, LoanDisbursement);
    end;


    procedure RunWorkflowOnSendStandingOrderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStandingOrderForApproval'));
    end;


    procedure RunWorkflowOnCancelStandingOrderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelStandingOrderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendStandingOrderForApproval', '', false, false)]

    procedure RunWorkflowOnSendStandingOrderForApproval(var StandingOrder: Record "Standing Orders")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStandingOrderForApprovalCode, StandingOrder);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelStandingOrderApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelStandingOrderApprovalRequest(var StandingOrder: Record "Standing Orders")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelStandingOrderApprovalRequestCode, StandingOrder);
    end;


    procedure RunWorkflowOnSendMWithdrawalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMWithdrawalForApproval'));
    end;


    procedure RunWorkflowOnCancelMWithdrawalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMWithdrawalApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendMWithdrawalForApproval', '', false, false)]

    procedure RunWorkflowOnSendMWithdrawalForApproval(var MWithdrawal: Record "Membership Exit")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMWithdrawalForApprovalCode, MWithdrawal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelMWithdrawalApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelMWithdrawalApprovalRequest(var MWithdrawal: Record "Membership Exit")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMWithdrawalApprovalRequestCode, MWithdrawal);
    end;


    procedure RunWorkflowOnSendATMCardForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendATMCardForApproval'));
    end;


    procedure RunWorkflowOnCancelATMCardApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelATMCardApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendATMCardForApproval', '', false, false)]

    procedure RunWorkflowOnSendATMCardForApproval(var ATMCard: Record "ATM Card Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendATMCardForApprovalCode, ATMCard);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelATMCardApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelATMCardApprovalRequest(var ATMCard: Record "ATM Card Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelATMCardApprovalRequestCode, ATMCard);
    end;


    procedure RunWorkflowOnSendGuarantorRecoveryForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendGuarantorRecoveryForApproval'));
    end;


    procedure RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelGuarantorRecoveryApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendGuarantorRecoveryForApproval', '', false, false)]

    procedure RunWorkflowOnSendGuarantorRecoveryForApproval(var GuarantorRecovery: Record "Loan Recovery Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendGuarantorRecoveryForApprovalCode, GuarantorRecovery);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelGuarantorRecoveryApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelGuarantorRecoveryApprovalRequest(var GuarantorRecovery: Record "Loan Recovery Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode, GuarantorRecovery);
    end;


    procedure RunWorkflowOnSendChangeRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendChangeRequestForApproval'));
    end;


    procedure RunWorkflowOnCancelChangeRequestApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelChangeRequestApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendChangeRequestForApproval', '', false, false)]

    procedure RunWorkflowOnSendChangeRequestForApproval(var ChangeRequest: Record "Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendChangeRequestForApprovalCode, ChangeRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelChangeRequestApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelChangeRequestApprovalRequest(var ChangeRequest: Record "Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelChangeRequestApprovalRequestCode, ChangeRequest);
    end;


    procedure RunWorkflowOnSendTTransactionsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTTransactionsForApproval'));
    end;


    procedure RunWorkflowOnCancelTTransactionsApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTTransactionsApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendTTransactionsForApproval', '', false, false)]

    procedure RunWorkflowOnSendTTransactionsForApproval(var TTransactions: Record "Treasury Transactions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTTransactionsForApprovalCode, TTransactions);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelTTransactionsApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelTTransactionsApprovalRequest(var TTransactions: Record "Treasury Transactions")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTTransactionsApprovalRequestCode, TTransactions);
    end;


    procedure RunWorkflowOnSendFAccountApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFAccountApplicationForApproval'));
    end;


    procedure RunWorkflowOnCancelFAccountApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFAccountApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendFAccountApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendFAccountApplicationForApproval(var FAccount: Record "FOSA Account Applicat. Details")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFAccountApplicationForApprovalCode, FAccount);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelFAccountApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelFAccountApplicationApprovalRequest(var FAccount: Record "FOSA Account Applicat. Details")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFAccountApplicationApprovalRequestCode, FAccount);
    end;


    // procedure RunWorkflowOnSendSReqApplicationForApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendSReqApplicationForApproval'));
    // end;


    // procedure RunWorkflowOnCancelSReqApplicationApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelSReqApplicationApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendSReqApplicationForApproval', '', false, false)]

    // procedure RunWorkflowOnSendSReqApplicationForApproval(var SReq: Record "Store Requistion Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendSReqApplicationForApprovalCode, SReq);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelSReqApplicationApprovalRequest', '', false, false)]

    // procedure RunWorkflowOnCancelSReqApplicationApprovalRequest(var SReq: Record "Store Requistion Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelSReqApplicationApprovalRequestCode, SReq);
    // end;


    procedure RunWorkflowOnSendSaccoTransferForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSaccoTransferForApproval'));
    end;


    procedure RunWorkflowOnCancelSaccoTransferApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSaccoTransferApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendSaccoTransferForApproval', '', false, false)]

    procedure RunWorkflowOnSendSaccoTransferForApproval(var SaccoTransfer: Record "Sacco Transfers")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSaccoTransferForApprovalCode, SaccoTransfer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelSaccoTransferApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelSaccoTransferApprovalRequest(var SaccoTransfer: Record "Sacco Transfers")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSaccoTransferApprovalRequestCode, SaccoTransfer);
    end;


    procedure RunWorkflowOnSendChequeDiscountingForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendChequeDiscountingForApproval'));
    end;


    procedure RunWorkflowOnCancelChequeDiscountingApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelChequeDiscountingApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendChequeDiscountingForApproval', '', false, false)]

    procedure RunWorkflowOnSendChequeDiscountingForApproval(var ChequeDiscounting: Record "Cheque Discounting")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendChequeDiscountingForApprovalCode, ChequeDiscounting);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelChequeDiscountingApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelChequeDiscountingApprovalRequest(var ChequeDiscounting: Record "Cheque Discounting")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelChequeDiscountingApprovalRequestCode, ChequeDiscounting);
    end;


    procedure RunWorkflowOnSendImprestRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendImprestRequisitionForApproval'));
    end;


    procedure RunWorkflowOnCancelImprestRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelImprestRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendImprestRequisitionForApproval', '', false, false)]

    procedure RunWorkflowOnSendImprestRequisitionForApproval(var ImprestRequisition: Record "Imprest Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestRequisitionForApprovalCode, ImprestRequisition);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelImprestRequisitionApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelImprestRequisitionApprovalRequest(var ImprestRequisition: Record "Imprest Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestRequisitionApprovalRequestCode, ImprestRequisition);
    end;


    procedure RunWorkflowOnSendImprestSurrenderForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendImprestSurrenderForApproval'));
    end;


    procedure RunWorkflowOnCancelImprestSurrenderApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelImprestSurrenderApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendImprestSurrenderForApproval', '', false, false)]

    procedure RunWorkflowOnSendImprestSurrenderForApproval(var ImprestSurrender: Record "Imprest Surrender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestSurrenderForApprovalCode, ImprestSurrender);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelImprestSurrenderApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelImprestSurrenderApprovalRequest(var ImprestSurrender: Record "Imprest Surrender Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestSurrenderApprovalRequestCode, ImprestSurrender);
    end;


    procedure RunWorkflowOnSendLeaveApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLeaveApplicationForApproval'));
    end;


    procedure RunWorkflowOnCancelLeaveApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLeaveApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLeaveApplicationForApproval', '', false, false)]

    procedure RunWorkflowOnSendLeaveApplicationForApproval(var LeaveApplication: Record "HR Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveApplicationForApprovalCode, LeaveApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLeaveApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLeaveApplicationApprovalRequest(var LeaveApplication: Record "HR Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveApplicationApprovalRequestCode, LeaveApplication);
    end;


    procedure RunWorkflowOnSendPVForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPVForApproval'));
    end;


    procedure RunWorkflowOnCancelPVApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPVApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendPVForApproval', '', false, false)]

    procedure RunWorkflowOnSendPVForApproval(var PaymentsHeader: Record "Payments Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPVForApprovalCode, PaymentsHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPVApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPVApprovalRequest(var PaymentsHeader: Record "Payments Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPVApprovalRequestCode, PaymentsHeader);
    end;


    procedure RunWorkflowOnSendBulkWithdrawalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendBulkWithdrawalForApproval'));
    end;


    procedure RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBulkWithdrawalApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendBulkWithdrawalForApproval', '', false, false)]

    procedure RunWorkflowOnSendBulkWithdrawalForApproval(var BulkWithdrawal: Record "Bulk Withdrawal Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBulkWithdrawalForApprovalCode, BulkWithdrawal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelBulkWithdrawalApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelBulkWithdrawalApprovalRequest(var BulkWithdrawal: Record "Bulk Withdrawal Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode, BulkWithdrawal);
    end;


    procedure RunWorkflowOnSendPackageLodgeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPackageLodgeForApproval'));
    end;


    procedure RunWorkflowOnCancelPackageLodgeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPackageLodgeApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendPackageLodgeForApproval', '', false, false)]

    procedure RunWorkflowOnSendPackageLodgeForApproval(var PackageLodge: Record "Safe Custody Package Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPackageLodgeForApprovalCode, PackageLodge);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPackageLodgeApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPackageLodgeApprovalRequest(var PackageLodge: Record "Safe Custody Package Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPackageLodgeApprovalRequestCode, PackageLodge);
    end;


    procedure RunWorkflowOnSendPackageRetrievalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPackageRetrievalForApproval'));
    end;


    procedure RunWorkflowOnCancelPackageRetrievalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPackageRetrievalApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendPackageRetrievalForApproval', '', false, false)]

    procedure RunWorkflowOnSendPackageRetrievalForApproval(var PackageRetrieval: Record "Package Retrieval Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPackageRetrievalForApprovalCode, PackageRetrieval);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPackageRetrievalApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPackageRetrievalApprovalRequest(var PackageRetrieval: Record "Package Retrieval Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPackageRetrievalApprovalRequestCode, PackageRetrieval);
    end;


    procedure RunWorkflowOnSendPurchaseRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPurchaseRequisitionForApproval'));
    end;


    procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPurchaseRequisitionApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendPurchaseRequisitionForApproval', '', false, false)]

    procedure RunWorkflowOnSendPurchaseRequisitionForApproval(var PRequest: Record "Purchase Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPurchaseRequisitionForApprovalCode, PRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPurchaseRequisitionApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPurchaseRequisitionApprovalRequest(var PRequest: Record "Purchase Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPurchaseRequisitionApprovalRequestCode, PRequest);
    end;


    procedure RunWorkflowOnSendHouseChangeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHouseChangeForApproval'));
    end;


    procedure RunWorkflowOnCancelHouseChangeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHouseChangeApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendHouseChangeForApproval', '', false, false)]

    procedure RunWorkflowOnSendHouseChangeForApproval(var HouseChange: Record "House Group Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHouseChangeForApprovalCode, HouseChange);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelHouseChangeApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelHouseChangeApprovalRequest(var HouseChange: Record "House Group Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHouseChangeApprovalRequestCode, HouseChange);
    end;


    procedure RunWorkflowOnSendCRMTrainingForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendCRMTrainingForApproval'));
    end;


    procedure RunWorkflowOnCancelCRMTrainingApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelCRMTrainingApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendCRMTrainingForApproval', '', false, false)]

    procedure RunWorkflowOnSendCRMTrainingForApproval(var CRMTraining: Record "CRM Trainings")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendCRMTrainingForApprovalCode, CRMTraining);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelCRMTrainingApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelCRMTrainingApprovalRequest(var CRMTraining: Record "CRM Trainings")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelCRMTrainingApprovalRequestCode, CRMTraining);
    end;


    procedure RunWorkflowOnSendPettyCashForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPettyCashForApproval'));
    end;


    procedure RunWorkflowOnCancelPettyCashApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPettyCashApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendPettyCashForApproval', '', false, false)]

    procedure RunWorkflowOnSendPettyCashForApproval(var PettyCash: Record "Payment Header.")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPettyCashForApprovalCode, PettyCash);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPettyCashApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPettyCashApprovalRequest(var PettyCash: Record "Payment Header.")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPettyCashApprovalRequestCode, PettyCash);
    end;


    procedure RunWorkflowOnSendStaffClaimsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStaffClaimsForApproval'));
    end;


    procedure RunWorkflowOnCancelStaffClaimsApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelStaffClaimsApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendStaffClaimsForApproval', '', false, false)]

    procedure RunWorkflowOnSendStaffClaimsForApproval(var StaffClaims: Record "Staff Claims Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffClaimsForApprovalCode, StaffClaims);
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelPettyCashApprovalRequest', '', false, false)]

    // // procedure RunWorkflowOnCancelStaffClaimsApprovalRequest(var StaffClaims: Record "Staff Claims Header")
    // // begin
    // //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffClaimsApprovalRequestCode,StaffClaims);
    // // end;


    procedure RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMemberAgentNOKChangeForApproval'));
    end;


    procedure RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendMemberAgentNOKChangeForApproval', '', false, false)]

    procedure RunWorkflowOnSendMemberAgentNOKChangeForApproval(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode, MemberAgentNOKChange);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelMemberAgentNOKChangeApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequest(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode, MemberAgentNOKChange);
    end;


    procedure RunWorkflowOnSendHouseRegistrationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendHouseRegistrationForApproval'));
    end;


    procedure RunWorkflowOnCancelHouseRegistrationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelHouseRegistrationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendHouseRegistrationForApproval', '', false, false)]

    procedure RunWorkflowOnSendHouseRegistrationForApproval(var HouseRegistration: Record "House Groups Registration")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendHouseRegistrationForApprovalCode, HouseRegistration);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelHouseRegistrationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelHouseRegistrationApprovalRequest(var HouseRegistration: Record "House Groups Registration")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelHouseRegistrationApprovalRequestCode, HouseRegistration);
    end;


    procedure RunWorkflowOnSendLoanPayOffForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanPayOffForApproval'));
    end;


    procedure RunWorkflowOnCancelLoanPayOffApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanPayOffApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLoanPayOffForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanPayOffForApproval(var LoanPayOff: Record "Loan PayOff")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanPayOffForApprovalCode, LoanPayOff);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLoanPayOffApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanPayOffApprovalRequest(var LoanPayOff: Record "Loan PayOff")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanPayOffApprovalRequestCode, LoanPayOff);
    end;


    procedure RunWorkflowOnSendFixedDepositForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFixedDepositForApproval'));
    end;


    procedure RunWorkflowOnCancelFixedDepositApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFixedDepositApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendFixedDepositForApproval', '', false, false)]

    procedure RunWorkflowOnSendFixedDepositForApproval(var FixedDeposit: Record "Fixed Deposit Placement")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFixedDepositForApprovalCode, FixedDeposit);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelFixedDepositApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelFixedDepositApprovalRequest(var FixedDeposit: Record "Fixed Deposit Placement")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFixedDepositApprovalRequestCode, FixedDeposit);
    end;


    procedure RunWorkflowOnSendEFTRTGSForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendEFTRTGSForApproval'));
    end;


    procedure RunWorkflowOnCancelEFTRTGSApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelEFTRTGSApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendEFTRTGSForApproval', '', false, false)]

    procedure RunWorkflowOnSendEFTRTGSForApproval(var EFTRTGS: Record "EFT Details")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendEFTRTGSForApprovalCode, EFTRTGS);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelEFTRTGSApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelEFTRTGSApprovalRequest(var EFTRTGS: Record "EFT Details")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelEFTRTGSApprovalRequestCode, EFTRTGS);
    end;


    procedure RunWorkflowOnSendDemandNoticeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendDemandNoticeForApproval'));
    end;


    procedure RunWorkflowOnCanceDemandNoticeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelDemandNoticeApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendDemandNoticeForApproval', '', false, false)]

    procedure RunWorkflowOnSendDemandNoticeForApproval(var LDemand: Record "Default Notices Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendDemandNoticeForApprovalCode, LDemand);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelDemandNoticeApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelDemandNoticeApprovalRequest(var LDemand: Record "Default Notices Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCanceDemandNoticeApprovalRequestCode, LDemand);
    end;


    procedure RunWorkflowOnSendOverDraftForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendOverDraftForApproval'));
    end;


    // procedure RunWorkflowOnCancelOverDraftApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelOverDraftApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendOverDraftForApproval', '', false, false)]

    // procedure RunWorkflowOnSendOverDraftForApproval(var OverDraft: Record "OverDraft Application")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendOverDraftForApprovalCode, OverDraft);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelOverDraftApprovalRequest', '', false, false)]

    // procedure RunWorkflowOnCancelOverDraftApprovalRequest(var OverDraft: Record "OverDraft Application")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelOverDraftApprovalRequestCode, OverDraft);
    // end;


    // procedure RunWorkflowOnSendLoanRestructureForApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendLoanRestructureForApproval'));
    // end;


    // procedure RunWorkflowOnCancelLoanRestructureApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelLoanRestructureApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLoanRestructureForApproval', '', false, false)]

    // procedure RunWorkflowOnSendLoanRestructureForApproval(var LoanRestructure: Record "Loan Rescheduling")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanRestructureForApprovalCode, LoanRestructure);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLoanRestructureApprovalRequest', '', false, false)]

    // procedure RunWorkflowOnCancelLoanRestructureApprovalRequest(var LoanRestructure: Record "Loan Rescheduling")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanRestructureApprovalRequestCode, LoanRestructure);
    // end;


    // procedure RunWorkflowOnSendSweepingInstructionsForApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendSweepingInstructionsForApproval'));
    // end;


    // procedure RunWorkflowOnCancelSweepingInstructionsApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelSweepingInstructionsApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendSweepingInstructionsForApproval', '', false, false)]

    // procedure RunWorkflowOnSendSweepingInstructionsForApproval(var SweepingInstructions: Record "Member Sweeping Instructions")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendSweepingInstructionsForApprovalCode, SweepingInstructions);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelSweepingInstructionsApprovalRequest', '', false, false)]

    // procedure RunWorkflowOnCancelSweepingInstructionsApprovalRequest(var SweepingInstructions: Record "Member Sweeping Instructions")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelSweepingInstructionsApprovalRequestCode, SweepingInstructions);
    // end;


    procedure RunWorkflowOnSendChequeBookForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnChequeBookForApproval'));
    end;


    procedure RunWorkflowOnCancelChequeBookApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelChequeBookApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendChequeBookForApproval', '', false, false)]

    procedure RunWorkflowOnSendChequeBookForApproval(var ChequeBook: Record "Cheque Book Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendChequeBookForApprovalCode, ChequeBook);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelChequeBookApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelChequeBookApprovalRequest(var ChequeBook: Record "Cheque Book Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelChequeBookApprovalRequestCode, ChequeBook);
    end;


    procedure RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnLoanTrunchDisbursementForApproval'));
    end;


    procedure RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendLoanTrunchDisbursementForApproval', '', false, false)]

    procedure RunWorkflowOnSendLoanTrunchDisbursementForApproval(var LoanTrunchDisbursement: Record "Loan trunch Disburesment")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode, LoanTrunchDisbursement);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelLoanTrunchDisbursementApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequest(var LoanTrunchDisbursement: Record "Loan trunch Disburesment")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode, LoanTrunchDisbursement);
    end;


    procedure RunWorkflowOnSendInwardChequeClearingForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnInwardChequeClearingForApproval'));
    end;


    procedure RunWorkflowOnCancelInwardChequeClearingApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelInwardChequeClearingApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendInwardChequeClearingForApproval', '', false, false)]

    procedure RunWorkflowOnSendInwardChequeClearingForApproval(var InwardChequeClearing: Record "Cheque Receipts-Family")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendInwardChequeClearingForApprovalCode, InwardChequeClearing);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelInwardChequeClearingApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelInwardChequeClearingApprovalRequest(var InwardChequeClearing: Record "Cheque Receipts-Family")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode, InwardChequeClearing);
    end;


    procedure RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnInvalidPaybillTransactionsForApproval'));
    end;


    procedure RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequest'));
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendInvalidPaybillTransactionsForApproval', '', false, false)]

    procedure RunWorkflowOnSendInvalidPaybillTransactionsForApproval(var InvalidPaybillTransactions: Record "Paybill Processing Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode, InvalidPaybillTransactions);
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelInvalidPaybillTransactionsApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequest(var InvalidPaybillTransactions: Record "Paybill Processing Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequestCode, InvalidPaybillTransactions);
    end;


    // procedure RunWorkflowOnSendInternalPVForApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnInternalPVForApproval'));
    // end;


    // procedure RunWorkflowOnCancelInternalPVApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelInternalPVApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendInternalPVForApproval', '', false, false)]

    // procedure RunWorkflowOnSendInternalPVForApproval(var InternalPV: Record "Internal PV Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendInternalPVForApprovalCode, InternalPV);
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelInternalPVApprovalRequest', '', false, false)]

    // procedure RunWorkflowOnCancelInternalPVApprovalRequest(var InternalPV: Record "Internal PV Header")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelInternalPVApprovalRequestCode, InternalPV);
    // end;


    procedure RunWorkflowOnSendSalaryProcessingForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSalaryProcessingForApproval'));
    end;


    procedure RunWorkflowOnCancelSalaryProcessingApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSalaryProcessingApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendSalaryProcessingForApproval', '', false, false)]

    procedure RunWorkflowOnSendSalaryProcessingForApproval(var SProcessing: Record "Salary Processing Headerr")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSalaryProcessingForApprovalCode, SProcessing);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelSalaryProcessingApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelSalaryProcessingApprovalRequest(var SProcessing: Record "Salary Processing Headerr")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSalaryProcessingApprovalRequestCode, SProcessing);
    end;


    // procedure RunWorkflowOnSendPaymentReceiptForApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendMembershipApplicationForApproval'));
    // end;


    // procedure RunWorkflowOnCancelPaymentReceiptApprovalRequestCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelMembershipApplicationApprovalRequest'));
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnSendMembershipApplicationForApproval', '', false, false)]

    // procedure RunWorkflowOnPaymentReceiptForApproval(var MembershipApplication: Record "Membership Applications")
    // begin
    //     WorkflowManagement.HandleEvent(RunWorkflowOnSendMembershipApplicationForApprovalCode, MembershipApplication);
    // end;

    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnExecuteWorkflowResponse', '', false, false)]
    procedure addresponses(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    begin
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                         SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanApplicationApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::WorkflowIntegration, 'OnCancelMembershipApplicationApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelPaymentReceiptApprovalRequest(var MembershipApplication: Record "Membership Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode, MembershipApplication);
    end;



    procedure SetStatusLoanAppStatusToPendingApprovalCode(): Code[128]
    begin
        exit(UpperCase('SetLoanAppStatusTopendingApproval'))
    end;

    procedure SetLoanAppStatusTopendingApproval(var variant: Variant)
    var
        RecRef: RecordRef;
        LoanApp: Record "Loans Register";
    begin
        RecRef.GetTable(variant);
        case
            RecRef.Number of
            DATABASE::"Loans Register":
                begin

                    RecRef.SetTable(LoanApp);
                    LoanApp.Validate("Approval Status", LoanApp."Approval Status"::Pending);
                    //  MembershipApp.Modify();
                    variant := LoanApp;

                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddResponsesToLib()
    var
        Workfloweventhandling: Codeunit "Workflow Response Handling";
    begin
        Workfloweventhandling.AddResponseToLibrary(SetStatusLoanAppStatusToPendingApprovalCode(), 0, 'Set status to pending', 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::codeunit, codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExecuteResponses(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponses: Record "Workflow Response";
    begin
        if WorkflowResponses.Get(ResponseWorkflowStepInstance."Function Name") then
            case
                WorkflowResponses."Function Name" of
                SetStatusLoanAppStatusToPendingApprovalCode():
                    begin
                        SetLoanAppStatusTopendingApproval(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
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
        //  SReq: Record "Store Requistion Header";
        SaccoTransfers: Record "Sacco Transfers";
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
        //  InternalPV: Record "Internal PV Header";
        JournalBatch: Record "Gen. Journal Batch";
        SProcessing: Record "Salary Processing Headerr";
        GuarantorshipSubstitution: Record "Guarantorship Substitution H";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            //Payment Header
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    PaymentHeader.Validate(Status, PaymentHeader.Status::"Pending Approval");
                    PaymentHeader.Modify(true);
                    IsHandled := true;

                end;

            //Membership Application
            Database::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate(Status, MembershipApplication.Status::"Pending Approval");
                    MembershipApplication.Modify(true);

                    IsHandled := true;
                end;
            //Loan Application
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoanApplication);
                    LoanApplication.Validate("Loan Status", LoanApplication."loan status"::Appraisal);
                    LoanApplication.Validate("Approval Status", LoanApplication."approval status"::Pending);
                    IsHandled := true;
                    LoanApplication.Modify(true);
                end;
            //Guarantor substitutionn
            Database::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorshipSubstitution);
                    GuarantorshipSubstitution.Validate(Status, GuarantorshipSubstitution.Status::Pending);
                    GuarantorshipSubstitution.Modify;
                    Variant := GuarantorshipSubstitution;
                end;
            //Standing Order
            Database::"Standing Orders":
                begin
                    RecRef.SetTable(StandingOrder);
                    StandingOrder.Validate(Status, StandingOrder.Status::Pending);
                    StandingOrder.Modify(true);
                    Variant := StandingOrder;
                end;

            //Loan Disbursement
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanDisbursement);
                    LoanDisbursement.Validate(Status, LoanDisbursement.Status::"Pending Approval");
                    LoanDisbursement.Modify(true);
                    IsHandled := true;
                end;

            //Membership Withdrawal
            Database::"Membership Exit":
                begin
                    RecRef.SetTable(MWithdrawal);
                    MWithdrawal.Validate(Status, MWithdrawal.Status::Pending);
                    MWithdrawal.Modify(true);
                    IsHandled := true;
                end;

            //ATM Card
            Database::"ATM Card Applications":
                begin
                    RecRef.SetTable(ATMCard);
                    ATMCard.Validate(Status, ATMCard.Status::Pending);
                    ATMCard.Modify(true);
                    IsHandled := true;
                end;

            //Guarantor Recovery
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(GuarantorR);
                    GuarantorR.Validate(Status, GuarantorR.Status::Pending);
                    GuarantorR.Modify(true);
                    IsHandled := true;
                end;

            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Validate(Status, ChangeRequest.Status::Pending);
                    ChangeRequest.Modify(true);
                    IsHandled := true;
                end;

            //Treasury Transaction
            Database::"Treasury Transactions":
                begin
                    RecRef.SetTable(TTransactions);
                    TTransactions.Validate(Status, TTransactions.Status::"Pending Approval");
                    TTransactions.Modify(true);
                    IsHandled := true;
                end;
            //FOSA Account Application
            Database::"FOSA Account Applicat. Details":
                begin
                    RecRef.SetTable(FAccount);
                    FAccount.Validate(Status, FAccount.Status::Pending);
                    FAccount.Modify(true);
                    IsHandled := true;
                end;

            //Stores Requisition
            // Database::"Store Requistion Header":
            //     begin
            //         RecRef.SetTable(SReq);
            //         SReq.Validate(Status, SReq.Status::"Pending Approval");
            //         SReq.Modify(true);
            //         IsHandled := true;
            //     end;
            //Sacco Transfers
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Validate(Status, SaccoTransfers.Status::"Pending Approval");
                    SaccoTransfers.Modify(true);
                    IsHandled := true;
                end;
            //Cheque Discounting
            Database::"Cheque Discounting":
                begin
                    RecRef.SetTable(ChequeDiscounting);
                    ChequeDiscounting.Validate(Status, ChequeDiscounting.Status::"Pending Approval");
                    ChequeDiscounting.Modify(true);
                    IsHandled := true;
                end;
            //Imprest Requisition
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ImprestRequisition.Validate(Status, ImprestRequisition.Status::"Pending Approval");
                    ImprestRequisition.Modify(true);
                    IsHandled := true;
                end;
            //Imprest Surrender
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Validate(Status, ImprestSurrender.Status::"Pending Approval");
                    ImprestSurrender.Modify(true);
                    IsHandled := true;
                end;
            //Leave Application
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Validate(Status, LeaveApplication.Status::"Pending Approval");
                    LeaveApplication.Modify(true);
                    IsHandled := true;
                end;
            //Bulk Withdrawal
            Database::"Bulk Withdrawal Application":
                begin
                    RecRef.SetTable(BulkWithdrawal);
                    BulkWithdrawal.Validate(Status, BulkWithdrawal.Status::"Pending Approval");
                    BulkWithdrawal.Modify(true);
                    IsHandled := true;
                end;
            //Package Lodge
            Database::"Safe Custody Package Register":
                begin
                    RecRef.SetTable(PackageLodge);
                    PackageLodge.Validate(Status, PackageLodge.Status::"Pending Approval");
                    PackageLodge.Modify(true);
                    IsHandled := true;
                end;
            //Package Retrieval
            Database::"Package Retrieval Register":
                begin
                    RecRef.SetTable(PackageRetrieval);
                    PackageRetrieval.Validate(Status, PackageRetrieval.Status::"Pending Approval");
                    PackageRetrieval.Modify(true);
                    IsHandled := true;
                end;

            //House Change
            Database::"House Group Change Request":
                begin
                    RecRef.SetTable(HouseChange);
                    HouseChange.Validate(Status, HouseChange.Status::"Pending Approval");
                    HouseChange.Modify(true);
                    IsHandled := true;
                end;

            //CRM
            Database::"CRM Trainings":
                begin
                    RecRef.SetTable(CRMTraining);
                    CRMTraining.Validate(Status, CRMTraining.Status::Pending);
                    CRMTraining.Modify(true);
                    IsHandled := true;
                end;

            //Petty Cash
            Database::"Payment Header.":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Validate(Status, PettyCash.Status::"Pending Approval");
                    PettyCash.Modify(true);
                    IsHandled := true;
                end;

            //Staff Claims
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    StaffClaims.Validate(Status, StaffClaims.Status::"Pending Approval");
                    StaffClaims.Modify(true);
                    IsHandled := true;
                end;

            //Member Agent/NOK Change
            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    MemberAgentNOKChange.Validate(Status, MemberAgentNOKChange.Status::"Pending Approval");
                    MemberAgentNOKChange.Modify(true);
                    IsHandled := true;
                end;

            //House Registration
            Database::"House Groups Registration":
                begin
                    RecRef.SetTable(HouseRegistration);
                    HouseRegistration.Validate(Status, HouseRegistration.Status::"Pending Approval");
                    HouseRegistration.Modify(true);
                    IsHandled := true;
                end;

            //Loan PayOff
            Database::"Loan PayOff":
                begin
                    RecRef.SetTable(LoanPayOff);
                    LoanPayOff.Validate(Status, LoanPayOff.Status::"Pending Approval");
                    LoanPayOff.Modify(true);
                    IsHandled := true;
                end;

            //Fixed Deposit
            Database::"Fixed Deposit Placement":
                begin
                    RecRef.SetTable(FixedDeposit);
                    FixedDeposit.Validate(Status, FixedDeposit.Status::"Pending Approval");
                    FixedDeposit.Modify(true);
                    IsHandled := true;
                end;

            //EFTRTGS
            Database::"EFT Details":
                begin
                    RecRef.SetTable(EFTRTGS);
                    EFTRTGS.Validate(Status, EFTRTGS.Status::"Pending Approval");
                    EFTRTGS.Modify(true);
                    IsHandled := true;
                end;

            //Loan Demand Notices
            Database::"Default Notices Register":
                begin
                    RecRef.SetTable(LDemand);
                    LDemand.Validate(Status, LDemand.Status::"Pending Approval");
                    LDemand.Modify(true);
                    IsHandled := true;
                end;

            //Over Draft
            // Database::"OverDraft Application":
            //     begin
            //         RecRef.SetTable(OverDraft);
            //         OverDraft.Validate(Status, OverDraft.Status::"Pending Approval");
            //         OverDraft.Modify(true);
            //         IsHandled := true;
            //     end;

            //Loan Restructure
            // Database::"Loan Restructure":
            //     begin
            //         RecRef.SetTable(LoanRestructure);
            //         LoanRestructure.Validate(Status, LoanRestructure.Status::"Pending Approval");
            //         LoanRestructure.Modify(true);
            //         IsHandled := true;
            //     end;

            //Sweeping Instructions
            // Database::"Member Sweeping Instructions":
            //     begin
            //         RecRef.SetTable(SweepingInstructions);
            //         SweepingInstructions.Validate(Status, SweepingInstructions.Status::"Pending Approval");
            //         SweepingInstructions.Modify(true);
            //         IsHandled := true;
            //     end;

            //Cheque Book Application
            Database::"Cheque Book Application":
                begin
                    RecRef.SetTable(ChequeBook);
                    ChequeBook.Validate(Status, ChequeBook.Status::"Pending Approval");
                    ChequeBook.Modify(true);
                    IsHandled := true;
                end;


            //Loan Trunch
            Database::"Loan trunch Disburesment":
                begin
                    RecRef.SetTable(LoanTrunch);
                    LoanTrunch.Validate(Status, LoanTrunch.Status::Pending);
                    LoanTrunch.Modify(true);
                    IsHandled := true;
                end;

            //Inward Cheque Clearing
            Database::"Cheque Receipts-Family":
                begin
                    RecRef.SetTable(InwardChequeClearing);
                    InwardChequeClearing.Validate(Status, InwardChequeClearing.Status::"Pending Approval");
                    InwardChequeClearing.Modify(true);
                    IsHandled := true;
                end;

            //Invalid Paybill Transactions
            Database::"Paybill Processing Header":
                begin
                    RecRef.SetTable(InvalidPaybillTransactions);
                    InvalidPaybillTransactions.Validate(Status, InvalidPaybillTransactions.Status::"Pending Approval");
                    InvalidPaybillTransactions.Modify(true);
                    IsHandled := true;
                end;

            //Internal PV
            // Database::"Internal PV Header":
            //     begin
            //         RecRef.SetTable(InternalPV);
            //         InternalPV.Validate(Status, InternalPV.Status::"Pending Approval");
            //         InternalPV.Modify(true);
            //         IsHandled := true;
            //     end;

            //Journal Batch
            Database::"Gen. Journal Batch":
                begin
                    RecRef.SetTable(JournalBatch);
                    JournalBatch.Validate(Status, JournalBatch.Status::"Pending Approval");
                    JournalBatch.Modify(true);
                    IsHandled := true;
                end;

            //Salary Processing
            Database::"Salary Processing Headerr":
                begin
                    RecRef.SetTable(SProcessing);
                    SProcessing.Validate("Approval Status", SProcessing."Approval Status"::Pending);
                    SProcessing.Modify(true);
                    IsHandled := true;
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; Handled: boolean)

    var
        // RecRef: RecordRef;
        //Handled: Boolean;
        MemberShipApp: Record "Membership Applications";
        SaccoTransfers: Record "Sacco Transfers";
        MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang";
        HouseRegistration: Record "House Groups Registration";
        LaonApplication: Record "Loans Register";
        PettyCash: Record "Payment Header.";
        StandingOrder: Record "Standing Orders";
        MWithdrawal: Record "Membership Exit";
        StaffClaims: Record "Staff Claims Header";
        ImprestSurrender: Record "Imprest Surrender Header";
        ImprestRequisition: Record "Imprest Header";
        PRequest: Record "Purchase Header";
        LoanPayOff: Record "Loan PayOff";
        GuarantorRecovery: Record "Loan Recovery Header";
    begin
        // RecRef.GetTable();
        case RecRef.Number of
            DATABASE::"Membership Applications":
                begin
                    RecRef.SetTable(MemberShipApp);
                    MemberShipApp.Status := MemberShipApp.Status::Approved;
                    MemberShipApp.Modify(true);
                    Handled := true;
                end;
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Status := SaccoTransfers.Status::Approved;
                    SaccoTransfers.Modify(true);
                    Handled := true;
                end;
            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    MemberAgentNOKChange.Status := MemberAgentNOKChange.Status::Approved;
                    MemberAgentNOKChange.Modify(true);
                    Handled := true;
                end;

            Database::"House Groups Registration":
                begin
                    RecRef.SetTable(HouseRegistration);
                    HouseRegistration.Status := HouseRegistration.Status::Approved;
                    HouseRegistration.Modify(true);
                    Handled := true;
                end;
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LaonApplication);
                    LaonApplication."Approval Status" := LaonApplication."Approval Status"::Approved;
                    LaonApplication.Modify(true);
                    Handled := true;
                end;

            Database::"Payment Header.":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Status := PettyCash.Status::Approved;
                    PettyCash.Modify(true);
                    Handled := true;
                end;
            Database::"Standing Orders":
                begin
                    RecRef.SetTable(StandingOrder);
                    StandingOrder.Status := StandingOrder.Status::Approved;
                    StandingOrder.Modify(true);
                    Handled := true;
                end;
            Database::"Membership Exit":
                begin
                    RecRef.SetTable(MWithdrawal);
                    MWithdrawal.Status := MWithdrawal.Status::Approved;
                    MWithdrawal.Modify(true);
                    Handled := true;
                end;

            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    StaffClaims.Status := StaffClaims.Status::Approved;
                    StaffClaims.Modify(true);
                    Handled := true;
                end;

            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Status := ImprestSurrender.Status::Approved;
                    ImprestSurrender.Modify(true);
                    Handled := true;
                end;
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ImprestRequisition.Status := ImprestRequisition.Status::Approved;
                    ImprestRequisition.Modify(true);
                    Handled := true;
                end;
            Database::"Purchase Header":
                begin
                    RecRef.SetTable(PRequest);
                    PRequest.Status := PRequest.Status::Released;
                    PRequest.Modify(true);
                    Handled := true;

                end;
            Database::"Loan PayOff":
                begin
                    RecRef.SetTable(LoanPayOff);
                    LoanPayOff.Status := LoanPayOff.Status::Approved;
                    LoanPayOff.Modify(true);
                    Handled := true;
                end;
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(GuarantorRecovery);
                    GuarantorRecovery.Status := GuarantorRecovery.Status::Approved;
                    GuarantorRecovery.Modify(true);
                    Handled := true;
                end;
        end

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PaymentHeader: Record "Payments Header";
        SaccoTransfers: Record "Sacco Transfers";
        ObjMembership: Record "Membership Applications";
        ObjLoans: Record "Loans Register";
        ObjLoanPayoff: Record "Loan PayOff";
        // ObjLoanRestructure: Record "Loan Restructure";
        ObjSalaryProcessing: Record "Salary Processing Headerr";
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
        //LoanRestructure: Record "Loan Restructure";
        //SweepingInstructions: Record "Member Sweeping Instructions";
        ChequeBook: Record "Cheque Book Application";
        LoanTrunch: Record "Loan trunch Disburesment";
        InwardChequeClearing: Record "Cheque Receipts-Family";
        InvalidPaybillTransactions: Record "Paybill Processing Header";
        //InternalPV: Record "Internal PV Header";
        ObjStanding: Record "Standing Orders";
        ObjMembershipExit: Record "Membership Exit";
        ObjInternalTransfer: Record "Sacco Transfers";
        ObjChangeRequest: Record "Change Request";
        GuarantorshipSubstitution: Record "Guarantorship Substitution H";
        MembershipApp: Record "Membership Applications";
        LoanApplication: Record "Loans Register";
        StandingOrder: Record "Standing Orders";
        MWithdrawal: Record "Membership Exit";
        ImprestSurrender: Record "Imprest Surrender Header";
        ImprestRequisition: Record "Imprest Header";
        PRequest: Record "Purchase Header";
        GuarantorRecovery: Record "Loan Recovery Header";
    begin
        case RecRef.Number of
            DATABASE::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApp);
                    MembershipApp.Status := MembershipApp.Status::Open;
                    MembershipApp.Modify(true);
                    Handled := true;
                end;
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Status := SaccoTransfers.Status::Open;
                    SaccoTransfers.Modify(true);
                    Handled := true;
                end;
            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    MemberAgentNOKChange.Status := MemberAgentNOKChange.Status::Open;
                    MemberAgentNOKChange.Modify(true);
                    Handled := true;
                end;
            Database::"House Groups Registration":
                begin
                    RecRef.SetTable(HouseRegistration);
                    HouseRegistration.Status := HouseRegistration.Status::Open;
                    HouseRegistration.Modify(true);
                    Handled := true;
                end;

            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoanApplication);
                    LoanApplication."Approval Status" := LoanApplication."Approval Status"::Open;
                    LoanApplication.Modify(true);
                    Handled := true;
                end;
            Database::"Payment Header.":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Status := PettyCash.Status::New;
                    PettyCash.Modify(true);
                    Handled := true;
                end;
            Database::"Standing Orders":
                begin
                    RecRef.SetTable(StandingOrder);
                    StandingOrder.Status := StandingOrder.Status::Open;
                    StandingOrder.Modify(true);
                    Handled := true;
                end;
            Database::"Membership Exit":
                begin
                    RecRef.SetTable(MWithdrawal);
                    MWithdrawal.Status := MWithdrawal.Status::Open;
                    MWithdrawal.Modify(true);
                    Handled := true;
                end;
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    StaffClaims.Status := StaffClaims.Status::Pending;
                    StaffClaims.Modify(true);
                    Handled := true;
                end;
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Status := ImprestSurrender.Status::Open;
                    ImprestSurrender.Modify(true);
                    Handled := true;
                end;
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ImprestRequisition.Status := ImprestSurrender.Status::Open;
                    ImprestRequisition.Modify(true);
                    Handled := true;
                end;
            Database::"Purchase Header":
                begin
                    RecRef.SetTable(PRequest);
                    PRequest.Status := PRequest.Status::Open;
                    PRequest.Modify(true);
                    Handled := true;
                end;
            Database::"Loan PayOff":
                begin
                    RecRef.SetTable(LoanPayOff);
                    LoanPayOff.Status := LoanPayOff.Status::Open;
                    LoanPayOff.Modify(true);
                    Handled := true;
                end;
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(GuarantorRecovery);
                    GuarantorRecovery.Status := GuarantorRecovery.Status::Open;
                    GuarantorRecovery.Modify(true);
                    Handled := true;
                end;
        end

    end;

}
