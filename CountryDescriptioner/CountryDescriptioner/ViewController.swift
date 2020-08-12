//
//  ViewController.swift
//  CountryDescriptioner
//
//  Created by Todor Dimitrov on 11.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        
        return cell
    }
    
    
    
}

