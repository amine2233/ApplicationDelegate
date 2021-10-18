# ApplicationDelegate

Create a class implement ```ApplicationDelegate``` Protocol, then implement some needed method

```swift
import ApplicationDelegate

final class DependencyApplicationService: ApplicationDelegate {
    // TODO: implement class
}
```

When Creating you class, you need to readapt AppDelegate for add wich class needed.

``` swift

import UIKit
import ApplicationDelegate

//@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {
    
    override func services() -> [ApplicationDelegate] {
        return [
            DependencyApplicationService(),
            LoggerApplicationService(),
            AppCoordinatorApplicationService(window: window),
            CrashReportApplicationService()
        ]
    }
}
```

If you use Scene, you need to readapt your AppSceneDelegate

```swift
extension ApplicationService {
    // MARK: UISceneSession Lifecycle

    public func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let scene = AppSceneConfiguration(name: "Default Configuration",
                                          sessionRole: connectingSceneSession.role,
                                          sceneClass: AppScene.self,
                                          delegateClass: AppSceneDelegate.self)
        return scene
    }

    public func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

open class AppSceneConfiguration: UISceneConfiguration {
    public init(name: String, sessionRole: UISceneSession.Role, sceneClass: AnyClass?, delegateClass: AnyClass?) {
        super.init(name: name, sessionRole: sessionRole)
        self.sceneClass = sceneClass
        self.delegateClass = delegateClass
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class AppScene: UIScene {
    public init(session: UISceneSession, connectionOptions: UIScene.ConnectionOptions, title: String, sceneDelegate: UISceneDelegate?) {
        super.init(session: session, connectionOptions: connectionOptions)
        self.title = title
        delegate = sceneDelegate
    }
}

class AppSceneDelegate: PluggableApplicationSceneDelegate, UIWindowSceneDelegate {
    override init() {
        super.init()
    }

    override func services() -> [ApplicationSceneProtocol] {
        [
            ApplicationSceneService()
        ]
    }
}

class ApplicationSceneService: ApplicationSceneProtocol {
    let window: UIWindow

    init(window: UIWindow = UIWindow.makeMainWindow()) {
        self.window = window
    }

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // Override point for customization after application launch.
        guard let windowScene = scene as? UIWindowScene else { return }
        window.windowScene = windowScene
        window.makeKeyAndVisible()
    }
}

```

## Versions
### 0.6.0

- Add possibilty to use with Swift Package Manager
- Add new AppDelegate method for macOS
- Swift 5.4 copatibility
- Xcode 12 (remove public extension)

## Install
### CocoaPods
### Carthage
### Swift Package Manager
### Git SubModule
