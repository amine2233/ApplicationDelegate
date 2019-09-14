//
//  ApplicationDelegateWatchSiriKit.swift
//  ApplicationDelegate iOS
//
//  Created by Amine Bensalah on 14/09/2019.
//

#if canImport(SiriKit) && canImport(WatchKit)
import WatchKit
import SiriKit

#if !os(iOS) && !os(macOS) && !os(tvOS)
extension ApplicationDelegate {
    public func handle(_ intent: INIntent, completionHandler: @escaping (INIntentResponse) -> Void) {}
}

extension PluggableApplicationDelegate {
    public func handle(_ intent: INIntent, completionHandler: @escaping (INIntentResponse) -> Void) {
        lazyServices.forEach { $0.application(intent, completionHandler: completionHandler) }
    }
}

#endif
#endif
