//
//  ViewController.swift
//  CryptoStatusApp
//
//  Created by admin on 04.11.2022.
//

import UIKit
import SnapKit

protocol MainViewControllerProtocol: AnyObject, SpinnerableView, ErrorShowableView {
    func reloadTable()
}

final class MainViewController: UIViewController {
    private let presenter: MainPresenterProtocol

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    var spinner = UIActivityIndicatorView(style: .large)

    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupNavigationBar()
        presenter.setDelegateVC(self)
        presenter.getCoins()
    }

    private func setupSubviews() {
        tableView.backgroundColor = .appColor(name: .backgroundBlack)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.description())
        tableView.register(MainTableHeaderView.self, forHeaderFooterViewReuseIdentifier: MainTableHeaderView.description())
        view.addSubview(tableView)
        setupConstraints()
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutButtonPressed))
    }

    @objc
    private func sortByUSDPrice() {
        presenter.sortByUSDPrice()
    }

    @objc
    private func logoutButtonPressed() {
        presenter.logOut()
    }

}

// MARK: ext for MainViewControllerProtocol
extension MainViewController: MainViewControllerProtocol {
    func reloadTable() {
        tableView.reloadData()
    }

    func startSpinner() {
        let footerSpinner = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        spinner.startAnimating()
        spinner.color = .appColor(name: .appGreen)
        footerSpinner.addSubview(spinner)
        spinner.center = footerSpinner.center
        tableView.tableFooterView = footerSpinner
    }

    func stopSpinner() {
        tableView.tableFooterView = nil
    }

    func showError(_ error: Error) {
        let errorLabel: UILabel = {
            let errorLabel = UILabel()
            errorLabel.text = "Some Error"
            errorLabel.textColor = .red
            errorLabel.textAlignment = .center
            errorLabel.font = UIFont.mediumAppFont()
            return errorLabel
        }()

        if let text = (error as? ErrorNetwork)?.rawValue {
            errorLabel.text = text
        } else if let text = (error as? AppError)?.rawValue {
            errorLabel.text = text
        }

        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            errorLabel.removeFromSuperview()
        }
    }

    func showAlert(error: Error) {
        let alert = UIAlertController(title: "\(error)",
                                      message: "Want to try to reconnect? Press Repeat",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Repeat", style: .default, handler: { [weak self] _ in
            self?.presenter.getCoins()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            fatalError("Fatal error. Aplication closed")
        }))

        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: ext for UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            guard let storage = presenter.cryptoCoinsModelStorage else {
                throw AppError.emptyStorage
            }
            presenter.showDetailsVC(about: storage[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
        } catch {
            print(error)
        }
    }
}

// MARK: ext for UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.cryptoCoinsModelStorage?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        do {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.description(), for: indexPath) as? MainTableViewCell else {
                throw AppError.wrongMainTableViewCell
            }
            guard let storage = presenter.cryptoCoinsModelStorage else {
                throw AppError.emptyStorage
            }
            cell.setupCell(details: storage[indexPath.row])
            return cell
        } catch {
            print(error)
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else {
            return nil
        }
        do {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainTableHeaderView.description()) as? MainTableHeaderView else {
                throw AppError.wrongMainTableViewHeader
            }
            header.setSortButton(target: self, action: #selector(sortByUSDPrice), for: .touchUpInside)
            return header

        } catch {
            print(error)
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110
    }

}
