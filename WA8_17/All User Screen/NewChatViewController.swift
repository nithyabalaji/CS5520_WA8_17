//
//  NewChatViewController.swift
//  WA8_17
//
//  Created by Dina Barua on 11/13/24

import UIKit
import FirebaseFirestore

class NewChatViewController: UIViewController {
    let usersView = NewChatView()
    var userlist = [User]()
    let db = Firestore.firestore()

    override func loadView() {
        view = usersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Friends"
        
        // Assign delegate and data source
        usersView.tableViewUsers.delegate = self
        usersView.tableViewUsers.dataSource = self
        usersView.tableViewUsers.register(NewChatViewTableViewCell.self, forCellReuseIdentifier: Configs.tableviewUserID)
        
        fetchUsers()
    }

    // MARK: - Fetch Users from Firestore
    private func fetchUsers() {
        db.collection("users").getDocuments { [weak self] (snapshot, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching users: \(error)")
                return
            }
            
            self.userlist = snapshot?.documents.compactMap { document in
                let data = document.data()
                let name = data["Name"] as? String ?? "Unknown"
                let email = data["Email"] as? String ?? ""
                return User(Name: name, Email: email)
            } ?? []
            
            DispatchQueue.main.async {
                self.usersView.tableViewUsers.reloadData()
            }
        }
    }
}
