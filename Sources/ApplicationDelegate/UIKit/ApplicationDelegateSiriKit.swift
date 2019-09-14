//
//  ApplicationDelegateSiriKit.swift
//  ApplicationDelegate iOS
//
//  Created by Amine Bensalah on 14/09/2019.
//

#if canImport(SiriKit) && canImport(UIKit)
import UIKit
import SiriKit

#if !os(watchOS) && !os(macOS) && !os(tvOS)
extension ApplicationDelegate {
    public func application(_ application: UIApplication, handle intent: INIntent, completionHandler: @escaping (INIntentResponse) -> Void) {}
}

extension PluggableApplicationDelegate {
    public func application(_ application: UIApplication,
                            handle intent: INIntent,
                            completionHandler: @escaping (INIntentResponse) -> Void) {
        lazyServices.forEach { $0.application(application, handle: intent, completionHandler: completionHandler) }
    }
}
#endif
#endif
