//
//  ChatMessageManager.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/12/24.
//

import Foundation
import UIKit

extension ChatMessageViewController: UITableViewDelegate, UITableViewDataSource {

    // Re-add this method to conform to UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cellIdentifier = message.isSentByCurrentUser ? "UserMessageTableViewCell" : "ChatMessageTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if let userCell = cell as? UserMessageTableViewCell {
            userCell.setMessage(message.text)
            userCell.setTimestamp(message.timeStamp)
        } else if let friendCell = cell as? ChatMessageTableViewCell {
            friendCell.setMessage(message.text)
            friendCell.setTimestamp(message.timeStamp)
        }
        
        return cell
    }
    
    // MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
