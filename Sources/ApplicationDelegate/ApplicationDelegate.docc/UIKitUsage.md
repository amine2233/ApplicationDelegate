# Using ApplicationDelegate on UIKit

Compose your iOS, tvOS and visionOS app delegate from independent services.

## Overview

On UIKit platforms the ``ApplicationDelegate`` protocol mirrors
`UIApplicationDelegate`. You write one service per concern, then register them in
a ``PluggableApplicationDelegate`` subclass that you set as your app's entry
point.

## Write a service

Conform to ``ApplicationDelegate`` and implement only the callbacks you need —
everything else uses a default implementation.

```swift
import UIKit
import ApplicationDelegate

final class DependencyApplicationService: ApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // configure your dependency container
        return true
    }
}

final class AppCoordinatorApplicationService: ApplicationDelegate {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window.rootViewController = RootViewController()
        window.makeKeyAndVisible()
        return true
    }
}
```

## Register the services

Subclass ``PluggableApplicationDelegate`` and override `services()`. The class
provides a `window: UIWindow?` property you can use for your main window.

```swift
import UIKit
import ApplicationDelegate

@main
final class AppDelegate: PluggableApplicationDelegate {
    override func services() -> [ApplicationDelegate] {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        return [
            DependencyApplicationService(),
            LoggerApplicationService(),
            AppCoordinatorApplicationService(window: window),
            CrashReportApplicationService()
        ]
    }
}
```

## What gets forwarded

``PluggableApplicationDelegate`` forwards the full UIKit surface, including:

- Launch: `willFinishLaunchingWithOptions`, `didFinishLaunchingWithOptions`
  (combined with logical AND).
- Lifecycle: foreground/background transitions, active/resign, memory warnings,
  termination.
- Remote notifications, background fetch and background URL sessions.
- State restoration and `NSUserActivity` continuation.
- URL handling: `application(_:open:options:)`.

## Optional callbacks

When the framework is available on the target, these are added automatically —
just implement them on any service:

- **CloudKit**: `application(_:userDidAcceptCloudKitShareWith:)`.
- **SiriKit**: `application(_:handle:completionHandler:)`.

## See also

- <doc:SceneUsage>
- ``PluggableApplicationDelegate``
