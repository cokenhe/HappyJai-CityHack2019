//
//  ChatViewController.swift
//  Happy Jai
//
//  Created by Ken Ho on 26/1/2019.
//  Copyright © 2019 Happy Jai. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    var messageInputTextViewRightConstraint: NSLayoutConstraint!
    var messageInputContainerViewBottomConstraint: NSLayoutConstraint!
    var messageInputTextViewHeightConstraint: NSLayoutConstraint!
    var messageInputContainerViewHeightConstraint: NSLayoutConstraint!
    
    var roomTitle = ""
    let cellId = "cellId"
    var chats = ["CITYHACK2019", "48 HRS CODING CHALLENGE"]
    let messageBank = MessageBank.instance
    
    lazy var alertController: MyAlertController = {
        let controller = MyAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        controller.view.tintColor = .secondaryColor
        let starAction = UIAlertAction(title: "Star", style: .default) { (action) in
            print("starAction")
        }
        controller.addAction(starAction)
        
        let copyAction = UIAlertAction(title: "Copy", style: .default) { (action) in
            if let text = controller.copyText {
                
                UIPasteboard.general.string = text
            }
        }
        controller.addAction(copyAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        
        return controller
    }()
    
    let messageInputContainerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .primaryColor
        view.setShadow(opacity: 0.5, offset: .zero, radius: 0.5)
        return view
    }()
    
    lazy var messageInputTextView: UITextView = {
        
        let textview = UITextView(frame: .zero)
        textview.backgroundColor = .clear
        textview.delegate = self
        textview.font = UIFont.systemFont(ofSize: 16)
        textview.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        textview.layer.masksToBounds = true
        textview.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        return textview
    }()
    
    lazy var tableView: UITableView = {
        
        let view = UITableView(frame: .zero)
        view.separatorStyle = .none
        view.register(ChatCell.self, forCellReuseIdentifier: cellId)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .whatsappGray
        return view
    }()
    
    let sendButton: UIButton = {
        
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 16
        button.backgroundColor = .secondaryColor
        let image = UIImage(named: "send")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.white
        button.setShadow(opacity: 0.1, offset: .zero, radius: 0.25)
        return button
    }()
    
    @objc func handleSend(_ sender: UIButton) {
        guard let text = messageInputTextView.text, text != "" else { return }
        chats.append(text)
        messageBank.chatMessages.append(ChatMessage(text: text, isIncoming: false, date: Date()))
        messageInputTextView.text = ""
       // messageInputTextView.endEditing(true)
        textViewDidChange(messageInputTextView)
        tableView.reloadData()
        scrollToBottom()
    }
    
    func scrollToBottom() {
        tableView.scrollToRow(at: IndexPath(row: messageBank.chatMessages.count-1, section: 0), at: .bottom, animated: true)
    }
    
    func setupRootView() {
        view.backgroundColor = .primaryColor
        navigationItem.title =  roomTitle
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.primaryColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func setupTableView() {
        
        view.addSubview(tableView)
        
        _ = tableView.fullAnchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: messageInputContainerView.topAnchor, right: view.rightAnchor)
    }
    
    func setupMessageInputContainerView() {
        
        let safeAreaFillerView = UIView()
        safeAreaFillerView.backgroundColor = messageInputContainerView.backgroundColor
        
        view.addSubview(messageInputContainerView)
        view.addSubview(safeAreaFillerView)
        
        let viewBottomAnchor: NSLayoutYAxisAnchor!
        if #available(iOS 11.0, *) {
            viewBottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            viewBottomAnchor = view.bottomAnchor
        }
        
        _ = messageInputContainerView.fullAnchor(nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        messageInputContainerViewBottomConstraint = messageInputContainerView.bottomAnchor.constraint(equalTo: viewBottomAnchor)
        messageInputContainerViewBottomConstraint.isActive = true
        
        messageInputContainerViewHeightConstraint = messageInputContainerView.heightAnchor.constraint(equalToConstant: 50)
        messageInputContainerViewHeightConstraint.isActive = true
        
        _ = safeAreaFillerView.fullAnchor(messageInputContainerView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupMessageInputTextView() {
        
        let shadowView: UIView = {
            let view = UIView()
            view.layer.masksToBounds = false
            view.backgroundColor = .white
            view.layer.cornerRadius = 15
            view.setShadow(opacity: 1, offset: .zero , radius: 0.3)
            view.isUserInteractionEnabled = false
            return view
        }()
        
        messageInputContainerView.addSubview(shadowView)
        messageInputContainerView.addSubview(messageInputTextView)
        
        _ = messageInputTextView.fullAnchor(messageInputContainerView.topAnchor, left: messageInputContainerView.leftAnchor, bottom: messageInputContainerView.bottomAnchor, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        messageInputTextViewRightConstraint = messageInputTextView.rightAnchor.constraint(equalTo: messageInputContainerView.rightAnchor, constant: -20)
        messageInputTextViewRightConstraint.isActive = true
        
        messageInputTextViewHeightConstraint = messageInputTextView.heightAnchor.constraint(lessThanOrEqualToConstant: 106)
        messageInputTextViewHeightConstraint.isActive = true
        
        _ = shadowView.fullAnchor(messageInputTextView.topAnchor, left: messageInputTextView.leftAnchor, bottom: messageInputTextView.bottomAnchor, right: messageInputTextView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupSendButton() {
        
        messageInputContainerView.addSubview(sendButton)
        
        _ = sendButton.fullAnchor(nil, left: nil, bottom: messageInputContainerView.bottomAnchor, right: messageInputContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 9, rightConstant: 12, widthConstant: 32, heightConstant: 32)
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        
        sendButton.isHidden = true
        sendButton.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRootView()
        setupMessageInputContainerView()
        setupMessageInputTextView()
        setupSendButton()
        setupTableView()
        observeKeyboardNotifications()
        textViewDidChange(messageInputTextView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeKeyboardNotifications()
    }
}

// MARK: TableView

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageBank.chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatCell
        cell.chatMessage = messageBank.chatMessages[indexPath.item]
        //        cell.textLabel?.text = chats[indexPath.row]
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleTap))
        cell.bubbleBackgroundView.addGestureRecognizer(tapGesture)
        cell.bubbleBackgroundView.isUserInteractionEnabled = true
        return cell
    }
    
    @objc func handleTap(sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizer.State.began {
            view.endEditing(true)
            resignFirstResponder()
            let location: CGPoint = sender.location(in: tableView)
            let ipath: IndexPath? = tableView.indexPathForRow(at: location)
            let cell = tableView.cellForRow(at: ipath ?? IndexPath(row: 0, section: 0)) as! ChatCell
            if let text = cell.messageLabel.text {
                print(text)
                alertController.copyText = text
            }
            present(alertController, animated: true, completion: nil)
            becomeFirstResponder()
        }
    }
}

// MARK: TextView

extension ChatViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        let size = CGSize(width: messageInputTextView.bounds.width, height: .infinity)
        let estimatedSize = messageInputTextView.sizeThatFits(size)
        print(estimatedSize)
        let height = estimatedSize.height>106 ? 106 : estimatedSize.height
        messageInputContainerViewHeightConstraint.constant = height + 20
        
        print("Content Height \(self.messageInputTextView.contentSize.height) ")
        print("Height Constraint \(self.messageInputTextViewHeightConstraint.constant) ")
        
        if(self.messageInputTextView.contentSize.height < self.messageInputTextViewHeightConstraint.constant) {
            self.messageInputTextView.isScrollEnabled = false
        } else {
            self.messageInputTextView.isScrollEnabled = true
        }
        
        if (messageInputTextView.text.isEmpty) {
            print("not typing")
            messageInputTextViewRightConstraint.constant = -15
            sendButton.isHidden = true
            sendButton.alpha = 0
            UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
            
        else {
            print("typing: " + messageInputTextView.text!)
            messageInputTextViewRightConstraint.constant = -58
            
            UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            sendButton.isHidden = false
            UIView.animate(withDuration: 0.15, delay: 0.15, options: .curveEaseOut, animations: {self.sendButton.alpha = 1})
        }
    }
}

// MARK: KeyboardNotification

extension ChatViewController {
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotifications), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotifications), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardNotifications(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            print(keyboardFrame)
            let newHeight: CGFloat
            
            if #available(iOS 11.0, *) {
                newHeight = keyboardFrame.height - view.safeAreaInsets.bottom
            } else {
                newHeight = keyboardFrame.height
            }
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            messageInputContainerViewBottomConstraint.constant = isKeyboardShowing ? -newHeight : 0
            UIView.animate(withDuration: 0, animations: {
                self.tableView.contentOffset.y += newHeight
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        view.endEditing(true)
        resignFirstResponder()
        scrollView.keyboardDismissMode = .interactive
    }
    
    func finishEditing() {
        view.endEditing(true)
    }
}

class MyAlertController: UIAlertController {
    var copyText: String?
}
