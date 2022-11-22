//
//  StarsView.swift
//  CryptoStatusApp
//
//  Created by admin on 17.11.2022.
//

import Foundation
import UIKit

final class StarsView: UIView {
    // MARK: Properties

    let starsLabel: UILabel = {
        let starsLabel = UILabel()
        starsLabel.textAlignment = .center
        starsLabel.textColor = .appColor(name: .appGreen)
        starsLabel.font = UIFont.mediumAppFont()
        return starsLabel
    }()

    private let starsImageView: UIImageView = {
        let starsImageView = UIImageView(image: UIImage(systemName: "star.fill"))
        starsImageView.contentMode = .scaleAspectFill
        starsImageView.tintColor = .appColor(name: .loginViewGreen)
        return starsImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods

    private func setupSubViews() {
        [starsLabel, starsImageView].forEach { self.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        starsLabel.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
        }

        starsImageView.snp.makeConstraints { make in
            make.leading.equalTo(starsLabel.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
}
