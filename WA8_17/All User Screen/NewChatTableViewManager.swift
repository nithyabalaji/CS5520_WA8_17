//
//  NewChatTableViewManager.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/7/24.
//

import Foundation
import UIKit

extension NewChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableviewUserID, for: indexPath) as! NewChatViewTableViewCell
        cell.labelName.text = userlist[indexPath.row].Name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = ChatMessageViewController()
        chatVC.title = userlist[indexPath.row].Name
        navigationController?.pushViewController(chatVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
