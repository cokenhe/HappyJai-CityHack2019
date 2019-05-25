//
//  ChatViewCell.swift
//  HappyJai
//
//  Created by Tony Cheng on 26/1/2019.
//  Copyright © 2019 tychengaf. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    var trailingConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    
    var chatMessage: ChatMessage! {
        didSet{
            bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .primaryColor : .secondaryColor
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white

            messageLabel.text = chatMessage.text

            if (chatMessage.isIncoming) {
                leadingConstraint?.isActive = true
                trailingConstraint?.isActive = false
            } else {
                leadingConstraint?.isActive = false
                trailingConstraint?.isActive = true
            }
        }
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        selectionStyle = .none
        
        bubbleBackgroundView.backgroundColor = .yellow
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        bubbleBackgroundView.layer.cornerRadius = 12
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)

        messageLabel.text = "Default Message"

        messageLabel.numberOfLines = 0

        addConstraintsWithFormat(format: "V:|-32-[v0]-32-|", views: messageLabel)
        addConstraintsWithFormat(format: "H:[v0(<=250)]", views: messageLabel)
        //        messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        //        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        //        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        //        messageLabel.widthAnchor.constraint(equalToConstant: 250),
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)


        bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16).isActive = true
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16).isActive = true
        bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16).isActive = true
        bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16).isActive = true

        //messageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
