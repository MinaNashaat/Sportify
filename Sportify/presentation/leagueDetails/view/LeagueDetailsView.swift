//
//  LeagueDetailsView.swift
//  Sportify
//
//  Created by Mina on 13/05/2026.
//

import Foundation
import UIKit
protocol LeagueDetailsView: AnyObject {

    func showLoading()
    func hideLoading()
    func reloadData()
    func showError(message: String)

}
