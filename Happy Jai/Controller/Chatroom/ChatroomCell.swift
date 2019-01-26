//
//  ChatroomCell.swift
//  Happy Jai
//
//  Created by Ken Ho on 26/1/2019.
//  Copyright © 2019 Happy Jai. All rights reserved.
//

import UIKit

class ChatroomCell: UITableViewCell {

    var roomTitle = "" {
        didSet { titleLabel.text = roomTitle }
    }

    var lastChat = "" {
        didSet { lastReplyLabel.text = "  \(lastChat)  "}
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let emojiLabel: UILabel = {
        let label = UILabel()
        label.text = "😅"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "How's everybody goin?"
        label.font = UIFont.systemFont(ofSize: 16)

        return label
    }()
    let lastReplyLabel: UILabel = {
        let label = UILabel()
        label.text = "  cityhack is fun!  "
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true

        return label
    }()

    func setupViews() {

        emojiLabel.text = String.randomEmoji()

        addSubview(emojiLabel)
        addSubview(titleLabel)
        addSubview(lastReplyLabel)

        addConstraintsWithFormat(format: "H:|-12-[v0(48)]", views: emojiLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0(48)]-16-|", views: emojiLabel)
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: emojiLabel, attribute: .right, multiplier: 1, constant: 12))
        addConstraintsWithFormat(format: "H:[v0]-24-|", views: titleLabel)
        addConstraint(NSLayoutConstraint(item: lastReplyLabel, attribute: .left, relatedBy: .equal, toItem: emojiLabel, attribute: .right, multiplier: 1, constant: 12))

        addConstraintsWithFormat(format: "V:|-12-[v0(24)]-12-[v1(20)]-12-|", views: titleLabel, lastReplyLabel)
    }

}
