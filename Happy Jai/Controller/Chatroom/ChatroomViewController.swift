//
//  ChatroomView.swift
//  Happy Jai
//
//  Created by Ken Ho on 26/1/2019.
//  Copyright © 2019 Happy Jai. All rights reserved.
//

import UIKit

class ChatroomViewController: UIViewController {

    let cellId = "cellId"
    let rooms = ["9UP GROUP", "ON9 CHAT"]
    let chats = ["FUCK", "YOU"]

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.delegate = self
        view.dataSource = self
        view.register(ChatroomCell.self, forCellReuseIdentifier: cellId)
        return view
    }()

    func setupViews() {
        view.addSubview(tableView)
        navigationItem.title = "Chat"
        navigationController?.navigationBar.backgroundColor = .secondaryColor
        navigationController?.navigationBar.barTintColor = .secondaryColor

        _ = tableView.fullAnchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}


extension ChatroomViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatroomCell
        cell.selectionStyle = .none
        cell.roomTitle = rooms[indexPath.row]
        cell.lastChat = chats[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = ChatViewController()
        view.roomTitle = rooms[indexPath.row]
        navigationController?.pushViewController(view, animated: true)
    }
    
}
