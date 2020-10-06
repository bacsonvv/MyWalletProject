//
//  AddTrasactionController.swift
//  MyWallet
//
//  Created by BAC Vuong Toan (VTI.Intern) on 9/21/20.
//  Copyright © 2020 THUY Nguyen Duong Thu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class AddTransactionController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfNote: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var tfCategory: UITextField!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tfEvent: UITextField!
    @IBOutlet weak var iconEvent: UIImageView!
    @IBOutlet weak var viewShowMore: UIView!
    
    @IBOutlet var btnAddMore: UIButton!
    @IBOutlet var btnCancel: UIBarButtonItem!
    @IBOutlet var btnSave: UIBarButtonItem!
    var nameCategory: String = ""
    var iconImages: String = ""
    var date: String = ""
    var amount: Int = 0
    var categoryid: String = ""
    var type: String = ""
    var thisDate = Date()
    var budgets = [Budget]()
    private let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewShowMore.isHidden = true
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        tfCategory.text = nameCategory
        iconImage.image = UIImage(named: iconImages)
        tfDate.text = date
        tfDate.delegate = self
        tfAmount.delegate = self
        tfCategory.delegate = self
        tfNote.delegate = self
        btnSave.isEnabled = false
        customizeLayout()
        addEvent()
        fetchDataBudget()
        
    }
    
    func customizeLayout(){
        btnAddMore.layer.borderWidth = 1
        btnAddMore.layer.borderColor = #colorLiteral(red: 0.3929189782, green: 0.4198221317, blue: 0.8705882353, alpha: 1)
        btnAddMore.layer.cornerRadius = 6
        
        tfCategory.setRightImage2(imageName: "arrowright")
        tfDate.setRightImage2(imageName: "arrowright")
        tfEvent.setRightImage2(imageName: "arrowright")
    }
    
    func addEvent()  {
        tfCategory.addTarget(self, action: #selector(myCategory), for: .touchDown)
        tfDate.addTarget(self, action: #selector(myDate), for: .touchDown)
        tfEvent.addTarget(self, action: #selector(myEven), for: .touchDown)
    }
    
    @objc func myCategory(textField: UITextField) {
        let vc = UIStoryboard.init(name: Constant.detailsTransaction, bundle: nil).instantiateViewController(withIdentifier: "selectCategory") as? SelectCategoryController
        vc?.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func myDate(textField: UITextField) {
        let vc = UIStoryboard.init(name: Constant.detailsTransaction, bundle: nil).instantiateViewController(withIdentifier: "customDate") as? CustomDateController
        if tfDate.text != "" {
            thisDate = dateFormatter.date(from: tfDate.text!)!
        }
        vc?.customDate = thisDate
        vc?.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @objc func myEven(textField:UITextField){
        let vc = UIStoryboard.init(name: Constant.detailsTransaction, bundle: nil).instantiateViewController(withIdentifier: "selectEvent") as! SelectEventController
        vc.delegate = self
        let presenter = SelectEventPresenter(delegate: vc, usecase: SelectEventUserCase())
        vc.setUp(presenter: presenter)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func clickCancel(_ sender: Any) {
        let vc = RouterType.tabbar.getVc()
        AppRouter.routerTo(from: vc, options: .curveEaseOut, duration: 0.2, isNaviHidden: true)
        
    }
    @IBAction func btnSave(_ sender: Any) {
        if let strAmount = tfAmount.text,
            let intAmount = Int(strAmount){
            amount = intAmount
            if amount <= 0{
                let alert = UIAlertController(title: "Notification", message: "Amount of money cannot be 0", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        let writeData: [String: Any] = [
            "date": tfDate.text!,
            "note": tfNote.text!,
            "amount" :amount,
            "categoryid": categoryid,
            "eventid":tfEvent.text!]
        print("my categoryid ahihi: \(categoryid)")
        Defined.ref.child("Account/userid1/transaction/\(type)").childByAutoId().setValue(writeData)
        //check budget
        modifyBudget(list: budgets, date: dateFormatter.date(from: tfDate.text!)!, aAmount: amount)
        let alert = UIAlertController(title: "Notification", message: "Add a new transaction successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            let vc = RouterType.tabbar.getVc()
            AppRouter.routerTo(from: vc, options: .curveEaseOut, duration: 0.2, isNaviHidden: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func modifyBudget(list: [Budget], date: Date, aAmount: Int){
        print("budget list: \(list)")
        for a in list {
            let startDate = Defined.convertStringToDate(str: a.startDate!)
            let endDate = Defined.convertStringToDate(str: a.endDate!)
            if startDate.compare(date) != .orderedDescending && date.compare(endDate) != .orderedDescending {
                print("Yes in this case")
                let newValue = a.amount! + aAmount
                Defined.ref.child("Account/userid1/budget/\(a.id)").updateChildValues(["amount": newValue]){(error,ref) in
                }
            } else {
                print("no in this case")
            }
        }
    }
    
    func fetchDataBudget(){
        let dispatchGroup = DispatchGroup()
        
        print("my categoryid: \(categoryid)")
        dispatchGroup.enter()
        //start loading
        
        Defined.ref.child("Account/userid1/budget").observeSingleEvent(of: .value) {[weak self] (snapshot) in
            guard let `self` = self else {return}
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshots {
                    if let value = snap.value as? [String: Any]{
                        if let id = Int(snap.key),
                            let dateStart = value["startDate"] as? String,
                            let dateEnd = value["endDate"] as? String,
                            let categoryid = value["categoryId"] as? String,
                            let amount = value["amount"] as? Int {
                            print("budget categoryid: \(categoryid)")
                            if categoryid == self.categoryid {
                                let bud = Budget(id: id, categoryId: categoryid, amount: amount, startDate: dateStart, endDate: dateEnd)
                                self.budgets.append(bud)
                            }
                        }
                    }
                }
                dispatchGroup.leave()
            }
        }
        
    }
    
    @IBAction func btnAddMoreDetails(_ sender: Any) {
        
        viewShowMore.isHidden = false
        btnAddMore.isHidden = true
    }
    
    @IBAction func btnDeleteMoreDetails(_ sender: Any) {
        tfEvent.text = ""
        iconEvent.image = UIImage(named: "others")
    }
    //TODO: - Fix only enable button all textfields except tfNote is not empty
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowCharacters = "0123456789"
        let allowCharacterSet = CharacterSet(charactersIn: allowCharacters)
        let typeCharacterSet = CharacterSet(charactersIn: string)
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if !text.isEmpty {
            btnSave.isEnabled = true
        } else {
            btnSave.isEnabled = false
        }
        if textField == tfAmount {
            return allowCharacterSet.isSuperset(of: typeCharacterSet)
        }
        return true
    }
}

extension AddTransactionController: SelectCategory, SelectDate, SelectEvent{
    func setEvent(nameEvent: String, imageEvent: String) {
        tfEvent.text = nameEvent
        iconEvent.image = UIImage(named: imageEvent)
    }
    
  
    
    func setDate(date: String) {
        tfDate.text = date
    }
    
    func setCategory(nameCategory: String, iconCategory: String, type: String, id: String) {
        self.categoryid = id
        self.type = type
        tfCategory.text = nameCategory
        iconImage.image = UIImage(named: iconCategory)
    }
}

