//
//  AppDelegate.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 18.08.2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        setupRootViewController()

        return true
    }
}

private extension AppDelegate {
    func setupRootViewController() {
        let vc = FlightsConfigurator.configure()

        let navigation = UINavigationController(rootViewController: vc)
        navigation.isNavigationBarHidden = true

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        self.window = window
    }
}
