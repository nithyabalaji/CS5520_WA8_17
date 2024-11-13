//
//  ViewController.swift
//  WA8_17
//
//  Created by Dina Barua on 11/13/24
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var chatsList = [Chat]()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    let mainScreen = MainScreenView()
    let db = Firestore.firestore()

    override func loadView() {
        view = mainScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check if a user is already logged in
        if Auth.auth().currentUser == nil {
            // No user is logged in, present login screen
            presentLoginScreen()
        } else {
            // User is logged in, handle logged-in state
            setupAuthenticatedUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Chats"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Set up table view
        mainScreen.tableViewChats.delegate = self
        mainScreen.tableViewChats.dataSource = self
        mainScreen.tableViewChats.separatorStyle = .none
        
        // Set up floating button
        mainScreen.floatingButtonAddChat.addTarget(self, action: #selector(addChatButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let handleAuth = handleAuth {
            Auth.auth().removeStateDidChangeListener(handleAuth)
        }
    }
    
    // MARK: - Actions
    @objc func addChatButtonTapped() {
        let newChatVC = NewChatViewController()
        navigationController?.pushViewController(newChatVC, animated: true)
    }

    // MARK: - Login and UI Setup Methods
    private func presentLoginScreen() {
        let loginController = LoginScreenViewController()
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: nil)
    }

    private func setupAuthenticatedUI() {
        // Set up UI for authenticated user
        handleAuth = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            if let user = user {
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user.displayName ?? "Anonymous")!"
                self.mainScreen.floatingButtonAddChat.isEnabled = true
                self.mainScreen.floatingButtonAddChat.isHidden = false
                self.setupRightBarButton(isLoggedin: true)
                self.observeChats()
            } else {
                self.mainScreen.labelText.text = "Please sign in to see the chats!"
                self.mainScreen.floatingButtonAddChat.isEnabled = false
                self.mainScreen.floatingButtonAddChat.isHidden = true
                self.setupRightBarButton(isLoggedin: false)
            }
        }
    }
    
    // MARK: - Right Bar Button Setup
    func setupRightBarButton(isLoggedin: Bool) {
        if isLoggedin {
            let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(onLogOutBarButtonTapped))
            navigationItem.rightBarButtonItem = logoutButton
        } else {
            let loginButton = UIBarButtonItem(title: "Sign in", style: .plain, target: self, action: #selector(onSignInBarButtonTapped))
            navigationItem.rightBarButtonItem = loginButton
        }
    }
    
    @objc func onSignInBarButtonTapped() {
        presentLoginScreen()
    }
    
    @objc func onLogOutBarButtonTapped() {
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: { _ in
            do {
                try Auth.auth().signOut()
                self.presentLoginScreen()
            } catch {
                print("Error occurred while logging out!")
            }
        }))
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(logoutAlert, animated: true)
    }
    
    // MARK: - Firestore Data Fetching
    private func observeChats() {
        guard let currentUserEmail = currentUser?.email else { return }
        db.collection("users").document(currentUserEmail).collection("chats").addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching chats: \(error)")
                return
            }
            
            self.chatsList = querySnapshot?.documents.compactMap { document in
                let data = document.data()
                let senderName = data["senderName"] as? String ?? "Unknown"
                let lastMessage = data["lastMessage"] as? String ?? ""
                let timestamp = data["timestamp"] as? String ?? ""
                return Chat(senderName: senderName, lastMessage: lastMessage, timestamp: timestamp)
            } ?? []
            
            self.chatsList.sort { $0.timestamp > $1.timestamp }
            self.mainScreen.tableViewChats.reloadData()
        }
    }

    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatsID, for: indexPath) as! ChatTableViewCell
        let chat = chatsList[indexPath.row]
        cell.labelSenderName.text = chat.senderName
        cell.labelMessage.text = chat.lastMessage
        cell.labelTimestamp.text = chat.timestamp
        return cell
    }
    
    // MARK: - UITableViewDelegate Method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = ChatMessageViewController()
        chatVC.title = chatsList[indexPath.row].senderName
        navigationController?.pushViewController(chatVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
