//
//  ChatsTableViewManager.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/7/24.
//

import UIKit

class ChatsTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var chatsList: [Chat] = []
    var navigationController: UINavigationController?
    
    init(chatsList: [Chat], navigationController: UINavigationController?) {
        self.chatsList = chatsList
        self.navigationController = navigationController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatsID, for: indexPath) as! ChatTableViewCell
        let chat = chatsList[indexPath.row]
        cell.labelSenderName.text = chat.senderName  // Updated from friendName to senderName
        cell.labelMessage.text = chat.lastMessage
        cell.labelTimestamp.text = chat.timestamp
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = ChatMessageViewController()
        chatVC.title = chatsList[indexPath.row].senderName  // Updated from friendName to senderName
        navigationController?.pushViewController(chatVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func updateChatsList(_ chatsList: [Chat]) {
        self.chatsList = chatsList
    }
}
