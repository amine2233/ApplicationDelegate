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
    
    func applicationDidFinishLaunching(_ aNotification: Notification)
    func applicationWillTerminate(_ aNotification: Notification)
}

extension ApplicationDelegate {
    
    public func applicationDidFinishLaunching(_ aNotification: Notification) {}
    public func applicationWillTerminate(_ aNotification: Notification) {}
}

open class PluggableApplicationDelegate: NSObject, NSApplicationDelegate {
    
    public var application: NSApplication?
    
    public lazy var lazyServices: [ApplicationDelegate] = services()
    
    public func services() -> [ApplicationDelegate] {
        return []
    }
}

public extension PluggableApplicationDelegate {
    
    public func applicationDidFinishLaunching(_ aNotification: Notification) {
        lazyServices.forEach { $0.applicationDidFinishLaunching(aNotification) }
    }
    
    public func applicationWillTerminate(_ notification: Notification) {
        lazyServices.forEach { $0.applicationWillTerminate(notification) }
    }
}


#endif

#endif
