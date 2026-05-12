//
//  LoadingView.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//
import UIKit
import Lottie

class LoadingView: UIView {

    private let animationView =
    LottieAnimationView(name: "loading")

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    private func setup() {

        backgroundColor =
        UIColor.black.withAlphaComponent(0.4)

        animationView.loopMode = .loop
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(animationView)

        NSLayoutConstraint.activate([

            animationView.centerXAnchor.constraint(
                equalTo: centerXAnchor
            ),

            animationView.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),

            animationView.widthAnchor.constraint(
                equalToConstant: 160
            ),

            animationView.heightAnchor.constraint(
                equalToConstant: 160
            )
        ])
    }
}
