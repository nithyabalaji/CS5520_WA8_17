//
//  NewChatViewController.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/7/24.
//

import UIKit

class NewChatViewController: UIViewController {
let usersView = NewChatView()
    var userlist = [User]()
    
    override func loadView() {
        view = usersView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        self.title = "Your Friends"
  
        usersView.tableViewUsers.delegate = self
        usersView.tableViewUsers.dataSource = self
        
        // Do any additional setup after loading the view.
        //mock data
        let user = User(Name: "John Doe", Email: "jhona@gmail.com")
        let user2 = User(Name: "ben Doe", Email: "bena@gmail.com")
        userlist.append(user)
        userlist.append(user2)
        self.usersView.tableViewUsers.reloadData()
    }
    

   

}
