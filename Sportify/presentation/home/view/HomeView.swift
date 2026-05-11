//
//  HomeView.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//

import Foundation

protocol HomeView: AnyObject {

    func showLoading()

    func hideLoading()

    func reloadData()

    func showError(
        message: String
    )
}
