//
//  ApiFirebase.swift
//  MyWalletProject
//
//  Created by THUY Nguyen Duong Thu on 10/13/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import Foundation

class FirebasePath {

}

enum Path {
    case transaction
    case expense
    case income
    case information
    case balance
    case budget
    case event
    case category
    case cateExpense
    case cateIncome
    case imageLibrary
}

extension Path {
    func getPath() -> String {
        var path = ""
        let userid = Defined.defaults.string(forKey: Constants.userid) ?? ""
        switch self {
        case .transaction:
            path = "Account/\(userid)/transaction"
            return path
        case .expense:
            path = "Account/\(userid)/transaction/expense"
            return path
        case .income:
            path = "Account/\(userid)/transaction/income"
            return path
        case .information:
            path = "Account/\(userid)/information"
            return path
        case .balance:
            path = "Account/\(userid)/information/balance"
            return path
        case .budget:
            path = "Account/\(userid)/budget"
            return path
        case .event:
            path = "Account/\(userid)/event"
            return path
        case .category:
            path = "Category"
            return path
        case .cateExpense:
            path = "Category/expense"
            return path
        case .cateIncome:
            path = "Category/income"
            return path
        case .imageLibrary:
            path = "ImageLibrary"
            return path
        }
    }
}
