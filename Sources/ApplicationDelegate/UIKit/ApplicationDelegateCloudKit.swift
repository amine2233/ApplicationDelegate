//
//  ApplicationDelegateHealthKit.swift
//  ApplicationDelegate iOS
//
//  Created by Amine Bensalah on 14/09/2019.
//

#if canImport(CloudKit) && canImport(UIKit)
import UIKit
import CloudKit

#if !os(watchOS) && !os(macOS) && !os(tvOS)
extension ApplicationDelegate {
    @available(iOS 10.0, *)
    public func application(_ application: UIApplication, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata) {}
}

extension PluggableApplicationDelegate {
    @available(iOS 10.0, *)
    public func application(_ application: UIApplication,
                            userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata) {
        lazyServices.forEach { $0.application(application, userDidAcceptCloudKitShareWith: cloudKitShareMetadata) }
    }
}

#endif
#endif
