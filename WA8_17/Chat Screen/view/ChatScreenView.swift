//
//  ChatScreenView.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/11/24.
//

import UIKit

class ChatScreenView: UIView {
    var tableView: UITableView!

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .white
            setupTableView()
            initConstraints()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
         func setupTableView() {
             tableView = UITableView()
                     
                     // Registering UserMessageTableViewCell and FriendMessageTableViewCell
                     tableView.register(UserMessageTableViewCell.self, forCellReuseIdentifier: "UserMessageTableViewCell")
                     tableView.register(ChatMessageTableViewCell.self, forCellReuseIdentifier: "ChatMessageTableViewCell")
                     
                     tableView.separatorStyle = .none
                     tableView.translatesAutoresizingMaskIntoConstraints = false
                     tableView.rowHeight = UITableView.automaticDimension
                     tableView.estimatedRowHeight = 80
                     self.addSubview(tableView)
        }
    func initConstraints(){
        NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                    tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
                    tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
                ])
    }

}
