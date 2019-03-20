//
//  MenuCell.swift
//  DemoAutoLayoutGuide
//
//  Created by Tam Nguyen M. on 3/20/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class MenuCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configRoundView(containerView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }

    private func configRoundView(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
    }

    func configView(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
}
