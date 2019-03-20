//
//  DetailVC.swift
//  DemoAutoLayoutGuide
//
//  Created by Tam Nguyen M. on 3/20/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class DetailVC: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var starLabel: UILabel!
    @IBOutlet private weak var trophyLabel: UILabel!
    @IBOutlet private weak var ultimateButton: UIButton!

    private var isUltimated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configRoundView(containerView)
        configRoundView(ultimateButton)
    }

    private func configRoundView(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
    }

    @IBAction func ultimateButtonTouchUpInside(_ sender: Any) {
        isUltimated = !isUltimated
        usernameLabel.text = isUltimated ? "nmint88888888m" : "nmint8m"
        starLabel.text = isUltimated ? "⭐️ 999,999" : "⭐️ 99"
        trophyLabel.text = isUltimated ? "🥇 999,999" : "🥇 99"
    }

    @IBAction func closeButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
