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

    private var isLoadingFails = false
    private var connectionRepeat = 0

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
        var errorToAlert: Error?

        for coin in availableCoins {

            guard !isLoadingFails else {
                break
            }

            group.enter()
            networkManager.fetchDataModelType(endpoint: Endpoint.getCoin(name: coin), modelType: CryptoCoinRespModel.self) { [weak self] result in
                switch result {
                case .success(let coinModel):
                    gettedCoins.append(coinModel)
                    group.leave()
                case .failure(let error):
                    errorToAlert = error
                    self?.isLoadingFails = true
                    self?.presentedVC?.showError(error)
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) { [weak self] in
            guard let self = self else {
                return
            }

            guard self.isLoadingFails else {
                self.presentedVC?.stopSpinner()
                self.cryptoCoinsModelStorage = gettedCoins.filter({ $0.data?.name != nil })
                return
            }

            if self.connectionRepeat < 3 {
                self.connectionRepeat += 1
                print("try to reconnect \(self.connectionRepeat)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isLoadingFails = false
                    self.getCoins()
                }
            } else {
                self.connectionRepeat = 0
                self.isLoadingFails = false
                guard let errorToAlert = errorToAlert else {
                    return
                }
                self.showAlert(error: errorToAlert)
            }
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

    private func showAlert(error: Error) {
        presentedVC?.showAlert(error: error)
    }
}
