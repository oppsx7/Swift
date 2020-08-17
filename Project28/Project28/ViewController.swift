//
//  ViewController.swift
//  Project28
//
//  Created by Todor Dimitrov on 17.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import LocalAuthentication
import UIKit

class ViewController: UIViewController {
    @IBOutlet var secret: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nothing to see here"
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @IBAction func authenticateTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Register/LogIn", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Register", style: .default, handler: register))
        ac.addAction(UIAlertAction(title: "LogIn", style: .default, handler: logIn))
        present(ac, animated: true)
        
        
        
        
    }
    
    @objc func register(_ sender: UIAlertAction) {
        let ac = UIAlertController(title: "Enter a username and a password", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Continue", style: .default) {
            [weak self, weak ac] action in
            guard let userName = ac?.textFields?[0].text else { return }
            guard let password = ac?.textFields?[1].text else { return }
            self?.registerUser(userName: userName, password: password)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
        
    }
    
    @objc func registerUser(userName: String, password: String) {
        KeychainWrapper.standard.set(password, forKey: userName)
        unlockSecretMessage(userName: userName)
        
    }
    
    @objc func logIn(_ sender: UIAlertAction) {
        
        let ac = UIAlertController(title: "Enter a username", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Password", style: .default) {
            [weak self, weak ac] action in
            guard let userName = ac?.textFields?[0].text else { return }
            self?.unlockWithPassword(userName: userName)
        })
        ac.addAction(UIAlertAction(title: "FaceID", style: .default) {
            [weak self, weak ac] action in
            guard let userName = ac?.textFields?[0].text else { return }
            self?.unlockWithBiometric(userName: userName)
        })
        present(ac, animated: true)
        
    }
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEnd = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEnd, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    func unlockWithPassword(userName: String) {
        let ac = UIAlertController(title: "Enter a password", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let password = ac?.textFields?[0].text else { return }
            if KeychainWrapper.standard.string(forKey: userName) == password{
                self?.unlockSecretMessage(userName: userName)
            } else {
                let tempAC = UIAlertController(title: "Wrong username or password",message: nil, preferredStyle: .alert)
                tempAC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                self?.present(tempAC, animated: true)
            }
        })
        present(ac, animated: true)
        
    }
    
    func unlockWithBiometric(userName: String) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage(userName: userName)
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified, please try again", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Biometry Unavailable", message: "your device is not configured for biometric authentication", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac ,animated: true)
        }
    }
    
    func unlockSecretMessage(userName: String) {
        secret.isHidden = false
        title = "Secret stuff!"
        secret.text = KeychainWrapper.standard.string(forKey: userName) ?? ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveSecretMessage))
        
        
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
        title = "Nothing to see here"
        self.navigationItem .setRightBarButtonItems(nil, animated: true)
    }
    
    
    
}

