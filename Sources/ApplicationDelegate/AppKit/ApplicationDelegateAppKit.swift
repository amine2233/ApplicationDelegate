//
//  ApplicationDelegateAppKit.swift
//  ApplicationDelegate macOS
//
//  Created by Amine Bensalah on 20/10/2018.
//

#if canImport(Cocoa)
import Cocoa

#if !os(watchOS)
public protocol ApplicationDelegate  {

    func applicationWillFinishLaunching(_ aNotification: Notification)
    func applicationDidFinishLaunching(_ aNotification: Notification)

    func applicationWillTerminate(_ aNotification: Notification)
    func applicationShouldTerminate(_ aSender: NSApplication) -> NSApplication.TerminateReply
    func applicationShouldTerminateAfterLastWindowClosed(_ aSender: NSApplication) -> Bool

    func applicationWillBecomeActive(_ aNotification: Notification)
    func applicationDidBecomeActive(_ aNotification: Notification)
    func applicationWillResignActive(_ aNotification: Notification)

    func applicationWillHide(_ aNotification: Notification)
    func applicationDidHide(_ aNotification: Notification)
    func applicationWillUnhide(_ aNotification: Notification)
    func applicationDidUnhide(_ aNotification: Notification)

    func applicationWillUpdate(_ aNotification: Notification)
    func applicationDidUpdate(_ aNotification: Notification)
    func applicationShouldHandleReopen(_ aSender: NSApplication, hasVisibleWindows flag: Bool) -> Bool

    func applicationDockMenu(_ aSender: NSApplication) -> NSMenu?

    func application(_ application: NSApplication, willPresentError error: Error) -> Error

    func applicationDidChangeScreenParameters(_ aNotification: Notification)
}

/// Launching Applications
extension ApplicationDelegate {

    public func applicationDidFinishLaunching(_ aNotification: Notification) {}
    public func applicationWillFinishLaunching(_ aNotification: Notification) {}
}

/// Terminating Applications
extension ApplicationDelegate {
    
    public func applicationShouldTerminate(_ aSender: NSApplication) -> NSApplication.TerminateReply { return .terminateNow }
    public func applicationWillTerminate(_ aNotification: Notification) {}
    public func applicationShouldTerminateAfterLastWindowClosed(_ aSender: NSApplication) -> Bool { return true }
}

/// Managing Active Status
extension ApplicationDelegate {

    func applicationWillBecomeActive(_ aNotification: Notification) {}
    func applicationDidBecomeActive(_ aNotification: Notification) {}
    func applicationWillResignActive(_ aNotification: Notification) {}
}

/// Hiding Applications
extension ApplicationDelegate {
    func applicationWillHide(_ aNotification: Notification) {}
    func applicationDidHide(_ aNotification: Notification) {}
    func applicationWillUnhide(_ aNotification: Notification) {}
    func applicationDidUnhide(_ aNotification: Notification) {}
}

/// Managing Windows
extension ApplicationDelegate {

    func applicationWillUpdate(_ aNotification: Notification) {}
    func applicationDidUpdate(_ aNotification: Notification) {}
    func applicationShouldHandleReopen(_ aSender: NSApplication, hasVisibleWindows flag: Bool) -> Bool { return true }
}

/// Managing the Dock Menu
extension ApplicationDelegate {
    func applicationDockMenu(_ aSender: NSApplication) -> NSMenu? { return nil }
}

/// Displaying Errors
extension ApplicationDelegate {
    func application(_ application: NSApplication, willPresentError error: Error) -> Error { return error }
}

/// Managing the Screen
extension ApplicationDelegate {
    func applicationDidChangeScreenParameters(_ aNotification: Notification) {}
}

open class PluggableApplicationDelegate: NSObject, NSApplicationDelegate {
    
    public var application: NSApplication?
    
    public lazy var lazyServices: [ApplicationDelegate] = services()
    
    public func services() -> [ApplicationDelegate] {
        return []
    }
}

extension PluggableApplicationDelegate {

    /// Sent by the default notification center after the application has been launched and initialized but before it has received its first event.
    public func applicationDidFinishLaunching(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationDidFinishLaunching(aNotification) }
    }

    /// Sent by the default notification center immediately before the application object is initialized.
    public func applicationWillFinishLaunching(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationWillFinishLaunching(aNotification) }
    }
}

extension PluggableApplicationDelegate {

    /// Sent by the default notification center immediately before the application terminates.
    public func applicationWillTerminate(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationWillTerminate(aNotification) }
    }

    /// Sent to notify the delegate that the application is about to terminate.
    public func applicationShouldTerminate(_ aSender: NSApplication) -> NSApplication.TerminateReply {
        return lazyServices.reduce(.terminateNow) { $1.applicationShouldTerminate(aSender) }
    }

    /// Invoked when the user closes the last window the application has open.
    public func applicationShouldTerminateAfterLastWindowClosed(_ aSender: NSApplication) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.applicationShouldTerminateAfterLastWindowClosed(aSender) }
    }
}

extension PluggableApplicationDelegate {

    /// Sent by the default notification center immediately before the application becomes active.
    public func applicationWillBecomeActive(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationWillBecomeActive(aNotification) }
    }

    /// Sent by the default notification center immediately after the application becomes active.
    public func applicationDidBecomeActive(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationDidBecomeActive(aNotification) }
    }

    /// Sent by the default notification center immediately before the application is deactivated.
    public func applicationWillResignActive(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationWillResignActive(aNotification) }
    }
}

extension PluggableApplicationDelegate {

    /// Sent by the default notification center immediately before the application is hidden.
    public func applicationWillHide(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationWillHide(aNotification) }
    }

    /// Sent by the default notification center immediately after the application is hidden.
    public func applicationDidHide(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationDidHide(aNotification) }
    }

    /// Sent by the default notification center immediately after the application is unhidden.
    public func applicationWillUnhide(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationWillUnhide(aNotification) }
    }

    /// Sent by the default notification center immediately after the application is made visible.
    public func applicationDidUnhide(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationDidUnhide(aNotification) }
    }
}

extension PluggableApplicationDelegate {

    /// Sent by the default notification center immediately before the application object updates its windows.
    public func applicationWillUpdate(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationWillUpdate(aNotification) }
    }

    /// Sent by the default notification center immediately after the application object updates its windows.
    public func applicationDidUpdate(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationDidUpdate(aNotification) }
    }

    ///Sent by the application to the delegate prior to default behavior to reopen (rapp) AppleEvents.
    public func applicationShouldHandleReopen(_ aSender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        return lazyServices.reduce(true) { $0 && $1.applicationShouldHandleReopen(aSender, hasVisibleWindows: flag) }
    }
}

extension PluggableApplicationDelegate {

    /// Allows the delegate to supply a dock menu for the application dynamically.
    public func applicationDockMenu(_ aSender: NSApplication) -> NSMenu? {
        return lazyServices.reduce(nil) { $1.applicationDockMenu(aSender) }
    }
}

extension PluggableApplicationDelegate {

    /// Sent to the delegate before the specified application presents an error message to the user.
    public func application(_ application: NSApplication, willPresentError error: Error) -> Error {
        return lazyServices.reduce(error) { $1.application(application, willPresentError: error) }
    }
}

extension PluggableApplicationDelegate {

    /// Sent by the default notification center when the configuration of the displays attached to the computer is changed
    /// (either programmatically or when the user changes settings in the Displays control panel).
    public func applicationDidChangeScreenParameters(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationDidChangeScreenParameters(aNotification) }
    }
}


#endif

#endif
