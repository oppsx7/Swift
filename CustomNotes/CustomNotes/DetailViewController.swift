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
        var items = [UIBarButtonItem]()
        
        let doneButton = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(done))
        items.append(doneButton)
        self.toolbarItems = items
        self.navigationController?.toolbar.tintColor = UIColor.systemPink
        navigationController?.isToolbarHidden = false
        
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
    
    @objc func done() {
        notesInformation[noteName] = script.text ?? ""
        save()
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
