# Using the UIScene lifecycle

Compose your scene delegate from independent services.

## Overview

For apps that adopt the multi-scene lifecycle, the package provides
``ApplicationSceneProtocol`` and ``PluggableApplicationSceneDelegate`` — the
scene-level counterparts of ``ApplicationDelegate`` and
``PluggableApplicationDelegate``. They are available on UIKit platforms only.

## Declare the scene configuration

From your ``PluggableApplicationDelegate`` subclass, point the scene
configuration at your pluggable scene delegate:

```swift
extension AppDelegate {
    override func application(_ application: UIApplication,
                             configurationForConnecting connectingSceneSession: UISceneSession,
                             options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: "Default Configuration",
                                                 sessionRole: connectingSceneSession.role)
        configuration.delegateClass = AppSceneDelegate.self
        return configuration
    }
}
```

## Subclass the pluggable scene delegate

```swift
import UIKit
import ApplicationDelegate

final class AppSceneDelegate: PluggableApplicationSceneDelegate, UIWindowSceneDelegate {
    var window: UIWindow?

    override func services() -> [ApplicationSceneProtocol] {
        [MainSceneService()]
    }
}
```

## Write scene services

Conform to ``ApplicationSceneProtocol`` and implement only the callbacks you
need.

```swift
final class MainSceneService: ApplicationSceneProtocol {
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = RootViewController()
        window.makeKeyAndVisible()
    }
}
```

## What gets forwarded

``PluggableApplicationSceneDelegate`` forwards the core scene lifecycle to each
service:

- `scene(_:willConnectTo:options:)`
- `sceneDidDisconnect(_:)`
- `sceneDidBecomeActive(_:)`
- `sceneWillResignActive(_:)`
- `sceneWillEnterForeground(_:)`
- `sceneDidEnterBackground(_:)`

It also handles `application(_:configurationForConnecting:options:)` and
`application(_:didDiscardSceneSessions:)` at the application-delegate level.

## See also

- <doc:UIKitUsage>
- ``ApplicationSceneProtocol``
- ``PluggableApplicationSceneDelegate``
