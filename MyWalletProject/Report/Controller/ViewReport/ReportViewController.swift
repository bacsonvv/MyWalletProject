//
//  ReportViewController.swift
//  MyWallet
//
//  Created by Nguyen Thi Huong on 9/21/20.
//  Copyright © 2020 THUY Nguyen Duong Thu. All rights reserved.
//

import Charts
import UIKit
import FirebaseDatabase
import MonthYearPicker

class ReportViewController: UIViewController {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var txtDatePicker: UITextField!
    var ref: DatabaseReference!
    private var dateFormatter = DateFormatter()
    var months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    let calendar = Calendar.current
    var currentMonth = 9
    var currentYear = 2020
    var open = 0
    var sumIncome = 0
    var sumExpense = 0
    var date = ""
    var category = ""
    var expenseArray: [Transaction] = []
    var incomeArray: [Transaction] = []
    var categories: [Category] = []
    var timer = Timer()
    var sumByCategoryIncome = [SumByCate]()
    var sumByCategoryExpense = [SumByCate]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        setupTableView()
        setupTxtDate()
        showDatePicker()
        createDatePicker()
        DispatchQueue.main.async {
            self.getIncome()
            self.getExpense()
            self.getCategory("expense")
            self.getCategory("income")
        }
        checkWhenDataIsReady()
        tableView.reloadData()
    }
    
    //MARK: - Check data is ready
    func checkWhenDataIsReady() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ReportViewController.finishLoading)), userInfo: nil, repeats: true)
    }
    
    @objc func finishLoading() {
        if expenseArray.count != 0 && incomeArray.count != 0 {
            self.dataForPieChart(dataArray: self.incomeArray, state: "income")
            self.dataForPieChart(dataArray: self.expenseArray, state: "expense")
            tableView.reloadData()
            timer.invalidate()
        }
    }
    
    //MARK: - Get all transaction
    func getExpense() {
        expenseArray.removeAll()
        sumExpense = 0
        self.ref.child("Account").child("userid1").child("transaction").child("expense").observeSingleEvent(of: .value) {
            snapshot in
            for case let child as DataSnapshot in snapshot.children {
                guard let dict = child.value as? [String:Any] else {
                    return
                }
                let amount = dict["amount"] as! Int
                let date = dict["date"] as! String
                let categoryid = dict["categoryid"] as! String
                let tempDate = date.split(separator: "/")
                let checkDate = tempDate[1] + "/" + tempDate[2]
                
                if self.date == checkDate {
                    let ex = Transaction(amount: amount, categoryid: categoryid, date: date)
                    self.sumExpense += amount
                    self.category = categoryid
                    self.expenseArray.append(ex)
                }
            }
        }
    }
    
    func getCategory(_ nameNode: String) {
        self.ref.child("Category").child(nameNode).observeSingleEvent(of: .value) {
            snapshot in
            for case let child as DataSnapshot in snapshot.children {
                guard let dict = child.value as? [String:Any] else {
                    return
                }
                let iconImage = dict["iconImage"] as! String
                let name = dict["name"] as! String
                let ex = Category(id: child.key, name: name, iconImage: iconImage)
                self.categories.append(ex)
            }
        }
    }
    
    func getIncome() {
        incomeArray.removeAll()
        sumIncome = 0
        self.ref.child("Account").child("userid1").child("transaction").child("income").observeSingleEvent(of: .value) {
            snapshot in
            for case let child as DataSnapshot in snapshot.children {
                guard let dict = child.value as? [String:Any] else {
                    return
                }
                let amount = dict["amount"] as! Int
                let date = dict["date"] as! String
                let categoryid = dict["categoryid"] as! String
                
                let tempDate = date.split(separator: "/")
                let checkDate = tempDate[1] + "/" + tempDate[2]
                
                if self.date == checkDate {
                    let ex = Transaction(amount: amount, categoryid: categoryid, date: date)
                    self.sumIncome += amount
                    self.category = categoryid
                    self.incomeArray.append(ex)
                }
            }
        }
    }
    
    // Sum by Category
    func dataForPieChart(dataArray: [Transaction], state: String) {
        var sumByCategory = [SumByCate]()
        for index in 0 ..< dataArray.count {
            let sumIndex = checkExist(category: dataArray[index].categoryid!, array: sumByCategory)
            if sumIndex != -1 {
                sumByCategory[sumIndex].amount += dataArray[index].amount!
            } else {
                sumByCategory.append(SumByCate(category: dataArray[index].categoryid!, amount: dataArray[index].amount!))
            }
        }
        sumByCategory.sort(by: { $0.amount > $1.amount })
        if state == "income" {
            sumByCategoryIncome = sumByCategory
        } else {
            sumByCategoryExpense = sumByCategory
        }
    }
    
    // Check if a Category exists
    func checkExist(category: String, array: [SumByCate]) -> Int {
        for index in 0 ..< array.count {
            if category == array[index].category {
                return index
            }
        }
        return -1
    }
    
    //MARK: - Setup Date
    func setupTxtDate() {
        txtDatePicker.tintColor = .clear
        currentYear = calendar.component(.year, from: Date())
        currentMonth = calendar.component(.month, from: Date())
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        lblDate.text = "\(months[currentMonth - 1]) \(currentYear)"
        if currentMonth < 10 {
            txtDatePicker.text = "0\(currentMonth)/\(currentYear)"
            self.date = txtDatePicker.text ?? "Error"
        } else {
            txtDatePicker.text = "\(currentMonth)/\(currentYear)"
            self.date = txtDatePicker.text ?? "Error"
        }
        txtDatePicker.setRightImage(imageName: "down")
    }
    
    func showDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker))
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        txtDatePicker.inputAccessoryView = toolbar
    }
    
    @objc func doneDatePicker(){
        self.tableView.reloadData()
        self.view.endEditing(true)
    }
    
    func createDatePicker(){
        let picker = MonthYearPickerView(frame: CGRect(origin: CGPoint(x: 0, y: (view.bounds.height - 216) / 2), size: CGSize(width: view.bounds.width, height: 216)))
        picker.minimumDate = Calendar.current.date(byAdding: .year, value: -2, to: Date())
        picker.maximumDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())
        picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        txtDatePicker.inputView = picker
    }
    
    @objc func dateChanged(_ picker: MonthYearPickerView) {
        let components = calendar.dateComponents([.month, .year], from: picker.date)
        lblDate.text = "\(months[components.month! - 1]) \(components.year!)"
        if components.month! < 10 {
            txtDatePicker.text = "0\(components.month!)/\(components.year!)"
            self.date = txtDatePicker.text ?? "\(currentMonth)/\(currentYear)"
        } else {
            txtDatePicker.text = "\(components.month!)/\(components.year!)"
            self.date = txtDatePicker.text ?? "\(currentMonth)/\(currentYear)"
        }
        getIncome()
        getExpense()
        self.tableView.reloadData()
    }
    
    //MARK: - Setup TableView
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        MoneyTableViewCell.registerCellByNib(tableView)
        StackedBarChartTableViewCell.registerCellByNib(tableView)
        PieChartTableViewCell.registerCellByNib(tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
}

