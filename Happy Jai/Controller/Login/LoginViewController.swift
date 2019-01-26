//
//  ViewController.swift
//  HappyJai
//
//  Created by Tony Cheng on 26/1/2019.
//  Copyright © 2019 tychengaf. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        observeKeyboardNotifications()
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        setupViews()
    }

    override func viewDidDisappear(_ animated: Bool) {
        removeKeyboardNotifications()
    }

    lazy var username: LoginInputView = {
        let view = LoginInputView()
        view.textField.placeholder = "Enter your username"
        view.textField.delegate = self
        return view
    }()

    lazy var password: LoginInputView = {
        let view = LoginInputView()
        view.textField.placeholder = "Enter your password"
        view.textField.delegate = self
        view.textField.isSecureTextEntry = true
        return view
    }()

    let forgotLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot your password?"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    let logoImageView : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "HappyJai2.0"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 0.7019607843, blue: 0, alpha: 1)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("SIGN IN", for: .normal)
        button.layer.cornerRadius = 24
        //        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.addTarget(self, action: #selector(pressedSignIn(_:)), for: .touchUpInside)
        return button
    }()

    @objc func pressedSignIn(_ sender: UIButton) {
        print("you clicked on button")
        let navigationController = UINavigationController(rootViewController: MainController())
        navigationController.navigationBar.tintColor = .primaryColor
        navigationController.navigationBar.barTintColor = .secondaryColor
        navigationController.navigationBar.backgroundColor = .secondaryColor
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = navigationController
    }

    func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(signInButton)
        view.addSubview(forgotLabel)

        view.addConstraintsWithFormat(format: "H:|[v0]|", views: logoImageView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: username)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: password)
        view.addConstraintsWithFormat(format: "H:|-36-[v0]-36-|", views: signInButton)
        view.addConstraintsWithFormat(format: "H:|-36-[v0]-36-|", views: forgotLabel)


        view.addConstraintsWithFormat(format: "V:|-150-[v0(200)]-24-[v1]-[v2]-12-[v3(48)]-[v4]", views: logoImageView, username, password, signInButton, forgotLabel)
    }
}


// MARK: handle textfield and keyboard

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        finishEditing()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        finishEditing()
        return true
    }
}


extension LoginViewController {

    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    fileprivate func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }

    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -290
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }

    func finishEditing() {
        view.endEditing(true)
    }

}

