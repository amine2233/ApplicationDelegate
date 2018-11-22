//
//  ApplicationDelegate.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 20/10/2018.
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)

public protocol ApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool
    
    func applicationDidEnterBackground(_ application: UIApplication)
    func applicationWillEnterForeground(_ application: UIApplication)
    func applicationDidBecomeActive(_ application: UIApplication)
    func applicationWillResignActive(_ application: UIApplication)
    
    func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication)
    func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication)
    
    func applicationWillTerminate(_ application: UIApplication)
    func applicationDidReceiveMemoryWarning(_ application: UIApplication)
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
}

extension ApplicationDelegate {
    
    public func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { return true }
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { return true }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {}
    public func applicationDidEnterBackground(_ application: UIApplication) {}
    public func applicationDidBecomeActive(_ application: UIApplication) {}
    public func applicationWillResignActive(_ application: UIApplication) {}
    
    public func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {}
    public func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {}
    
    public func applicationWillTerminate(_ application: UIApplication) {}
    public func applicationDidReceiveMemoryWarning(_ application: UIApplication) {}
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {}
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {}
}

open class PluggableApplicationDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    
    public lazy var lazyServices: [ApplicationDelegate] = services()
    
    public func services() -> [ApplicationDelegate] {
        return []
    }
}

public extension PluggableApplicationDelegate {
    
    public func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.application(application, willFinishLaunchingWithOptions: launchOptions) }
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.application(application, didFinishLaunchingWithOptions: launchOptions) }
    }
}

public extension PluggableApplicationDelegate {
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationWillEnterForeground(application) }
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationDidEnterBackground(application) }
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationDidBecomeActive(application) }
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationWillResignActive(application) }
    }
}

public extension PluggableApplicationDelegate {
    
    public func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationProtectedDataWillBecomeUnavailable(application) }
    }
    
    public func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationProtectedDataDidBecomeAvailable(application) }
    }
}

public extension PluggableApplicationDelegate {
    
    public func applicationWillTerminate(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationWillTerminate(application) }
    }
    
    public func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationDidReceiveMemoryWarning(application) }
    }
}

public extension PluggableApplicationDelegate {
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        lazyServices.forEach { $0.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }
    
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        lazyServices.forEach { $0.application(application, didFailToRegisterForRemoteNotificationsWithError: error) }
    }
}

#endif
#endif
