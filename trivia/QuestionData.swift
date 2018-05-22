//
//  QuestionData.swift
//  trivia
//
//  Created by Philine Wairata on 17/05/2018.
//  Copyright © 2018 Philine Wairata. All rights reserved.
//

import Foundation
import UIKit

// Array storing the question items from jService.io
typealias Questions = [StoreQuestions]

struct StoreQuestions: Codable {
    let answer: String
    let question: String
    let value: Int?
}

// Index of the store questions list
var questionIndex = 0

// Stores the userscore
var userScore = 0

// Amound of questions in a round
var questionRounds = 10

// Stores the player's lives 
var lives = 4

// Stores the amount of right anwsers.
var rightAnwsers = 0
