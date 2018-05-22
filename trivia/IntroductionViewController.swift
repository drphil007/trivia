//
//  IntroductionViewController.swift
//  trivia
//
//  Created by Philine Wairata on 16/05/2018.
//  Copyright © 2018 Philine Wairata. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {

    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var startQuizButton: UIButton!
    @IBOutlet weak var leaderboardButton: UIButton!
    
    // If textfield is changed.
    @IBAction func userNameChanged(_ sender: UITextField) {
        userNameIndex += 1
        // Set text to username of current player.
        if let text = sender.text {
            userName = text
            if userName.isEmpty {
                userName = "Player \(userNameIndex)"
            }
        }
        print(userName)
    }
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameField.delegate = self as? UITextFieldDelegate
    }
    
    // Set textfield to entered text.
    func textFieldSet(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            textField.resignFirstResponder()
        }
        return true
    }

    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /// Enables the player to dismiss the results and start with a clean slate.
    @IBAction func unwindToQuizIntroduction(segue: UIStoryboardSegue) {
        
    }

}
