//
//  ViewController.swift
//  ChallengeProject
//
//  Created by Todor Dimitrov on 5.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var countries = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "World Flags"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") {
                    //this is a picture to load !
                countries.append(item)
            }
        }
        
        print(countries)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    var i = 0
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        
        let tempCountryArr = countries[indexPath.row].components(separatedBy: "@")
        cell.imageView?.image = UIImage(named: "\(countries[i])")
        cell.imageView?.layer.borderWidth = 0.8
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
        cell.textLabel?.text = tempCountryArr[0]
        i += 1
        //cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = countries[indexPath.row]
           
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

