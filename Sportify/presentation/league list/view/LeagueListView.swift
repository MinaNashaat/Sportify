//
//  LeagueListView.swift
//  Sportify
//
//  Created by Mina on 12/05/2026.
//

import Foundation
import UIKit

protocol LeagueListView: AnyObject {

    func showLoading()

    func hideLoading()

    func reloadData()

    func showError(message: String)
    
    var viewController: UIViewController { get }
}
