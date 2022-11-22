//
//  SceneDelegate.swift
//  CryptoStatusApp
//
//  Created by admin on 04.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appRouter: AppRouterProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }

        let mainWindow = UIWindow(windowScene: scene)
        mainWindow.overrideUserInterfaceStyle = .light

        window = mainWindow
        window?.makeKeyAndVisible()
        appRouter = AppRouter()
        appRouter?.showRootScreen()
    }

}
