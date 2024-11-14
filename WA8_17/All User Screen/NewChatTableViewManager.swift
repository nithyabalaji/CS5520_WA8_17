//
//  NewChatTableViewManager.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/7/24.
//

import UIKit

// Delegate protocol to handle user selection
protocol NewChatTableViewManagerDelegate: AnyObject {
    func didSelectUser(_ user: AppUser)
}

class NewChatTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    // Properties
    var usersList: [AppUser] = []  // Array of users to display
    weak var delegate: NewChatTableViewManagerDelegate?

    // MARK: - TableView Data Source Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableviewUserID, for: indexPath) as! NewChatViewTableViewCell
        let user = usersList[indexPath.row]
        cell.labelName.text = user.name  // Display the user's name
        return cell
    }

    // MARK: - TableView Delegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = usersList[indexPath.row]
        delegate?.didSelectUser(selectedUser)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
