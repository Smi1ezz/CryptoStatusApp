//
//  MainPresenter.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
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

protocol CanShowDetailsPresenter {
    func showDetailsVC(about data: DetailableCoin)
}

protocol MainPresenterProtocol: PresenterProtocol, SortablePresenter, LogOutAblePresenter, CanShowDetailsPresenter {
    var cryptoCoinsModelStorage: [CryptoCoinRespModel]? {get}
    func getCoins()
}

final class MainPresenter: MainPresenterProtocol {

    private let router: MainRouterProtocol
    private let networkManager: CryptoNetworkManagerProtocol
    private var availableCoins = CoinNames.allCases

    var sortMode: SortMode?
    var cryptoCoinsModelStorage: [CryptoCoinRespModel]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.presentedVC?.reloadTable()
            }
        }
    }

    weak var presentedVC: MainViewControllerProtocol?

    init(router: MainRouterProtocol, networkManager: CryptoNetworkManagerProtocol, cryptoCoinsModel: [CryptoCoinRespModel]? = nil) {
        self.router = router
        self.networkManager = networkManager
        self.cryptoCoinsModelStorage = cryptoCoinsModel
    }

    func setDelegateVC(_ delegate: UIViewController) {
        self.presentedVC = delegate as? MainViewControllerProtocol
    }

    func getCoins() {
        guard !availableCoins.isEmpty else {
            presentedVC?.showError(AppError.coinsToFetchAreNotAvailable)
            return
        }
        presentedVC?.startSpinner()
        var gettedCoins = [CryptoCoinRespModel]()
        let group = DispatchGroup()
        for coin in availableCoins {
            group.enter()
            networkManager.fetchDataModelType(endpoint: Endpoint.getCoin(name: coin), modelType: CryptoCoinRespModel.self) { result in
                switch result {
                case .success(let coinModel):
                    gettedCoins.append(coinModel)
                    group.leave()

                case .failure(let error):
                    self.presentedVC?.showError(error)
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            self.presentedVC?.stopSpinner()
            self.cryptoCoinsModelStorage = gettedCoins.filter({ $0.data?.name != nil })
        }
    }

    func sortByUSDPrice() {
        switch sortMode {
        case .hiPriceFirst:
            self.sortMode = .lowPriceFirst
            sortPriceFromLoToHi()
        case .lowPriceFirst:
            self.sortMode = .hiPriceFirst
            sortPriceFromHiToLo()
        case .none:
            self.sortMode = .hiPriceFirst
            sortPriceFromHiToLo()
        }
    }

    func showDetailsVC(about data: DetailableCoin) {
        router.showDetailsVC(about: data)
    }

    func logOut() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isLoginPassed.rawValue)
        router.showRootScreen()
    }

    private func sortPriceFromHiToLo() {
        cryptoCoinsModelStorage = cryptoCoinsModelStorage?.sorted(by: {
            guard let firstPrise = $0.data?.marketData?.priceUsd else {
                return false
            }
            guard let secondPrice = $1.data?.marketData?.priceUsd else {
                return true
            }
            return firstPrise > secondPrice
        })
    }

    private func sortPriceFromLoToHi() {
        cryptoCoinsModelStorage = cryptoCoinsModelStorage?.sorted(by: {
            guard let firstPrise = $0.data?.marketData?.priceUsd else {
                return true
            }
            guard let secondPrice = $1.data?.marketData?.priceUsd else {
                return false
            }
            return firstPrise < secondPrice
        })
    }
}
