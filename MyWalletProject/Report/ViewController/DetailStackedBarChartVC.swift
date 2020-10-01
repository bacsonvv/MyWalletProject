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
    var expense = 0
    var income = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        print(expense)
        print(income)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        DetailSBCTableViewCell.registerCellByNib(tableView)
        DayStackedBarChartTableViewCell.registerCellByNib(tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    @IBAction func popReportVC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailStackedBarChartVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = DetailSBCTableViewCell.loadCell(tableView)  as! DetailSBCTableViewCell
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = DayStackedBarChartTableViewCell.loadCell(tableView) as! DayStackedBarChartTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            print("Helooo. This my cell")
            let vc = UIStoryboard.init(name: "Report", bundle: Bundle.main).instantiateViewController(identifier: "dayDetailSBC") as! DayDetailSBC
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
  
}

extension DetailStackedBarChartVC: GetDataFromVC {
    func getData(income: Int, expense: Int) {
           self.income = income
           self.expense = expense
    }
}
