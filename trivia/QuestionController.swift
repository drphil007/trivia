//
//  QuestionController.swift
//  trivia
//
//  Created by Philine Wairata on 17/05/2018.
//  Copyright © 2018 Philine Wairata. All rights reserved.
//

import Foundation
import UIKit

// Network calls in the same protocol and host.
class QuestionController {

    static let shared = QuestionController()

    let url = URL(string: "http://jservice.io/api/random?count=10")!

    /// Function for the request of the question items.
    func fetchQuestions(completion: @escaping (Questions?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            //print(data)
            if let data = data,
                let storeQuestions = try? jsonDecoder.decode(Questions.self, from: data) {
                completion(storeQuestions)
                print(storeQuestions)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
