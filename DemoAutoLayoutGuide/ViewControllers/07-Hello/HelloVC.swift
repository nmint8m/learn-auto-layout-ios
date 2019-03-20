//
//  HelloVC.swift
//  DemoAutoLayoutGuide
//
//  Created by Tam Nguyen M. on 3/20/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class HelloVC: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    private var isEnglish = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Config label
        setTextForLabel(isEnglish)

        // Config buttons
        signInButton.clipsToBounds = true
        signInButton.layer.cornerRadius = 25
        setTextForButtons(isEnglish)
    }

    private func setTextForLabel(_ isEnglish: Bool) {
        helloLabel.text = isEnglish ? Strings.hello.english : Strings.hello.vietnamese
    }

    private func setTextForButtons(_ isEnglish: Bool) {
        signInButton.setTitle(isEnglish ? Strings.signIn.english : Strings.signIn.vietnamese,
                              for: .normal)
        signUpButton.setTitle(isEnglish ? Strings.signUp.english : Strings.signUp.vietnamese,
                              for: .normal)
    }

    @IBAction func buttonTouchUpInside(_ sender: Any) {
        // Change language when tap on sign in or sign up button
        isEnglish = !isEnglish
        setTextForLabel(isEnglish)
        setTextForButtons(isEnglish)
    }

    @IBAction func closeButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension HelloVC {
    enum Strings {
        case hello
        case signIn
        case signUp

        var english: String {
            switch self {
            case .hello: return "H\nE\nL\nL\nO"
            case .signIn: return "Sign in"
            case .signUp: return "Sign up"
            }
        }

        var vietnamese: String {
            switch self {
            case .hello: return "X\nI\nN\nC\nH\nÀ\nO"
            case .signIn: return "Đăng nhập"
            case .signUp: return "Đăng ký"
            }
        }
    }
}
