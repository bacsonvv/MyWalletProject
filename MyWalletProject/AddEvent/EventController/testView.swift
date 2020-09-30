//
//  testView.swift
//  MyWalletProject
//
//  Created by Van Thanh on 9/28/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import UIKit

class testView: UIViewController{
    let cell1 = "nameEventCell"
    let cell2 = "moneyEventCell"
    let cell3 = "calendarEventCell"
    @IBOutlet weak var tableAddEvent: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableAddEvent.register(UINib(nibName: "nameEventCell", bundle: nil), forCellReuseIdentifier: "nameEventCell")
//        tableAddEvent.register(UINib(nibName: "moneyEventCell", bundle: nil), forCellReuseIdentifier: "moneyEventCell")
//        tableAddEvent.register(UINib(nibName: "calendarEventCell", bundle: nil), forCellReuseIdentifier: "calendarEventCell")
        tableAddEvent.delegate = self
        tableAddEvent.dataSource = self
        // Do any additional setup after loading the view.
    }
    

   

}
extension testView: UITableViewDataSource, UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if indexPath.row == 0
        {
            cell = tableView.dequeueReusableCell(withIdentifier: cell1, for: indexPath)
        }
        if indexPath.row == 1 {
             cell = tableView.dequeueReusableCell(withIdentifier: cell2, for: indexPath)
        }
        if indexPath.row == 2  {
             cell = tableView.dequeueReusableCell(withIdentifier: cell3, for: indexPath)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}

