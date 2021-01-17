//
//  MainFeedViewController.swift
//  HackDavis
//
//  Created by Haruna Yamakawa on 1/17/21.
//

import UIKit
import Firebase

class MainFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    
    var posts: [Post] = [
        Post(foodName: "pizza", foodType: "", spice: "normal", description: "I made pizza today"),
        Post(foodName: "pasta", foodType: "", spice: "normal", description: "tomato pasta")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // read
//        Firestore.firestore().collection("posts").getDocuments { (snaps, error) in
//            if let error = error {
//                fatalError("\(error)")
//            }
//            guard let snaps = snaps else { return }
//            for document in snaps.documents {
//                print(document.data())
//            }
//        }
  
    }
    
    func getPosts() {
        ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
//        let refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
//            if let postDict = snapshot.value as? [String: AnyObject] ?? [:] {
//                let description = postDict["description"] as! String
//                let dishName = postDict["dishName"] as! String
//                let spiciness = postDict["spice"] as! String
//                let type = postDict["type"] as! String
//                let image = postDict["image"] as! UIImageView
//        }
//
//        }) { (error) in
//            print(error)
//
//        }
        
    }
   

}


// MARK: - tableViewDataSource
extension MainFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        cell.dishNameLabel?.text = posts[indexPath.row].foodName
        
        return cell
    }

}
// MARK: - UITableViewDelegate
extension MainFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }
}

