//
//  MainTableHeaderView.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
//

import UIKit
import SnapKit

final class MainTableHeaderView: UITableViewHeaderFooterView {
    private let chooseLabel: UILabel = {
        let chooseLabel = UILabel()
        chooseLabel.text = "Choose coin"
        chooseLabel.textAlignment = .center
        chooseLabel.textColor = .black
        chooseLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
         return chooseLabel
    }()

    private let descrLabel: UILabel = {
        let descrLabel = UILabel()
        descrLabel.text = "to see more details"
        descrLabel.textAlignment = .center
        descrLabel.textColor = .black
        descrLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
         return descrLabel
    }()

    private let sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.setTitle("Sort by price", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont.smallAppFont()
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSortButton(target: Any?, action: Selector, for event: UIControl.Event) {
        sortButton.addTarget(target, action: action, for: event)
    }

    private func setupSubViews() {
        [chooseLabel, descrLabel, sortButton].forEach { contentView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        chooseLabel.snp.makeConstraints { make in
            make.centerX.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }

        descrLabel.snp.makeConstraints { make in
            make.centerX.leading.trailing.equalToSuperview()
            make.top.equalTo(chooseLabel.snp.bottom).offset(5)
        }

        sortButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(descrLabel.snp.bottom).offset(5)
        }
    }
}
