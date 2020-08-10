//
//  ViewController.swift
//  HangMan
//
//  Created by Todor Dimitrov on 10.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var words = [String]()
    var usedLetters = [String]()
    var promptWord = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let wordFileURL = Bundle.main.url(forResource: "Words", withExtension: "txt") {
            
            if let wordsContents = try? String(contentsOf: wordFileURL) {
                words = wordsContents.components(separatedBy: "\n")
            }
        }
        
        if words.isEmpty {
            words = ["silkworm"]
        }
        
        startGame()
        
    }
    
    func checkWord() {
        
        let word = String(title ?? "unknown")
        for letter in word {
            let strLetter = String(letter)
            
            if usedLetters.contains(strLetter) {
                promptWord += strLetter
            } else {
                promptWord += "?"
            }
        }
    }
    
    func startGame() {
        
        title = words.randomElement()
        usedLetters.removeAll(keepingCapacity: true)
        
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter a word", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else {
                return }
            self?.submit(answer)
        }
    }

func submit(_ answer: String) {
    
}

@IBAction func enterLetter(_ sender: Any) {
    
}


}

