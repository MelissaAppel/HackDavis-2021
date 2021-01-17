//
//  LoginViewControl.swift
//  evolv
//
//  Created by Aryan Vaid on 1/1/21.
//  Copyright © 2021 Evolv Ideas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFirestore

class InitialViewController: UIViewController {
    var fstore: Firestore!
    var posts = [[String:Any]]()
    var descriptionArray = [String]()
    var dishNameArray = [String]()
    var imageArray = [String]()
    var flavorArray = [String]()
    var typeArray = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        fstore = Firestore.firestore()

    }
    override func viewDidAppear(_ animated: Bool) {
        getData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.segue()
        })
       
    }
    func segue() {
        self.performSegue(withIdentifier: "notLoggedIn", sender: nil)

//        if UserDefaults.standard.bool(forKey: "logIn") == true {
//            print("User logged in ")
//            let userId = UserDefaults.standard.string(forKey: "currentUserID")!
//            MyDatabase.shared.setCurrentUserID(currentUserID: userId)
//           self.performSegue(withIdentifier: "loggedIn", sender: nil)
//        }else{
//            print("User not Logged in ")
//            self.performSegue(withIdentifier: "notLoggedIn", sender: nil)
//        }
    }
    func getData() {
        //Network request snippet
               let url = URL(string: "https://hack-davis-f5888-default-rtdb.firebaseio.com/Database.json")!
               let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
               let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
               let task = session.dataTask(with: request) { (data, response, error) in
                  // This will run when the network request returns
                  if let error = error {
                     print(error.localizedDescription)
                  } else if let data = data {
                     let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                   self.posts = dataDictionary["posts"] as! [[String:Any]]
//                   print(self.posts)
                   MyDatabase.shared.setAllPosts(posts: self.posts)
                   
                    //for i in stride(from: self.posts.count-1, to: -1, by: -1) {

                   /* for i in self.posts.count...0 {
                        let post = self.posts[i]
                        let description = post["description"] as! String
                            self.descriptionArray.append(description)
                        let dishName = post["dishName"] as! String
                            self.dishNameArray.append(dishName)
                        let image = post["image"] as! String
                            self.imageArray.append(image)
                        let flavor = post["flavor"] as! String
                            self.flavorArray.append(flavor)
                        let type = post["type"] as! String
                            self.typeArray.append(type)
                    }*/
                    
                    MyDatabase.shared.setDescriptionArray(descriptionArray: self.descriptionArray)
                    MyDatabase.shared.setDishNameArray(dishNameArray: self.dishNameArray)
                    MyDatabase.shared.setImageArray(imageArray: self.imageArray)
                    MyDatabase.shared.setFlavorArray(flavorArray: self.flavorArray)
                    MyDatabase.shared.setTypeArray(typeArray: self.typeArray)
                }
               }
        task.resume()
               
    }
        
}


