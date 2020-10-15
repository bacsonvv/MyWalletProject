//
//  CurrencyViewController.swift
//  MyWalletProject
//
//  Created by Vuong Vu Bac Son on 9/23/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    @IBOutlet weak var txtVND: UITextField!
    @IBOutlet weak var txtUSD: UITextField!
    @IBOutlet weak var txtEUR: UITextField!
    @IBOutlet weak var txtJPY: UITextField!
    @IBOutlet weak var txtKRW: UITextField!
    @IBOutlet weak var txtCNY: UITextField!
    @IBOutlet weak var txtSGD: UITextField!
    @IBOutlet weak var txtAUD: UITextField!
    @IBOutlet weak var txtCAD: UITextField!
    
    @IBOutlet weak var btnChangeCurrency: UIButton!
    
    public var presenter: CurrencyPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFieldDelegate()
        configureButton(btnChangeCurrency)
        disabledEdittingTextField([txtUSD, txtEUR, txtJPY, txtKRW, txtCNY, txtSGD, txtAUD, txtCAD])
        
        presenter?.fetchData()
        
        self.title = Constants.currencyExchange
    }
    
    // MARK: - Hide tab bar
    override var hidesBottomBarWhenPushed: Bool {
        get {
            return true
        }
        set {
            super.hidesBottomBarWhenPushed = newValue
        }
    }
    
    // MARK: - Setup text field delegate
    func setupTextFieldDelegate() {
        txtVND.delegate = self
    }
    
    // MARK: - Disable editable text in other currencies text field
    func disabledEdittingTextField(_ textFields: [UITextField]) {
        textFields.forEach { (textField) in
            textField.isEnabled = false
            textField.isUserInteractionEnabled = false
        }
    }
    
    // MARK: - Setup delegate
    func setupDelegate(presenter: CurrencyPresenter) {
        self.presenter = presenter
    }
    
    // MARK: - Make rounded buttons
    func configureButton(_ button: UIButton) {
        button.layer.cornerRadius = 10
    }
    
    // MARK: - Hide keyboard when tap on view or hit return key
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func btnChangeCurrencyClick(_ sender: Any) {
        if txtVND.text == "" {
            AlertUtil.showAlert(from: self, with: Constants.alertInvalidActionTitle, message: Constants.moneyCurrencyBlank)
        } else {
            let amount = Double(txtVND.text!) ?? 0
            presenter?.exchangeCurrency(amount: amount)
        }
    }
}

// MARK: - Restrict text field accepts number only
extension CurrencyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
}

extension CurrencyViewController: CurrencyPresenterDelegate {
    func setupForViews(resultModel: ResultData) {
        txtUSD.text = "\(resultModel.USD)"
        txtEUR.text = "\(resultModel.EUR)"
        txtJPY.text = "\(resultModel.JPY)"
        txtKRW.text = "\(resultModel.KRW)"
        txtCNY.text = "\(resultModel.CNY)"
        txtSGD.text = "\(resultModel.SGD)"
        txtAUD.text = "\(resultModel.AUD)"
        txtCAD.text = "\(resultModel.CAD)"
    }
}

