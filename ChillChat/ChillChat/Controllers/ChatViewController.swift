//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        }
    }
    @IBOutlet weak var messageTextfield: UITextField!
    
    var message: [Message] = [
        Message(sender: "1@2.com", body: "Hi"),
        Message(sender: "melek@1.com", body: "Hi!"),
        Message(sender: "1@2.com", body: "What's up?What's up?What's up?What's up?What's up?What's up?What's up?What's up?What's up?What's up?")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        self.title = K.appName
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    @IBAction func logOutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as? MessageCell {
            cell.label?.text = message[indexPath.row].body

            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ChatViewController: UITableViewDelegate {
    
}
