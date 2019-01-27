//
//  ChatViewController.swift
//  Happy Jai
//
//  Created by Ken Ho on 26/1/2019.
//  Copyright © 2019 Happy Jai. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    var roomTitle = ""
    
    let cellId = "cellId"
    var chats = [
        "CITYHACK2019", "48 HRS CODING CHALLENGE"
    ]

    var chatMessages = MessageBank().chatMessages

    var bottomAnchor: NSLayoutConstraint?
    var keyboardHeight: CGFloat!
    var lastOffset: CGPoint!

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.separatorStyle = .none
        view.allowsSelection = false
        view.register(ChatCell.self, forCellReuseIdentifier: cellId)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryColor
        return view
    }()

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryColor
        return view
    }()

    lazy var textField: UITextField = {
        let field = UITextField(frame: .zero)
        field.borderStyle = .roundedRect
//        field.delegate = self
        return field
    }()

    let sendbutton: UIButton = {
        let btn = UIButton()
        btn.setTitle("SEND", for: .normal)
        btn.setTitleColor(.secondaryColor, for: .normal)
        btn.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return btn
    }()

    @objc func handleSend(_ sender: UIButton) {
        guard let text = textField.text, text != "" else { return }
        chats.append(text)
        chatMessages.append(ChatMessage(text: text, isIncoming: false, date: Date()))
        textField.text = ""
        tableView.reloadData()
        scrollToBottom()
    }

    func scrollToBottom() {
        tableView.scrollToRow(at: IndexPath(row: chatMessages.count-1, section: 0), at: .bottom, animated: true)
        
    }

    func setupViews() {
        view.backgroundColor = .primaryColor
        navigationItem.title =  roomTitle
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.primaryColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes


        view.addSubview(tableView)
        view.addSubview(containerView)
        self.bottomAnchor = containerView.anchorWithSize(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, heightConstant: 50)[1]

        _ = tableView.fullAnchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: containerView.topAnchor, right: view.rightAnchor)

        let width = UIScreen.main.bounds.width

        containerView.addSubview(separatorView)
        containerView.addSubview(textField)
        containerView.addSubview(sendbutton)

        _ = separatorView.anchorWithSize(containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor,  widthConstant: 0, heightConstant: 1)

        _ = textField.fullAnchor(separatorView.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0.75 * width, heightConstant: 0)

        _ = sendbutton.anchorWithConstant(separatorView.bottomAnchor, left: textField.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, topConstant: 8)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        observeKeyboardNotifications()
    }

    override func viewDidDisappear(_ animated: Bool) {
        removeKeyboardNotifications()
    }
}

// MARK: TableView

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatCell
        cell.chatMessage = chatMessages[indexPath.item]
//        cell.textLabel?.text = chats[indexPath.row]
        return cell
    }
}


// MARK: handle textfield and keyboard

extension ChatViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        finishEditing()
    }
}


extension ChatViewController {

    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
        scrollToBottom()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -315
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        view.endEditing(true)
        resignFirstResponder()
        scrollView.keyboardDismissMode = .interactive
    }

    func finishEditing() {
        view.endEditing(true)
    }

    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            print(endFrameY)
//            if endFrameY >= UIScreen.main.bounds.size.height {
//                self.bottomAnchor?.constant = 0.0
//            } else {
//                self.bottomAnchor?.constant = 0 - (endFrame?.size.height ?? 0.0) + 25
//            }
//            UIView.animate(withDuration: 0.3) {
//                self.view.layoutIfNeeded()
//            }
        }
    }
}

