//
//  ViewController.swift
//  Project1
//
//  Created by Todor Dimitrov on 4.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    var picturesClick = [String: Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(loadFiles), with: nil)
        
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "picturesClick") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                picturesClick = try jsonDecoder.decode([String: Int].self, from: savedPeople)
            } catch {
                print("failed to load people.")
            }
        }
        print(pictures)
    }
    
    @objc func loadFiles() {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                    //this is a picture to load !
                pictures.append(item)
            }
        }
        
        for picture in pictures {
            picturesClick[picture] = 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.sort(by: <)
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.rowNumber = pictures.count
            vc.currentRow = indexPath.row + 1
            picturesClick[pictures[indexPath.row]]! += 1
            save()
            vc.pictures[pictures[indexPath.row]] = picturesClick[pictures[indexPath.row]]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
            
            if let savedData = try? jsonEncoder.encode(picturesClick) {
                let defaults = UserDefaults.standard
                defaults.set(savedData, forKey: "picturesClick")
            } else {
                print("Failed to save picture.")
            }
        }
    }


