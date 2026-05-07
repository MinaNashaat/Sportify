//
//  myPageViewController.swift
//  Sportify
//
//  Created by Mina on 07/05/2026.
//

import UIKit

class myPageViewController: UIPageViewController,
                            UIPageViewControllerDelegate,
                            UIPageViewControllerDataSource {

    var pages = [UIViewController]()
    var currentIndex = 0

    let stackView = UIStackView()
    var indicators: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self

        let v1 = self.storyboard?.instantiateViewController(withIdentifier: "v1")
        let v2 = self.storyboard?.instantiateViewController(withIdentifier: "v2")
        let v3 = self.storyboard?.instantiateViewController(withIdentifier: "v3")

        pages.append(v1!)
        pages.append(v2!)
        pages.append(v3!)

        setViewControllers([v1!],
                           direction: .forward,
                           animated: true,
                           completion: nil)

        setupIndicators()
    }

    func setupIndicators() {

        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        for i in 0..<pages.count {

            let dot = UIView()

            dot.layer.cornerRadius = 4
            dot.translatesAutoresizingMaskIntoConstraints = false

            dot.backgroundColor = (i == 0)
            ? UIColor(named: "PrimaryColor") : .lightGray

            NSLayoutConstraint.activate([
                dot.heightAnchor.constraint(equalToConstant: 8),
                dot.widthAnchor.constraint(equalToConstant: i == 0 ? 24 : 8)
            ])

            indicators.append(dot)
            stackView.addArrangedSubview(dot)
        }
    }

    func updateDots() {

        for (index, dot) in indicators.enumerated() {

            for constraint in dot.constraints {

                if constraint.firstAttribute == .width {

                    constraint.constant = (index == currentIndex) ? 24 : 8
                }
            }

            dot.backgroundColor = (index == currentIndex)
            ? UIColor(named: "PrimaryColor") : .lightGray
        }

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let index = pages.firstIndex(of: viewController),
              index > 0 else {
            return nil
        }

        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let index = pages.firstIndex(of: viewController),
              index < pages.count - 1 else {
            return nil
        }

        return pages[index + 1]
    }

    func goToNextPage() {

        let nextIndex = currentIndex + 1

        if nextIndex < pages.count {

            currentIndex = nextIndex

            setViewControllers([pages[currentIndex]],
                               direction: .forward,
                               animated: true)

            updateDots()
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {

        if completed,
           let visibleVC = viewControllers?.first,
           let index = pages.firstIndex(of: visibleVC) {

            currentIndex = index
            updateDots()
        }
    }
}
