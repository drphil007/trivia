//
//  ResultsViewController.swift
//  trivia
//
//  Created by Philine Wairata on 16/05/2018.
//  Copyright © 2018 Philine Wairata. All rights reserved.
//

import UIKit
import Firebase


class ResultsViewController: UIViewController {
    
    var ref = DatabaseReference()

    @IBOutlet weak var resultTitel: UILabel!
    @IBOutlet weak var resultText: UILabel!
    
    var storeQuestions = [StoreQuestions]()
    
    // Show results and makes sure the user can't go back and change anwsers.
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculateTriviaResult()
        
        // create an unique ID of the user to be stored in the database without overwriting others' data
        let uuid = NSUUID().uuidString
        
        self.ref.child("leaderboard").child(uuid).setValue(["userName": userName, "userScore": userScore])
    }
    
    /// Calculates results and changes resultTitel and resultText accordingly.
    func calculateTriviaResult() {
        
        // Percentage of the questions that are right.
        var percentage = Double(rightAnwsers) / Double(questionRounds)
        percentage *= 100
        
        // Sets Titel based on percentage of questions right.
        var title = ""
        if(percentage < 50) {
            title = "Keep practicing!"
        } else if(percentage < 70) {
            title = "Keep it up!"
        } else{
            title = "You're Einstein!"
        }
        resultTitel.text = title
        
        // Sets results text.
        resultText.text = "You got \(rightAnwsers) out of \(questionRounds) correct \n \n Your scorevalue is \(userScore)\n \n Click below to upload your score to the Firebase Leaderboard"
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
