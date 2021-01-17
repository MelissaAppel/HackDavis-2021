//
//  ConversationListController.swift
//  HackDavis
//
//  Created by Melissa Appel on 1/16/21.
//

import UIKit
import Firebase

class ConversationListController: UIViewController {

    @IBOutlet weak var conversationTableView: UITableView!
    
    let database = Firestore.firestore()
    var conversations : [Message] = []
    var numConvos : Int = 0
    var listOfSenders : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversationTableView.delegate = self
        conversationTableView.dataSource = self
        conversationTableView.register(UINib(nibName: StaticsAndConstants.cellNibName, bundle: nil), forCellReuseIdentifier: StaticsAndConstants.cellIdentifier)
        loadConversations()
    }
    
    
    //Retreives messages from firebase, currently receives all messages from every user, need to filter only selected user and implement chat message selector/picker
    func loadConversations(){
        database.collection(StaticsAndConstants.fStore.collectionName)
            .order(by: StaticsAndConstants.fStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            self.conversations = []
            if let e = error {
                print("issue retreiving data \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let messageSender = data[StaticsAndConstants.fStore.senderField] as? String, let messageBody = data[StaticsAndConstants.fStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.conversations.append(newMessage)
                            
                            DispatchQueue.main.async{
                                self.conversationTableView.reloadData()
                                let indexPath = IndexPath(row: self.conversations.count - 1, section: 0)
                                self.conversationTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                            
                        }
                    }
                }
            }
        }
        
    }
    

    /*//Create array of strings of unique senders
    func filterConversations(){
        for i in 0..<conversations.count {
            let convo = conversations[i].sender
            if !listOfSenders.contains(convo) {
                listOfSenders.append(convo)
                numConvos += 1
            }
        }
        print(listOfSenders.count)
    }*/
}



extension ConversationListController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    //populates each row of table with messages.body
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = conversations[indexPath.row]
        
        let cell = conversationTableView.dequeueReusableCell(withIdentifier: StaticsAndConstants.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.sender
        
        //filter messages from current user
        if message.sender == Auth.auth().currentUser?.email{
            cell.messageBubble.backgroundColor = UIColor.systemYellow
            cell.label.backgroundColor = UIColor.systemYellow
        } else { //message is from someone else
            cell.messageBubble.backgroundColor = UIColor.systemGreen
            cell.label.backgroundColor = UIColor.systemGreen
        }
        return cell
    }
    
    
}

extension ConversationListController : UITableViewDelegate {
    //Called when text cell is clicked - currently disabled
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }*/
}
