//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Todor Dimitrov on 17.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

enum Position: UInt32 {
    case top = 1
    case bottom = 2
}

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var picture: UIImageView!
    @IBOutlet var bottomTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(onCameraClick))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add text", style: .plain, target: self, action: #selector(addtext))
    }
    
    @objc func addtext() {
        let ac = UIAlertController(title: "Add text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let text = ac?.textFields?[0].text else { return }
            self?.submit(text,Position.top)
            self?.addBottomtext()
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func submit(_ text: String,_ position: Position) {
        if position.rawValue == 1 {
        textLabel.text = text
        } else if position.rawValue == 2 {
            bottomTextLabel.text = text
        }
    }
    
    @objc func onCameraClick() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        picture.image = image
    }
    
   func addBottomtext() {
        let ac = UIAlertController(title: "Add bottom text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let text = ac?.textFields?[0].text else { return }
            self?.submit(text,Position.bottom)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }


}

