//
//  SignInVC.swift
//  DemoAutoLayoutGuide
//
//  Created by Tam Nguyen M. on 3/20/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class SignInVC: UIViewController {

    @IBOutlet private weak var titleContainerView: UIView!
    @IBOutlet private weak var contentContainerView: UIView!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var titleContainerViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var bigTitleContainterViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var smallTitleContainerViewTopConstraint: NSLayoutConstraint!

    private var isCollapsed = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configTitleContainerView()
        configContentContainerView()
    }

    private func configTitleContainerView() {
        configRoundView(titleContainerView)

        bigTitleContainterViewTopConstraint.constant = (Config.screenSize.height - Config.bigContainerViewHeight) / 2
        bigTitleContainterViewTopConstraint.priority = Config.highPriority

        smallTitleContainerViewTopConstraint.constant = (Config.screenSize.height - contentContainerView.frame.height) / 2 - Config.smallContainerViewHeight + 10
        smallTitleContainerViewTopConstraint.priority = Config.lowPriority
    }

    private func configContentContainerView() {
        contentContainerView.alpha = 0
        configRoundView(contentContainerView)
        configRoundView(signInButton)
    }

    private func configRoundView(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
    }

    private func updateTilteContainerView(_ isCollapsed: Bool, animated: Bool, completion: (() -> Void)? = nil) {
        titleContainerViewHeight.constant = isCollapsed ? Config.smallContainerViewHeight : Config.bigContainerViewHeight

        bigTitleContainterViewTopConstraint.priority = isCollapsed ? Config.lowPriority : Config.highPriority

        smallTitleContainerViewTopConstraint.priority = isCollapsed ? Config.highPriority : Config.lowPriority

        UIView.animate(withDuration: animated ? 0.2 : 0, animations: { [weak self] in
            guard let this = self else { return }
            this.view.layoutIfNeeded()
        }, completion: { _ in
            completion?()
        })
    }

    private func updateContentContainerView(_ isCollapsed: Bool, animated: Bool, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: animated ? 0.2 : 0, animations: { [weak self] in
            guard let this = self else { return }
            this.contentContainerView.alpha = isCollapsed ? 1 : 0
        }, completion: { _ in
            completion?()
        })
    }


    @IBAction func titleButtonTouchUpInside(_ sender: Any) {
        isCollapsed = !isCollapsed
        signInButton.isUserInteractionEnabled = false
        updateTilteContainerView(isCollapsed, animated: true) { [weak self] in
            guard let this = self else { return }
            this.signInButton.isUserInteractionEnabled = true
        }
        updateContentContainerView(isCollapsed, animated: true)
    }

    @IBAction func closeButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension SignInVC {
    struct Config {
        static let smallContainerViewHeight: CGFloat = 50
        static let bigContainerViewHeight: CGFloat = 100
        static let highPriority = UILayoutPriority(rawValue: 900)
        static let lowPriority = UILayoutPriority(rawValue: 800)
        static let screenSize = UIScreen.main.bounds.size
    }
}
