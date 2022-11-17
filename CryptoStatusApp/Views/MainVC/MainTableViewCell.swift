//
//  MainTableView.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
//

import UIKit
import SnapKit

final class MainTableViewCell: UITableViewCell {
    private let symbolLabel: UILabel = {
        let symbolLabel = UILabel()
        symbolLabel.textAlignment = .center
        symbolLabel.adjustsFontSizeToFitWidth = true
        symbolLabel.font = UIFont.bigAppFont()
        symbolLabel.textColor = .black
        symbolLabel.backgroundColor = .green
        symbolLabel.makeBorder(borderColor: .black, borderWidth: 0.5, cornerRadius: 30)
        return symbolLabel
    }()

    private let symbolShadowView: UIView = {
        let symbolShadowView = UIView()
        symbolShadowView.layer.cornerRadius = 30
        symbolShadowView.makeShadow(color: .green, opacity: 1, offSet: .zero, radius: 5)
        return symbolShadowView
    }()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.mediumAppFont()
        return nameLabel
    }()

    private let priceUsd: UILabel = {
        let priceUsd = UILabel()
        priceUsd.font = UIFont.smallAppFont()
        return priceUsd
    }()

    private let priceBtc: UILabel = {
        let priceBtc = UILabel()
        priceBtc.font = UIFont.smallAppFont()
        return priceBtc
    }()

    private let percentCngUsdLastHour: UILabel = {
        let percentCngUsdLastHour = UILabel()
        percentCngUsdLastHour.font = UIFont.smallAppFont()
        return percentCngUsdLastHour
    }()

    private let percentCngBtcLastHour: UILabel = {
        let percentCngBtcLastHour = UILabel()
        percentCngBtcLastHour.font = UIFont.smallAppFont()
        return percentCngBtcLastHour
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setupCell(details coin: DetailableCoin) {
        symbolLabel.text = coin.data?.symbol
        nameLabel.text = coin.data?.name
        priceUsd.text = "price: " + correctDetail(coin.data?.marketData?.priceUsd) + " $"
        priceBtc.text = "price: " + correctDetail(coin.data?.marketData?.priceBtc) + " btc"
        percentCngUsdLastHour.text = "delta 24h: " + correctDetail(coin.data?.marketData?.percentChangeUsdLast24Hours) + " %"
        percentCngBtcLastHour.text = "delta 24h: " + correctDetail(coin.data?.marketData?.percentChangeBtcLast24Hours) + " %"
    }

    private func correctDetail<T>(_ detail: T?) -> String {
        guard let detail = detail else {
            return "-"
        }
        guard let double = detail as? Double else {
            return "\(detail)"
        }
        return String(format: "%.3f", double)
    }

    private func setupSubviews() {
        symbolShadowView.addSubview(symbolLabel)
        [symbolShadowView, nameLabel, priceBtc, priceUsd, percentCngBtcLastHour, percentCngUsdLastHour].forEach { contentView.addSubview($0)
        }
        setupConstraints()

    }

    private func setupConstraints() {
        symbolLabel.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }

        symbolShadowView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(60)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(symbolShadowView.snp.trailing).offset(10)
        }

        priceUsd.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(nameLabel.snp.leading)
        }

        priceBtc.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(priceUsd.snp.trailing).offset(10)
        }

        percentCngUsdLastHour.snp.makeConstraints { make in
            make.top.equalTo(priceUsd.snp.bottom).offset(5)
            make.leading.equalTo(nameLabel.snp.leading)
        }

        percentCngBtcLastHour.snp.makeConstraints { make in
            make.top.equalTo(priceBtc.snp.bottom).offset(5)
            make.leading.equalTo(percentCngUsdLastHour.snp.trailing).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

}
