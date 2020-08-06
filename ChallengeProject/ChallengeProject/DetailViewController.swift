//
//  DetailViewController.swift
//  ChallengeProject
//
//  Created by Todor Dimitrov on 5.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        let tempArray = selectedImage?.components(separatedBy: "@")
        title = tempArray![0]
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            imageView.layer.borderWidth = 0.9
            imageView.layer.borderColor = UIColor.gray.cgColor
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.pngData() else{
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image, selectedImage!], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)

    }
}
