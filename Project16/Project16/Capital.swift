//
//  Capital.swift
//  Project16
//
//  Created by Todor Dimitrov on 12.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }

}
