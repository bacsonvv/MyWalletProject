//
//  DetailStackedBarChartVC.swift
//  MyWalletProject
//
//  Created by Nguyen Thi Huong on 9/28/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import UIKit

class DetailStackedBarChartVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var sumExpense = 0
    var sumIncome = 0
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.title = Constants.netIncome
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        DetailSBCTableViewCell.registerCellByNib(tableView)
        DetailSBCCell.registerCellByNib(tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
    }
    
    func setupData(info: SumInfo) {
        self.sumIncome = info.sumIncome
        self.sumExpense = info.sumExpense
        self.date = info.date
    }
    
    @IBAction func popReportVC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailStackedBarChartVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = DetailSBCTableViewCell.loadCell(tableView)  as! DetailSBCTableViewCell
            cell.setChartData(sumIncome, sumExpense)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = DetailSBCCell.loadCell(tableView) as! DetailSBCCell
            cell.setupData(info: SumInfo(sumIncome: sumIncome, sumExpense: sumExpense, netIncome: sumIncome - sumExpense, date: date))
            cell.selectionStyle = .none
            return cell
        }
    }
}
