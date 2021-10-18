//
//  ApplicationDelegateWatchKit.swift
//  ApplicationDelegate watchOS
//
//  Created by Amine Bensalah on 20/10/2018.
//

#if canImport(WatchKit)
import WatchKit

#if !os(iOS) && !os(macOS) && !os(tvOS)
public protocol ApplicationDelegate {
    func applicationDidFinishLaunching()
    func applicationDidBecomeActive()
    func applicationWillResignActive()
    func applicationWillEnterForeground()
    func applicationDidEnterBackground()
    
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>)
    
    // app crashed while in a workout
    func handleActiveWorkoutRecovery()
    
    
    // app brought frontmost due to auto-launching audio apps
    func handleRemoteNowPlayingActivity()
    
    
    func handleUserActivity(_ userInfo: [AnyHashable : Any]?)
    
    func handle(_ userActivity: NSUserActivity)

    func deviceOrientationDidChange() // called when WKInterfaceDeviceWristLocation, WKInterfaceDeviceCrownOrientation, or autorotated value changes
}

extension ApplicationDelegate {
    public func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
    }
    
    public func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    public func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }
    
    public func applicationWillEnterForeground() {}
    
    public func applicationDidEnterBackground() {}
    
    public func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {}
    
    // app crashed while in a workout
    public func handleActiveWorkoutRecovery() {}
    
    
    // app brought frontmost due to auto-launching audio apps
    public func handleRemoteNowPlayingActivity() {}
    
    
    public func handleUserActivity(_ userInfo: [AnyHashable : Any]?) {}
    
    public func handle(_ userActivity: NSUserActivity) {}
    
    public func deviceOrientationDidChange() {
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
    public func applicationDidFinishLaunching() {
        lazyServices.forEach { $0.applicationDidFinishLaunching() }
    }
    
    public func applicationDidBecomeActive() {
        lazyServices.forEach { $0.applicationDidBecomeActive() }
    }
    
    public func applicationWillResignActive() {
        lazyServices.forEach { $0.applicationWillResignActive() }
    }
    
    public func applicationWillEnterForeground() {
        lazyServices.forEach { $0.applicationWillEnterForeground() }
    }
    
    public func applicationDidEnterBackground() {
        lazyServices.forEach { $0.applicationDidEnterBackground() }
    }
    
    public func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        lazyServices.forEach { $0.handle(backgroundTasks) }
    }
}

extension PluggableApplicationDelegate {
    public func handleActiveWorkoutRecovery() {
        lazyServices.forEach { $0.handleActiveWorkoutRecovery() }
    }
    
    // app brought frontmost due to auto-launching audio apps
    public func handleRemoteNowPlayingActivity() {
        lazyServices.forEach { $0.handleRemoteNowPlayingActivity() }
    }
    
    public func handleUserActivity(_ userInfo: [AnyHashable : Any]?) {
        lazyServices.forEach { $0.handleUserActivity(userInfo) }
    }
    
    public func handle(_ userActivity: NSUserActivity) {
        lazyServices.forEach { $0.handle(userActivity) }
    }
    
    public func deviceOrientationDidChange() {
        lazyServices.forEach { $0.deviceOrientationDidChange() }
    }
}
#endif

#endif
