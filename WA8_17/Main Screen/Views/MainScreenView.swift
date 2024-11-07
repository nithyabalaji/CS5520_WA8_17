//
//  MainScreenView.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/6/24.
//

import UIKit

class MainScreenView: UIView {

    var tableViewChats: UITableView!
        var labelText: UILabel!
    var floatingButtonAddChat: UIButton!
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .white
            setupLabelText()
            setupTableViewChats()
            setupFloatingButtonAddChat()
            initConstraints()
        }
        
        // MARK: - Setting up UI elements
        
        func setupLabelText() {
            labelText = UILabel()
            labelText.font = .boldSystemFont(ofSize: 18)
            labelText.text = "Chats"
            labelText.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(labelText)
        }
    func setupFloatingButtonAddChat(){
        floatingButtonAddChat = UIButton(type: .system)
        floatingButtonAddChat.setTitle("", for: .normal)
        floatingButtonAddChat.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysOriginal), for: .normal)
        floatingButtonAddChat.contentHorizontalAlignment = .fill
        floatingButtonAddChat.contentVerticalAlignment = .fill
        floatingButtonAddChat.imageView?.contentMode = .scaleAspectFit
        floatingButtonAddChat.layer.cornerRadius = 16
        floatingButtonAddChat.imageView?.layer.shadowOffset = .zero
        floatingButtonAddChat.imageView?.layer.shadowRadius = 0.8
        floatingButtonAddChat.imageView?.layer.shadowOpacity = 0.7
        floatingButtonAddChat.imageView?.clipsToBounds = true
        floatingButtonAddChat.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonAddChat)
    }
    
        func setupTableViewChats() {
            tableViewChats = UITableView()
            tableViewChats.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
            tableViewChats.translatesAutoresizingMaskIntoConstraints = false
            tableViewChats.rowHeight = 80
            self.addSubview(tableViewChats)
        }
        
        // MARK: - Setting up constraints
        
        func initConstraints() {
            NSLayoutConstraint.activate([
                labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
                labelText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                
                tableViewChats.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 8),
                tableViewChats.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                tableViewChats.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
                tableViewChats.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
                floatingButtonAddChat.widthAnchor.constraint(equalToConstant: 48),
                floatingButtonAddChat.heightAnchor.constraint(equalToConstant: 48),
                floatingButtonAddChat.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                floatingButtonAddChat.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            ])
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}

