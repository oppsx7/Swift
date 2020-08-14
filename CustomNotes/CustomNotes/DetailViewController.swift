//
//  DetailViewController.swift
//  CustomNotes
//
//  Created by Todor Dimitrov on 13.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var notesInformation = [String: String]()
    var noteName = ""
    @IBOutlet var script: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = noteName
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        self.script.addDoneButton(title: "Done", target: self, selector: #selector(tapDone))
        navigationController?.isToolbarHidden = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: self)
        
        let defaults = UserDefaults.standard
        if let savedNotes = defaults.object(forKey: "notesInformation") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                notesInformation = try jsonDecoder.decode([String: String].self, from: savedNotes)
            } catch {
                print("Failed to load script")
            }
        }
        
        script.text = notesInformation[title!]
        
        
        
    }
    
    
    @objc func tapDone(sender: Any) {
        notesInformation[noteName] = script.text ?? ""
        save()
        self.view.endEditing(true)
    }
    
    func save() {
        
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(notesInformation) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notesInformation")
        } else {
            print("failed to save people")
        }
    }
    
    @objc func shareTapped() {
        guard let text = script.text else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillChangeFrameNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldSouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
