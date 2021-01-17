//
//  MyDatabase.swift
//  HackDavis
//
//  Created by Aryan Vaid on 1/17/21.
//

import Foundation

class MyDatabase {
    static let shared = MyDatabase()

    var currentUserID = ""
    var allPosts = [[String:Any]]()
    
    var descriptionArray = [String]()
    var dishNameArray = [String]()
    var imageArray = [String]()
    var spiceArray = [String]()
    var typeArray = [String]()

    private init() {}
    // Setter functions

    func setAllPosts(posts:[[String:Any]]){
        self.allPosts = posts
    }
    func setDescriptionArray(descriptionArray:[String]){
        self.descriptionArray = descriptionArray
    }
    func setDishNameArray(dishNameArray:[String]){
        self.dishNameArray = dishNameArray
    }
    func setImageArray(imageArray:[String]){
        self.imageArray = imageArray
    }
    func setSpiceArray(spiceArray:[String]){
        self.spiceArray = spiceArray
    }
    func setTypeArray(typeArray:[String]){
        self.typeArray = typeArray
    }
    
    func setCurrentUserID(currentUserID:String) {
        self.currentUserID = currentUserID
    }
    
    // Getter functions

    func getCurrentUserID() -> String {
        return currentUserID
    }
    func getAllPosts() -> [[String:Any]] {
        return allPosts
    }
    func getDescriptionArray() -> [String] {
        return descriptionArray
    }
    func getDishNameArray() -> [String] {
        return dishNameArray
    }
    func getImageArray() -> [String] {
        return imageArray
    }
    func getSpiceArray() -> [String] {
        return spiceArray
    }
    func getTypeArray() -> [String] {
        return typeArray
    }
    
}

