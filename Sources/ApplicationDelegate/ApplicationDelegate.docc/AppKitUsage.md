# Using ApplicationDelegate on macOS

Compose your `NSApplicationDelegate` from independent services.

## Overview

On macOS the ``ApplicationDelegate`` protocol mirrors `NSApplicationDelegate`.
Its callbacks are notification-based (`applicationDidFinishLaunching(_:)` takes a
`Notification`) and include the AppKit-specific lifecycle: termination policy,
hide/unhide, dock menu and screen-parameter changes.

## Write a service

```swift
import AppKit
import ApplicationDelegate

final class LoggerApplicationService: ApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print("App launched")
    }
}

final class MenuApplicationService: ApplicationDelegate {
    func applicationDockMenu(_ aSender: NSApplication) -> NSMenu? {
        // build and return a dock menu
        NSMenu()
    }
}
```

## Register the services

```swift
import AppKit
import ApplicationDelegate

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

## What gets forwarded

``PluggableApplicationDelegate`` forwards the AppKit delegate surface, including:

- Launch: `applicationWillFinishLaunching(_:)`, `applicationDidFinishLaunching(_:)`.
- Termination: `applicationShouldTerminate(_:)` (chained),
  `applicationShouldTerminateAfterLastWindowClosed(_:)` and
  `applicationShouldHandleReopen(_:hasVisibleWindows:)` (require all services to agree),
  `applicationWillTerminate(_:)`.
- Activation: become/resign active, hide/unhide, will/did update.
- `applicationDockMenu(_:)`, `application(_:willPresentError:)` and
  `applicationDidChangeScreenParameters(_:)`.

> Value-returning callbacks chain through your services; the last meaningful
> value wins. `Bool`-returning callbacks are combined with logical AND.

## See also

- ``ApplicationDelegate``
- ``PluggableApplicationDelegate``
