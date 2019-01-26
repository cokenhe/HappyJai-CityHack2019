//
//  LoginInputColumn.swift
//  HappyJai
//
//  Created by Tony Cheng on 26/1/2019.
//  Copyright © 2019 tychengaf. All rights reserved.
//

import UIKit

class LoginInputView: UIView {

    let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "I am a placeholder"
        field.font = UIFont.systemFont(ofSize: 16)
        field.autocorrectionType = .no
        return field
    }()

    let inputUnderline: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    func setupViews() {
        addSubview(textField)
        addSubview(inputUnderline)
        addConstraintsWithFormat(format: "H:|-36-[v0]-36-|", views: inputUnderline)
        addConstraintsWithFormat(format: "H:|-36-[v0]-36-|", views: textField)
        addConstraintsWithFormat(format: "V:|-18-[v0]-18-[v1]-18-|", views: textField, inputUnderline)
        addConstraintsWithFormat(format: "V:[v0(1)]", views: inputUnderline)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
