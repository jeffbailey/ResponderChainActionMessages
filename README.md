# Responder Chain Action Messages

```SendActionDemo``` is a sample app that demonstrates how to use the UIKit responder chain as an alternative to the commonly used delegate pattern. It's a great alternative when you need looser coupling between components, but still want the type safety of delegates.
<p align="center">
    <img src="https://img.shields.io/badge/Swift-4.2-orange.svg" />
     <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://twitter.com/johnsundell">
        <img src="https://img.shields.io/badge/twitter-@jeffbailey-blue.svg?style=flat" alt="Twitter: @jeffbailey" />
    </a>
</p>

## Motivation
In this sample app we're building a tab bar based application, where the first tab is a dashboard that provides summary information for each of the other tabs. Each card in the dashboard has a "Go To" button that allows the user to quickly switch tabs.

<p><img src="Images/demo.gif?raw=true" alt="ScrollingStackViewController Demo" width="350"/></p>

The "Go To" button lives in a ```DashboardCollectionViewCell```, but the action to switch tabs needs to be handled by the ```MainTabBarController```, which is far removed from the button. Instead of passing a delegate down from the tab bar controller to every cell, we take advantage of the responder chain to send an Action Message from the ```DashboardCollectionViewCell``` up to the ```MainTabBarController```.

## The Responder Chain
For background on the UIKit Responder Chain, refer to these resources:

[Apple UIKit Documentation: Using Responders and the Responder Chain to Handle Events](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/using_responders_and_the_responder_chain_to_handle_events)

[The Amazing Responder Chain | Cocoanetics](https://www.cocoanetics.com/2012/09/the-amazing-responder-chain/)

## Foundation Code

We start with a simple extension of ```UIResponder``` to send an action message to the responder chain.

```swift
extension UIResponder {
    func app_sendActionToResponderChain(_ action: Selector, sender: UIResponder,
                                        forEvent event: UIEvent? = nil) -> Bool {

        return UIApplication.shared.sendAction(action, to: nil, from: sender, for: event)
    }
}
```

Note that sending ```nil``` as the target in ```sendAction``` will cause UIKit to traverse the responder chain until it finds an object that implements the appropriate action method.

Next, we encapsulate a Action Message, which consists of a ```Selector``` and an optional ```UIEvent``` that will be sent to the message.

```swift
protocol ActionMessage {
    var selector: Selector { get }
    var event: UIEvent? { get }
}

extension ActionMessage {
    func sendAction(from sender: UIResponder) -> Bool {
        return sender.app_sendActionToResponderChain(selector, sender: sender, forEvent: event)
    }
}
```

## Application Code
The goal in our sample application is to open either the Map, Favorites, or Settings tab, depending on which button was pressed. That sounds like a good use for an enum based ```ActionMessage```!

```swift
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
```

Using a protocol for ```OpenTabMessageHandler``` and the ```Selector``` extension provides type safety between the sender and receiver.

All that's left is to send and receive the ```OpenTabActionMessage```.

First, send the ```ActionMessage``` from the ```IBAction``` handler wired to the button press:

```swift
class DashboardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectTabButton: UIButton!

    var openTabActionMessage: OpenTabActionMessage?

    @IBAction func selectTabButtonTapped(_ sender: Any) {
        _ = openTabActionMessage?.sendAction(from: self)
    }
}
```

UIKit will traverse the responder chain until it finds an object that implements the selector to open the tab:

```swift
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
```

## Summary

Responder Chain Action Messages aren't a replacement for the tried and true delegate pattern used in iOS, but they can be a handy tool in your toolbox.

Download or clone the project to take a closer look.

## Credits
Inspired by a great talk by at the 2017 360iDev by Brandon Alexander :

https://vimeopro.com/360conferences/360idev-2017-public-session-recordings/video/231791014

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

MIT © [Jeff Bailey]()
