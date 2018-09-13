//
//  DashboardCollectionViewController.swift
//  SendActionDemo
//
//  Created by Jeff Bailey on 9/9/18.
//  Copyright © 2018 Jeff Bailey. All rights reserved.
//

import UIKit

class DashboardCollectionViewController: UICollectionViewController {
    private let dashboardCellReuseIdentifier = "dashboardCell"

    let viewModel: DashboardViewModel = DashboardViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor.App.concrete
        self.collectionView?.alwaysBounceVertical = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.becomeFirstResponder()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cardModels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dashboardCellReuseIdentifier, for: indexPath)
    
        if let dashboardCell = cell as? DashboardCollectionViewCell,
            let dashboardCardModel = viewModel.cardModel(forIndexPath: indexPath) {
            
            dashboardCell.configure(dashboardCardModel: dashboardCardModel)
        }
    
        return cell
    }

}
