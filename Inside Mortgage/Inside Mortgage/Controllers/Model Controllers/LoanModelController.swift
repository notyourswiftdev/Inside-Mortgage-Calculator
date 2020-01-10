//
//  LoanModelController.swift
//  Inside Mortgage
//
//  Created by Aaron Cleveland on 1/5/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation
import UIKit

class LoanModelController {
    
    func createPrinciple(with homePrice: Double?, downPayment: Double?) -> String {
        guard let unwrapHomePrice = homePrice,
            let unwrapDownPayment = downPayment else { return "0" }
        return currencyFormatter(xxx: Double(unwrapHomePrice - unwrapDownPayment))
    }
    
    func createInterestRate(with annualRate: Double?) -> String {
        guard let unwrapAnnualRate = annualRate else { return "0" }
        let monthlyInterest = unwrapAnnualRate / 12
        return percentFormatter(xxx: Double(1+(monthlyInterest / 100)))
    }
    
    func createNumberOfPayments(with termLife: Int?) -> String {
        guard let unwrapTerm = termLife else { return "0" }
        return String(unwrapTerm)
    }
    
    func createMonthlyPayments(with homePrice: Double?, downPay: Double?, annualRate: Double?, termLife: Double?) -> String {
        guard let unwrapHomePrice = homePrice,
            let unwrapDownPayment = downPay,
            let unwrapAnnualRate = annualRate,
            let unwrapTerm = termLife else { return "0" }
        
        let annualRate = max(0.00001, unwrapAnnualRate)
        let principle = unwrapHomePrice - unwrapDownPayment
        return currencyFormatter(xxx: Double(principle * ((annualRate/100) / 12)) / (1 - pow(1+((annualRate/100)/12), -unwrapTerm)))
    }
    
    func currencyFormatter(xxx: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_US")
        return currencyFormatter.string(from: xxx as NSNumber) ?? "0"
    }
    
    func percentFormatter(xxx: Double) -> String {
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .decimal
        percentFormatter.multiplier = 1
        percentFormatter.usesSignificantDigits = true
        percentFormatter.minimumSignificantDigits = 4
        percentFormatter.locale = Locale(identifier: "en_US")
        return percentFormatter.string(from: xxx as NSNumber) ?? "0"
    }
}
