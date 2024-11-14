//
//  ChatMessageViewController.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/12/24.
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
            "isSentByCurrentUser": true // Current user is sending this message
        ]

        // Define message data for friend
        let friendMessageData: [String: Any] = [
            "text": messageText,
            "timestamp": FieldValue.serverTimestamp(),
            "isSentByCurrentUser": false // Friend is receiving this message
        ]

        // Store the message in Firestore for the current user
        db.collection("users")
            .document(currentUserEmail)
            .collection("chats")
            .document(friendEmail)
            .collection("messages")
            .addDocument(data: currentUserMessageData) { [weak self] error in
                if let error = error {
                    print("Error sending message: \(error)")
                } else {
                    self?.chatView.messageTextField.text = "" // Clear text field
                    self?.fetchMessages() // Optionally refresh messages
                }
            }

        // Store the message in Firestore for the friend
        db.collection("users")
            .document(friendEmail)
            .collection("chats")
            .document(currentUserEmail)
            .collection("messages")
            .addDocument(data: friendMessageData)
    }

}


