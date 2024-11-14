//
//  NewChatViewController.swift
//  WA8_17
//
//  Created by Dina Barua on 11/13/24

import UIKit
import FirebaseFirestore
import FirebaseAuth

class NewChatViewController: UIViewController {
    
    // Properties
    var usersList = [AppUser]() // Array to store registered users
    let db = Firestore.firestore()
    let newChatView = NewChatView()

    override func loadView() {
        view = newChatView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Your Friends"
        navigationController?.navigationBar.prefersLargeTitles = true

        // Set up the table view
        newChatView.tableViewUsers.delegate = self
        newChatView.tableViewUsers.dataSource = self

        // Fetch all users from Firestore
        fetchAllUsers()
    }

    private func fetchAllUsers() {
        db.collection("users").getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("Error fetching users: \(error)")
                return
            }

            // Clear the existing user list
            self?.usersList.removeAll()

            // Populate usersList with fetched data
            snapshot?.documents.forEach { document in
                let data = document.data()
                let email = data["email"] as? String ?? "No Email"
                let name = data["name"] as? String ?? "Unknown"
                let user = AppUser(name: name, email: email)
                self?.usersList.append(user)
            }

            // Reload the table view with updated user data
            self?.newChatView.tableViewUsers.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension NewChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableviewUserID, for: indexPath) as! NewChatViewTableViewCell
        let user = usersList[indexPath.row]
        cell.labelName.text = user.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = usersList[indexPath.row]
        let chatVC = ChatMessageViewController()
        chatVC.friendEmail = selectedUser.email
        chatVC.title = selectedUser.name
        navigationController?.pushViewController(chatVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
