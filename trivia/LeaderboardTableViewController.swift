////
////  LeaderboardTableViewController.swift
////  trivia
////
////  Created by Philine Wairata on 21/05/2018.
////  Copyright © 2018 Philine Wairata. All rights reserved.
////
//
import UIKit
import Firebase

class LeaderboardTableViewController: UITableViewController {

    
    // var ref = DatabaseReference()
    var ref: DatabaseReference!
    
    // items of database
    var items: [LeaderboardItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        ref.child("leaderboard").observe(.value, with: { snapshot in
            var newItems: [LeaderboardItem] = []

            for item in snapshot.children {
                let leaderboardItem = LeaderboardItem(snapshot: item as! DataSnapshot)
                newItems.append(leaderboardItem)
            }
            newItems = newItems.sorted(by: { $0.userScore >= $1.userScore })
            self.updateUI(with: newItems)
        })
    }

    // Update the user interface with new data from the database
    func updateUI(with items: [LeaderboardItem]) {
        DispatchQueue.main.async {
            self.items = items
            self.tableView.reloadData()
            self.tableView.allowsSelection = false
        }
    }

    // Returns the number of rows that need to be created, one extra for the header information
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 1
    }

    // Create the appropriate rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "LeaderboardCellIdentifier", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }

    // Make the cells of the tableview
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)

        
        // Create the header cell
        if indexPath.row == 0 {
            
            cell.textLabel?.text = "Name"
            cell.detailTextLabel?.text = "Score"
            print("------------------------------00--")
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.white
        }

        //    Create the name and score cells
        else {
            let indexPathNew = Int(indexPath.row) - 1
            let leaderboardString = items[indexPathNew]
            cell.textLabel?.text = String(indexPathNew + 1) + ". " + leaderboardString.userName
            cell.detailTextLabel?.text = String(leaderboardString.userScore)
            print(leaderboardString.userName)
            print("-------------------------o-")
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16.0)
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16.0)
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.white
        }
    }
}
