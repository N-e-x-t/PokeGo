//
//  CDHelper.swift
//  PokéGo
//
//  Created by Jigar Parekh on 06/04/17.
//  Copyright © 2017 Next. All rights reserved.
//

import CoreData
import UIKit

//This function creates all pokemons
func makeAllPokemon() {
    
    makePokemon(name: "Abra", withThe: "abra")
    makePokemon(name: "Pikachu", withThe: "pikachu-2")
    makePokemon(name: "Psyduck", withThe: "psyduck")
    //makePokemon(name: "Jigglypuff", withThe: "jigglypuff")
    makePokemon(name: "Bellsprout", withThe: "bellsprout")
    makePokemon(name: "Bullbasaur", withThe: "bullbasaur")
    makePokemon(name: "Meowth", withThe: "meowth")
    makePokemon(name: "Snorlax", withThe: "snorlax")
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    }

//This function creates a pokemon, which is used to create multiple pokemons in the above functon, makeAllPokemon
func makePokemon(name: String, withThe imageName: String) {
    
    //Context takes access from the AppDelegate, as it cannot access data directly
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let pokemon = Pokemon(context: context)
    pokemon.name = name
    pokemon.imageFileName = imageName
    
}

//This funtions fetches the pokemons to the empty array which is created in the ViewController
func bringAllPokemon() -> [Pokemon] {
    
    //Context takes access from the AppDelegate, as it cannot access data directly
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    do {
        let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        
        if pokemons.count == 0 {
            makeAllPokemon()
            return bringAllPokemon()
        } else {
            return pokemons
        }
        
    } catch {
            print ("Error")
    }
    return []
}

//This function returns the pokemons which are caught
func getAllCaughtPokemon() -> [Pokemon] {
    
    //Context takes access from the AppDelegate, as it cannot access data directly
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "timesCaught > %d", 0)
    
    do {
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    } catch {
        print("Error")
    }
    
    return []
    
    }

//This function returns the pokemons which are uncaught
func getAllUncaughtPokemon() -> [Pokemon] {
    
    //Context takes access from the AppDelegate, as it cannot access data directly
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "timesCaught == %d", 0)
    
    do {
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    } catch {
        print("Error")
    }
    
    return []
    
}













