//
//  ActionMessageType.swift
//  SendActionDemo
//
//  Created by Jeff Bailey on 9/9/18.
//  Copyright © 2018 Jeff Bailey. All rights reserved.
//

import UIKit

protocol ActionMessage {
    var selector: Selector { get }
    var event: UIEvent? { get }
}

extension ActionMessage {
    func sendAction(from sender: UIResponder) -> Bool {
        return sender.app_sendActionToResponderChain(selector, sender: sender, forEvent: event)
    }
}
