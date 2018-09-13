//
//  DashboardCollectionViewCell.swift
//  SendActionDemo
//
//  Created by Jeff Bailey on 9/9/18.
//  Copyright © 2018 Jeff Bailey. All rights reserved.
//

import UIKit

class DashboardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectTabButton: UIButton!
    
    var openTabActionMessage: OpenTabActionMessage?
    
    override func awakeFromNib() {
        self.contentView.backgroundColor = UIColor.white
        self.selectTabButton.app_setBackgroundColor(color: UIColor.App.azure, forState: .normal)
        self.selectTabButton.layer.cornerRadius = 8.0
        self.layer.cornerRadius = 8.0
    }
    
    @IBAction func selectTabButtonTapped(_ sender: Any) {
        _ = openTabActionMessage?.sendAction(from: self)
    }
}

extension DashboardCollectionViewCell {
    func configure(dashboardCardModel: DashboardCardModel) {
        self.titleLabel.text = dashboardCardModel.cardHeaderName
        self.openTabActionMessage = dashboardCardModel.tabOpenEventAction
        self.selectTabButton.setTitle("Go To \(dashboardCardModel.cardHeaderName)", for: .normal)
    }
}
