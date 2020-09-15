//
//  ViewController.swift
//  Coordinator
//
//  Created by Todor Dimitrov on 15.09.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func buyTapped(_ sender: Any) {
        coordinator?.buySubscription()
        
    }
    
    @IBAction func createAccount(_ sender: Any) {
        coordinator?.createAccount()
    }
    
}

