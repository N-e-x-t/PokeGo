//
//  ViewController.swift
//  PokéGo
//
//  Created by Jigar Parekh on 06/04/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //Initialized empty array for Pokemon
    var pokemon : [Pokemon] = []

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
            
            //Shows the blue spot for user location, which is later changed to a different annotation, ie. an image
            self.mapView.showsUserLocation = true
            
            //Updates the user location
            self.manager.startUpdatingLocation()
            
            //Used to show annotation as images
            self.mapView.delegate = self
            
            //Brings all pokemon from the CDHelper file
            pokemon = bringAllPokemon()
            
            //Equatation to find the annotation
            Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: {
                (timer) in
                if let coordinate = self.manager.location?.coordinate {
                    
                    //Setting pokemon images to annotation
                    let randomPokemon = Int(arc4random_uniform(UInt32(self.pokemon.count)))
                    
                    let pokemon = self.pokemon[randomPokemon]
                    
                    let annotation = PokemonAnnotation(coordinate: coordinate, pokemon: pokemon)
                    
                    annotation.coordinate = coordinate
                    annotation.coordinate.latitude += (Double(arc4random_uniform(1000)) - 500) / 300000.0
                    annotation.coordinate.longitude += (Double(arc4random_uniform(1000)) - 500) / 300000.0
                    
                    self.mapView.addAnnotation(annotation)
                    }
                }
            )
            
        }
        else {
            self.manager.requestWhenInUseAuthorization()
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation {
            annotationView .image = #imageLiteral(resourceName: "player")
        } else {
            let pokemon = (annotation as! PokemonAnnotation).pokemon
            annotationView.image = UIImage(named: pokemon.imageFileName!)
        }
        
        //Resizes the annotation images to a particular size
        var newFrame = annotationView.frame
        newFrame.size.width = 50
        newFrame.size.height = 50
        annotationView.frame = newFrame
        
        return annotationView
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if update < 4{
        
        // Sets the region of view to display
        let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, 400, 400)
        self.mapView.setRegion(region, animated: true)
        self.manager.startUpdatingLocation()
        update += 4
        }
        else {
            self.manager.stopUpdatingLocation()
        }
        
    }
    
    //To hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //To select an annotation/pokemon from the map
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        mapView.deselectAnnotation(view.annotation!, animated: true)
        
        if view.annotation is MKUserLocation {
            return
        }
        
        //It zooms the region around the annotation/pokemon which is clicked
        let region = MKCoordinateRegionMakeWithDistance((view.annotation?.coordinate)!, 50, 50)
        self.mapView.setRegion(region, animated: true)
        
        //Setting a range around the player/user in which the player can catch pokemons
        if let coordinate = self.manager.location?.coordinate {
            if MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(coordinate)) {
               
                //To send the pokemon to the BattleScene
               let battle = BattleViewController()
                
                //To get a pokemon to send to the BattleScene
                let pokemon = (view.annotation as! PokemonAnnotation).pokemon
                battle.pokemon = pokemon
                
                
               self.present(battle, animated: true, completion: nil)
                
               print("in range")
                self.mapView.removeAnnotation(view.annotation!)

            } else {
                print ("Out of range")
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

