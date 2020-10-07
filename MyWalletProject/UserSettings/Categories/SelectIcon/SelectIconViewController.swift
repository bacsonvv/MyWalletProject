//
//  SelectIconViewController.swift
//  MyWalletProject
//
//  Created by Vuong Vu Bac Son on 10/7/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import UIKit

class SelectIconViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var segmentView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var listImage: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupCell()
    }
    
    // MARK: - Setup for table view
    func setupCollectionView() {
        ImageCollectionViewCell.registerCellByNib(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Customize the width and the height of a cell
    func setupCell() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
    }
    
    @IBAction func segmentControlClick(_ sender: Any) {
        if segmentControl.selectedSegmentIndex != 0 {
            collectionView.isHidden = true
        } else {
            collectionView.isHidden = false
        }
    }
}

extension SelectIconViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ImageCollectionViewCell.loadCell(collectionView, path: indexPath) as! ImageCollectionViewCell
        cell.setupImage("food")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}
