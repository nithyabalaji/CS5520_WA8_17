//
//  NewChatView.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/7/24.
//

import UIKit

class NewChatView: UIView {

       var labelText: UILabel!
       var tableViewUsers: UITableView!
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           self.backgroundColor = .white
           
           setupLabelText()
           setupTableViewUsers()
           initConstraints()
       }
       
       // MARK: - Setting up UI elements
       
       func setupLabelText() {
           labelText = UILabel()
           labelText.font = .boldSystemFont(ofSize: 18)
           labelText.text = "Users"
           labelText.translatesAutoresizingMaskIntoConstraints = false
           self.addSubview(labelText)
       }
       
    func setupTableViewUsers() {
        tableViewUsers = UITableView()
        tableViewUsers.register(NewChatViewTableViewCell.self, forCellReuseIdentifier: Configs.tableviewUserID)
        tableViewUsers.translatesAutoresizingMaskIntoConstraints = false
        tableViewUsers.rowHeight = 80
        self.addSubview(tableViewUsers)
    }
       
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Label constraints
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            labelText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            // Table view constraints
            tableViewUsers.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 8),
            tableViewUsers.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),  // Optional padding
            tableViewUsers.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),  // Optional padding
            tableViewUsers.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }



       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

}
