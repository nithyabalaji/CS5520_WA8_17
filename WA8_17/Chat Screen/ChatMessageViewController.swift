//
//  ChatMessageViewController.swift
//  WA8_17
//
//  Created by Nishy Ann Tomy on 11/12/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ChatMessageViewController: UIViewController {
    
    // Properties
    var messages: [ChatMessage] = []  // Store messages
    var friendEmail: String?
    let db = Firestore.firestore()
    let chatView = ChatScreenView()

    override func loadView() {
        view = chatView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        chatView.tableView.delegate = self
        chatView.tableView.dataSource = self
        
        // Hide keyboard when tapping outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // Fetch messages when the view loads
        fetchMessages()
        chatView.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)

    }
    
    @objc private func sendButtonTapped() {
        sendMessage()
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Helper function to scroll to the bottom of the table view
    private func scrollToBottom() {
        guard !messages.isEmpty else { return }
        let lastIndex = IndexPath(row: messages.count - 1, section: 0)
        chatView.tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
    }
    
    private func fetchMessages() {
        // Ensure we have the friendEmail and current user's email
        guard let currentUserEmail = Auth.auth().currentUser?.email, let friendEmail = friendEmail else {
            print("Error: Unable to retrieve emails")
            return
        }

        // Access the messages collection for the specific chat
        db.collection("users")
            .document(currentUserEmail)
            .collection("chats")
            .document(friendEmail)
            .collection("messages")
            .order(by: "timestamp", descending: true) // Fetch latest messages first, reverse to display oldest at top
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error fetching messages: \(error)")
                    return
                }

                // Clear the existing messages
                self?.messages.removeAll()
                
                // Loop through each document in the snapshot and add the message
                querySnapshot?.documents.forEach { document in
                    let data = document.data()
                    let text = data["text"] as? String ?? ""
                    let timestamp = data["timestamp"] as? Timestamp
                    let isSentByCurrentUser = data["isSentByCurrentUser"] as? Bool ?? false
                    
                    // Convert timestamp to a readable string, if available
                    let timeString = timestamp?.dateValue().description ?? ""
                    
                    // Create a ChatMessage object and append it to the messages array
                    let chatMessage = ChatMessage(text: text, timeStamp: timeString, isSentByCurrentUser: isSentByCurrentUser)
                    self?.messages.append(chatMessage)
                }

                // Reverse the messages to display oldest at the top
                self?.messages.reverse()
                
                // Reload the table view with the fetched messages
                self?.chatView.tableView.reloadData()
                
                // Automatically scroll to the bottom
                self?.scrollToBottom()
            }
    }

    
    private func sendMessage() {
        guard let currentUserEmail = Auth.auth().currentUser?.email,
              let friendEmail = friendEmail,
              let messageText = chatView.messageTextField.text,
              !messageText.isEmpty else {
            print("Message is empty or unable to retrieve emails")
            return
        }

        // Define message data for current user
        let currentUserMessageData: [String: Any] = [
            "text": messageText,
            "timestamp": FieldValue.serverTimestamp(),
            "isSentByCurrentUser": true
        ]

        // Define message data for friend
        let friendMessageData: [String: Any] = [
            "text": messageText,
            "timestamp": FieldValue.serverTimestamp(),
            "isSentByCurrentUser": false
        ]

        // Define initial chat data
        let initialChatData: [String: Any] = [
            "friendEmail": friendEmail,
            "createdAt": FieldValue.serverTimestamp()
        ]

        let currentUserChatRef = db.collection("users")
                                    .document(currentUserEmail)
                                    .collection("chats")
                                    .document(friendEmail)

        // Check if the chat document exists for the current user
        currentUserChatRef.getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error checking chat document: \(error)")
                return
            }

            // If the chat document does not exist, create it
            if document?.exists == false {
                currentUserChatRef.setData(initialChatData, merge: true) { error in
                    if let error = error {
                        print("Error creating chat document: \(error)")
                        return
                    }
                    // After creating the chat, add the message to the current user's messages
                    self?.addMessageToCurrentUserChat(currentUserChatRef, messageData: currentUserMessageData)
                }
            } else {
                // If the chat document exists, add the message as usual
                self?.addMessageToCurrentUserChat(currentUserChatRef, messageData: currentUserMessageData)
            }
        }

        // Create or update the chat document for the friend and add the message
        let friendChatRef = db.collection("users")
                              .document(friendEmail)
                              .collection("chats")
                              .document(currentUserEmail)
        friendChatRef.setData(["friendEmail": currentUserEmail, "createdAt": FieldValue.serverTimestamp()], merge: true) { error in
            if let error = error {
                print("Error creating chat document for friend: \(error)")
                return
            }
            // Add the message to the friend's messages subcollection
            friendChatRef.collection("messages")
                .addDocument(data: friendMessageData)
        }
    }

    // Helper function to add message to current user's messages subcollection
    private func addMessageToCurrentUserChat(_ chatRef: DocumentReference, messageData: [String: Any]) {
        chatRef.collection("messages")
            .addDocument(data: messageData) { [weak self] error in
                if let error = error {
                    print("Error sending message: \(error)")
                } else {
                    self?.chatView.messageTextField.text = "" // Clear text field
                    self?.fetchMessages() // Optionally refresh messages
                }
            }
    }


}


