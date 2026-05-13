//
//  DateHelper.swift
//  Sportify
//
//  Created by Mina on 13/05/2026.
//

import Foundation

enum DateHelper {

    static func dateString(daysOffset: Int) -> String {
        let date = Calendar.current.date(
            byAdding: .day,
            value: daysOffset,
            to: Date()
        ) ?? Date()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
