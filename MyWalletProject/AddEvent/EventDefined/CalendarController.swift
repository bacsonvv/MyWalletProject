//
//  CalendarController.swift
//  MyWallet
//
//  Created by Van Thanh on 9/22/20.
//  Copyright © 2020 THUY Nguyen Duong Thu. All rights reserved.
//

import UIKit
import FSCalendar
import SwiftDate



class CalendarController: UIViewController, FSCalendarDelegate {
    var completionHandler: ((String) -> Void)?
    var textFomat: String?
    var dateLich: String?
    var checkDate = CheckDate()
    
    @IBOutlet weak var vCalendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vCalendar.delegate = self
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        let formatDate = format.string(from: date)
        let check = checkDate.checkDate(dateEnd: formatDate)
        if check {
            dateLich = formatDate
            completionHandler?(formatDate)
            self.navigationController?.popViewController(animated: true)
        } else {
            _ = AlertUtil.showAlert(from: self, with: "Message", message: "The event cannot be a date in the past")
        }
    }
}
