//
//  ViewController.swift
//  textField
//
//  Created by Todor Dimitrov on 25.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    var count = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.addTarget(self, action: #selector(addDotToTextField), for: .editingChanged)
    }
    
    @objc func addDotToTextField(textfield: UITextField) {
        
        if count % 3 == 0 {
            textfield.text?.append(".")
        }
        
        count += 1
    }


}

