//
//  UIResponder+AppExtension.swift
//  SendActionDemo
//
//  Created by Jeff Bailey on 9/9/18.
//  Copyright © 2018 Jeff Bailey. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {
    func app_sendActionToResponderChain(_ action: Selector, sender: UIResponder, forEvent event: UIEvent? = nil) -> Bool {
    
        return UIApplication.shared.sendAction(action, to: nil, from: sender, for: event)
    }
}
