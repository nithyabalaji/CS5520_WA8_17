//
//  ChatMessageManager.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/12/24.
//

import Foundation
import UIKit
extension ChatMessageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let message = messages[indexPath.row]
            
            if message.isCurrentUser {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UserMessageTableViewCell", for: indexPath) as! UserMessageTableViewCell
                cell.setMessage(message.text)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageTableViewCell", for: indexPath) as! ChatMessageTableViewCell
                cell.messageLabel.text = message.text
                return cell
            }
        }
        
        // MARK: - UITableView Delegate Methods

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    }
