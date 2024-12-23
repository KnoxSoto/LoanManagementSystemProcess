public with sharing class payScheduleController {

    // Method to generate payment schedules
    public static List<Payment_Schedule__c> generatePaymentSchedule(List<Loan_Application__c> loanList) {
        // Validate input
        if (loanList == null || loanList.isEmpty()) {
            return new List<Payment_Schedule__c>();
        }

        // Initialize the list to hold payment schedules
        List<Payment_Schedule__c> paymentScheduleList = new List<Payment_Schedule__c>();

        // Iterate through the loan applications
        for (Loan_Application__c loan : loanList) {
            if (loan.Monthly_Installment__c == null || loan.Loan_duration__c == null) {
                continue; // Skip loan records missing required information
            }

            // Generate payment schedule entries for the loan
            for (Integer i = 1; i <= loan.Loan_duration__c; i++) {
                Payment_Schedule__c paymentSchedule = new Payment_Schedule__c();
                paymentSchedule.Name = loan.Name + ' Payment Schedule ' + i;
                paymentSchedule.Installment_Number__c = i;
                paymentSchedule.Due_Date__c = calculateDueDate(i, loan.Approval_Date__c);
                paymentSchedule.Amount__c = loan.Monthly_Installment__c;

                paymentScheduleList.add(paymentSchedule);
            }
        }

        // Return the list of payment schedules
        return paymentScheduleList;
    }

    // Helper method to calculate due dates
    private static Date calculateDueDate(Integer installmentNumber, Date startDate) {
        if (startDate == null) {
            return null; // Return null if the start date is missing
        }
        // Add months to the start date based on the installment number
        return startDate.addMonths(installmentNumber - 1);
    }
}
