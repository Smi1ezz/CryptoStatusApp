//
//  DetailsViewController.swift
//  CryptoStatusApp
//
//  Created by admin on 17.11.2022.
//

import UIKit

protocol DetailsViewControllerProtocol: AnyObject {
    func setupDetailsView(coin: DetailableCoin)
}

final class DetailsViewController: UIViewController {

    private var presenter: DetailsPresenterProtocol

    private let detailsView = DetailsScrollView()

    init(presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsView.backgroundColor = .appColor(name: .backgroundBlack)
        presenter.setDelegateVC(self)
        presenter.getDetails()
        setupNavigationBar()
        setupSubViews()
    }

    private func setupSubViews() {
        view.addSubview(detailsView)
        detailsView.setupSubViews()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutButtonPressed))
    }

    @objc
    private func logoutButtonPressed() {
        presenter.logOut()
    }
}

// MARK: ext for DetailsViewControllerProtocol
extension DetailsViewController: DetailsViewControllerProtocol {
    func setupDetailsView(coin: DetailableCoin) {
        detailsView.setupDetails(coin: coin)
    }
}
