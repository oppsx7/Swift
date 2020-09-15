//
//  Coordinator.swift
//  Coordinator
//
//  Created by Todor Dimitrov on 15.09.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
