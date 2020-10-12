//
//  EventControllerView.swift
//  MyWalletProject
//
//  Created by Van Thanh on 10/6/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import UIKit

class EventControllerView: UIViewController {
    
    @IBOutlet weak var eventTable: UITableView!
    @IBOutlet weak var sgm: UISegmentedControl!
    
    @IBOutlet weak var imgNoEvent: UIImageView!
    @IBOutlet weak var loadViewIndicator: UIActivityIndicatorView!
    var presenter: EventPresenter?
    var arrNameEvent = [String]()
    var currenScore: Int!
    var currenKey: String!
    let navication = UINavigationController()
    
    var arrEvent: [Event] = []{
        didSet{
            loadViewIndicator.stopAnimating()
            loadViewIndicator.alpha = 0
            eventTable.reloadData()
        }
    }

    //load view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        let nib = UINib(nibName: "EventCell", bundle: nil)
        eventTable.register(nib, forCellReuseIdentifier: "EventCell")
        eventTable.delegate = self
        eventTable.dataSource = self
        
    }
    
    func setUp(presenter: EventPresenter)  {
        self.presenter = presenter
    }
    
    @IBAction func sgmMode(_ sender: Any) {
        switch sgm.selectedSegmentIndex {
        case 0:
            arrEvent.removeAll()
            arrNameEvent.removeAll()
           acctivityIndicator()
            presenter?.fetchDataApplying()
        case 1:
            arrNameEvent.removeAll()
            arrEvent.removeAll()
            acctivityIndicator()
            presenter?.fetchDataFinished()
        default:
            print("chonlai")
        }
            
    }
    // back
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
      }
    
    // butt add Event
    @IBAction func addEvent(_ sender: Any) {
        let add = UIStoryboard.init(name: "AddEvent", bundle: nil).instantiateViewController(identifier: "AddEventTableController") as! AddEventTableController
        let presenter = AddEventPresenter(delegate: add , userCase: AddEventTableUseCase())
        add.setUp(presenter: presenter)
        add.nameEvents = arrNameEvent
        self.navigationController?.pushViewController(add, animated: true)
        
    }
    
    
    
}
extension EventControllerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        cell.load(event: arrEvent[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = UIStoryboard.init(name: "AddEvent", bundle: nil).instantiateViewController(identifier: "DetailEvent")
            as! DetailEventController
        detail.event = arrEvent[indexPath.row]
        let presenter = DetailPresenter(delegate: detail, useCase: DetailEventUseCase())
        detail.setUp(presenter: presenter)
        self.navigationController?.pushViewController(detail, animated: true)
        
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currenOfSet = scrollView.contentOffset.y
        let maxOffSet = scrollView.contentSize.height - scrollView.frame.size.height
        if maxOffSet - currenOfSet <= 40{
            
        }
        
    }
    
}

extension EventControllerView: EventPresenterDelegate{
    func getDataEvent(arrEvent: [Event], arrNameEvent: [String]) {
        if arrEvent.count == 0 {
            self.imgNoEvent.alpha = 1
            loadViewIndicator.alpha = 0	
        }
        self.arrEvent = arrEvent
        self.arrNameEvent = arrNameEvent
    }
    
    
}
extension EventControllerView {
    override func viewWillAppear(_ animated: Bool) {
        sgm.selectedSegmentIndex = 0
        acctivityIndicator()
        loadViewIndicator.startAnimating()
        presenter?.fetchDataApplying()
    }
    override var hidesBottomBarWhenPushed: Bool {
        get{
            return true
        }
        set {
            super.hidesBottomBarWhenPushed = newValue
        }
    }
 
}

extension EventControllerView{
    func acctivityIndicator()  {
       loadViewIndicator.startAnimating()
       loadViewIndicator.alpha = 1
        imgNoEvent.alpha = 0
    }

}
