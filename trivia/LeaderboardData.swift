//
//  LeaderboardData.swift
//  trivia
//
//  Created by Philine Wairata on 21/05/2018.
//  Copyright © 2018 Philine Wairata. All rights reserved.
//

import Foundation
import Firebase


// Store the items of the leaderboard from the database in the struct.
struct LeaderboardItem {
    
    let uuid: String
    let userName: String
    let userScore: Int
    
    init(userName: String, userScore: Int, uuid: String = "") {
        self.uuid = uuid
        self.userName = userName
        self.userScore = userScore
    }
    
    init(snapshot: DataSnapshot) {
        uuid = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        userName = snapshotValue["userName"] as! String
        userScore = snapshotValue["userScore"] as! Int
    }
    
    func toAnyObject() -> Any {
        return [
            "userName": userName,
            "userScore": userScore,
        ]
    }
    
}

// Current users' index
var userNameIndex: Int = 0

// Remember the user name entered at the home view.
var userName: String = "Player \(userNameIndex)"
