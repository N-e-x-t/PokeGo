//
//  PokemonAnnotation.swift
//  PokéGo
//
//  Created by Jigar Parekh on 06/04/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnnotation: NSObject ,MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    var pokemon : Pokemon
    
    init(coordinate : CLLocationCoordinate2D, pokemon : Pokemon) {
        self.coordinate = coordinate
        self.pokemon = pokemon
    }

}
