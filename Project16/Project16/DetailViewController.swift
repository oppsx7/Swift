//
//  DetailViewController.swift
//  Project16
//
//  Created by Todor Dimitrov on 12.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet var webView: WKWebView!

    override func loadView() {
        
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
