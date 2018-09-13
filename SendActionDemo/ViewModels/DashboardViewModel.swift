//
//  DashboardViewModel.swift
//  SendActionDemo
//
//  Created by Jeff Bailey on 9/11/18.
//  Copyright © 2018 Jeff Bailey. All rights reserved.
//

import Foundation

struct DashboardViewModel {
    
    let cardModels: [DashboardCardModel]
    
    init() {
        cardModels = [
            DashboardCardModel(cardHeaderName: "Map", tabOpenEventAction: .openMap),
            DashboardCardModel(cardHeaderName: "Favorites", tabOpenEventAction: .openFavorites),
            DashboardCardModel(cardHeaderName: "Settings", tabOpenEventAction: .openSettings)
        ]
    }
    
    func cardModel(forIndexPath indexPath: IndexPath) -> DashboardCardModel? {
        guard indexPath.item < cardModels.count else {
            return nil
        }
        
        return cardModels[indexPath.item]
    }
}
