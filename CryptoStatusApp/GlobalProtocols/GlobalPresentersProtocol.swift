//
//  GlobalPresentersProtocol.swift
//  CryptoStatusApp
//
//  Created by admin on 22.11.2022.
//

import Foundation
import UIKit

protocol PresenterProtocol {
    func setDelegateVC(_ delegate: UIViewController)
}

protocol SortablePresenter {
    var sortMode: SortMode? {get}
    func sortByUSDPrice()
}

protocol LogOutAblePresenter {
    func logOut()
}

protocol LogInAblePresenter {
    func tryToLogIn(name: String, password: String) throws
}

protocol CanShowDetailsPresenter {
    func showDetailsVC(about data: DetailableCoin)
}

protocol RoutablePresenter {
    func setupRouterNavigation()
}
