//
//  ViewController.swift
//  tabGestureImgPreview
//
//  Created by Todor Dimitrov on 3.09.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var button: UIButton!
    var newImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = image
        newImageView = UIImageView(image: imageView!.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        let myButton = UIButton() // if you want to set the type use like UIButton(type: .RoundedRect) or UIButton(type: .Custom)
        myButton.setTitle("Hai Touch Me", for: .normal)
        myButton.setTitleColor(UIColor.blue, for: .normal)
        myButton.frame = CGRect(x: 15, y: 50, width: 300, height: 500)
        myButton.addTarget(self, action: #selector(dismissFullscreenImage), for: .touchUpInside)
        newImageView.addSubview(myButton)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    @objc func dismissFullscreenImage() {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        newImageView.removeFromSuperview()
    }


}

