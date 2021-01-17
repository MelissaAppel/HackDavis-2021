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
    var numConvos = 0
    var listOfSenders : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversationTableView.delegate = self
        conversationTableView.dataSource = self
        loadConversations()
        print(conversations.count)
        filterConversations()
    }
    
    
    //ARYAN: I cannot get my global conversations : [Message] to update outside of this enclosure to use in my filterConversations() function
    func loadConversations(){
        //get message db from firecloud, order by time sent
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
                            }
                        }
                    }
                }
            }
        }
        
    }
    

    //Create array of strings of unique senders
    func filterConversations(){
        for i in 0..<conversations.count {
            let convo = conversations[i].sender
            if !listOfSenders.contains(convo) {
                listOfSenders.append(convo)
                numConvos += 1
            }
        }
        print(listOfSenders.count)
    }
}


//Populate cells with unique sender names
extension ConversationListController : UITableViewDataSource {
    //set number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numConvos
    }
    
    //populates each row of table with messages.sender
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = listOfSenders[indexPath.row]
        let cell = conversationTableView.dequeueReusableCell(withIdentifier: StaticsAndConstants.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = user
        return cell
    }
}

extension ConversationListController : UITableViewDelegate {
    
}
