//
//  ChatsTableViewManager.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/7/24.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatsID, for: indexPath) as! ChatTableViewCell
        cell.labelSenderName.text = chatsList[indexPath.row].senderName
        cell.labelMessage.text = chatsList[indexPath.row].lastMessage
        cell.labelTimestamp.text = chatsList[indexPath.row].timestamp
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
            let chatVC = ChatMessageViewController()
            
        chatVC.title = chatsList[indexPath.row].senderName
            
            navigationController?.pushViewController(chatVC, animated: true)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
}
