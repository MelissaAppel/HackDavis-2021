//
//  ChatViewController.swift
//  HackDavis
//
//  Created by Haruna Yamakawa on 1/17/21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    let db = Firestore.firestore()
        
        var messages : [Message] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            chatTableView.delegate = self
            chatTableView.dataSource = self
            chatTableView.register(UINib(nibName: StaticsAndConstants.cellNibName, bundle: nil), forCellReuseIdentifier: StaticsAndConstants.cellIdentifier) //Links to MessageCell.xib style
            loadMessages()
        }
        
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out", signOutError)
        }
    }
    
    //Retreives messages from firebase, currently receives all messages from every user, need to filter only selected user and implement chat message selector/picker
        func loadMessages(){
            db.collection(StaticsAndConstants.fStore.collectionName)
                .order(by: StaticsAndConstants.fStore.dateField)
                .addSnapshotListener { (querySnapshot, error) in
                self.messages = []
                if let e = error {
                    print("issue retreiving data \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments{
                            let data = doc.data()
                            if let messageSender = data[StaticsAndConstants.fStore.senderField] as? String, let messageBody = data[StaticsAndConstants.fStore.bodyField] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async{
                                    self.chatTableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                }
                                
                            }
                        }
                    }
                }
            }
            
        }
        
        //when send it pressed, uploads message data to firebase
        @IBAction func sendPressed(_ sender: UIButton) {
            if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
                db.collection(StaticsAndConstants.fStore.collectionName).addDocument(data: [StaticsAndConstants.fStore.senderField : messageSender, StaticsAndConstants.fStore.bodyField: messageBody,
                    StaticsAndConstants.fStore.dateField: Date().timeIntervalSince1970
                    ]) { (error) in
                    if let e = error {
                        print("Error saving data to firestore")
                    } else {
                        DispatchQueue.main.async {
                            self.messageTextField.text = ""
                        }
                    }
                }
            }
        }
        

    }

    extension ChatViewController : UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count
        }
        
        //populates each row of table with messages.body
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let message = messages[indexPath.row]
            
            let cell = chatTableView.dequeueReusableCell(withIdentifier: StaticsAndConstants.cellIdentifier, for: indexPath) as! MessageCell
            cell.label.text = message.body
            
            //filter messages from current user
            if message.sender == Auth.auth().currentUser?.email{
                cell.messageBubble.backgroundColor = UIColor.systemYellow
            } else { //message is from someone else
                cell.messageBubble.backgroundColor = UIColor.systemGreen
            }
            return cell
        }
        
        
    }

    extension ChatViewController : UITableViewDelegate {
        //Called when text cell is clicked - currently disabled
        /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print(indexPath.row)
        }*/
    }
