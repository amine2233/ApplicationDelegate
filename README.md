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

## Versions
### 0.3.0

- Add possibilty to use with Swift Package Manager
- Add new AppDelegate method for macOS

## Install
### CocoaPods
### Carthage
### Swift Package Manager
### Git SubModule
