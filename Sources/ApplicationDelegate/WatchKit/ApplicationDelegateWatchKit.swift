//
//  ApplicationDelegateWatchKit.swift
//  ApplicationDelegate watchOS
//
//  Created by Amine Bensalah on 20/10/2018.
//

#if canImport(WatchKit)
import WatchKit

#if !os(iOS) || !os(macOS)
public protocol ApplicationDelegate {
    func applicationDidFinishLaunching()
    func applicationDidBecomeActive()
    func applicationWillResignActive()
    func applicationWillEnterForeground()
    func applicationDidEnterBackground()
    
    @available(watchOS 3.0, *)
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>)
    
    // app crashed while in a workout
    @available(watchOS 5.0, *)
    func handleActiveWorkoutRecovery()
    
    
    // app brought frontmost due to auto-launching audio apps
    @available(watchOS 5.0, *)
    func handleRemoteNowPlayingActivity()
    
    
    func handleUserActivity(_ userInfo: [AnyHashable : Any]?)
    
    @available(watchOS 3.2, *)
    func handle(_ userActivity: NSUserActivity)

    @available(watchOS 4.0, *)
    func deviceOrientationDidChange() // called when WKInterfaceDeviceWristLocation, WKInterfaceDeviceCrownOrientation, or autorotated value changes
}

extension ApplicationDelegate {
    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
    }
    
    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }
    
    func applicationWillEnterForeground() {}
    
    func applicationDidEnterBackground() {}
    
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {}
    
    // app crashed while in a workout
    @available(watchOS 5.0, *)
    func handleActiveWorkoutRecovery() {}
    
    
    // app brought frontmost due to auto-launching audio apps
    @available(watchOS 5.0, *)
    func handleRemoteNowPlayingActivity() {}
    
    
    func handleUserActivity(_ userInfo: [AnyHashable : Any]?) {}
    
    @available(watchOS 3.2, *)
    func handle(_ userActivity: NSUserActivity) {}
    
    @available(watchOS 4.0, *)
    func deviceOrientationDidChange() {
        // called when WKInterfaceDeviceWristLocation, WKInterfaceDeviceCrownOrientation, or autorotated value changes
    }
}

open class PluggableApplicationDelegate: NSObject, WKExtensionDelegate {
    public lazy var lazyServices: [ApplicationDelegate] = services()
    
    open func services() -> [ApplicationDelegate] {
        return []
    }
}

extension PluggableApplicationDelegate {
    func applicationDidFinishLaunching() {
        lazyServices.forEach { $0.applicationDidFinishLaunching() }
    }
    
    func applicationDidBecomeActive() {
        lazyServices.forEach { $0.applicationDidBecomeActive() }
    }
    
    func applicationWillResignActive() {
        lazyServices.forEach { $0.applicationWillResignActive() }
    }
    
    func applicationWillEnterForeground() {
        lazyServices.forEach { $0.applicationWillEnterForeground() }
    }
    
    func applicationDidEnterBackground() {
        lazyServices.forEach { $0.applicationDidEnterBackground() }
    }
    
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        lazyServices.forEach { $0.handle(backgroundTasks) }
    }
}

extension PluggableApplicationDelegate {
    @available(watchOS 5.0, *)
    func handleActiveWorkoutRecovery() {
        lazyServices.forEach { $0.handleActiveWorkoutRecovery() }
    }
    
    // app brought frontmost due to auto-launching audio apps
    @available(watchOS 5.0, *)
    func handleRemoteNowPlayingActivity() {
        lazyServices.forEach { $0.handleRemoteNowPlayingActivity() }
    }
    
    func handleUserActivity(_ userInfo: [AnyHashable : Any]?) {
        lazyServices.forEach { $0.handleUserActivity(userInfo) }
    }
    
    @available(watchOS 3.2, *)
    func handle(_ userActivity: NSUserActivity) {
        lazyServices.forEach { $0.handle(userActivity) }
    }
    
    @available(watchOS 4.0, *)
    func deviceOrientationDidChange() {
        lazyServices.forEach { $0.deviceOrientationDidChange() }
    }
}
#endif

#endif
