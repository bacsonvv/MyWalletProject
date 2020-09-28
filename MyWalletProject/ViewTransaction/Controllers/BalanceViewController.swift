//
//  BalanceViewController.swift
//  MyWallet
//
//  Created by THUY Nguyen Duong Thu on 9/21/20.
//  Copyright © 2020 THUY Nguyen Duong Thu. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController {

    
    @IBOutlet var txtAmount: UITextField!
    @IBOutlet var btnCancel: UIBarButtonItem!
    @IBOutlet var btnSave: UIBarButtonItem!
    var balance = MyDatabase.defaults.integer(forKey: Key.balance)
    private var formatter = NumberFormatter()
    override func viewDidLoad() {
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        if balance == 0 {
            balance = 100
            MyDatabase.defaults.set(balance, forKey: Key.balance)
        }
        super.viewDidLoad()
        txtAmount.delegate = self
        txtAmount.text = "\(formatter.string(from: NSNumber(value: balance))!)"
    }
    
    
    @IBAction func clickSave(_ sender: Any) {
        if let balanceStr = txtAmount.text,
            let balancInt = Int(balanceStr){
            MyDatabase.defaults.set(balancInt, forKey: Key.balance)
            balance = balancInt
            MyDatabase.ref.child("Account/userid1/information").updateChildValues(["balance": balancInt]){ (error,reference) in
                
            }
        }
        self.dismiss(animated: true, completion: nil)
        self.modalPresentationStyle = .fullScreen
    }
    @IBAction func clickCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.modalPresentationStyle = .fullScreen
        
    }
}
extension BalanceViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //only text num
        let allowCharacters = "0123456789"
        let allowCharacterSet = CharacterSet(charactersIn: allowCharacters)
        let typeCharacterSet = CharacterSet(charactersIn: string)
        return allowCharacterSet.isSuperset(of: typeCharacterSet)
    }
}
