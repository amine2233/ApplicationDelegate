//
//  ApplicationDelegate.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 20/10/2018.
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS) && !os(macOS)
public protocol ApplicationDelegate {

    func applicationDidFinishLaunching(_ application: UIApplication)

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

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool

    func applicationSignificantTimeChange(_ application: UIApplication)


    func application(_ application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect)
    func application(_ application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect)

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)

    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void)
    func application(_ application: UIApplication, handleWatchKitExtensionRequest userInfo: [AnyHashable : Any]?, reply: @escaping ([AnyHashable : Any]?) -> Void)

    func applicationShouldRequestHealthAuthorization(_ application: UIApplication)

    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool

    func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController?

    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool

    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool

    func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder)

    func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder)

    func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool

    func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error)

    func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity)
}


extension ApplicationDelegate {
    public func applicationDidFinishLaunching(_ application: UIApplication) {}

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

    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool { return true }

    public func applicationSignificantTimeChange(_ application: UIApplication) {}


    public func application(_ application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {}
    public func application(_ application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect) {}

    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {}
    public func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {}

    public func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {}
    public func application(_ application: UIApplication, handleWatchKitExtensionRequest userInfo: [AnyHashable : Any]?, reply: @escaping ([AnyHashable : Any]?) -> Void) {}

    public func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {}

    public func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool { return true }

    public func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? { return nil }

    public func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool { return true }

    public func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool { return true }

    public func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {}

    public func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {}

    public func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool { return true }

    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool { return true }

    public func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {}

    public func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {}
}

open class PluggableApplicationDelegate: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?
    
    public lazy var lazyServices: [ApplicationDelegate] = services()
    
    open func services() -> [ApplicationDelegate] {
        return []
    }
}

extension PluggableApplicationDelegate {
    public func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.application(application, willFinishLaunchingWithOptions: launchOptions) }
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.application(application, didFinishLaunchingWithOptions: launchOptions) }
    }
}

extension PluggableApplicationDelegate {
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

extension PluggableApplicationDelegate {
    public func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationProtectedDataWillBecomeUnavailable(application) }
    }
    
    public func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationProtectedDataDidBecomeAvailable(application) }
    }
}

extension PluggableApplicationDelegate {
    public func applicationWillTerminate(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationWillTerminate(application) }
    }
    
    public func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationDidReceiveMemoryWarning(application) }
    }
}

extension PluggableApplicationDelegate {
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        lazyServices.forEach { $0.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }
    
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        lazyServices.forEach { $0.application(application, didFailToRegisterForRemoteNotificationsWithError: error) }
    }
}

extension PluggableApplicationDelegate {
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.application(app, open: url, options: options) }
    }
}

extension PluggableApplicationDelegate {
    public func applicationSignificantTimeChange(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationSignificantTimeChange(application) }
    }

    public func application(_ application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
        lazyServices.forEach { $0.application(application, willChangeStatusBarFrame: newStatusBarFrame) }
    }

    public func application(_ application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect) {
        lazyServices.forEach { $0.application(application, didChangeStatusBarFrame: oldStatusBarFrame) }
    }

    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) { lazyServices.forEach { $0.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler) } }

    public func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        lazyServices.forEach { $0.application(application, performFetchWithCompletionHandler: completionHandler)}
    }
}

extension PluggableApplicationDelegate {
    public func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        lazyServices.forEach { $0.application(application, handleEventsForBackgroundURLSession: identifier, completionHandler: completionHandler) }
    }

    public func application(_ application: UIApplication, handleWatchKitExtensionRequest userInfo: [AnyHashable : Any]?, reply: @escaping ([AnyHashable : Any]?) -> Void) {
        lazyServices.forEach { $0.application(application, handleWatchKitExtensionRequest: userInfo, reply: reply) }
    }
}

extension PluggableApplicationDelegate {
    public func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        lazyServices.forEach { $0.applicationShouldRequestHealthAuthorization(application) }
    }
}

extension PluggableApplicationDelegate {
    public func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.application(application, shouldAllowExtensionPointIdentifier: extensionPointIdentifier) }
    }

    public func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
        return lazyServices.reduce(nil) { $1.application(application, viewControllerWithRestorationIdentifierPath: identifierComponents, coder: coder) }
    }

    public func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.application(application, shouldSaveApplicationState: coder) }
    }

    public func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.application(application, shouldRestoreApplicationState: coder) }
    }

    public func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        lazyServices.forEach { $0.application(application, willEncodeRestorableStateWith: coder) }
    }

    public func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        lazyServices.forEach { $0.application(application, didDecodeRestorableStateWith: coder) }
    }

    public func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.application(application, willContinueUserActivityWithType: userActivityType) }
    }

    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.application(application, continue: userActivity, restorationHandler: restorationHandler) }
    }

    public func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        lazyServices.forEach { $0.application(application, didFailToContinueUserActivityWithType: userActivityType, error: error) }
    }

    public func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        lazyServices.forEach { $0.application(application, didUpdate: userActivity) }
    }
}

#endif

#if !os(watchOS) && !os(macOS) && !os(tvOS)
extension ApplicationDelegate {
    public func application(_ application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: TimeInterval) {}

    public func application(_ application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {}

    @available(iOS 9.0, *)
    public func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {}

    public func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask { return .all }
}

extension PluggableApplicationDelegate {
    public func application(_ application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        lazyServices.forEach { $0.application(application, willChangeStatusBarOrientation: newStatusBarOrientation, duration: duration) }
    }

    public func application(_ application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
        lazyServices.forEach { $0.application(application, didChangeStatusBarOrientation: oldStatusBarOrientation) }
    }

    @available(iOS 9.0, *)
    public func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        lazyServices.forEach { $0.application(application, performActionFor: shortcutItem, completionHandler: completionHandler) }
    }

    public func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return lazyServices.reduce(.all) { $1.application(application, supportedInterfaceOrientationsFor: window) }
    }
}

#endif
#endif
