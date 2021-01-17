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
        chatTableView.register(UINib(nibName: StaticsAndConstants.cellNibName, bundle: nil), forCellReuseIdentifier: StaticsAndConstants.cellIdentifier)
        
        loadMessages()
    }
    
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
                            }
                            
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(StaticsAndConstants.fStore.collectionName).addDocument(data: [StaticsAndConstants.fStore.senderField : messageSender, StaticsAndConstants.fStore.bodyField: messageBody,
                StaticsAndConstants.fStore.dateField: Date().timeIntervalSince1970
                ]) { (error) in
                if let e = error {
                    print("Error saving data to firestore")
                } else {
                    print("saved data")
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
        let cell = chatTableView.dequeueReusableCell(withIdentifier: StaticsAndConstants.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        return cell
    }
    
    
}

extension ChatViewController : UITableViewDelegate {
    //Called when text cell is clicked - currently disabled
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }*/
}
