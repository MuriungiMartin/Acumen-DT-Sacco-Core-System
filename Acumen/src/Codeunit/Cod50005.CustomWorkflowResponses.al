#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50005 "Custom Workflow Responses"
{

    trigger OnRun()
    begin
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        SurestepWFEvents: Codeunit "Custom Workflow Events";
        WFResponseHandler: Codeunit "Workflow Response Handling";


    procedure AddResponsesToLib()
    begin
    end;


    procedure AddResponsePredecessors()
    begin

        //Payment Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPaymentDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPaymentDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPaymentDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPaymentApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPaymentApprovalRequestCode);

        //Membership Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMembershipApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMembershipApplicationApprovalRequestCode);
        //Loan Application
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

        //Guarantor Substitution
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelGuarantorSubstitutionApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelGuarantorSubstitutionApprovalRequestCode);

        //Loan Disbursement
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanDisbursementApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanDisbursementApprovalRequestCode);



        //Standing Order
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStandingOrderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStandingOrderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStandingOrderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStandingOrderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStandingOrderApprovalRequestCode);

        //Membership Withdrawal
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMWithdrawalApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMWithdrawalApprovalRequestCode);

        //ATM Card Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelATMCardApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelATMCardApprovalRequestCode);

        //Guarantor Recovery
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode);

        //Change Request
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChangeRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChangeRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChangeRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChangeRequestApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChangeRequestApprovalRequestCode);

        //Treasury Transactions
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendTTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendTTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendTTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelTTransactionsApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelTTransactionsApprovalRequestCode);


        //FOSA Account Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFAccountApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFAccountApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFAccountApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFAccountApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFAccountApplicationApprovalRequestCode);



        //Stores Requisition

        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendSReqApplicationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendSReqApplicationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendSReqApplicationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SurestepWFEvents.RunWorkflowOnCancelSReqApplicationApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //SurestepWFEvents.RunWorkflowOnCancelSReqApplicationApprovalRequestCode);

        //Sacco Transfer
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSaccoTransferForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSaccoTransferForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSaccoTransferForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSaccoTransferApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSaccoTransferApprovalRequestCode);
        //Cheque Discounting
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChequeDiscountingApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChequeDiscountingApprovalRequestCode);

        //Imprest Requisition
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelImprestRequisitionApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelImprestRequisitionApprovalRequestCode);

        //Imprest Surrender
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelImprestSurrenderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelImprestSurrenderApprovalRequestCode);

        //Leave Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLeaveApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLeaveApplicationApprovalRequestCode);
        //Bulk Withdrawal
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode);

        //Package Lodge
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageLodgeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageLodgeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageLodgeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPackageLodgeApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPackageLodgeApprovalRequestCode);

        //Package Retrieval
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageRetrievalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageRetrievalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageRetrievalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPackageRetrievalApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPackageRetrievalApprovalRequestCode);

        //House Change
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHouseChangeApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHouseChangeApprovalRequestCode);

        //CRM Training
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendCRMTrainingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendCRMTrainingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendCRMTrainingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelCRMTrainingApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelCRMTrainingApprovalRequestCode);

        //Petty Cash
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPettyCashForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPettyCashForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPettyCashForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPettyCashApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPettyCashApprovalRequestCode);

        //Staff Claims
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStaffClaimsApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStaffClaimsApprovalRequestCode);

        //Member Agent/NOK Change
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode);

        //House Registration
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHouseRegistrationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHouseRegistrationApprovalRequestCode);

        //Loan Payoff
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanPayOffApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanPayOffApprovalRequestCode);

        //Fixed Deposit
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFixedDepositApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFixedDepositApprovalRequestCode);

        //EFT/RTGS
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendEFTRTGSForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendEFTRTGSForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendEFTRTGSForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelEFTRTGSApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelEFTRTGSApprovalRequestCode);

        //LOAN DEMAND NOTICE
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendDemandNoticeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendDemandNoticeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendDemandNoticeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCanceDemandNoticeApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCanceDemandNoticeApprovalRequestCode);

        //OVER DRAFT
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendOverDraftForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendOverDraftForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendOverDraftForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SurestepWFEvents.RunWorkflowOnCancelOverDraftApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SurestepWFEvents.RunWorkflowOnCancelOverDraftApprovalRequestCode);

        // //Loan Restructure
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendLoanRestructureForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendLoanRestructureForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendLoanRestructureForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SurestepWFEvents.RunWorkflowOnCancelLoanRestructureApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SurestepWFEvents.RunWorkflowOnCancelLoanRestructureApprovalRequestCode);

        // //Sweeping Instructions
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendSweepingInstructionsForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendSweepingInstructionsForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendSweepingInstructionsForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SurestepWFEvents.RunWorkflowOnCancelSweepingInstructionsApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SurestepWFEvents.RunWorkflowOnCancelSweepingInstructionsApprovalRequestCode);

        //Cheque Book Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeBookForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeBookForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeBookForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChequeBookApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChequeBookApprovalRequestCode);

        //Loan Trunch
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode);

        //Inward Cheque Clearing
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInwardChequeClearingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInwardChequeClearingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInwardChequeClearingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInwardChequeClearingApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInwardChequeClearingApprovalRequestCode);

        //Invalid Paybill Transactions
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequestCode);


        // //Internal PV
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendInternalPVForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendInternalPVForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SurestepWFEvents.RunWorkflowOnSendInternalPVForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SurestepWFEvents.RunWorkflowOnCancelInternalPVApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SurestepWFEvents.RunWorkflowOnCancelInternalPVApprovalRequestCode);

        //Salary Processing
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSalaryProcessingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSalaryProcessingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSalaryProcessingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSalaryProcessingApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSalaryProcessingApprovalRequestCode);


        //-----------------------------End AddOn--------------------------------------------------------------------------------------
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', true, true)]
    procedure SetStatusToPendingApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        IsHandled: Boolean;
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
        // InternalPV: Record "Internal PV Header";
        JournalBatch: Record "Gen. Journal Batch";
        SProcessing: Record "Salary Processing Headerr";
        // PaymentHeader: Record "Payments Header";
        GuarantorshipSubstitution: Record "Guarantorship Substitution H";
    begin
        case RecRef.Number of
            //Payment Header
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    PaymentHeader.Validate(Status, PaymentHeader.Status::"Pending Approval");
                    PaymentHeader.Modify(true);
                    Variant := PaymentHeader;
                end;

            //Membership Application
            Database::"Membership Applications":
                begin
                    //  Message('we here');
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate(Status, MembershipApplication.Status::"Pending Approval");
                    MembershipApplication.Modify(true);
                    Variant := MembershipApplication;
                end;
            //Loan Application
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoanApplication);
                    LoanApplication.Validate("Loan Status", LoanApplication."loan status"::Appraisal);
                    LoanApplication.Validate("Approval Status", LoanApplication."approval status"::Pending);
                    LoanApplication.Modify(true);
                    Variant := LoanApplication;
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
                    Variant := LoanDisbursement;
                end;

            //Membership Withdrawal
            Database::"Membership Exit":
                begin
                    RecRef.SetTable(MWithdrawal);
                    MWithdrawal.Validate(Status, MWithdrawal.Status::Pending);
                    MWithdrawal.Modify(true);
                    Variant := MWithdrawal;
                end;

            //ATM Card
            Database::"ATM Card Applications":
                begin
                    RecRef.SetTable(ATMCard);
                    ATMCard.Validate(Status, ATMCard.Status::Pending);
                    ATMCard.Modify(true);
                    Variant := ATMCard;
                end;

            //Guarantor Recovery
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(GuarantorR);
                    GuarantorR.Validate(Status, GuarantorR.Status::Pending);
                    GuarantorR.Modify(true);
                    Variant := GuarantorR;
                end;

            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Validate(Status, ChangeRequest.Status::Pending);
                    ChangeRequest.Modify(true);
                    Variant := ChangeRequest;
                end;

            //Treasury Transaction
            Database::"Treasury Transactions":
                begin
                    RecRef.SetTable(TTransactions);
                    TTransactions.Validate(Status, TTransactions.Status::"Pending Approval");
                    TTransactions.Modify(true);
                    Variant := TTransactions;
                end;
            //FOSA Account Application
            Database::"FOSA Account Applicat. Details":
                begin
                    RecRef.SetTable(FAccount);
                    FAccount.Validate(Status, FAccount.Status::Pending);
                    FAccount.Modify(true);
                    Variant := FAccount;
                end;

            //Stores Requisition
            // Database::"Store Requistion Header":
            //     begin
            //         RecRef.SetTable(SReq);
            //         SReq.Validate(Status, SReq.Status::"Pending Approval");
            //         SReq.Modify(true);
            //         Variant := SReq;
            //     end;
            //Sacco Transfers
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Validate(Status, SaccoTransfers.Status::"Pending Approval");
                    SaccoTransfers.Modify(true);
                    Variant := SaccoTransfers;
                end;
            //Cheque Discounting
            Database::"Cheque Discounting":
                begin
                    RecRef.SetTable(ChequeDiscounting);
                    ChequeDiscounting.Validate(Status, ChequeDiscounting.Status::"Pending Approval");
                    ChequeDiscounting.Modify(true);
                    Variant := ChequeDiscounting;
                end;
            //Imprest Requisition
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ImprestRequisition.Validate(Status, ImprestRequisition.Status::"Pending Approval");
                    ImprestRequisition.Modify(true);
                    Variant := ImprestRequisition;
                end;
            //Imprest Surrender
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Validate(Status, ImprestSurrender.Status::"Pending Approval");
                    ImprestSurrender.Modify(true);
                    Variant := ImprestSurrender;
                end;
            //Leave Application
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Validate(Status, LeaveApplication.Status::"Pending Approval");
                    LeaveApplication.Modify(true);
                    Variant := LeaveApplication;
                end;
            //Bulk Withdrawal
            Database::"Bulk Withdrawal Application":
                begin
                    RecRef.SetTable(BulkWithdrawal);
                    BulkWithdrawal.Validate(Status, BulkWithdrawal.Status::"Pending Approval");
                    BulkWithdrawal.Modify(true);
                    Variant := BulkWithdrawal;
                end;
            //Package Lodge
            Database::"Safe Custody Package Register":
                begin
                    RecRef.SetTable(PackageLodge);
                    PackageLodge.Validate(Status, PackageLodge.Status::"Pending Approval");
                    PackageLodge.Modify(true);
                    Variant := PackageLodge;
                end;
            //Package Retrieval
            Database::"Package Retrieval Register":
                begin
                    RecRef.SetTable(PackageRetrieval);
                    PackageRetrieval.Validate(Status, PackageRetrieval.Status::"Pending Approval");
                    PackageRetrieval.Modify(true);
                    Variant := PackageRetrieval;
                end;

            //House Change
            Database::"House Group Change Request":
                begin
                    RecRef.SetTable(HouseChange);
                    HouseChange.Validate(Status, HouseChange.Status::"Pending Approval");
                    HouseChange.Modify(true);
                    Variant := HouseChange;
                end;

            //CRM
            Database::"CRM Trainings":
                begin
                    RecRef.SetTable(CRMTraining);
                    CRMTraining.Validate(Status, CRMTraining.Status::Pending);
                    CRMTraining.Modify(true);
                    Variant := CRMTraining;
                end;

            //Petty Cash
            Database::"Payment Header.":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Validate(Status, PettyCash.Status::"Pending Approval");
                    PettyCash.Modify(true);
                    Variant := PettyCash;
                end;

            //Staff Claims
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    StaffClaims.Validate(Status, StaffClaims.Status::"Pending Approval");
                    StaffClaims.Modify(true);
                    Variant := StaffClaims;
                end;

            //Member Agent/NOK Change
            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    MemberAgentNOKChange.Validate(Status, MemberAgentNOKChange.Status::"Pending Approval");
                    MemberAgentNOKChange.Modify(true);
                    Variant := MemberAgentNOKChange;
                end;

            //House Registration
            Database::"House Groups Registration":
                begin
                    RecRef.SetTable(HouseRegistration);
                    HouseRegistration.Validate(Status, HouseRegistration.Status::"Pending Approval");
                    HouseRegistration.Modify(true);
                    Variant := HouseRegistration;
                end;

            //Loan PayOff
            Database::"Loan PayOff":
                begin
                    RecRef.SetTable(LoanPayOff);
                    LoanPayOff.Validate(Status, LoanPayOff.Status::"Pending Approval");
                    LoanPayOff.Modify(true);
                    Variant := LoanPayOff;
                end;

            //Fixed Deposit
            Database::"Fixed Deposit Placement":
                begin
                    RecRef.SetTable(FixedDeposit);
                    FixedDeposit.Validate(Status, FixedDeposit.Status::"Pending Approval");
                    FixedDeposit.Modify(true);
                    Variant := FixedDeposit;
                end;

            //EFTRTGS
            Database::"EFT Details":
                begin
                    RecRef.SetTable(EFTRTGS);
                    EFTRTGS.Validate(Status, EFTRTGS.Status::"Pending Approval");
                    EFTRTGS.Modify(true);
                    Variant := EFTRTGS;
                end;

            //Loan Demand Notices
            Database::"Default Notices Register":
                begin
                    RecRef.SetTable(LDemand);
                    LDemand.Validate(Status, LDemand.Status::"Pending Approval");
                    LDemand.Modify(true);
                    Variant := LDemand;
                end;

            //Over Draft
            // Database::"OverDraft Application":
            //     begin
            //         RecRef.SetTable(OverDraft);
            //         OverDraft.Validate(Status, OverDraft.Status::"Pending Approval");
            //         OverDraft.Modify(true);
            //         Variant := OverDraft;
            //     end;

            // //Loan Restructure
            // Database::"Loan Restructure":
            //     begin
            //         RecRef.SetTable(LoanRestructure);
            //         LoanRestructure.Validate(Status, LoanRestructure.Status::"Pending Approval");
            //         LoanRestructure.Modify(true);
            //         Variant := LoanRestructure;
            //     end;

            // //Sweeping Instructions
            // Database::"Member Sweeping Instructions":
            //     begin
            //         RecRef.SetTable(SweepingInstructions);
            //         SweepingInstructions.Validate(Status, SweepingInstructions.Status::"Pending Approval");
            //         SweepingInstructions.Modify(true);
            //         Variant := SweepingInstructions;
            //     end;

            //Cheque Book Application
            Database::"Cheque Book Application":
                begin
                    RecRef.SetTable(ChequeBook);
                    ChequeBook.Validate(Status, ChequeBook.Status::"Pending Approval");
                    ChequeBook.Modify(true);
                    Variant := ChequeBook;
                end;


            //Loan Trunch
            Database::"Loan trunch Disburesment":
                begin
                    RecRef.SetTable(LoanTrunch);
                    LoanTrunch.Validate(Status, LoanTrunch.Status::"Pending");
                    LoanTrunch.Modify(true);
                    Variant := LoanTrunch;
                end;

            //Inward Cheque Clearing
            Database::"Cheque Receipts-Family":
                begin
                    RecRef.SetTable(InwardChequeClearing);
                    InwardChequeClearing.Validate(Status, InwardChequeClearing.Status::"Pending Approval");
                    InwardChequeClearing.Modify(true);
                    Variant := InwardChequeClearing;
                end;

            //Invalid Paybill Transactions
            Database::"Paybill Processing Header":
                begin
                    RecRef.SetTable(InvalidPaybillTransactions);
                    InvalidPaybillTransactions.Validate(Status, InvalidPaybillTransactions.Status::"Pending Approval");
                    InvalidPaybillTransactions.Modify(true);
                    Variant := InvalidPaybillTransactions;
                end;

            //Internal PV
            // Database::"Internal PV Header":
            //     begin
            //         RecRef.SetTable(InternalPV);
            //         InternalPV.Validate(Status, InternalPV.Status::"Pending Approval");
            //         InternalPV.Modify(true);
            //         Variant := InternalPV;
            //     end;

            //Journal Batch
            Database::"Gen. Journal Batch":
                begin
                    RecRef.SetTable(JournalBatch);
                    JournalBatch.Validate(Status, JournalBatch.Status::"Pending Approval");
                    JournalBatch.Modify(true);
                    Variant := JournalBatch;
                end;

            //Salary Processing
            Database::"Salary Processing Headerr":
                begin
                    RecRef.SetTable(SProcessing);
                    SProcessing.Validate("Approval Status", SProcessing."Approval Status"::"Pending");
                    SProcessing.Modify(true);
                    Variant := SProcessing;
                end;
        end;
    end;




    /*   procedure ReleasePaymentVoucher(var PaymentHeader: Record "Payments Header")
      var
          PHeader: Record "Payment Header.";
      begin


          PaymentHeader.Reset;
          PaymentHeader.SetRange(PaymentHeader."No.", PaymentHeader."No.");
          if PaymentHeader.FindFirst then begin
              PaymentHeader.Status := PaymentHeader.Status::Approved;
              PaymentHeader.Modify;
          end;
      end;


      procedure ReOpenPaymentVoucher(var PaymentHeader: Record "Payments Header")
      var
          PHeader: Record "Payment Header.";
      begin
          PHeader.Reset;
          PHeader.SetRange(PHeader."No.", PaymentHeader."No.");
          if PHeader.FindFirst then begin
              PHeader.Status := PHeader.Status::New;
              PHeader.Modify;
          end;
      end;


      procedure ReleaseMembershipApplication(var MembershipApplication: Record "Membership Applications")
      var
          MembershipApp: Record "Membership Applications";
      begin
          MembershipApp.Reset;
          MembershipApp.SetRange(MembershipApp."No.", MembershipApplication."No.");
          if MembershipApp.FindFirst then begin
              MembershipApp.Status := MembershipApp.Status::Approved;
              MembershipApp.Modify;
          end;
      end;


      procedure ReOpenMembershipApplication(var MemberApplication: Record "Membership Applications")
      var
          MembershipApp: Record "Membership Applications";
      begin
          MembershipApp.Reset;
          MembershipApp.SetRange(MembershipApp."No.", MemberApplication."No.");
          if MembershipApp.FindFirst then begin
              MembershipApp.Status := MembershipApp.Status::Open;
              MembershipApp.Modify;
          end;
      end;


      procedure ReleaseLoanApplication(var LoanApplication: Record "Loans Register")
      var
          LoanB: Record "Loans Register";
      begin
          LoanB.Reset;
          LoanB.SetRange(LoanB."Loan  No.", LoanApplication."Loan  No.");
          if LoanB.FindFirst then begin
              LoanB."Loan Status" := LoanB."loan status"::Disbursed;
              LoanB."Approval Status" := LoanB."approval status"::Approved;
              LoanB."Approved By" := UserId;
              LoanB.Modify;
          end;
      end;


      procedure ReOpenLoanApplication(var LoanApplication: Record "Loans Register")
      var
          LoanB: Record "Loans Register";
      begin
          LoanB.Reset;
          LoanB.SetRange(LoanB."Loan  No.", LoanApplication."Loan  No.");
          if LoanB.FindFirst then begin
              LoanB."Loan Status" := LoanB."loan status"::Application;
              LoanB."Approval Status" := LoanB."approval status"::Open;
              LoanB.Modify;
          end;
      end;


      procedure ReleaseGuarantorSubstitution(var GuarantorshipSubstitution: Record "Guarantorship Substitution H")
      var
          GSub: Record "Guarantorship Substitution H";
      begin

          GSub.Reset;
          GSub.SetRange("Document No", GuarantorshipSubstitution."Document No");
          if GSub.FindFirst then begin
              GSub.Status := GSub.Status::Approved;
              GSub.Modify;
          end;
      end;


      procedure ReOpenGuarantorSubstitution(var GuarantorshipSubstitution: Record "Guarantorship Substitution H")
      var
          GSub: Record "Guarantorship Substitution H";
      begin
          GSub.Reset;
          GSub.SetRange("Document No", GuarantorshipSubstitution."Document No");
          if GSub.FindFirst then begin
              GSub.Status := GSub.Status::Open;
              GSub.Modify;
          end;
      end;


      procedure ReleaseLoanDisbursement(var LoanDisbursement: Record "Loan Disburesment-Batching")
      var
          LoanD: Record "Loan Disburesment-Batching";
      begin
          LoanD.Reset;
          LoanD.SetRange(LoanD."Batch No.", LoanDisbursement."Batch No.");
          if LoanD.FindFirst then begin
              LoanD.Status := LoanDisbursement.Status::Approved;
              LoanD.Modify;
          end;
      end;


      procedure ReOpenLoanDisbursement(var LoanDisbursement: Record "Loan Disburesment-Batching")
      var
          LoanD: Record "Loan Disburesment-Batching";
      begin
          LoanD.Reset;
          LoanD.SetRange(LoanD."Batch No.", LoanDisbursement."Batch No.");
          if LoanD.FindFirst then begin
              LoanD.Status := LoanDisbursement.Status::Open;
              LoanD.Modify;
          end;
      end;


      procedure ReleaseStandingOrder(var StandingOrder: Record "Standing Orders")
      var
          Sto: Record "Standing Orders";
      begin
          Sto.Reset;
          Sto.SetRange(Sto."No.", StandingOrder."No.");
          if Sto.FindFirst then begin
              Sto.Status := Sto.Status::Approved;
              Sto."Is Active" := true;
              Sto."Posted By" := UserId;
              Sto.Modify;
          end;
      end;


      procedure ReOpenStandingOrder(var StandingOrder: Record "Standing Orders")
      var
          Sto: Record "Standing Orders";
      begin
          Sto.Reset;
          Sto.SetRange(Sto."No.", StandingOrder."No.");
          if Sto.FindFirst then begin
              Sto.Status := Sto.Status::Open;
              Sto.Modify;
          end;
      end;


      procedure ReleaseMWithdrawal(var MWithdrawal: Record "Membership Exit")
      var
          Withdrawal: Record "Membership Exit";
      begin
          MWithdrawal.Reset;
          MWithdrawal.SetRange(MWithdrawal."No.", MWithdrawal."No.");
          if MWithdrawal.FindFirst then begin
              MWithdrawal.Status := MWithdrawal.Status::Approved;
              MWithdrawal.Modify;
          end;
      end;


      procedure ReOpenMWithdrawal(var MWithdrawal: Record "Membership Exit")
      var
          Withdrawal: Record "Membership Exit";
      begin
          MWithdrawal.Reset;
          MWithdrawal.SetRange(MWithdrawal."No.", MWithdrawal."No.");
          if MWithdrawal.FindFirst then begin
              MWithdrawal.Status := MWithdrawal.Status::Open;
              MWithdrawal.Modify;
          end;
      end;


      procedure ReleaseATMCard(var ATMCard: Record "ATM Card Applications")
      var
          ATM: Record "ATM Card Applications";
      begin
          ATMCard.Reset;
          ATMCard.SetRange(ATMCard."No.", ATMCard."No.");
          if ATMCard.FindFirst then begin
              ATMCard.Status := ATMCard.Status::Approved;
              ATMCard.Modify;
          end;
      end;


      procedure ReOpenATMCard(var ATMCard: Record "ATM Card Applications")
      var
          ATM: Record "ATM Card Applications";
      begin
          ATMCard.Reset;
          ATMCard.SetRange(ATMCard."No.", ATMCard."No.");
          if ATMCard.FindFirst then begin
              ATMCard.Status := ATMCard.Status::Open;
              ATMCard.Modify;
          end;
      end;


      procedure ReleaseGuarantorRecovery(var GuarantorRecovery: Record "Loan Recovery Header")
      var
          GuarantorR: Record "Loan Recovery Header";
      begin
          GuarantorRecovery.Reset;
          GuarantorRecovery.SetRange(GuarantorRecovery."Document No", GuarantorRecovery."Document No");
          if GuarantorRecovery.FindFirst then begin
              GuarantorRecovery.Status := GuarantorRecovery.Status::Approved;
              GuarantorRecovery.Modify;
          end;
      end;


      procedure ReOpenGuarantorRecovery(var GuarantorRecovery: Record "Loan Recovery Header")
      var
          GuarantorR: Record "Loan Recovery Header";
      begin
          GuarantorRecovery.Reset;
          GuarantorRecovery.SetRange(GuarantorRecovery."Document No", GuarantorRecovery."Document No");
          if GuarantorRecovery.FindFirst then begin
              GuarantorRecovery.Status := GuarantorRecovery.Status::Open;
              GuarantorRecovery.Modify;
          end;
      end;


      procedure ReleaseChangeRequest(var ChangeRequest: Record "Change Request")
      var
          ChReq: Record "Change Request";
      begin
          ChangeRequest.Reset;
          ChangeRequest.SetRange(ChangeRequest.No, ChangeRequest.No);
          if ChangeRequest.FindFirst then begin
              ChangeRequest.Status := ChangeRequest.Status::Approved;
              ChangeRequest.Modify;
          end;
      end;


      procedure ReOpenChangeRequest(var ChangeRequest: Record "Change Request")
      var
          ChReq: Record "Change Request";
      begin
          ChangeRequest.Reset;
          ChangeRequest.SetRange(ChangeRequest.No, ChangeRequest.No);
          if ChangeRequest.FindFirst then begin
              ChangeRequest.Status := ChangeRequest.Status::Open;
              ChangeRequest.Modify;
          end;
      end;


      procedure ReleaseTTransactions(var TTransactions: Record "Treasury Transactions")
      var
          TTrans: Record "Treasury Transactions";
      begin
          TTransactions.Reset;
          TTransactions.SetRange(TTransactions.No, TTransactions.No);
          if TTransactions.FindFirst then begin
              TTransactions.Status := TTransactions.Status::Approved;
              TTransactions.Modify;
          end;
      end;


      procedure ReOpenTTransactions(var TTransactions: Record "Treasury Transactions")
      var
          TTrans: Record "Treasury Transactions";
      begin
          TTransactions.Reset;
          TTransactions.SetRange(TTransactions.No, TTransactions.No);
          if TTransactions.FindFirst then begin
              TTransactions.Status := TTransactions.Status::Open;
              TTransactions.Modify;
          end;
      end;


      procedure ReleaseFAccount(var FAccount: Record "FOSA Account Applicat. Details")
      var
          FOSAACC: Record "FOSA Account Applicat. Details";
      begin
          FAccount.Reset;
          FAccount.SetRange(FAccount."No.", FAccount."No.");
          if FAccount.FindFirst then begin
              FAccount.Status := FAccount.Status::Approved;
              FAccount.Modify;

              if FAccount.Get(FOSAACC."No.") then begin
                  FAccount.Status := FAccount.Status::Approved;
                  FAccount.Modify;
              end;
          end;
      end;


      procedure ReOpenFAccount(var FAccount: Record "FOSA Account Applicat. Details")
      var
          FOSAACC: Record "FOSA Account Applicat. Details";
      begin
          FAccount.Reset;
          FAccount.SetRange(FAccount."No.", FAccount."No.");
          if FAccount.FindFirst then begin
              FAccount.Status := FAccount.Status::Open;
              FAccount.Modify;
          end;
      end;


      procedure ReleaseSReq(var SReq: Record "Store Requistion Header")
      var
          Stores: Record "Store Requistion Header";
      begin
          SReq.Reset;
          SReq.SetRange(SReq."No.", SReq."No.");
          if SReq.FindFirst then begin
              SReq.Status := SReq.Status::Released;
              SReq.Modify;

              if SReq.Get(Stores."No.") then begin
                  SReq.Status := SReq.Status::Released;
                  SReq.Modify;
              end;
          end;
      end;


      procedure ReOpenSReq(var SReq: Record "Store Requistion Header")
      var
          Stores: Record "Store Requistion Header";
      begin
          SReq.Reset;
          SReq.SetRange(SReq."No.", SReq."No.");
          if SReq.FindFirst then begin
              SReq.Status := SReq.Status::Open;
              SReq.Modify;
          end;
      end;


      procedure ReleaseSaccoTransfer(var SaccoTransfer: Record "Sacco Transfers")
      var
          STransfer: Record "Sacco Transfers";
      begin
          STransfer.Reset;
          STransfer.SetRange(STransfer.No, SaccoTransfer.No);
          if STransfer.FindFirst then begin
              STransfer.Status := SaccoTransfer.Status::Approved;
              STransfer.Modify;
          end;
      end;


      procedure ReOpenSaccoTransfer(var SaccoTransfer: Record "Sacco Transfers")
      var
          STransfer: Record "Sacco Transfers";
      begin
          STransfer.Reset;
          STransfer.SetRange(STransfer.No, SaccoTransfer.No);
          if STransfer.FindFirst then begin
              STransfer.Status := SaccoTransfer.Status::Open;
              STransfer.Modify;
          end;
      end;


      procedure ReleaseChequeDiscounting(var ChequeDiscounting: Record "Cheque Discounting")
      var
          CDiscounting: Record "Cheque Discounting";
      begin
          CDiscounting.Reset;
          CDiscounting.SetRange(CDiscounting."Transaction No", ChequeDiscounting."Transaction No");
          if CDiscounting.FindFirst then begin
              CDiscounting.Status := ChequeDiscounting.Status::Approved;
              CDiscounting.Modify;
          end;
      end;


      procedure ReOpenChequeDiscounting(var ChequeDiscounting: Record "Cheque Discounting")
      var
          CDiscounting: Record "Cheque Discounting";
      begin
          CDiscounting.Reset;
          CDiscounting.SetRange(CDiscounting."Transaction No", ChequeDiscounting."Transaction No");
          if CDiscounting.FindFirst then begin
              CDiscounting.Status := ChequeDiscounting.Status::Open;
              CDiscounting.Modify;
          end;
      end;


      procedure ReleaseImprestRequisition(var ImprestRequisition: Record "Imprest Header")
      var
          ImprestReq: Record "Imprest Header";
      begin
          ImprestReq.Reset;
          ImprestReq.SetRange(ImprestReq."No.", ImprestRequisition."No.");
          if ImprestReq.FindFirst then begin
              ImprestReq.Status := ImprestRequisition.Status::Approved;
              ImprestReq.Modify;
          end;
      end;


      procedure ReOpenImprestRequisition(var ImprestRequisition: Record "Imprest Header")
      var
          ImprestReq: Record "Imprest Header";
      begin
          ImprestReq.Reset;
          ImprestReq.SetRange(ImprestReq."No.", ImprestRequisition."No.");
          if ImprestReq.FindFirst then begin
              ImprestReq.Status := ImprestRequisition.Status::Open;
              ImprestReq.Modify;
          end;
      end;


      procedure ReleaseImprestSurrender(var ImprestSurrender: Record "Imprest Surrender Header")
      var
          ImprestSurr: Record "Imprest Surrender Header";
      begin
          ImprestSurr.Reset;
          ImprestSurr.SetRange(ImprestSurr.No, ImprestSurrender.No);
          if ImprestSurr.FindFirst then begin
              ImprestSurr.Status := ImprestSurrender.Status::Approved;
              ImprestSurr.Modify;
          end;
      end;


      procedure ReOpenImprestSurrender(var ImprestSurrender: Record "Imprest Surrender Header")
      var
          ImprestSurr: Record "Imprest Surrender Header";
      begin
          ImprestSurr.Reset;
          ImprestSurr.SetRange(ImprestSurr.No, ImprestSurrender.No);
          if ImprestSurr.FindFirst then begin
              ImprestSurr.Status := ImprestSurrender.Status::Open;
              ImprestSurr.Modify;
          end;
      end;


      procedure ReleaseLeaveApplication(var LeaveApplication: Record "HR Leave Application")
      var
          LeaveApp: Record "HR Leave Application";
      begin
          LeaveApp.Reset;
          LeaveApp.SetRange(LeaveApp."Application Code", LeaveApplication."Application Code");
          if LeaveApp.FindFirst then begin
              LeaveApp.Status := LeaveApplication.Status::"HOD Approval";
              LeaveApp.Modify;
          end;
      end;


      procedure ReOpenLeaveApplication(LeaveApplication: Record "HR Leave Application")
      var
          LeaveApp: Record "HR Leave Application";
      begin
          LeaveApp.Reset;
          LeaveApp.SetRange(LeaveApp."Application Code", LeaveApplication."Application Code");
          if LeaveApp.FindFirst then begin
              LeaveApp.Status := LeaveApplication.Status::New;
              LeaveApp.Modify;
          end;
      end;


      procedure ReleaseBulkWithdrawal(var BulkWithdrawal: Record "Bulk Withdrawal Application")
      var
          BulkWith: Record "Bulk Withdrawal Application";
      begin
          BulkWithdrawal.Reset;
          BulkWithdrawal.SetRange(BulkWithdrawal."Transaction No", BulkWithdrawal."Transaction No");
          if BulkWithdrawal.FindFirst then begin
              BulkWithdrawal.Status := BulkWithdrawal.Status::Approved;
              BulkWithdrawal.Modify;
          end;
      end;


      procedure ReOpenBulkWithdrawal(var BulkWithdrawal: Record "Bulk Withdrawal Application")
      var
          BulkWith: Record "Bulk Withdrawal Application";
      begin
          BulkWithdrawal.Reset;
          BulkWithdrawal.SetRange(BulkWithdrawal."Transaction No", BulkWithdrawal."Transaction No");
          if BulkWithdrawal.FindFirst then begin
              BulkWithdrawal.Status := BulkWithdrawal.Status::Open;
              BulkWithdrawal.Modify;
          end;
      end;


      procedure ReleasePackageLodge(var PackageLodge: Record "Safe Custody Package Register")
      var
          PLodge: Record "Safe Custody Package Register";
      begin
          PackageLodge.Reset;
          PackageLodge.SetRange(PackageLodge."Package ID", PackageLodge."Package ID");
          if PackageLodge.FindFirst then begin
              PackageLodge.Status := PackageLodge.Status::Approved;
              PackageLodge.Modify;
          end;
      end;


      procedure ReOpenPackageLodge(var PackageLodge: Record "Safe Custody Package Register")
      var
          PLodge: Record "Safe Custody Package Register";
      begin
          PackageLodge.Reset;
          PackageLodge.SetRange(PackageLodge."Package ID", PackageLodge."Package ID");
          if PackageLodge.FindFirst then begin
              PackageLodge.Status := PackageLodge.Status::Open;
              PackageLodge.Modify;
          end;
      end;


      procedure ReleasePackageRetrieval(var PackageRetrieval: Record "Package Retrieval Register")
      var
          PRetrieval: Record "Package Retrieval Register";
      begin
          PackageRetrieval.Reset;
          PackageRetrieval.SetRange(PackageRetrieval."Request No", PackageRetrieval."Request No");
          if PackageRetrieval.FindFirst then begin
              PackageRetrieval.Status := PackageRetrieval.Status::Approved;
              PackageRetrieval.Modify;
          end;
      end;


      procedure ReOpenPackageRetrieval(var PackageRetrieval: Record "Package Retrieval Register")
      var
          PRetrieval: Record "Package Retrieval Register";
      begin
          PackageRetrieval.Reset;
          PackageRetrieval.SetRange(PackageRetrieval."Request No", PackageRetrieval."Request No");
          if PackageRetrieval.FindFirst then begin
              PackageRetrieval.Status := PackageRetrieval.Status::Open;
              PackageRetrieval.Modify;
          end;
      end;


      procedure ReleaseHouseChange(var HouseChange: Record "House Group Change Request")
      var
          HChange: Record "House Group Change Request";
      begin
          HouseChange.Reset;
          HouseChange.SetRange(HouseChange."Document No", HouseChange."Document No");
          if HouseChange.FindFirst then begin
              HouseChange.Status := HouseChange.Status::Approved;
              HouseChange.Modify;
          end;
      end;


      procedure ReOpenHouseChange(var HouseChange: Record "House Group Change Request")
      var
          HChange: Record "House Group Change Request";
      begin
          HouseChange.Reset;
          HouseChange.SetRange(HouseChange."Document No", HouseChange."Document No");
          if HouseChange.FindFirst then begin
              HouseChange.Status := HouseChange.Status::Open;
              HouseChange.Modify;
          end;
      end;


      procedure ReleaseCRMTraining(var CRMTraining: Record "CRM Trainings")
      var
          CTraining: Record "CRM Trainings";
      begin
          CRMTraining.Reset;
          CRMTraining.SetRange(CRMTraining.Code, CRMTraining.Code);
          if CRMTraining.FindFirst then begin
              CRMTraining.Status := CRMTraining.Status::Approved;
              CRMTraining.Modify;
          end;
      end;


      procedure ReOpenCRMTraining(var CRMTraining: Record "CRM Trainings")
      var
          CTraining: Record "CRM Trainings";
      begin
          CRMTraining.Reset;
          CRMTraining.SetRange(CRMTraining.Code, CRMTraining.Code);
          if CRMTraining.FindFirst then begin
              CRMTraining.Status := CRMTraining.Status::Open;
              CRMTraining.Modify;
          end;
      end;


      procedure ReleasePettyCash(var PettyCash: Record "Payment Header.")
      var
          PettyC: Record "Payment Header.";
      begin
          PettyCash.Reset;
          PettyCash.SetRange(PettyCash."No.", PettyCash."No.");
          if PettyCash.FindFirst then begin
              PettyCash.Status := PettyCash.Status::Approved;
              PettyCash.Modify;
          end;
      end;


      procedure ReOpenPettyCash(var PettyCash: Record "Payment Header.")
      var
          PettyC: Record "Payment Header.";
      begin
          PettyCash.Reset;
          PettyCash.SetRange(PettyCash."No.", PettyCash."No.");
          if PettyCash.FindFirst then begin
              PettyCash.Status := PettyCash.Status::New;
              PettyCash.Modify;
          end;
      end;


      procedure ReleaseStaffClaims(var StaffClaims: Record "Staff Claims Header")
      var
          SClaims: Record "Staff Claims Header";
      begin
          StaffClaims.Reset;
          StaffClaims.SetRange(StaffClaims."No.", StaffClaims."No.");
          if StaffClaims.FindFirst then begin
              StaffClaims.Status := StaffClaims.Status::Approved;
              StaffClaims.Modify;
          end;
      end;


      procedure ReOpenStaffClaims(var StaffClaims: Record "Staff Claims Header")
      var
          SClaims: Record "Staff Claims Header";
      begin
          StaffClaims.Reset;
          StaffClaims.SetRange(StaffClaims."No.", StaffClaims."No.");
          if StaffClaims.FindFirst then begin
              StaffClaims.Status := StaffClaims.Status::"1st Approval";
              StaffClaims.Modify;
          end;
      end;


      procedure ReleaseMemberAgentNOKChange(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang")
      var
          MAgentNOKChange: Record "Member Agent/Next Of Kin Chang";
      begin
          MemberAgentNOKChange.Reset;
          MemberAgentNOKChange.SetRange(MemberAgentNOKChange."Document No", MemberAgentNOKChange."Document No");
          if MemberAgentNOKChange.FindFirst then begin
              MemberAgentNOKChange.Status := MemberAgentNOKChange.Status::Approved;
              MemberAgentNOKChange.Modify;
          end;
      end;


      procedure ReOpenMemberAgentNOKChange(var MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang")
      var
          MAgentNOKChange: Record "Member Agent/Next Of Kin Chang";
      begin
          MemberAgentNOKChange.Reset;
          MemberAgentNOKChange.SetRange(MemberAgentNOKChange."Document No", MemberAgentNOKChange."Document No");
          if MemberAgentNOKChange.FindFirst then begin
              MemberAgentNOKChange.Status := MemberAgentNOKChange.Status::Open;
              MemberAgentNOKChange.Modify;
          end;
      end;


      procedure ReleaseHouseRegistration(var HouseRegistration: Record "House Groups Registration")
      var
          HRegistration: Record "House Groups Registration";
      begin
          HouseRegistration.Reset;
          HouseRegistration.SetRange(HouseRegistration."House Group Code", HouseRegistration."House Group Code");
          if HouseRegistration.FindFirst then begin
              HouseRegistration.Status := HouseRegistration.Status::Approved;
              HouseRegistration.Modify;
          end;
      end;


      procedure ReOpenHouseRegistration(var HouseRegistration: Record "House Groups Registration")
      var
          HRegistration: Record "House Groups Registration";
      begin
          HouseRegistration.Reset;
          HouseRegistration.SetRange(HouseRegistration."House Group Code", HouseRegistration."House Group Code");
          if HouseRegistration.FindFirst then begin
              HouseRegistration.Status := HouseRegistration.Status::Open;
              HouseRegistration.Modify;
          end;
      end;


      procedure ReleaseLoanPayOff(var LoanPayOff: Record "Loan PayOff")
      var
          LPayOff: Record "Loan PayOff";
      begin
          LoanPayOff.Reset;
          LoanPayOff.SetRange(LoanPayOff."Document No", LoanPayOff."Document No");
          if LoanPayOff.FindFirst then begin
              LoanPayOff.Status := LoanPayOff.Status::Approved;
              LoanPayOff.Modify;
          end;
      end;


      procedure ReOpenLoanPayOff(var LoanPayOff: Record "Loan PayOff")
      var
          LPayOff: Record "Loan PayOff";
      begin
          LoanPayOff.Reset;
          LoanPayOff.SetRange(LoanPayOff."Document No", LoanPayOff."Document No");
          if LoanPayOff.FindFirst then begin
              LoanPayOff.Status := LoanPayOff.Status::Open;
              LoanPayOff.Modify;
          end;
      end;


      procedure ReleaseFixedDeposit(var FixedDeposit: Record "Fixed Deposit Placement")
      var
          FDeposit: Record "Fixed Deposit Placement";
      begin
          FixedDeposit.Reset;
          FixedDeposit.SetRange(FixedDeposit."Document No", FixedDeposit."Document No");
          if FixedDeposit.FindFirst then begin
              FixedDeposit.Status := FixedDeposit.Status::Approved;
              FixedDeposit.Modify;
          end;
      end;


      procedure ReOpenFixedDeposit(var FixedDeposit: Record "Fixed Deposit Placement")
      var
          FDeposit: Record "Fixed Deposit Placement";
      begin
          FixedDeposit.Reset;
          FixedDeposit.SetRange(FixedDeposit."Document No", FixedDeposit."Document No");
          if FixedDeposit.FindFirst then begin
              FixedDeposit.Status := FixedDeposit.Status::Open;
              FixedDeposit.Modify;
          end;
      end;


      procedure ReleaseEFTRTGS(var EFTRTGS: Record "EFT Details")
      var
          RTGS: Record "EFT Details";
      begin
          EFTRTGS.Reset;
          EFTRTGS.SetRange(EFTRTGS.No, EFTRTGS.No);
          if EFTRTGS.FindFirst then begin
              EFTRTGS.Status := EFTRTGS.Status::Approved;
              EFTRTGS.Modify;
          end;
      end;


      procedure ReOpenEFTRTGS(var EFTRTGS: Record "EFT Details")
      var
          RTGS: Record "EFT Details";
      begin
          EFTRTGS.Reset;
          EFTRTGS.SetRange(EFTRTGS.No, EFTRTGS.No);
          if EFTRTGS.FindFirst then begin
              EFTRTGS.Status := EFTRTGS.Status::Open;
              EFTRTGS.Modify;
          end;
      end;


      procedure ReleaseDemandNotice(var LDemand: Record "Default Notices Register")
      var
          LoanD: Record "Default Notices Register";
          ObjUserSignatures: Record "User Signatures";
      begin
          LDemand.Reset;
          LDemand.SetRange(LDemand."Document No", LDemand."Document No");
          if LDemand.FindFirst then begin
              LDemand.Status := LDemand.Status::Approved;

              if ObjUserSignatures.Get(UserId) then begin
                  LDemand."Approver User" := UserId;
                  LDemand."Approver Designation" := ObjUserSignatures.Designation;
                  LDemand."Approver Signature" := ObjUserSignatures.Signature;

                  if LDemand."Approver User" <> '' then begin
                      LDemand."Approver User II" := UserId;
                      LDemand."Approver Designation II" := ObjUserSignatures.Designation;
                      LDemand."Approver Signature II" := ObjUserSignatures.Signature;
                  end;
              end;
              LDemand.Modify;
          end;
      end;


      procedure ReOpenDemandNotice(var LDemand: Record "Default Notices Register")
      var
          LoanD: Record "Default Notices Register";
      begin
          LDemand.Reset;
          LDemand.SetRange(LDemand."Document No", LDemand."Document No");
          if LDemand.FindFirst then begin
              LDemand.Status := LDemand.Status::Open;
              LDemand.Modify;
          end;
      end;


      procedure ReleasePR(var PRequest: Record "Purchase Header")
      begin
          PRequest.Reset;
          PRequest.SetRange(PRequest."No.", PRequest."No.");
          if PRequest.FindFirst then begin
              PRequest.Status := PRequest.Status::Released;
              PRequest.Modify;

          end;
      end;


      procedure ReleaseOverDraft(var OverDraft: Record "OverDraft Application")
      var
          OD: Record "OverDraft Application";
      begin
          OverDraft.Reset;
          OverDraft.SetRange(OverDraft."Document No", OverDraft."Document No");
          if OverDraft.FindFirst then begin
              OverDraft.Status := OverDraft.Status::Approved;
              OverDraft.Modify;
          end;
      end;


      procedure ReOpenOverDraft(var OverDraft: Record "OverDraft Application")
      var
          OD: Record "OverDraft Application";
      begin
          OverDraft.Reset;
          OverDraft.SetRange(OverDraft."Document No", OverDraft."Document No");
          if OverDraft.FindFirst then begin
              OverDraft.Status := OverDraft.Status::Open;
              OverDraft.Modify;
          end;
      end;


      procedure ReleaseLoanRestructure(var LoanRestructure: Record "Loan Restructure")
      var
          LRestructure: Record "Loan Restructure";
      begin
          LoanRestructure.Reset;
          LoanRestructure.SetRange(LoanRestructure."Document No", LoanRestructure."Document No");
          if LoanRestructure.FindFirst then begin
              LoanRestructure.Status := LoanRestructure.Status::Approved;
              LoanRestructure.Modify;
          end;
      end;


      procedure ReOpenLoanRestructure(var LoanRestructure: Record "Loan Restructure")
      var
          LRestructure: Record "Loan Restructure";
      begin
          LoanRestructure.Reset;
          LoanRestructure.SetRange(LoanRestructure."Document No", LoanRestructure."Document No");
          if LoanRestructure.FindFirst then begin
              LoanRestructure.Status := LoanRestructure.Status::Open;
              LoanRestructure.Modify;
          end;
      end;


      procedure ReleaseSweepingInstructions(var SweepingInstructions: Record "Member Sweeping Instructions")
      var
          SInstructions: Record "Member Sweeping Instructions";
      begin
          SweepingInstructions.Reset;
          SweepingInstructions.SetRange(SweepingInstructions."Document No", SweepingInstructions."Document No");
          if SweepingInstructions.FindFirst then begin
              SweepingInstructions.Status := SweepingInstructions.Status::Approved;
              SweepingInstructions.Modify;
          end;
      end;


      procedure ReOpenSweepingInstructions(var SweepingInstructions: Record "Member Sweeping Instructions")
      var
          SInstructions: Record "Member Sweeping Instructions";
      begin
          SweepingInstructions.Reset;
          SweepingInstructions.SetRange(SweepingInstructions."Document No", SweepingInstructions."Document No");
          if SweepingInstructions.FindFirst then begin
              SweepingInstructions.Status := SweepingInstructions.Status::Open;
              SweepingInstructions.Modify;
          end;
      end;


      procedure ReleaseChequeBook(var ChequeBook: Record "Cheque Book Application")
      var
          CBook: Record "Cheque Book Application";
      begin
          ChequeBook.Reset;
          ChequeBook.SetRange(ChequeBook."No.", ChequeBook."No.");
          if ChequeBook.FindFirst then begin
              ChequeBook.Status := ChequeBook.Status::Approved;
              ChequeBook.Modify;
          end;
      end;


      procedure ReOpenChequeBook(var ChequeBook: Record "Cheque Book Application")
      var
          CBook: Record "Cheque Book Application";
      begin
          ChequeBook.Reset;
          ChequeBook.SetRange(ChequeBook."No.", ChequeBook."No.");
          if ChequeBook.FindFirst then begin
              ChequeBook.Status := ChequeBook.Status::Open;
              ChequeBook.Modify;
          end;
      end;


      procedure ReleaseJournalBatch(var JournalBatch: Record "Gen. Journal Batch")
      var
          JBatch: Record "Gen. Journal Batch";
      begin
          JBatch.Reset;
          JBatch.SetRange(JBatch.Name, JournalBatch.Name);
          JBatch.SetRange(JBatch."Journal Template Name", JournalBatch."Journal Template Name");
          if JBatch.FindFirst then begin
              JBatch.Status := JBatch.Status::Approved;
              JBatch.Modify;
          end;
      end;


      procedure ReOpenJournalBatch(var JournalBatch: Record "Gen. Journal Batch")
      var
          JBatch: Record "Gen. Journal Batch";
      begin
          JBatch.Reset;
          JBatch.SetRange(JBatch.Name, JournalBatch.Name);
          JBatch.SetRange(JBatch."Journal Template Name", JournalBatch."Journal Template Name");
          if JBatch.FindFirst then begin
              JBatch.Status := JBatch.Status::Open;
              JBatch.Modify;
          end;
      end;


      procedure ReleaseLoanTrunchDisbursement(var LoanTrunchDisbursement: Record "Loan trunch Disburesment")
      var
          TrunchDisbursement: Record "Loan trunch Disburesment";
      begin
          LoanTrunchDisbursement.Reset;
          LoanTrunchDisbursement.SetRange(LoanTrunchDisbursement."Document No", LoanTrunchDisbursement."Document No");
          if LoanTrunchDisbursement.FindFirst then begin
              LoanTrunchDisbursement.Status := LoanTrunchDisbursement.Status::Approved;
              LoanTrunchDisbursement.Modify;
          end;
      end;


      procedure ReOpenLoanTrunchDisbursement(var LoanTrunchDisbursement: Record "Loan trunch Disburesment")
      var
          TrunchDisbursement: Record "Loan trunch Disburesment";
      begin
          LoanTrunchDisbursement.Reset;
          LoanTrunchDisbursement.SetRange(LoanTrunchDisbursement."Document No", LoanTrunchDisbursement."Document No");
          if LoanTrunchDisbursement.FindFirst then begin
              LoanTrunchDisbursement.Status := LoanTrunchDisbursement.Status::Open;
              LoanTrunchDisbursement.Modify;
          end;
      end;


      procedure ReleaseInwardChequeClearing(var InwardChequeClearing: Record "Cheque Receipts-Family")
      var
          InwardCheque: Record "Cheque Receipts-Family";
      begin
          InwardChequeClearing.Reset;
          InwardChequeClearing.SetRange(InwardChequeClearing."No.", InwardChequeClearing."No.");
          if InwardChequeClearing.FindFirst then begin
              InwardChequeClearing.Status := InwardChequeClearing.Status::Approved;
              InwardChequeClearing.Modify;
          end;
      end;


      procedure ReOpenInwardChequeClearing(var InwardChequeClearing: Record "Cheque Receipts-Family")
      var
          InwardCheque: Record "Cheque Receipts-Family";
      begin
          InwardChequeClearing.Reset;
          InwardChequeClearing.SetRange(InwardChequeClearing."No.", InwardChequeClearing."No.");
          if InwardChequeClearing.FindFirst then begin
              InwardChequeClearing.Status := InwardChequeClearing.Status::Open;
              InwardChequeClearing.Modify;
          end;
      end;


      procedure ReleaseInvalidPaybillTransactions(var InvalidPaybill: Record "Paybill Processing Header")
      var
          Paybill: Record "Paybill Processing Header";
      begin
          InvalidPaybill.Reset;
          InvalidPaybill.SetRange(InvalidPaybill.No, InvalidPaybill.No);
          if InvalidPaybill.FindFirst then begin
              InvalidPaybill.Status := InvalidPaybill.Status::Approved;
              InvalidPaybill.Modify;
          end;
      end;


      procedure ReOpenInvalidPaybillTransactions(var InvalidPaybill: Record "Paybill Processing Header")
      var
          Paybill: Record "Paybill Processing Header";
      begin
          InvalidPaybill.Reset;
          InvalidPaybill.SetRange(InvalidPaybill.No, InvalidPaybill.No);
          if InvalidPaybill.FindFirst then begin
              InvalidPaybill.Status := InvalidPaybill.Status::Open;
              InvalidPaybill.Modify;
          end;
      end;


      procedure ReleaseInternalPV(var InternalPV: Record "Internal PV Header")
      var
          InternalPaymentVoucher: Record "Internal PV Header";
      begin
          InternalPV.Reset;
          InternalPV.SetRange(InternalPV.No, InternalPV.No);
          if InternalPV.FindFirst then begin
              InternalPV.Status := InternalPV.Status::Approved;
              InternalPV.Modify;
          end;
      end;


      procedure ReOpenInternalPV(var InternalPV: Record "Internal PV Header")
      var
          InternalPaymentVoucher: Record "Internal PV Header";
      begin
          InternalPV.Reset;
          InternalPV.SetRange(InternalPV.No, InternalPV.No);
          if InternalPV.FindFirst then begin
              InternalPV.Status := InternalPV.Status::Open;
              InternalPV.Modify;
          end;
      end;


      procedure ReleaseSalaryProcessing(var SProcessing: Record "Salary Processing Headerr")
      var
          SalaryProcessing: Record "Salary Processing Headerr";
      begin
          SProcessing.Reset;
          SProcessing.SetRange(SProcessing.No, SProcessing.No);
          if SProcessing.FindFirst then begin
              SProcessing.Status := SProcessing.Status::Approved;
              SProcessing.Modify;
          end;
      end;


      procedure ReOpenSalaryProcessing(var SProcessing: Record "Salary Processing Headerr")
      var
          SalaryProcessing: Record "Salary Processing Headerr";
      begin
          SProcessing.Reset;
          SProcessing.SetRange(SProcessing.No, SProcessing.No);
          if SProcessing.FindFirst then begin
              SProcessing.Status := SProcessing.Status::Open;
              SProcessing.Modify;
          end;
      end;
 */
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PaymentHeader: Record "Payments Header";
        SaccoTransfers: Record "Sacco Transfers";
        ObjMembership: Record "Membership Applications";
        ObjLoans: Record "Loans Register";
        ObjLoanPayoff: Record "Loan PayOff";
        //  ObjLoanRestructure: Record "Loan Restructure";
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
        // LoanRestructure: Record "Loan Restructure";
        // SweepingInstructions: Record "Member Sweeping Instructions";
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', true, true)]
    local procedure OnSetStatusToPendingApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        IsHandled: Boolean;
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
        //SReq: Record "Store Requistion Header";
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
        // InternalPV: Record "Internal PV Header";
        JournalBatch: Record "Gen. Journal Batch";
        SProcessing: Record "Salary Processing Headerr";
        GuarantorshipSubstitution: Record "Guarantorship Substitution H";
    begin
        case RecRef.Number of
            //Payment Header
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    PaymentHeader.Validate(Status, PaymentHeader.Status::"Pending Approval");
                    PaymentHeader.Modify(true);
                    Variant := PaymentHeader;
                end;

            //Membership Application
            Database::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate(Status, MembershipApplication.Status::"Pending Approval");
                    MembershipApplication.Modify(true);
                    Variant := MembershipApplication;
                end;
            //Loan Application
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoanApplication);
                    LoanApplication.Validate("Loan Status", LoanApplication."loan status"::Appraisal);
                    LoanApplication.Validate("Approval Status", LoanApplication."approval status"::Pending);
                    LoanApplication.Modify(true);
                    Variant := LoanApplication;
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
                    Variant := LoanDisbursement;
                end;

            //Membership Withdrawal
            Database::"Membership Exit":
                begin
                    RecRef.SetTable(MWithdrawal);
                    MWithdrawal.Validate(Status, MWithdrawal.Status::Pending);
                    MWithdrawal.Modify(true);
                    Variant := MWithdrawal;
                end;

            //ATM Card
            Database::"ATM Card Applications":
                begin
                    RecRef.SetTable(ATMCard);
                    ATMCard.Validate(Status, ATMCard.Status::Pending);
                    ATMCard.Modify(true);
                    Variant := ATMCard;
                end;


            //Guarantor Recovery
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(GuarantorR);
                    GuarantorR.Validate(Status, GuarantorR.Status::Pending);
                    GuarantorR.Modify(true);
                    Variant := GuarantorR;
                end;

            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Validate(Status, ChangeRequest.Status::Pending);
                    ChangeRequest.Modify(true);
                    Variant := ChangeRequest;
                end;

            //Treasury Transaction
            Database::"Treasury Transactions":
                begin
                    RecRef.SetTable(TTransactions);
                    TTransactions.Validate(Status, TTransactions.Status::"Pending Approval");
                    TTransactions.Modify(true);
                    Variant := TTransactions;
                end;
            //FOSA Account Application
            Database::"FOSA Account Applicat. Details":
                begin
                    RecRef.SetTable(FAccount);
                    FAccount.Validate(Status, FAccount.Status::Pending);
                    FAccount.Modify(true);
                    Variant := FAccount;
                end;

            //Stores Requisition
            // Database::"Store Requistion Header":
            //     begin
            //         RecRef.SetTable(SReq);
            //         SReq.Validate(Status, SReq.Status::"Pending Approval");
            //         SReq.Modify(true);
            //         Variant := SReq;
            //     end;
            //Sacco Transfers
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Validate(Status, SaccoTransfers.Status::"Pending Approval");
                    SaccoTransfers.Modify(true);
                    Variant := SaccoTransfers;
                end;
            //Cheque Discounting
            Database::"Cheque Discounting":
                begin
                    RecRef.SetTable(ChequeDiscounting);
                    ChequeDiscounting.Validate(Status, ChequeDiscounting.Status::"Pending Approval");
                    ChequeDiscounting.Modify(true);
                    Variant := ChequeDiscounting;
                end;
            //Imprest Requisition
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ImprestRequisition.Validate(Status, ImprestRequisition.Status::"Pending Approval");
                    ImprestRequisition.Modify(true);
                    Variant := ImprestRequisition;
                end;
            //Imprest Surrender
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Validate(Status, ImprestSurrender.Status::"Pending Approval");
                    ImprestSurrender.Modify(true);
                    Variant := ImprestSurrender;
                end;
            //Leave Application
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Validate(Status, LeaveApplication.Status::"Pending Approval");
                    LeaveApplication.Modify(true);
                    Variant := LeaveApplication;
                end;
            //Bulk Withdrawal
            Database::"Bulk Withdrawal Application":
                begin
                    RecRef.SetTable(BulkWithdrawal);
                    BulkWithdrawal.Validate(Status, BulkWithdrawal.Status::"Pending Approval");
                    BulkWithdrawal.Modify(true);
                    Variant := BulkWithdrawal;
                end;
            //Package Lodge
            Database::"Safe Custody Package Register":
                begin
                    RecRef.SetTable(PackageLodge);
                    PackageLodge.Validate(Status, PackageLodge.Status::"Pending Approval");
                    PackageLodge.Modify(true);
                    Variant := PackageLodge;
                end;
            //Package Retrieval
            Database::"Package Retrieval Register":
                begin
                    RecRef.SetTable(PackageRetrieval);
                    PackageRetrieval.Validate(Status, PackageRetrieval.Status::"Pending Approval");
                    PackageRetrieval.Modify(true);
                    Variant := PackageRetrieval;
                end;

            //House Change
            Database::"House Group Change Request":
                begin
                    RecRef.SetTable(HouseChange);
                    HouseChange.Validate(Status, HouseChange.Status::"Pending Approval");
                    HouseChange.Modify(true);
                    Variant := HouseChange;
                end;

            //CRM
            Database::"CRM Trainings":
                begin
                    RecRef.SetTable(CRMTraining);
                    CRMTraining.Validate(Status, CRMTraining.Status::Pending);
                    CRMTraining.Modify(true);
                    Variant := CRMTraining;
                end;

            //Petty Cash
            Database::"Payment Header.":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Validate(Status, PettyCash.Status::"Pending Approval");
                    PettyCash.Modify(true);
                    Variant := PettyCash;
                end;

            //Staff Claims
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    StaffClaims.Validate(Status, StaffClaims.Status::"Pending Approval");
                    StaffClaims.Modify(true);
                    Variant := StaffClaims;
                end;

            //Member Agent/NOK Change
            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    MemberAgentNOKChange.Validate(Status, MemberAgentNOKChange.Status::"Pending Approval");
                    MemberAgentNOKChange.Modify(true);
                    Variant := MemberAgentNOKChange;
                end;

            //House Registration
            Database::"House Groups Registration":
                begin
                    RecRef.SetTable(HouseRegistration);
                    HouseRegistration.Validate(Status, HouseRegistration.Status::"Pending Approval");
                    HouseRegistration.Modify(true);
                    Variant := HouseRegistration;
                end;

            //Loan PayOff
            Database::"Loan PayOff":
                begin
                    RecRef.SetTable(LoanPayOff);
                    LoanPayOff.Validate(Status, LoanPayOff.Status::"Pending Approval");
                    LoanPayOff.Modify(true);
                    Variant := LoanPayOff;
                end;

            //Fixed Deposit
            Database::"Fixed Deposit Placement":
                begin
                    RecRef.SetTable(FixedDeposit);
                    FixedDeposit.Validate(Status, FixedDeposit.Status::"Pending Approval");
                    FixedDeposit.Modify(true);
                    Variant := FixedDeposit;
                end;

            //EFTRTGS
            Database::"EFT Details":
                begin
                    RecRef.SetTable(EFTRTGS);
                    EFTRTGS.Validate(Status, EFTRTGS.Status::"Pending Approval");
                    EFTRTGS.Modify(true);
                    Variant := EFTRTGS;
                end;

            //Loan Demand Notices
            Database::"Default Notices Register":
                begin
                    RecRef.SetTable(LDemand);
                    LDemand.Validate(Status, LDemand.Status::"Pending Approval");
                    LDemand.Modify(true);
                    Variant := LDemand;
                end;

            //Over Draft
            // Database::"OverDraft Application":
            //     begin
            //         RecRef.SetTable(OverDraft);
            //         OverDraft.Validate(Status, OverDraft.Status::"Pending Approval");
            //         OverDraft.Modify(true);
            //         Variant := OverDraft;
            //     end;

            // //Loan Restructure
            // Database::"Loan Restructure":
            //     begin
            //         RecRef.SetTable(LoanRestructure);
            //         LoanRestructure.Validate(Status, LoanRestructure.Status::"Pending Approval");
            //         LoanRestructure.Modify(true);
            //         Variant := LoanRestructure;
            //     end;

            // //Sweeping Instructions
            // Database::"Member Sweeping Instructions":
            //     begin
            //         RecRef.SetTable(SweepingInstructions);
            //         SweepingInstructions.Validate(Status, SweepingInstructions.Status::"Pending Approval");
            //         SweepingInstructions.Modify(true);
            //         Variant := SweepingInstructions;
            //     end;

            //Cheque Book Application
            Database::"Cheque Book Application":
                begin
                    RecRef.SetTable(ChequeBook);
                    ChequeBook.Validate(Status, ChequeBook.Status::"Pending Approval");
                    ChequeBook.Modify(true);
                    Variant := ChequeBook;
                end;


            //Loan Trunch
            Database::"Loan trunch Disburesment":
                begin
                    RecRef.SetTable(LoanTrunch);
                    LoanTrunch.Validate(Status, LoanTrunch.Status::Pending);
                    LoanTrunch.Modify(true);
                    Variant := LoanTrunch;
                end;

            //Inward Cheque Clearing
            Database::"Cheque Receipts-Family":
                begin
                    RecRef.SetTable(InwardChequeClearing);
                    InwardChequeClearing.Validate(Status, InwardChequeClearing.Status::"Pending Approval");
                    InwardChequeClearing.Modify(true);
                    Variant := InwardChequeClearing;
                end;

            //Invalid Paybill Transactions
            Database::"Paybill Processing Header":
                begin
                    RecRef.SetTable(InvalidPaybillTransactions);
                    InvalidPaybillTransactions.Validate(Status, InvalidPaybillTransactions.Status::"Pending Approval");
                    InvalidPaybillTransactions.Modify(true);
                    Variant := InvalidPaybillTransactions;
                end;

            //Internal PV
            // Database::"Internal PV Header":
            //     begin
            //         RecRef.SetTable(InternalPV);
            //         InternalPV.Validate(Status, InternalPV.Status::"Pending Approval");
            //         InternalPV.Modify(true);
            //         Variant := InternalPV;
            //     end;

            //Journal Batch
            Database::"Gen. Journal Batch":
                begin
                    RecRef.SetTable(JournalBatch);
                    JournalBatch.Validate(Status, JournalBatch.Status::"Pending Approval");
                    JournalBatch.Modify(true);
                    Variant := JournalBatch;
                end;

            //Salary Processing
            Database::"Salary Processing Headerr":
                begin
                    RecRef.SetTable(SProcessing);
                    SProcessing.Validate("Approval Status", SProcessing."Approval Status"::"Pending");
                    SProcessing.Modify(true);
                    Variant := SProcessing;
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
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
        PaymentHeader: Record "Payments Header";
        LoanPayOff: Record "Loan PayOff";
        GuarantorRecovery: Record "Loan Recovery Header";
        LoanDisbursememnt: Record "Loan Disburesment-Batching";
        SalaryProcessingHeader: Record "Salary Processing Headerr";
        //FosaAccountOpenning: Record "FOSA Account Applicat. Details";
        FAccount: Record "FOSA Account Applicat. Details";
        EFTRTGS: record "EFT Details";
        LeaveApp: Record "HR Leave Application";
    begin
        case RecRef.Number of
            database::"HR Leave Application":
                begin
                    RecRef.SetTable(LeaveApp);
                    LeaveApp.Status := LeaveApp.Status::Approved;
                    LeaveApp.Modify(true);
                    Handled := true;
                end;
            database::"EFT Details":
                begin
                    RecRef.SetTable(EFTRTGS);
                    EFTRTGS.Status := EFTRTGS.Status::Approved;
                    EFTRTGS.Modify(true);
                    Handled := true;
                end;
            DATABASE::"Membership Applications":
                begin
                    RecRef.SetTable(MemberShipApp);
                    MemberShipApp.Status := MemberShipApp.Status::Approved;
                    MemberShipApp.Modify(true);
                    Handled := true;
                end;
            Database::"FOSA Account Applicat. Details":
                begin
                    RecRef.SetTable(FAccount);
                    FAccount.Status := FAccount.status::Approved;
                    FAccount.Modify();
                    Handled := true;
                end;
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Status := SaccoTransfers.Status::Approved;
                    SaccoTransfers.Modify(true);
                    Handled := true;
                end;
            Database::"Salary Processing Headerr":
                begin
                    RecRef.SetTable(SalaryProcessingHeader);
                    SalaryProcessingHeader."Approval Status" := SalaryProcessingHeader."Approval Status"::released;
                    SalaryProcessingHeader.Modify(true);
                    Handled := true;
                end;
            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    MemberAgentNOKChange.Status := MemberAgentNOKChange.Status::Approved;
                    MemberAgentNOKChange.Modify(true);
                    Handled := true;
                end;
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanDisbursememnt);
                    LoanDisbursememnt.Status := LoanDisbursememnt.Status::Approved;
                    LoanDisbursememnt.Modify(true);
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
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    PaymentHeader.Status := PaymentHeader.Status::Approved;
                    PaymentHeader.Modify(true);
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

}

