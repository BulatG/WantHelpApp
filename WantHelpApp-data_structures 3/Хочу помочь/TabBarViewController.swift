//
//  TabBarViewController.swift
//  Хочу помочь
//
//  Created by Булат on 17.04.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
    super.viewDidLoad()
    makeUI()
    middleButton.addTarget(self, action: #selector(didPressMiddleButton), for: .touchUpInside)

    }
    @objc
    private func didPressMiddleButton() {
        selectedIndex = 2
        middleButton.backgroundColor = greenColor

    }
    private let middleButtonDiameter: CGFloat = 42

    private let redColor: UIColor = UIColor(red: 254.0 / 255.0, green: 116.0 / 255.0, blue: 96.0 / 255.0, alpha: 1.0)
    private let greenColor: UIColor = UIColor(red: 102.0 / 255.0, green: 166.0 / 255.0, blue: 54.0 / 255.0, alpha: 1.0)
    private lazy var middleButton: UIButton = {
        let middleButton = UIButton()
        middleButton.layer.cornerRadius = middleButtonDiameter / 2
        middleButton.backgroundColor = redColor
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        return middleButton
    }()
    private lazy var heartImageView: UIImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = UIImage(systemName: "heart.fill")
        heartImageView.tintColor = .white
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()
    private func makeUI() {
        // 1
        tabBar.addSubview(middleButton)
        middleButton.addSubview(heartImageView)

        // 2
        NSLayoutConstraint.activate([
            // 2.1
            middleButton.heightAnchor.constraint(equalToConstant: middleButtonDiameter),
            middleButton.widthAnchor.constraint(equalToConstant: middleButtonDiameter),
            // 2.2
            middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            middleButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10)
        ])

        // 3
        NSLayoutConstraint.activate([
            // 3.1
            heartImageView.heightAnchor.constraint(equalToConstant: 15),
            heartImageView.widthAnchor.constraint(equalToConstant: 18),
            // 3.2
            heartImageView.centerXAnchor.constraint(equalTo: middleButton.centerXAnchor),
            heartImageView.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor)
        ])
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let selectedIndex = self.tabBar.items?.firstIndex(of: item) // 1
        if selectedIndex != 2 { // 2
            middleButton.backgroundColor = redColor // 3
        } else {
            middleButton.backgroundColor = greenColor // 4
        }
    }
}
