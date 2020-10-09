//
//  ReportPresenter.swift
//  MyWalletProject
//
//  Created by Nguyen Thi Huong on 10/9/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import Foundation
import UIKit

protocol ReportPresenterDelegate: class {
    func getData(_ open: Int)
}

class ReportPresenter {
    weak var delegate: ReportPresenterDelegate?
    var presenter: ViewTransactionPresenter?
    var allTransactions = [Transaction]()
}

//extension ReportPresenter {
//    func loadCell(month: Int, year: Int){
//        let previousMonth = (month == 1) ? 12 : (month - 1)
//        let previousYear = (month == 1) ? (year - 1) : year
//        let previousDates = presenter!.getDateArray(arr: Defined.getAllDayArray(allTransactions: allTransactions), month: previousMonth, year: previousYear)
//        let currentDates = getDateArray(arr: Defined.getAllDayArray(allTransactions: allTransactions), month: month, year: year)
//        let open = calculateDetail(list: getTransactionbyDate(dateArr: previousDates))
//        let end = calculateDetail(list: getTransactionbyDate(dateArr: currentDates))
//        delegate?.getDetailCellInfo(info: DetailInfo(opening: open, ending: end))
//    }
//}
