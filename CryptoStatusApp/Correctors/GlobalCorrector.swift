//
//  GlobalCorrector.swift
//  CryptoStatusApp
//
//  Created by admin on 18.11.2022.
//

import Foundation

enum DateFormat: String {
    case dateAndTime = "dd.MM.yyyy HH:mm"

}

final class GlobalCorrector {
    static let shared = GlobalCorrector()

    private init() {

    }

    func correctTimestampToString(timestamp: String?, dateFormat: DateFormat) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]

        guard let timestamp = timestamp, let date = formatter.date(from: timestamp) else {
            return "-"
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue

        return dateFormatter.string(from: date)
    }

    func correctDetail<T>(_ detail: T?, accuracy: Int) -> String {
        guard let detail = detail else {
            return "-"
        }
        guard let double = detail as? Double else {
            return "\(detail)"
        }
        return String(format: "%.\(accuracy)f", double)
    }
}
