//
//  MainFeedViewController.swift
//  HackDavis
//
//  Created by Haruna Yamakawa on 1/17/21.
//

import UIKit
import Firebase
import SDWebImage

class MainFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var searchBar: UISearchBar!
    var posts = [[String:Any]]()
    
    var descriptionArray = [String]()
    var dishNameArray = [String]()
    var imageArray = [String]()
    var flavorArray = [String]()
    var typeArray = [String]()
    var selectedIndex = IndexPath()
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionArray = MyDatabase.shared.getDescriptionArray()
        dishNameArray = MyDatabase.shared.getDishNameArray()
        imageArray = MyDatabase.shared.getImageArray()
        flavorArray = MyDatabase.shared.getFlavorArray()
        typeArray = MyDatabase.shared.getTypeArray()

        tableView.delegate = self
        tableView.dataSource = self
//        searchBar.delegate = self
    }
}

// MARK: - tableViewDataSource
extension MainFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptionArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        cell.dishNameLabel.text = dishNameArray[indexPath.row]
        cell.typeLabel.text = typeArray[indexPath.row]
        cell.flavorLabel.text = flavorArray[indexPath.row]
        let url = URL(string: imageArray[indexPath.row])
        cell.dishImage.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions.highPriority,context: nil, progress: nil, completed: nil)
        return cell
    }

}
// MARK: - UITableViewDelegate
extension MainFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        performSegue(withIdentifier: "goToDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailPostViewController {
            let vc = segue.destination as! DetailPostViewController
//            let cell = sender as! UITableViewCell
            let indexPath = selectedIndex
            vc.dishName = dishNameArray[indexPath.row]
            vc.imageURL = imageArray[indexPath.row]
            vc.flavor = flavorArray[indexPath.row]
            vc.type = typeArray[indexPath.row]
            vc.descriptionText = descriptionArray[indexPath.row]
        }
    }
}
//
//extension MainFeedViewController: UISearchBarDelegate  {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if !searchText.isEmpty {
//
//        } else {
//
//        }
//        tableView.reloadData()
//    }
//
//    // cancelling out of search and hiding keyboard
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        self.searchBar.showsCancelButton = true
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.showsCancelButton = false // remove cancel button
//        searchBar.text = "" // reset search text
//        searchBar.resignFirstResponder() // remove keyboarad
//
//        tableView.reloadData()
//    }
//}
