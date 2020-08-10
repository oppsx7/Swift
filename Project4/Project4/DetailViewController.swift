//
//  DetailViewController.swift
//  Project4
//
//  Created by Todor Dimitrov on 7.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var progressView: UIProgressView!
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(webView.reload))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        
        var items = [UIBarButtonItem]()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        items.append(progressButton)
        items.append(spacer)
        self.toolbarItems = items
        navigationController?.isToolbarHidden = false
        
                webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        


    }
    
    @objc func goBack() {
        
       }
       
       @objc func goForward() {
           webView.goForward()
       }
       
    
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "estimatedProgress" {
                progressView.progress = Float(webView.estimatedProgress)
            }
    
        }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//            let url = navigationAction.request.url
//            
//            if let host = url?.host {
//                for website in websites {
//                    if host.contains(website) {
//                        decisionHandler(.allow)
//                        return
//                    }
//    //                let ac = UIAlertController(title: "Blocked", message: nil, preferredStyle: .alert)
//    //                ac.addAction(UIAlertAction(title: "Go back", style: .cancel, handler: nil))
//    //                present(ac, animated: true)
//                }
//            }
//            decisionHandler(.cancel)
//        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
