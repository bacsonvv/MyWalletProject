//
//  SettingsViewController.swift
//  MyWalletProject
//
//  Created by Vuong Vu Bac Son on 9/23/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import UIKit

protocol SettingsViewControllerProtocol {
    func showAlert(_ message: String, _ state: Bool)
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var avaImage: UIImageView!
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtBalance: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtLanguage: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var presenter: SettingsPresenter = SettingsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeRoundedImage()
        configureButton(btnSave)
        configureButton(btnCancel)
    }
    
    // MARK: - Rounded user's avatar
    func makeRoundedImage() {
        avaImage.layer.borderWidth = 1
        avaImage.layer.masksToBounds = false
        avaImage.layer.backgroundColor = UIColor.systemPink.cgColor
        avaImage.layer.cornerRadius = avaImage.frame.height / 2
        avaImage.clipsToBounds = true
    }
    
    // MARK: - Make rounded buttons
    func configureButton(_ button: UIButton) {
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        presenter.viewDelegate = self
        
        var user = Account()
        user.name = txtUsername.text!
        user.balance = Int(txtBalance.text!) ?? -1
        user.email = "bacsonvv@gmail.com"
        user.dateOfBirth = txtDate.text!
        user.phoneNumber = txtPhoneNumber.text!
        user.gender = txtGender.text!
        user.address = txtAddress.text!
        user.language = txtLanguage.text!
        
        presenter.validateInput(user)
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
    }
}

extension SettingsViewController: SettingsViewControllerProtocol {
    func showAlert(_ message: String, _ state: Bool) {
        if !state {
            let alert = UIAlertController(title: "INVALID TRANSACTION", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "SUCCESS", message: "Your information has successfully been updated", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
