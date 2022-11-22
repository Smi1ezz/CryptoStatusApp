//
//  WatchersView.swift
//  CryptoStatusApp
//
//  Created by admin on 17.11.2022.
//

import Foundation
import UIKit

final class WatchersView: UIView {
    // MARK: Properties

    let watchersLabel: UILabel = {
        let watchersLabel = UILabel()
        watchersLabel.textAlignment = .center
        watchersLabel.textColor = .appColor(name: .appGreen)
        watchersLabel.font = UIFont.mediumAppFont()
        return watchersLabel
    }()

    private let watchersImageView: UIImageView = {
        let watchersImageView = UIImageView(image: UIImage(systemName: "eye.fill"))
        watchersImageView.contentMode = .scaleAspectFill
        watchersImageView.tintColor = .appColor(name: .loginViewGreen)
        return watchersImageView
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
        [watchersLabel, watchersImageView].forEach { self.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        watchersLabel.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
        }

        watchersImageView.snp.makeConstraints { make in
            make.leading.equalTo(watchersLabel.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
}
