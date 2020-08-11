//
//  Picture.swift
//  PictureStorage
//
//  Created by Todor Dimitrov on 11.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class Picture: NSObject, Codable {
    var name: String
    var image: UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }

}
