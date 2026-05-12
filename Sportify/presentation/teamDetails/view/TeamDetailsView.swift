//
//  TeamDetailsView.swift
//  Sportify
//
//  Created by Ahmed Salah on 12/05/2026.
//

import Foundation

protocol TeamDetailsView: AnyObject {
    func showLoading()
    func hideLoading()
    func reloadData()
    func showError(message: String)
}
