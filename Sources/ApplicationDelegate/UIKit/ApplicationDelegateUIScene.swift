//
//  ApplicationDelegateUIScene.swift
//  ApplicationDelegate iOS
//
//  Created by Amine Bensalah on 22/09/2019.
//

#if canImport(UIKit)
import UIKit

extension ApplicationDelegate {
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

extension PluggableApplicationDelegate {
    @available(iOS 13.0, *)
    public func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        return lazyServices.reduce(configuration) { $1.application(application, configurationForConnecting: connectingSceneSession, options: options) }
    }

    @available(iOS 13.0, *)
    public func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        lazyServices.forEach { $0.application(application, didDiscardSceneSessions: sceneSessions) }
    }
}

#endif
