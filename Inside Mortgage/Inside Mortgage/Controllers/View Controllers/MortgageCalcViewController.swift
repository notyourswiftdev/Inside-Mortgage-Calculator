//
//  MortgageCalcViewController.swift
//  Inside Mortgage
//
//  Created by Aaron Cleveland on 12/28/19.
//  Copyright © 2019 Aaron Cleveland. All rights reserved.
//

import UIKit
import Charts

class MortgageCalcViewController: UIViewController {
    
    //MARK: - Variables
    let loanModel = LoanModelController()
    var term = 0
    
    //MARK: - IBOutlet
//    @IBOutlet var chartsView: PieChartView!
    @IBOutlet weak var monthlyPaymentsLabel: UILabel!
    @IBOutlet weak var principleLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var numberOfPaymentsLabel: UILabel!
    //textfield outlets
    @IBOutlet weak var homePriceTextField: UITextField!
    @IBOutlet weak var downPaymentTextField: UITextField!
    @IBOutlet weak var ratesTextField: UITextField!
    //slider outlets
    @IBOutlet weak var homeSlider: UISlider!
    @IBOutlet weak var downPaymentSlider: UISlider!
    @IBOutlet weak var ratesSlider: UISlider!
    //segmented outlets
    @IBOutlet weak var termSegment: UISegmentedControl!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homePriceTextField.delegate = self
        downPaymentTextField.delegate = self
        termSegment.addTarget(self, action: #selector(MortgageCalcViewController.termSegment(_:)), for: .valueChanged)
        update()
    }
    
    //MARK: - IBActions
    @IBAction func homePricedSlider(_ sender: Any) {
        homePriceTextField.text = loanModel.currencyFormatter(xxx: homeSlider.value)
        update()
    }
    
    @IBAction func downPaySlider(_ sender: Any) {
        downPaymentTextField.text = loanModel.currencyFormatter(xxx: downPaymentSlider.value)
        update()
    }
    
    @IBAction func ratesInterestSlider(_ sender: Any) {
        ratesTextField.text = loanModel.percentFormatter(xxx: ratesSlider.value)
        update()
    }
    
    @IBAction func termSegment(_ sender: UISegmentedControl) {
        switch termSegment.selectedSegmentIndex {
        case 0:
            term = 30
        case 1:
            term = 15
        default:
            break
        }
        update()
    }
    
    
    
    //MARK: - Helper Functions
    func update() {
        principleLabel.text = loanModel.createPrinciple(with: Double(homeSlider.value), downPayment: Double(downPaymentSlider.value))
        interestLabel.text = loanModel.createInterestRate(with: Double(ratesSlider.value))
        numberOfPaymentsLabel.text = loanModel.createNumberOfPayments(with: Double(term) * 12.0)
//        monthlyPaymentsLabel.text = loanModel.createMonthlyPayment(with: Double(homeSlider.value), downPayment: Double(downPaymentSlider.value), interestRate: Double(ratesSlider.value), termPeriod: Double(termSegment.selectedSegmentIndex))
    }
}

//MARK: - Extensions
extension MortgageCalcViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let unwrapTextFieldText = textField.text,
            let unwrappedPrice = Float(unwrapTextFieldText) else {
                return
        }
        switch textField {
        case homePriceTextField:
            homeSlider.value = Float(unwrappedPrice)
        case downPaymentTextField:
            downPaymentSlider.value = Float(unwrappedPrice)
        case ratesTextField:
            ratesSlider.value = Float(unwrappedPrice)
        default:
            break
        }
    }
}
