# ``ApplicationDelegate``

Split a monolithic app delegate into small, composable, single-responsibility services.

## Overview

`ApplicationDelegate` lets you break up the work that normally piles up inside a
single `UIApplicationDelegate`, `NSApplicationDelegate` or `WKExtensionDelegate`
into focused **services**. Each service conforms to the ``ApplicationDelegate``
protocol and implements only the lifecycle callbacks it cares about — every
method has a default implementation.

You register your services by subclassing ``PluggableApplicationDelegate`` and
overriding its `services()` method. The pluggable delegate then forwards every
system callback to each service in order.

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

### Forwarding semantics

When the system invokes a method on ``PluggableApplicationDelegate``:

- **`Void` methods** run on every service.
- **`Bool`-returning methods** are combined with logical AND — all services must
  return `true`.
- **Value-returning methods** chain through services and return the last
  meaningful result.

The list returned by `services()` is resolved lazily once and cached.

### Platform coverage

A single import adapts to the platform you build against:

- **iOS / tvOS / visionOS** — wraps `UIApplicationDelegate` and the `UIScene` lifecycle.
- **macOS** — wraps `NSApplicationDelegate`.
- **watchOS** — wraps `WKExtensionDelegate`.

CloudKit and SiriKit callbacks are added automatically where those frameworks
are available.

## Topics

### Getting started

- <doc:UIKitUsage>
- <doc:SceneUsage>
- <doc:AppKitUsage>
- <doc:WatchKitUsage>

### Core types

- ``ApplicationDelegate``
- ``PluggableApplicationDelegate``

### Scenes

- ``ApplicationSceneProtocol``
- ``PluggableApplicationSceneDelegate``
