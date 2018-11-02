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

public extension ApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { return true }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { return true }
    
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillResignActive(_ application: UIApplication) {}
    
    func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {}
    func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {}
    
    func applicationWillTerminate(_ application: UIApplication) {}
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {}
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {}
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {}
}

open class PluggableApplicationDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    
    public lazy var lazyServices: [ApplicationDelegate] = services()
    
    func services() -> [ApplicationDelegate] {
        return []
    }
}

public extension PluggableApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.application(application, willFinishLaunchingWithOptions: launchOptions) }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.application(application, didFinishLaunchingWithOptions: launchOptions) }
    }
}

public extension PluggableApplicationDelegate {
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationWillEnterForeground(application) }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationDidEnterBackground(application) }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationDidBecomeActive(application) }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationWillResignActive(application) }
    }
}

public extension PluggableApplicationDelegate {
    
    func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationProtectedDataWillBecomeUnavailable(application) }
    }
    
    func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationProtectedDataDidBecomeAvailable(application) }
    }
}

public extension PluggableApplicationDelegate {
    
    func applicationWillTerminate(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationWillTerminate(application) }
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationDidReceiveMemoryWarning(application) }
    }
}

public extension PluggableApplicationDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        lazyServices.forEach { $0.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        lazyServices.forEach { $0.application(application, didFailToRegisterForRemoteNotificationsWithError: error) }
    }
}

#endif
#endif
