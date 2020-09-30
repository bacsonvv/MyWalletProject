//
//  EventCell.swift
//  MyWalletProject
//
//  Created by Van Thanh on 9/23/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var spent: UILabel!
    @IBOutlet weak var nameEvent: UILabel!
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var imgCategory: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func load(event: Event )  {
        imgCategory.image = UIImage(named: event.categoryid!)
        nameEvent.text = event.name
        lblMoney.text = String(event.spent!)
    }
    
}
