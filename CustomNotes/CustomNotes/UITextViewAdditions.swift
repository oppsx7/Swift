//
//  UITextViewAdditions.swift
//  CustomNotes
//
//  Created by Todor Dimitrov on 14.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

extension UITextView {
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}
