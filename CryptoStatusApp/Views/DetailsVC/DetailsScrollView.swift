//
//  DetailsScrollView.swift
//  CryptoStatusApp
//
//  Created by admin on 17.11.2022.
//

import UIKit
import SnapKit

class DetailsScrollView: UIScrollView {
    // MARK: Properties

    private let containerView = UIView()

    private let symbolLabel: UILabel = {
        let symbolLabel = UILabel()
        symbolLabel.textAlignment = .center
        symbolLabel.adjustsFontSizeToFitWidth = true
        symbolLabel.font = UIFont.bigAppFont()
        symbolLabel.textColor = .black
        symbolLabel.backgroundColor = .green
        symbolLabel.makeBorder(borderColor: .black, borderWidth: 1, cornerRadius: 40)
        return symbolLabel
    }()

    private let symbolShadowView: UIView = {
        let symbolShadowView = UIView()
        symbolShadowView.layer.cornerRadius = 40
        symbolShadowView.makeShadow(color: .green, opacity: 1, offSet: .zero, radius: 5)
        return symbolShadowView
    }()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.bigAppFont()
        return nameLabel
    }()

    private let timestampLabel: UILabel = {
        let timestampLabel = UILabel()
        timestampLabel.textAlignment = .center
        timestampLabel.font = UIFont.mediumAppFont()
        return timestampLabel
    }()

    private let starsView: StarsView = {
        let starsView = StarsView()
        return starsView
    }()

    private let watchersView: WatchersView = {
        let watchersView = WatchersView()
        return watchersView
    }()

    private let priceUsd: UILabel = {
        let priceUsd = UILabel()
        priceUsd.font = UIFont.mediumAppFont()
        return priceUsd
    }()

    private let priceBtc: UILabel = {
        let priceBtc = UILabel()
        priceBtc.font = UIFont.mediumAppFont()
        return priceBtc
    }()

    private let percentCngUsdLast24Hour: UILabel = {
        let percentCngUsdLastHour = UILabel()
        percentCngUsdLastHour.font = UIFont.mediumAppFont()
        return percentCngUsdLastHour
    }()

    private let percentCngBtcLast24Hour: UILabel = {
        let percentCngBtcLastHour = UILabel()
        percentCngBtcLastHour.font = UIFont.mediumAppFont()
        return percentCngBtcLastHour
    }()

    private let percentChangeUsdLast1Hour: UILabel = {
        let percentChangeUsdLast1Hour = UILabel()
        percentChangeUsdLast1Hour.font = UIFont.mediumAppFont()
        return percentChangeUsdLast1Hour
    }()

    private let percentChangeBtcLast1Hour: UILabel = {
        let percentChangeBtcLast1Hour = UILabel()
        percentChangeBtcLast1Hour.font = UIFont.mediumAppFont()
        return percentChangeBtcLast1Hour
    }()

    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    // MARK: Methods

    func setupSubViews() {
        symbolShadowView.addSubview(symbolLabel)
        [priceUsd, priceBtc, percentChangeUsdLast1Hour, percentChangeBtcLast1Hour, percentCngUsdLast24Hour, percentCngBtcLast24Hour].forEach { stackView.addArrangedSubview($0)
        }
        [symbolShadowView, nameLabel, timestampLabel, starsView, watchersView, stackView].forEach { containerView.addSubview($0)
        }
        self.addSubview(containerView)
        setupConstraints()
    }

    func setupDetails(coin: DetailableCoin) {
        symbolLabel.text = coin.data?.symbol
        nameLabel.text = coin.data?.name
        timestampLabel.text =  GlobalCorrector.shared.correctTimestampToString(timestamp: coin.status?.timestamp, dateFormat: DateFormat.dateAndTime)
        starsView.starsLabel.text = GlobalCorrector.shared.correctDetail(coin.data?.developerActivity?.stars, accuracy: 6)
        watchersView.watchersLabel.text = GlobalCorrector.shared.correctDetail(coin.data?.developerActivity?.watchers, accuracy: 6)
        priceUsd.text = "price: " + GlobalCorrector.shared.correctDetail(coin.data?.marketData?.priceUsd, accuracy: 6) + " $"
        priceBtc.text = "price: " + GlobalCorrector.shared.correctDetail(coin.data?.marketData?.priceBtc, accuracy: 6) + " btc"
        percentCngUsdLast24Hour.text = "delta 24h: " + GlobalCorrector.shared.correctDetail(coin.data?.marketData?.percentChangeUsdLast24Hours, accuracy: 6) + " %"
        percentCngBtcLast24Hour.text = "delta 24h: " + GlobalCorrector.shared.correctDetail(coin.data?.marketData?.percentChangeBtcLast24Hours, accuracy: 6) + " %"
        percentChangeUsdLast1Hour.text = "delta 1h: " + GlobalCorrector.shared.correctDetail(coin.data?.marketData?.percentChangeUsdLast1Hour, accuracy: 6) + " %"
        percentChangeBtcLast1Hour.text = "delta 1h: " + GlobalCorrector.shared.correctDetail(coin.data?.marketData?.percentChangeBtcLast1Hour, accuracy: 6) + " %"
    }

    private func setupConstraints() {
        self.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.top.bottom.width.height.equalToSuperview()
        }

        symbolLabel.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }

        symbolShadowView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolShadowView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        timestampLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        starsView.snp.makeConstraints { make in
            make.top.equalTo(timestampLabel.snp.bottom).offset(15)
            make.trailing.equalTo(timestampLabel.snp.centerX).offset(-25)
            make.width.height.equalTo(60)
        }

        watchersView.snp.makeConstraints { make in
            make.top.equalTo(timestampLabel.snp.bottom).offset(15)
            make.leading.equalTo(timestampLabel.snp.centerX).offset(25)
            make.width.height.equalTo(60)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(watchersView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
