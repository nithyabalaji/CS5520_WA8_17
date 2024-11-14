//
//  ChatScreenView.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/11/24.
//

import UIKit

class ChatScreenView: UIView {
    var tableView: UITableView!
    var messageInputContainerView: UIView!
        var messageTextField: UITextField!
        var sendButton: UIButton!
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .white
            setupTableView()
            setupMessageInputComponents()
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
    func setupMessageInputComponents() {
            // Container View for text field and send button
            messageInputContainerView = UIView()
            messageInputContainerView.backgroundColor = .white
            messageInputContainerView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(messageInputContainerView)
            
            // Message Text Field
            messageTextField = UITextField()
            messageTextField.placeholder = "Type a message"
            messageTextField.borderStyle = .roundedRect
            messageTextField.translatesAutoresizingMaskIntoConstraints = false
            messageInputContainerView.addSubview(messageTextField)
            
            // Send Button
            sendButton = UIButton(type: .system)
            sendButton.setTitle("Send", for: .normal)
            sendButton.translatesAutoresizingMaskIntoConstraints = false
            messageInputContainerView.addSubview(sendButton)
        }

        func initConstraints() {
            NSLayoutConstraint.activate([
                // Table view constraints
                tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: messageInputContainerView.topAnchor),
                
                // Message input container constraints
                messageInputContainerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                messageInputContainerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
                messageInputContainerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
                messageInputContainerView.heightAnchor.constraint(equalToConstant: 50),

                // Message text field constraints
                messageTextField.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor, constant: 8),
                messageTextField.centerYAnchor.constraint(equalTo: messageInputContainerView.centerYAnchor),
                
                // Send button constraints
                sendButton.leadingAnchor.constraint(equalTo: messageTextField.trailingAnchor, constant: 8),
                sendButton.trailingAnchor.constraint(equalTo: messageInputContainerView.trailingAnchor, constant: -8),
                sendButton.centerYAnchor.constraint(equalTo: messageInputContainerView.centerYAnchor),

                messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8)
            ])
        }

}
