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
        chooseLabel.textColor = .appColor(name: .appGreen)
        chooseLabel.font = UIFont.bigAppFont()
         return chooseLabel
    }()

    private let descrLabel: UILabel = {
        let descrLabel = UILabel()
        descrLabel.text = "to see more details"
        descrLabel.textAlignment = .center
        descrLabel.textColor = .appColor(name: .appGreen)
        descrLabel.font = UIFont.mediumAppFont()
         return descrLabel
    }()

    private let sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.setTitle("Sort by price", for: .normal)
        button.tintColor = .appColor(name: .appGreen)
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