extension ReportViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = MoneyTableViewCell.loadCell(tableView) as! MoneyTableViewCell
            cell.setUpData(opening: open, sumIncome: sumIncome, sumExpense: sumExpense)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = StackedBarChartTableViewCell.loadCell(tableView) as! StackedBarChartTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.setChartData(sumIncome, sumExpense, sumIncome - sumExpense)
            return cell
        default:
            let cell = PieChartTableViewCell.loadCell(tableView) as! PieChartTableViewCell
            cell.delegate = self
            cell.setupDataTB(info: SumForPieChart(sumIncome: sumIncome, sumExpense: sumExpense, sumByCateIncome: sumByCategoryIncome, sumByCateExpense: sumByCategoryExpense))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = UIStoryboard.init(name: "Report", bundle: Bundle.main).instantiateViewController(identifier: "detailSBC") as! DetailStackedBarChartVC
            vc.getData(info: SumInfo(sumIncome: sumIncome, sumExpense: sumExpense, netIncome: sumIncome - sumExpense, date: lblDate.text!))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - Go to DetailPieChartVC
extension ReportViewController: CustomCollectionCellDelegate {
    func collectionView(collectioncell: PieChartCollectionViewCell?, didTappedInTableview TableCell: PieChartTableViewCell, indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Report", bundle: Bundle.main).instantiateViewController(identifier: "detailPC") as! DetailPieChartVC
        if indexPath.row == 0 {
            vc.state = .income
            vc.getData(info: SumArr(sum: sumIncome, sumByCategory: sumByCategoryIncome, transations: incomeArray))
        } else {
            vc.state = .expense
            vc.getData(info: SumArr(sum: sumExpense, sumByCategory: sumByCategoryExpense, transations: expenseArray))
        }
        vc.categories = categories
        navigationController?.pushViewController(vc, animated: true)
    }
}
