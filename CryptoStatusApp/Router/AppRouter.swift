//
//  AppRouter.swift
//  CryptoStatusApp
//
//  Created by admin on 04.11.2022.
//

import UIKit

protocol AppRouterType: AnyObject {
    func showRootScreen()
}

final class AppRouter: AppRouterType {
    private(set) var window: UIWindow
    private var navigationVC: UINavigationController?

    init(window: UIWindow = UIWindow()) {
        self.window = window
    }

    func showRootScreen() {
//        let storyboard = UIStoryboard(name: "MusicSearch", bundle: Bundle.main)
//        guard let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController,
//                let searchViewController = navigationController.viewControllers.first as? MusicSearchViewController else {
//            fatalError("Expected to have UINavigationController as initial")
//        }
//
//        let urlBuilder = URLBuilder()
//        let networkClient = NetworkClient(urlBuilder: urlBuilder)
//        let router = MusicSearchViewRouter(viewController: searchViewController)
//        let presenter = MusicSearchPresenter(networkClient: networkClient, router: router)
//        searchViewController.output = presenter
//        presenter.input = searchViewController
//
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()

        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoginPassed.rawValue) {
            // вход без логина и пароля
            let vc = ViewController()
            let navigationVC = UINavigationController(rootViewController: vc)
            self.navigationVC = navigationVC
        } else {
            let loginVC = LoginViewController()
            let navigationVC = UINavigationController(rootViewController: loginVC)
            self.navigationVC = navigationVC
        }

        window.rootViewController = navigationVC
        window.makeKeyAndVisible()

        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                delegate.window = window
        }

    }
}
