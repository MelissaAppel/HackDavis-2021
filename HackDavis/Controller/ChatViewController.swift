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
    var listOfMessages : [String] = []
        
    var messages : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(UINib(nibName: StaticsAndConstants.cellNibName, bundle: nil), forCellReuseIdentifier: StaticsAndConstants.cellIdentifier) //Links to MessageCell.xib style
        loadMessages()
        print(messages.count)
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
                        if let messageSender = data[StaticsAndConstants.fStore.senderField] as? String, let messageBody = data[StaticsAndConstants.fStore.bodyField] as? String, let theirEmail = MyDatabase.theirEmail as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody, them : theirEmail)
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
        
    @IBAction func logOutPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                } catch let signOutError as NSError {
                    print("Error signing out", signOutError)
                }
    }
    
    //when send is pressed, uploads message data to firebase
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(StaticsAndConstants.fStore.collectionName).addDocument(data: [StaticsAndConstants.fStore.senderField : messageSender, StaticsAndConstants.fStore.bodyField: messageBody, StaticsAndConstants.fStore.theirField : MyDatabase.theirEmail,
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
    
    /*func filterConversations(){
        for i in 0..<messages.count {
            //if you sent them a message and theyr received it
            if messages[i].sender == Auth.auth().currentUser?.email && MyDatabase.theirEmail == messages[i].them{
                listOfMessages.append(messages[i].body)
            }
            //if they sent you a message
            if messages[i].sender == MyDatabase.theirEmail && Auth.auth().currentUser?.email == MyDatabase.theirEmail {
                listOfMessages.append(messages[i].body)
            }
        }
    }*/

}



extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //filterConversations()
        return messages.count
    }
    
    //populates each row of table with messages.body
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = chatTableView.dequeueReusableCell(withIdentifier: StaticsAndConstants.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        //filter messages from current user
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
            cell.messageBubble.backgroundColor = UIColor.systemBlue
        } else { //message is from someone else
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
            cell.messageBubble.backgroundColor = UIColor.systemIndigo
        }
        return cell
    }
    
    
}

/*
 //    Create array of strings of unique senders
     func filterConversations(){
         for i in 0..<conversations.count {
             let convo = conversations[i].sender
             if !listOfSenders.contains(convo) && convo != Auth.auth().currentUser?.email{
                 listOfSenders.append(convo)
                 numConvos += 1
             }
         }
     }
 }


 extension ConversationListController : UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         filterConversations()
         return listOfSenders.count
     }
 */

extension ChatViewController : UITableViewDelegate {
    //Called when text cell is clicked - currently disabled
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }*/
}
