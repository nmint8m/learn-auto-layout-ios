//
//  MenuVC.swift
//  Artichoke
//
//  Created by Tam Nguyen M. on 8/23/18.
//  Copyright © 2018 Tam Nguyen M. All rights reserved.
//

import UIKit

final class MenuVC: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configRoundView(titleLabel)
        configTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    private func configTable() {
        let nib = UINib(nibName: "MenuCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "MenuCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func configRoundView(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
    }
}

extension MenuVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.row),
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell" , for: indexPath) as? MenuCell else { return UITableViewCell() }
        cell.configView(title: section.title, content: section.content)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.row) else { return }
        switch section {
        case .signIn:
            let vc = SignInVC()
            present(vc, animated: true, completion: nil)
        case .detail:
            let vc = DetailVC()
            present(vc, animated: true, completion: nil)
        case .ultimateDetail:
            let vc = UltimateDetailVC()
            present(vc, animated: true, completion: nil)
        case .ultimateX2Detail:
            let vc = UltimateX2DetailVC()
            present(vc, animated: true, completion: nil)
        case .hello:
            let vc = HelloVC()
            present(vc, animated: true, completion: nil)
        }
    }
}

extension MenuVC {
    enum Section: Int, CaseIterable {
        case signIn
        case detail
        case ultimateDetail
        case ultimateX2Detail
        case hello

        var title: String {
            switch self {
            case .signIn: return "Sign In"
            case .detail: return "Detail"
            case .ultimateDetail: return "Ultimate Detail"
            case .ultimateX2Detail: return "Ultimate x2 Detail"
            case .hello: return "Hello"
            }
        }

        var content: String {
            switch self {
            case .signIn: return "Required constraint Optional constraint  and . "
            case .detail: return "This example describe the requirements that we need to do."
            case .ultimateDetail: return "Auto layout with compression resistance priority."
            case .ultimateX2Detail: return "Auto layout with UIStackView and content hugging priority."
            case .hello: return "Auto layout with UIStackView greatly simplifies the constraint logic needed for the rest of the layout."
            }
        }

        static var count: Int {
            return Section.allCases.count
        }
    }
}

