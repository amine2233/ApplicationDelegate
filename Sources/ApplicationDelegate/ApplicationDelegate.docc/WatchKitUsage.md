# Using ApplicationDelegate on watchOS

Compose your `WKExtensionDelegate` from independent services.

## Overview

On watchOS the ``ApplicationDelegate`` protocol mirrors `WKExtensionDelegate`.
Its callbacks are parameterless lifecycle methods plus the watch-specific
handlers for background tasks, workout recovery and now-playing activity.

## Write a service

```swift
import WatchKit
import ApplicationDelegate

final class LifecycleService: ApplicationDelegate {
    func applicationDidFinishLaunching() {
        // bootstrap your app
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // process background refresh tasks, then mark them complete
    }
}
```

## Register the services

```swift
import WatchKit
import ApplicationDelegate

final class ExtensionDelegate: PluggableApplicationDelegate {
    override func services() -> [ApplicationDelegate] {
        [LifecycleService()]
    }
}
```

Register `ExtensionDelegate` as your extension delegate. In a SwiftUI watchOS
app use `@WKExtensionDelegateAdaptor(ExtensionDelegate.self)` on your `App`
type.

## What gets forwarded

``PluggableApplicationDelegate`` forwards the WatchKit delegate surface,
including:

- Lifecycle: `applicationDidFinishLaunching()`, `applicationDidBecomeActive()`,
  `applicationWillResignActive()`, `applicationWillEnterForeground()`,
  `applicationDidEnterBackground()`.
- `handle(_:)` for `WKRefreshBackgroundTask` sets.
- `handleActiveWorkoutRecovery()` and `handleRemoteNowPlayingActivity()`.
- `handleUserActivity(_:)`, `handle(_ userActivity:)` and
  `deviceOrientationDidChange()`.

## Optional callbacks

When SiriKit is available, `handle(_:completionHandler:)` for `INIntent` is
added automatically — implement it on any service.

## See also

- ``ApplicationDelegate``
- ``PluggableApplicationDelegate``
