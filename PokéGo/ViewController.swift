//
//  ViewController.swift
//  PokéGo
//
//  Created by Jigar Parekh on 06/04/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func userLocationRepositioningButtonPress(_ sender: Any) {
        // Sets the region of view to display
        let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, 400, 400)
        self.mapView.setRegion(region, animated: true)
    }
    
    var manager = CLLocationManager()
    
    var update = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.manager.delegate = self
        
        
        //Authorization status and location setting
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            //Shows the blue spot for user location
            self.mapView.showsUserLocation = true
            
            //Updates the user location
            self.manager.startUpdatingLocation()
            
        }
        else {
            self.manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if update < 4{
        
        // Sets the region of view to display
        let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, 400, 400)
        self.mapView.setRegion(region, animated: true)
        self.manager.startUpdatingLocation()
            //update += 4
        }
        else {
            self.manager.stopUpdatingLocation()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

