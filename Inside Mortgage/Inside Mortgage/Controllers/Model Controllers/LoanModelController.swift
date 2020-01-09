//
//  LoanModelController.swift
//  Inside Mortgage
//
//  Created by Aaron Cleveland on 1/5/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation
import UIKit

// Step1: monthlyInterest = divide annual percent by 12(months)
// Step2: add 1 to the monthlyInterest
// Step3: multiply termLife(30 or 15 years) by 12(months of payment)(360 or 180)
// Step4: raise the monthlyInterest to the negative power of the termLife payments(360 or 180)
// Step5: subtract the new monthlyInterest from 1
// Step6: divide the old monthlyInterest(before adding the 1) by the number in step5
// Step7: multiply the number from step6 by loanAmount = monthly payment

class LoanModelController {

    var loan = LoanData()
    
    func createPrinciple(with homePrice: Double?, downPayment: Double?) -> String {
        guard let unwrapHomePrice = homePrice,
            let unwrapDownPayment = downPayment else { return "" }
        return currencyFormatter(xxx: Double(unwrapHomePrice - unwrapDownPayment))
    }
    
    func createInterestRate(with annualRate: Double?) -> String {
        guard let unwrapAnnualRate = annualRate else { return "" }
        let monthlyInterest = unwrapAnnualRate / 12
        return percentFormatter(xxx: Double(1+(monthlyInterest / 100)))
    }
    
    func createNumberOfPayments(with termLife: Double?) -> String {
        guard let unwrapTerm = termLife else { return "" }
        return String(unwrapTerm)
    }
    
    func createMonthlyPayments(with homePrice: Double?, downPay: Double?, annualRate: Double?, termLife: Double?) -> String {
        guard let unwrapHomePrice = homePrice,
            let unwrapDownPayment = downPay,
            let unwrapAnnualRate = annualRate,
            let unwrapTerm = termLife else { return "" }
        let principle = unwrapHomePrice - unwrapDownPayment
        return currencyFormatter(xxx: Double(principle * ((unwrapAnnualRate/100) / 12)) / (1 - pow(1+((unwrapAnnualRate/100)/12), -unwrapTerm)))
    }
    
    func currencyFormatter(xxx: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_US")
        return currencyFormatter.string(from: xxx as NSNumber) ?? ""
    }
    
    func percentFormatter(xxx: Double) -> String {
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .decimal
        percentFormatter.multiplier = 1
        percentFormatter.usesSignificantDigits = true
        percentFormatter.minimumSignificantDigits = 4
        percentFormatter.locale = Locale(identifier: "en_US")
        return percentFormatter.string(from: xxx as NSNumber) ?? ""
    }
}
