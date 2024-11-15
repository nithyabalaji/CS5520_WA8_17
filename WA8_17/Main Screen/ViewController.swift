//
//  ViewController.swift
//  WA8_17
//
//  Created by Dina Barua on 11/13/24

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
    var userName: String = "Anonymous"

    override func loadView() {
        view = mainScreen
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if Auth.auth().currentUser == nil {
            presentLoginScreen()
        } else {
            setupAuthenticatedUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Chats"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        mainScreen.tableViewChats.delegate = self
        mainScreen.tableViewChats.dataSource = self
        mainScreen.tableViewChats.separatorStyle = .none
        
        mainScreen.floatingButtonAddChat.addTarget(self, action: #selector(addChatButtonTapped), for: .touchUpInside)
    }
    
    func fetchCurrentUserName(completion: @escaping (String) -> Void) {
        guard let email = Auth.auth().currentUser?.email else {
            completion("Anonymous")
            return
        }
        
        db.collection("users").document(email).getDocument { (document, error) in
            if let document = document, document.exists {
                let name = document.data()?["name"] as? String ?? "Anonymous"
                completion(name)
            } else {
                print("Error fetching user document: \(error?.localizedDescription ?? "No error info")")
                completion("Anonymous")
            }
        }
    }

    private func setupAuthenticatedUI() {
        handleAuth = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            if let user = user {
                self.currentUser = user
                self.fetchCurrentUserName { userName in
                    DispatchQueue.main.async {
                        self.userName = userName
                        self.mainScreen.labelText.text = "Welcome \(self.userName)!"
                    }
                }
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



    private func presentLoginScreen() {
        let loginController = UINavigationController(rootViewController: LoginScreenViewController())
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: nil)
    }



    @objc func addChatButtonTapped() {
        let newChatVC = NewChatViewController()
        navigationController?.pushViewController(newChatVC, animated: true)
    }

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

    private func observeChats() {
        guard let currentUserEmail = currentUser?.email else { return }
        

        db.collection("users").document(currentUserEmail).collection("chats").addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching chats: \(error)")
                return
            }

            // Temporary list to store chats as they are fetched
            var fetchedChatsList: [Chat] = []
            let dispatchGroup = DispatchGroup()

            // Loop through each chat document
            querySnapshot?.documents.forEach { chatDocument in
                let friendName = chatDocument.documentID // Assuming document ID is the friend's name or email
                dispatchGroup.enter()

                // Fetch the last message from the messages subcollection
                self.db.collection("users")
                    .document(currentUserEmail)
                    .collection("chats")
                    .document(friendName)
                    .collection("messages")
                    .order(by: "timestamp", descending: true)
                    .limit(to: 1)
                    .getDocuments { (messageSnapshot, messageError) in
                        defer { dispatchGroup.leave() }

                        if let messageError = messageError {
                            print("Error fetching messages for chat with \(friendName): \(messageError)")
                            return
                        }

                        if let messageDocument = messageSnapshot?.documents.first {
                            let data = messageDocument.data()
                            let lastMessage = data["text"] as? String ?? ""
                            let timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())

                            // Append the fetched chat information to the list
                            fetchedChatsList.append(Chat(senderName: friendName, lastMessage: lastMessage, timestamp: timestamp.dateValue().description))
                        } else {
                            print("No messages found for chat with \(friendName)")
                            fetchedChatsList.append(Chat(senderName: friendName, lastMessage: "", timestamp: ""))
                        }
                    }
            }

            // After all messages have been fetched, update the chats list
            dispatchGroup.notify(queue: .main) {
                self.chatsList = fetchedChatsList.sorted { $0.timestamp > $1.timestamp }
                self.mainScreen.tableViewChats.reloadData()
            }

            self.chatsList = querySnapshot?.documents.compactMap { document in
                let data = document.data()
                let senderName = data["friendName"] as? String ?? "Unknown"
                let lastMessage = data["lastMessage"] as? String ?? ""
                let timestamp = data["timestamp"] as? String ?? ""
                return Chat(senderName: senderName, lastMessage: lastMessage, timestamp: timestamp)
            } ?? []

            self.chatsList.sort { $0.timestamp > $1.timestamp }
            self.mainScreen.tableViewChats.reloadData()

        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatsID, for: indexPath) as! ChatTableViewCell
        let chat = chatsList[indexPath.row]
        cell.labelSenderName.text = chat.senderName
        cell.labelMessage.text = chat.lastMessage
        cell.setTimestamp(chat.timestamp)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = ChatMessageViewController()
        let selectedChat = chatsList[indexPath.row]
        chatVC.title = selectedChat.senderName
        chatVC.friendEmail = selectedChat.senderName
        navigationController?.pushViewController(chatVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
