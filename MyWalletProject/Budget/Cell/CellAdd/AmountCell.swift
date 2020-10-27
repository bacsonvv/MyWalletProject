//
//  AmountCell.swift
//  MyWalletProject
//
//  Created by Hoang Lam on 9/30/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import UIKit
protocol AmountCellDelegete: class {
    func amountDidChange(value: String)
}

class AmountCell: UITableViewCell {

    weak var delegate: AmountCellDelegete?

    @IBOutlet weak var lblAmount: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblAmount.addTarget(self, action: #selector(setAmount), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func setAmount() {
        if let value = lblAmount.text {
            delegate?.amountDidChange(value: value)
        }
    }
}
