//
//  ViewController.swift
//  Project2
//
//  Created by Todor Dimitrov on 4.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionAsked = 0
    var highestScore = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
        
        askQuestion(action: nil)
        
    }
    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "Which one is \(countries[correctAnswer].uppercased())"
        
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            if score > highestScore {
                highestScore = score
                let ac = UIAlertController(title: "You beat your highest score!", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Awesome!", style: .default, handler: askQuestion))
                present(ac, animated: true)
            }
        } else {
            title = "Wrong"
            score -= 1
        }
        
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        var tempScore = score
        let finished = UIAlertController(title: title, message: "Game finished, your final score is: \(tempScore)", preferredStyle: .alert)
        
        questionAsked += 1
        if questionAsked != 5 {
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        } else {
            score = 0
            finished.addAction(UIAlertAction(title: "Finish", style: .default, handler: askQuestion))
            tempScore = 0
            present(finished, animated: true)
        }
        
        present(ac, animated: true)
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: nil, message: "Your score is: \(score)\n Your highest score is \(highestScore)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Hide", style: .cancel))
        
        present(ac, animated: true)
    }
    

}

