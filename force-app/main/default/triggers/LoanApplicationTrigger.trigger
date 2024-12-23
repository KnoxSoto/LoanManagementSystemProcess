trigger LoanApplicationTrigger on Loan_Application__c (
        before insert, after insert,
        before update, after update,
        before delete, after delete,
        after undelete
    ) {
        // Handle before insert logic
        if (Trigger.isBefore && Trigger.isInsert) {
            List<Loan_Application__c> newLoanList = Trigger.new;

            for (Loan_Application__c loan : newLoanList) {
                // Add your before insert logic here
                // Example: Validating or modifying loan records before saving
                if (loan.Loan_Amount__c == null || loan.Interest_Rate__c == null || loan.Loan_Duration__c == null) {
                    loan.addError('Loan Amount,Interest Rate,Loan Duration need to be filled in');
                }
            }
        }
        if (Trigger.isBefore && Trigger.isInsert) {
            // Calculate Monthly Installment after record is inserted
            List<Loan_Application__c> loansToUpdate = new List<Loan_Application__c>();
    
            for (Loan_Application__c loan : Trigger.new) {
                if (loan.Loan_Amount__c != null && loan.Interest_Rate__c != null && loan.Loan_Duration__c != null) {
                    loan.Monthly_Installment__c = LoanCalculatorService.calculateMonthlyInstallment(
                        loan.Loan_Amount__c, 
                        loan.Interest_Rate__c, 
                        loan.Loan_Duration__c.intValue()
                    );
                }
            }

        if (Trigger.isBefore && Trigger.isUpdate) {
            for (Loan_Application__c loan : Trigger.new) {
                // Add before update logic here
            }
        }

        if (Trigger.isAfter && Trigger.isUpdate) {
            for (Loan_Application__c loan : Trigger.new) {
                if(loan.Status__c == 'Approved'){
                    payScheduleController.generatePaymentSchedule(Trigger.new);
                }
            }
        }

        if (Trigger.isBefore && Trigger.isDelete) {
            for (Loan_Application__c loan : Trigger.old) {
                // Add before delete logic here
            }
        }

        if (Trigger.isAfter && Trigger.isDelete) {
            for (Loan_Application__c loan : Trigger.old) {
                // Add after delete logic here
            }
        }

        if (Trigger.isAfter && Trigger.isUndelete) {
            for (Loan_Application__c loan : Trigger.new) {
                // Add after undelete logic here
            }
        }
    }
    }