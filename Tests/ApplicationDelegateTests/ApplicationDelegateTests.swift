//
//  ApplicationDelegateTests.swift
//  ApplicationDelegateTests
//
//  Created by Amine Bensalah on 20/10/2018.
//

import Testing
@testable import ApplicationDelegate

@Suite("ApplicationDelegate")
struct ApplicationDelegateTests {

    #if canImport(AppKit) || canImport(UIKit) || canImport(WatchKit)
    @Test("Default pluggable services are empty")
    @MainActor
    func defaultServicesAreEmpty() {
        let delegate = PluggableApplicationDelegate()
        #expect(delegate.lazyServices.isEmpty)
    }
    #endif

    #if canImport(AppKit) && !targetEnvironment(macCatalyst)
    @Test("AppKit notifications are forwarded to every registered service")
    @MainActor
    func appKitNotificationsAreForwarded() {
        let spy = SpyService()
        let delegate = StubPluggableApplicationDelegate(services: [spy])

        delegate.applicationWillFinishLaunching(.init(name: .init("test")))
        delegate.applicationDidFinishLaunching(.init(name: .init("test")))

        #expect(spy.willFinishLaunchingCount == 1)
        #expect(spy.didFinishLaunchingCount == 1)
    }

    @Test("AppKit boolean decisions are reduced across services")
    @MainActor
    func appKitBooleanDecisionsAreReduced() {
        let allowing = SpyService()
        let denying = SpyService(shouldTerminateAfterLastWindowClosed: false)

        let delegate = StubPluggableApplicationDelegate(services: [allowing, denying])

        #expect(delegate.applicationShouldTerminateAfterLastWindowClosed(.shared) == false)
    }
    #endif
}

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

/// Records the delegate callbacks it receives so tests can assert on the forwarding behaviour.
private final class SpyService: ApplicationDelegate, @unchecked Sendable {
    private(set) var willFinishLaunchingCount = 0
    private(set) var didFinishLaunchingCount = 0
    private let shouldTerminateAfterLastWindowClosed: Bool

    init(shouldTerminateAfterLastWindowClosed: Bool = true) {
        self.shouldTerminateAfterLastWindowClosed = shouldTerminateAfterLastWindowClosed
    }

    func applicationWillFinishLaunching(_ aNotification: Notification) {
        willFinishLaunchingCount += 1
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        didFinishLaunchingCount += 1
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ aSender: NSApplication) -> Bool {
        shouldTerminateAfterLastWindowClosed
    }
}

private final class StubPluggableApplicationDelegate: PluggableApplicationDelegate {
    private let injectedServices: [ApplicationDelegate]

    init(services: [ApplicationDelegate]) {
        self.injectedServices = services
        super.init()
    }

    override func services() -> [ApplicationDelegate] {
        injectedServices
    }
}
#endif
