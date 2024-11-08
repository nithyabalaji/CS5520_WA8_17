//
//  ViewController.swift
//  WA8_17
//
//  Created by Nithya Balaji on 11/5/24.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    var chatsList = [Chat]()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    //let childProgressView = ProgressSpinnerViewController()

    let mainScreen = MainScreenView()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
                self.mainScreen.labelText.text = "Please sign in to see the notes!"
                self.mainScreen.floatingButtonAddChat.isEnabled = false
                self.mainScreen.floatingButtonAddChat.isHidden = true
                
                //MARK: Reset tableView...
                //self.contactsList.removeAll()
                self.mainScreen.tableViewChats.reloadData()
                
                self.setupRightBarButton(isLoggedin: false)
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                self.mainScreen.floatingButtonAddChat.isEnabled = true
                self.mainScreen.floatingButtonAddChat.isHidden = false
                
                self.setupRightBarButton(isLoggedin: true)
                /*
                //MARK: Observe Firestore database to display the contacts list...
                self.database.collection("users")
                    .document((self.currentUser?.email)!)
                    .collection("contacts")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
                            self.contactsList.removeAll()
                            for document in documents{
                                do{
                                    let contact  = try document.data(as: Contact.self)
                                    self.contactsList.append(contact)
                                }catch{
                                    print(error)
                                }
                            }
                            self.contactsList.sort(by: {$0.name < $1.name})
                            self.mainScreen.tableViewContacts.reloadData()
                        }
                    })
                 */
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Chats"
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: Put the floating button above all the views...
        view.bringSubviewToFront(mainScreen.floatingButtonAddChat)
        
        //MARK: patching table view delegate and data source...
        mainScreen.tableViewChats.delegate = self
        mainScreen.tableViewChats.dataSource = self
        
        //MARK: removing the separator line...
        mainScreen.tableViewChats.separatorStyle = .none
        
        mainScreen.floatingButtonAddChat.addTarget(self, action: #selector(addChatButtonTapped), for: .touchUpInside)
        let chat = Chat(senderName: "xxx", lastMessage: "Hello", timestamp: "yesterday")
        chatsList.append(chat)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
   
    @objc func addChatButtonTapped(){
        let newChatVC = NewChatViewController()
                
        navigationController?.pushViewController(newChatVC, animated: true)
    }
    
}



