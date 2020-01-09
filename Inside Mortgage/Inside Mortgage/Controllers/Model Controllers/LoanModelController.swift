//
//  LoanModelController.swift
//  Inside Mortgage
//
//  Created by Aaron Cleveland on 1/5/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation
import UIKit
import Charts

//struct LoanData {
//    var monthlyPayment: Double?
//    var principle: Double?
//    var monthlyInterest: Double?
//    var termLife: Double?
//}

class LoanModelController {
    //M = P[r(1+r)^n/((1+r)^n)-1)]
    //
    //M = the total monthly mortgage payment.
    //P = the principal loan amount.
    //r = your monthly interest rate. Lenders provide you an annual rate so you’ll need to divide that figure by 12 (the number of months in a year) to get the monthly rate. If your interest rate is 5%, your monthly rate would be 0.004167 (0.05/12=0.004167)
    //n = number of payments over the loan’s lifetime. Multiply the number of years in your loan term by 12 (the number of months in a year) to get the number of payments for your loan. For example, a 30-year fixed mortgage would have 360 payments (30x12=360)

    var loan = LoanData()
    
    func createPrinciple(with homePrice: Double?, downPayment: Double?) -> String {
        guard let unwrapHomePrice = homePrice,
            let unwrapDownPayment = downPayment else { return "" }
        loan.principle = (unwrapHomePrice - unwrapDownPayment)
            return currencyFormatter(xxx: Float(unwrapHomePrice - unwrapDownPayment))
    }
    
    func createInterestRate(with annualRate: Double?) -> String {
        guard let unwrapAnnual = annualRate else { return "" }
        let monthlyInterest = unwrapAnnual / 12
        return currencyFormatter(xxx: Float(monthlyInterest))
    }
    
    func createNumberOfPayments(with termLife: Double?, numberOfPayments: Double? = 12.0) -> String {
        guard let unwrapTerm = termLife,
            let unwrapNOP = numberOfPayments else { return "" }
        let numberOfPayments = unwrapTerm * unwrapNOP
        return String(numberOfPayments)
    }
    
    func currencyFormatter(xxx: Float) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_US")
        return currencyFormatter.string(from: xxx as NSNumber) ?? ""
    }
    
    func percentFormatter(xxx: Float) -> String {
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = NumberFormatter.Style.percent
        percentFormatter.multiplier = 1
        percentFormatter.minimumFractionDigits = 1
        percentFormatter.maximumFractionDigits = 3
        percentFormatter.locale = Locale(identifier: "en_US")
        return percentFormatter.string(from: xxx as NSNumber) ?? ""
    }
}

//
//
//let loan:(principal: Double, interestRate: Double, period: Double) = (93000.0, 4.125, 360.0)
//
//let monthlyPayment = (loan.0 * ((loan.1/100) / 12)) / (1 - pow(1+((loan.1/100)/12), -loan.2))
//
//print(String(format: "Your Monthly Mortgage Payment is:  $ %.2f", monthlyPayment))
//

