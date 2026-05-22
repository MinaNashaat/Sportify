//
//  SportType.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//

import Foundation

enum SportType: String, CaseIterable {

    case football
    case tennis
    case basketball
    case cricket

    var title: String {

        switch self {
        case .football:
            return "Football"

        case .tennis:
            return "Tennis"

        case .basketball:
            return "Basketball"

        case .cricket:
            return "Cricket"
        }
    }

    var imageName: String {

        switch self {
        case .football:
            return "Football"

        case .tennis:
            return "Tennis"

        case .basketball:
            return "BascketBall"

        case .cricket:
            return "Cracket"
        }
    }
}
