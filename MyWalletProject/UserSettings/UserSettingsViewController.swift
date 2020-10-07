//
//  UserSettingsViewController.swift
//  MyWalletProject
//
//  Created by Vuong Vu Bac Son on 9/23/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import UIKit

class UserSettingsViewController: UIViewController {
    
    @IBOutlet weak var avaImage: UIImageView!
    
    @IBOutlet weak var lblUsername: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewConfiguration()
    }
    
    // MARK: - Deselected effect on cell after popping a view from view stack
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    // MARK: - Config and regist for tableView
    func tableViewConfiguration() {
        tableView.register(SettingsItemViewCell.nib(), forCellReuseIdentifier: SettingsItemViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false
    }
    
    // MARK: - Set text for back button
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.tintColor = UIColor.init(displayP3Red: 52, green: 199, blue: 90, alpha: 1.0)
        navigationItem.backBarButtonItem = backItem
    }
}

extension UserSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsItemViewCell.identifier, for: indexPath) as! SettingsItemViewCell
        
        var imageName = ""
        var labelName = ""
        
        switch indexPath.row {
        case 0:
            imageName = "s-settings"
            labelName = "Information"
        case 1:
            imageName = "s-categories"
            labelName = "Add Category"
        case 2:
            imageName = "s-currencies"
            labelName = "Currencies Exchange"
        case 3:
            imageName = "s-travel"
            labelName = "Travel Mode"
        case 4:
            imageName = "s-scanner"
            labelName = "Bill Scanner"
        default:
            imageName = "Undefined"
            labelName = "Undefined"
        }
        
        cell.setupView(imageName, labelName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            AppRouter.routerTo(from: self, router: .settings, options: .push)
        case 1:
            AppRouter.routerTo(from: self, router: .categories, options: .push)
        case 2:
            AppRouter.routerTo(from: self, router: .currencies, options: .push)
        case 3:
            AppRouter.routerTo(from: self, router: .travelMode, options: .push)
        case 4:
            AppRouter.routerTo(from: self, router: .billScanner, options: .push)
        default:
            return
        }
    }
}

