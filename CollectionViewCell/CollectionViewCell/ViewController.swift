//
//  ViewController.swift
//  CollectionViewCell
//
//  Created by Todor Dimitrov on 25.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: view.topAnchor )
    }


}

