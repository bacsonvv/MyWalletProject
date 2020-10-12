////
////  ReportUseCase.swift
////  MyWalletProject
////
////  Created by Nguyen Thi Huong on 10/9/20.
////  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Firebase
//
//class ReportUseCase {
//
//}
//
//extension ReportUseCase {
//    // MARK: - Get all transaction
//    func getExpense() {
////        expenseArray.removeAll()
////        sumExpense = 0
//        var expenseArray = [SumByCate]()
//        Defined.ref.child("Account/userid1/transaction/expense").observeSingleEvent(of: .value) {
//            snapshot in
//            for case let child as DataSnapshot in snapshot.children {
//                guard let dict = child.value as? [String:Any] else {
//                    return
//                }
//                let amount = dict["amount"] as! Int
//                let date = dict["date"] as! String
//                let categoryid = dict["categoryid"] as! String
//                let tempDate = date.split(separator: "/")
//                let checkDate = tempDate[1] + "/" + tempDate[2]
//
//                if self.date == checkDate {
//                    let ex = Transaction(amount: amount, categoryid: categoryid, date: date)
//                    self.sumExpense += amount
//                    self.category = categoryid
//                    self.expenseArray.append(ex)
//                }
//            }
//        }
//    }
//
//    func getIncome() {
////        incomeArray.removeAll()
////        sumIncome = 0
//        var incomeArray = [SumByCate]()
//        Defined.ref.child("Account/userid1/transaction/income").observeSingleEvent(of: .value) {
//            snapshot in
//            for case let child as DataSnapshot in snapshot.children {
//                guard let dict = child.value as? [String:Any] else {
//                    return
//                }
//                let amount = dict["amount"] as! Int
//                let date = dict["date"] as! String
//                let categoryid = dict["categoryid"] as! String
//
//                let tempDate = date.split(separator: "/")
//                let checkDate = tempDate[1] + "/" + tempDate[2]
//
//                if self.date == checkDate {
//                    let ex = Transaction(amount: amount, categoryid: categoryid, date: date)
//                    self.sumIncome += amount
//                    self.category = categoryid
//                    self.incomeArray.append(ex)
//                }
//            }
//        }
//    }
//
//    // MARK: - Get all Category
//    func getCategory(_ nameNode: String) {
//        var categories = [Category]()
//        Defined.ref.child("Category").child(nameNode).observeSingleEvent(of: .value) {
//            snapshot in
//            for case let child as DataSnapshot in snapshot.children {
//                guard let dict = child.value as? [String:Any] else {
//                    return
//                }
//                let iconImage = dict["iconImage"] as! String
//                let name = dict["name"] as! String
//                let ex = Category(id: child.key, name: name, iconImage: iconImage)
//                self.categories.append(ex)
//            }
//        }
//    }
//}
//
