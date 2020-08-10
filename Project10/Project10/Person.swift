//
//  Person.swift
//  Project10
//
//  Created by Todor Dimitrov on 10.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
