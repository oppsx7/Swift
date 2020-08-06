//
//  ViewController.swift
//  ShoppingList
//
//  Created by Todor Dimitrov on 6.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var products = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var items = [UIBarButtonItem]()
        
       let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToList))
        items.append(addButton)
        
        self.toolbarItems = items
        navigationController?.isToolbarHidden = false

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(reload))
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath)
        cell.textLabel?.text = products[indexPath.row]
        return cell
    }
    
    @objc func reload() {
        
        products.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func addToList() {
        let ac = UIAlertController(title: "Enter product name", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] action in
            guard let product = ac?.textFields?[0].text else { return }
            self?.add(product)
            
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func add(_ product: String) {
        
        products.insert(product, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func shareTapped() {
        
        let list = products.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    


}

