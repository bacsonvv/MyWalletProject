//
//  PlanningCell.swift
//  MyWalletProject
//
//  Created by THUY Nguyen Duong Thu on 10/1/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import UIKit

class PlanningCell: BaseTBCell{

    @IBOutlet var rightArrow2: UIImageView!
    @IBOutlet var rightArrow1: UIImageView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var budgetView: UIView!
    @IBOutlet weak var lblBudgets: UILabel!
    @IBOutlet weak var lblContent1: UILabel!
    @IBOutlet weak var lblContent2: UILabel!
    @IBOutlet weak var lblEvents: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        customizeLayout()
        addTapGestures()
        // Initialization code
    }
    
    func setLanguage(language:String){
        lblContent1.text = PlanningDataString.content1.rawValue.addLocalizableString(str: language)
        lblContent2.text = PlanningDataString.content2.rawValue.addLocalizableString(str: language)
        lblBudgets.text = PlanningDataString.budgets.rawValue.addLocalizableString(str: language)
        lblEvents.text = PlanningDataString.events.rawValue.addLocalizableString(str: language)


     }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func customizeLayout(){
        rightArrow1.setImageColor(color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        rightArrow2.setImageColor(color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
    }
    
    func addTapGestures(){
        let tapBudget = UITapGestureRecognizer(target: self, action: #selector(clickBudget))
        budgetView.addGestureRecognizer(tapBudget)
        let tapEvent = UITapGestureRecognizer(target: self, action: #selector(clickEvent))
        eventView.addGestureRecognizer(tapEvent)
    }
    
    @objc func clickBudget(){
        let vc = RouterType.budget.getVc()
        AppRouter.routerTo(from: vc, options: .curveEaseIn, duration: 0.2, isNaviHidden: false)
    }
    
    @objc func clickEvent(){
        let vc = RouterType.event.getVc()
        AppRouter.routerTo(from: vc, options: .curveEaseIn, duration: 0.2, isNaviHidden: false)
           
    }
    
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
