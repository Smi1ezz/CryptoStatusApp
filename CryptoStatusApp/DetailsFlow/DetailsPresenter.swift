//
//  DetailsPresenter.swift
//  CryptoStatusApp
//
//  Created by admin on 18.11.2022.
//

import UIKit

protocol DetailsPresenterProtocol: PresenterProtocol, RoutablePresenter, LogOutAblePresenter {
    func getDetails()
}

final class DetailsPresenter: DetailsPresenterProtocol {
    private let detailsRouter: DetailsRouterProtocol
    private var coinModel: DetailableCoin

    weak var presentedViewController: DetailsViewControllerProtocol? {
        didSet {
            setupRouterNavigation()
        }
    }

    init(router: DetailsRouterProtocol, coin: DetailableCoin) {
        self.detailsRouter = router
        self.coinModel = coin
    }

    func setupRouterNavigation() {
        guard let naviVC = (presentedViewController as? UIViewController)?.navigationController else {
            return
        }
        self.detailsRouter.setNavigationController(naviVC)
    }

    func setDelegateVC(_ delegate: UIViewController) {
        self.presentedViewController = delegate as? DetailsViewControllerProtocol
    }

    func getDetails() {
        presentedViewController?.setupDetailsView(coin: coinModel)
    }

    func logOut() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isLoginPassed.rawValue)
        detailsRouter.showRootScreen()
    }
}
