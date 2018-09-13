//
//  MainTabBarController.swift
//  SendActionDemo
//
//  Created by Jeff Bailey on 9/10/18.
//  Copyright © 2018 Jeff Bailey. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var favoritesViewController: FavoritesViewController? {
        return self.viewControllers?.filter { $0 is FavoritesViewController }.first as? FavoritesViewController
    }
    
    var mapViewController: MapViewController? {
        return self.viewControllers?.filter { $0 is MapViewController }.first as? MapViewController
    }
    
    var settingsViewController: SettingsViewController? {
        return self.viewControllers?.filter { $0 is SettingsViewController }.first as? SettingsViewController
    }
    
}

extension MainTabBarController: OpenTabMessageHandler {
    func handleOpenTab(_sender: AnyObject, forEvent event: OpenTabEvent) {
        switch event.tabType {
        case .nearby:
            self.selectedViewController = self.mapViewController
        case .favorites:
            self.selectedViewController = self.favoritesViewController
        case .settings:
            self.selectedViewController = self.settingsViewController
        }
    }
}
