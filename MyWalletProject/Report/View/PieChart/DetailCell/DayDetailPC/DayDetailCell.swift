//
//  DayDetailCell.swift
//  MyWalletProject
//
//  Created by Nguyen Thi Huong on 9/30/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import UIKit

class DayDetailCell: BaseTBCell {

    @IBOutlet weak var lblTypeOfMoney: UILabel!
    @IBOutlet weak var lblMoney: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
    func setupLabel(color: UIColor, text: String, sum: Int) {
        lblMoney.textColor = color
        lblTypeOfMoney.text = text
        lblMoney.text = String((Defined.formatter.string(from: NSNumber(value: sum))!))
    }
    
}
