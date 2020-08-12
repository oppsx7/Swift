//
//  ViewController.swift
//  Project16
//
//  Created by Todor Dimitrov on 12.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import UIKit
import MapKit
import WebKit

class ViewController: UIViewController, MKMapViewDelegate, WKNavigationDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Map type", style: .plain, target: self, action: #selector(changeMapType))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    @objc func changeMapToSatellite(_ sender: UIAlertAction) {
        mapView.mapType = MKMapType.satellite
    }
    
    @objc func changeMapToDefault(_ sender: UIAlertAction) {
        mapView.mapType = MKMapType.standard
    }
    
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Choose map type ", message: nil, preferredStyle: .alert)
               ac.addAction(UIAlertAction(title: "Default", style: .default, handler: changeMapToDefault))
               ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: changeMapToSatellite))
               present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.pinTintColor = UIColor.blue
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let wholeURL = "https://en.wikipedia.org/wiki/" + capital.title!
        
        let vc = DetailViewController()

        guard let url = URL(string: wholeURL) else { return }
        vc.webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        vc.webView?.load(URLRequest(url: url))
        vc.webView?.allowsBackForwardNavigationGestures = true
        navigationController?.pushViewController(vc, animated: true)

//        let placeName = capital.title
//        let placeInfo = capital.info
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
    }
    
    
    
}

