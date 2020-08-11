//
//  DetailViewController.swift
//  Project1
//
//  Created by Todor Dimitrov on 4.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var pictures = [String: Int]()
    var selectedImage: String?
    var rowNumber: Int = 0
    var currentRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Picture \(currentRow) of \(rowNumber)"
        navigationItem.largeTitleDisplayMode = .never
        

        if let imageToLoad = selectedImage {
            
            imageView.image = UIImage(named: imageToLoad)
            
            navigationItem.prompt = "Image clicked: \(pictures[imageToLoad] ?? 0) times"
            
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
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


