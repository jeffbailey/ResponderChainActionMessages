//
//  AppDelegate.swift
//  SendActionDemo
//
//  Created by Jeff Bailey on 9/9/18.
//  Copyright © 2018 Jeff Bailey. All rights reserved.
//

import UIKit

enum OpenTabActionMessage: ActionMessage {
    case openMap
    case openFavorites
    case openSettings
    
    var event: UIEvent? {
        switch self {
        case .openMap:
            return OpenTabEvent(tabType: .nearby)
        case .openFavorites:
            return OpenTabEvent(tabType: .favorites)
        case .openSettings:
            return OpenTabEvent(tabType: .settings)
        }
    }
    
    var selector: Selector {
        return .handleOpenTab
    }
}

class OpenTabEvent: UIEvent {
    enum TabType {
        case nearby, favorites, settings
    }
    
    let tabType: TabType
    
    init(tabType: TabType) {
        self.tabType = tabType
    }
}

@objc protocol OpenTabMessageHandler {
    func handleOpenTab(_sender: AnyObject, forEvent event: OpenTabEvent)
}

extension Selector {
    static let handleOpenTab = #selector(OpenTabMessageHandler.handleOpenTab(_sender:forEvent:))
}




