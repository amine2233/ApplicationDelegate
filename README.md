# ApplicationDelegate

A small, dependency-free Swift package that lets you split a monolithic
`AppDelegate` / scene delegate / `WKExtensionDelegate` into focused, composable
**services**.

Instead of cramming logging, dependency injection, crash reporting, push
notifications and routing into a single delegate, you write one small type per
concern and register them in a list. `ApplicationDelegate` forwards every system
lifecycle callback to each service in order.

```swift
import ApplicationDelegate

final class LoggerApplicationService: ApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("App launched")
        return true
    }
}
```

- Works on **iOS, tvOS, macOS, watchOS and visionOS** from a single import.
- Every delegate method has a **default implementation**, so each service only
  implements the callbacks it cares about.
- Built for **Swift 6** with full strict-concurrency support (`Sendable`).

---

## Table of contents

- [How it works](#how-it-works)
- [Installation](#installation)
- [UIKit (iOS / tvOS / visionOS)](#uikit-ios--tvos--visionos)
- [Scenes (UIScene)](#scenes-uiscene)
- [AppKit (macOS)](#appkit-macos)
- [WatchKit (watchOS)](#watchkit-watchos)
- [Optional integrations](#optional-integrations)
- [Documentation (DocC)](#documentation-docc)
- [Versions](#versions)

---

## How it works

The package ships three building blocks, each provided for the platform you
compile against:

| Type | Role |
| --- | --- |
| `ApplicationDelegate` | Protocol your services conform to. One method per system callback, all with default no-op implementations. |
| `PluggableApplicationDelegate` | Concrete delegate you set as your app's entry point. Override `services()` to return your list of `ApplicationDelegate`. |
| `ApplicationSceneProtocol` / `PluggableApplicationSceneDelegate` | UIKit-only equivalents for the `UIScene` lifecycle. |

When the system calls a method on `PluggableApplicationDelegate`, it forwards
the call to every service returned by `services()`:

- **`Void` methods** are called on every service.
- **`Bool`-returning methods** are combined with logical **AND** — every service
  must return `true` for the result to be `true`.
- **Optional / value-returning methods** (e.g. `applicationDockMenu`,
  `viewControllerWithRestorationIdentifierPath`) chain through the services and
  return the last non-default value.

Services are resolved lazily once and stored, so `services()` is called a single
time.

---

## Installation

### Swift Package Manager

Add the package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/amine2233/ApplicationDelegate.git", from: "0.6.0")
]
```

Then add `"ApplicationDelegate"` to your target's dependencies.

In Xcode: **File ▸ Add Package Dependencies…** and paste the repository URL.

> Older releases also shipped CocoaPods and Carthage support. SPM is the
> recommended and maintained integration path.

---

## UIKit (iOS / tvOS / visionOS)

### 1. Write a service per concern

```swift
import UIKit
import ApplicationDelegate

final class DependencyApplicationService: ApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // configure dependency container
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

### 2. Subclass `PluggableApplicationDelegate`

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

`PluggableApplicationDelegate` exposes a `window: UIWindow?` property you can use
to hold your main window, and forwards all the usual lifecycle, remote
notification, background fetch, state restoration and user-activity callbacks.

---

## Scenes (UIScene)

If your app uses the multi-scene lifecycle, the same pattern applies with
`ApplicationSceneProtocol` and `PluggableApplicationSceneDelegate`.

### 1. Declare the scene configuration from your app delegate

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

### 2. Subclass `PluggableApplicationSceneDelegate`

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

### 3. Write scene services

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

`PluggableApplicationSceneDelegate` forwards `scene(_:willConnectTo:options:)`,
`sceneDidDisconnect`, `sceneDidBecomeActive`, `sceneWillResignActive`,
`sceneWillEnterForeground` and `sceneDidEnterBackground` to each service.

---

## AppKit (macOS)

On macOS the `ApplicationDelegate` protocol mirrors `NSApplicationDelegate`
(notification-based callbacks, `applicationShouldTerminate`, dock menu, etc.).

```swift
import AppKit
import ApplicationDelegate

final class LoggerApplicationService: ApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print("App launched")
    }
}

@main
final class AppDelegate: PluggableApplicationDelegate {
    override func services() -> [ApplicationDelegate] {
        [
            DependencyApplicationService(),
            LoggerApplicationService(),
            MenuApplicationService()
        ]
    }
}
```

Value-returning callbacks are combined sensibly: `applicationShouldTerminate`
chains through services, while `applicationShouldTerminateAfterLastWindowClosed`
and `applicationShouldHandleReopen` require **all** services to agree.

---

## WatchKit (watchOS)

On watchOS the package targets `WKExtensionDelegate`.

```swift
import WatchKit
import ApplicationDelegate

final class LifecycleService: ApplicationDelegate {
    func applicationDidFinishLaunching() {
        // bootstrap
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // process background refresh tasks
    }
}

final class ExtensionDelegate: PluggableApplicationDelegate {
    override func services() -> [ApplicationDelegate] {
        [LifecycleService()]
    }
}
```

Register `ExtensionDelegate` as your extension delegate (via `@WKExtensionDelegateAdaptor`
in a SwiftUI watchOS app, or in your extension's Info configuration).

---

## Optional integrations

These callbacks are added automatically when the relevant framework is available
on the target platform — no extra import or configuration is required. Implement
them on any of your services:

- **CloudKit** — `application(_:userDidAcceptCloudKitShareWith:)` (iOS).
- **SiriKit / Intents** — `application(_:handle:completionHandler:)` (iOS) and
  `handle(_:completionHandler:)` (watchOS).

---

## Documentation (DocC)

Full API documentation lives in the in-source DocC catalog
(`Sources/ApplicationDelegate/ApplicationDelegate.docc`). Build it in Xcode with
**Product ▸ Build Documentation**.

To build from the command line, add the
[Swift-DocC Plugin](https://github.com/apple/swift-docc-plugin) to your
dependencies, then run:

```bash
swift package generate-documentation --target ApplicationDelegate
```

The catalog includes per-platform usage guides (UIKit, scenes, AppKit, WatchKit).

---

## Versions

### 0.6.0

- Swift 6 language mode with strict concurrency (`Sendable` protocols).
- Swift Package Manager support.
- Added macOS (AppKit) delegate methods.
- visionOS support.
- Xcode 12+ (removed public extensions that broke module boundaries).
```

