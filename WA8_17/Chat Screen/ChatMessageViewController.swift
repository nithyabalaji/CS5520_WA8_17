//
//  ChatMessageViewController.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/12/24.
//

import UIKit

class ChatMessageViewController: UIViewController {
    // mock data
    var messages: [ChatMessage] = [
            ChatMessage(text: "Hello!", isCurrentUser: false),
            ChatMessage(text: "Hi there! How are you?", isCurrentUser: true),
            ChatMessage(text: "I'm good, thanks for asking!", isCurrentUser: false),
            ChatMessage(text: "Glad to hear that.", isCurrentUser: true)
        ]
    let chatView = ChatScreenView()
        
        override func loadView() {
            view = chatView
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        chatView.tableView.delegate = self
        chatView.tableView.dataSource = self
               
               // Hide keyboard when tapping outside
               let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
               view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    @objc private func dismissKeyboard() {
            view.endEditing(true)
        }

}
