//
//  QuestionViewController.swift
//  trivia
//
//  Created by Philine Wairata on 16/05/2018.
//  Copyright © 2018 Philine Wairata. All rights reserved.
//

import UIKit
import Foundation

class QuestionViewController: UIViewController {
    
    // store question data for questions and anwsers
    var storeQuestions = [StoreQuestions]()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var anwserField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // reset values
        questionIndex = 0
        userScore = 0
        questionRounds = 10
        rightAnwsers = 0
        
        // Query data from jService
        QuestionController.shared.fetchQuestions { (storeQuestions) in
            if let storeQuestions = storeQuestions {
                    //print(storeQuestions)
                    self.storeQuestions = self.storeQuestions + storeQuestions
                    self.updateUI(with: self.storeQuestions)
                    print(storeQuestions)
            }
            print("---------------------------")
        }
    }
    
    // Update the user interface with storeQuestions from api.
    func updateUI(with storeQuestions: [StoreQuestions]) {
        DispatchQueue.main.async {
            self.showQuestion(with: storeQuestions)
            self.calculateScore()
        }
    }
    
    /// Displays next question and determines if there are any remaining questions.
    func nextQuestion() {
        
        // Empty textfield for new anwser.
        anwserField.text = ""
        
        // Add 1 to question index when next question.
        questionIndex += 1
        
        // If user has played not all questions go to next question.
        if questionIndex < questionRounds {
            updateUI(with: storeQuestions)
        }
        // If user has played one round of questions.
        else {
                performSegue(withIdentifier: "ResultsSegue", sender: nil)
            }
    }
    
    // Submit anwser when submit button pressed.
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        // Turn submit button off when anwser submitted
        submitButton.isEnabled = false
        
        // Store user input anwser.
        let userAnwser = anwserField.text!
        print(userAnwser)
        
        // Currentanwser for currentQuestion
        let currentAnswer = storeQuestions[questionIndex].answer
        
        // If input anwser is right anwser, update score and proceed to next question.
        if userAnwser == currentAnswer {
            
            // Take value from currentAnswer
            let valueScore = storeQuestions[questionIndex].value
            
            // Add point to rightAnwsers
            rightAnwsers += 1
            
            // If value of sotreQuestions is not nil, add score to userScore
            if valueScore != nil {
                 userScore += valueScore!
            }
            // else add zero
            else {
                userScore += 0
            }
            
            // Set label for right anwser
            navigationItem.title = "That's Right!"
            self.questionLabel.text = "You have the right anwser"
            self.calculateScore()
            
            // Go to next questiona fter showing label for couple seconds.
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.nextQuestion()
                // Enable the submit button.
                self.submitButton.isEnabled = false
            }
            
        }
        
        // Else if user anwser not right.
        else {
            // if anwser contains part of the anwser give half of the value
            if userAnwser.lowercased().contains(currentAnswer) {
                 navigationItem.title = "Almost!"
                self.questionLabel.text = "Seems like you got part of the question right, the right anwser was '\(currentAnswer)'."
            }
            // If input anwser is the wrong anwser
            else if userAnwser != currentAnswer {
                    // Set labels for wrong anwsers
                    navigationItem.title = "Wrong Answer!"
                    self.questionLabel.text = "The right anwser was '\(currentAnswer)'."
                 }
            
            // Go to next question after showing label for five seconds.
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.nextQuestion()
            }
        }
    }

    // Shows the question on the user interface
    func showQuestion(with storeQuestions: [StoreQuestions]) {
        
        // Enable the submit button when question is shown.
        self.submitButton.isEnabled = true
        
        // update navigationitem to display correct "nth question
        navigationItem.title = "Question #\(questionIndex+1)"        
        var currentQuestion = storeQuestions[questionIndex].question
        
        // Update questionLabel to display correct question, only when question not empty
        if currentQuestion == ""
        {
            currentQuestion = storeQuestions[questionIndex+1].question
        }
        // Else if currentQuestion string is not empty, set questionLabel with question
        else {
            questionLabel.text = currentQuestion
        }
    }
    
    // Update the scoreLabel
    func calculateScore() {
        scoreLabel.text = "Score: " + String(userScore)
        print(scoreLabel)
    }
    
    // Dispose of any recources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Pass data to the results view.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.storeQuestions = storeQuestions
       }
    }
}
