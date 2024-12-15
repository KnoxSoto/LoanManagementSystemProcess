public with sharing class LoanCalculatorService {
    public static Decimal calculateMonthlyInstallment(Decimal loanAmount, Decimal annualInterestRate, Integer durationYears) {
        // Convert annual interest rate to monthly interest rate
        Double monthlyInterestRate = (annualInterestRate / 12 / 100).doubleValue();

        // Total number of months
        Integer totalMonths = durationYears * 12;

        // Simplified monthly installment calculation
        Double denominator = 1 - Math.pow(1 + monthlyInterestRate, -totalMonths);

      
        Double monthlyPayment = (loanAmount.doubleValue() * monthlyInterestRate) / denominator;

        // Convert result back to Decimal and return
        return Decimal.valueOf(monthlyPayment).setScale(2);
    }
}
