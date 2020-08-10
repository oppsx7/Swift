//
//  ViewController.swift
//  Project4
//
//  Created by Todor Dimitrov on 5.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UITableViewController, WKNavigationDelegate {

    var websites = ["apple.com", "hackingwithswift.com"]
    
//    override func loadView() {
//        title = "Websites"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(websites)
        
        
       
        

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        websites.sort(by: <)
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        guard let url = URL(string: "https://" + websites[indexPath.row]) else {return}
        vc.webView?.load(URLRequest(url: url))
        vc.webView?.allowsBackForwardNavigationGestures = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    


    
    
}

