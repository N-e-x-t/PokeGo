//
//  BattleScene.swift
//  PokéGo
//
//  Created by Jigar Parekh on 07/04/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit
import SpriteKit

class BattleScene : SKScene, SKPhysicsContactDelegate {
    
    var pokemon : Pokemon!
    
    var pokemonSprite : SKSpriteNode!
    var pokeballSprite : SKSpriteNode!
    
    //define constants
    let kPokemonSize = CGSize(width: 100, height: 100)
    let kPokeballSize = CGSize(width: 50, height: 50)
    
    //To move/load the game scene in the view
    override func didMove(to view: SKView) {
        
        //print("Welcome to the PokéGo Battle")
        //print(pokemon.name)
        
        
        //Background Code
        
        let battleBg = SKSpriteNode(imageNamed: "bggg")
        //Size of background image
        battleBg.size = self.size
        //Position of background image
        battleBg.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        battleBg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        battleBg.zPosition = -1
        self.addChild(battleBg)
        
        self.perform(#selector(setupPokemon), with: nil, afterDelay: 2.0)
        self.perform(#selector(setupPokeball), with: nil, afterDelay: 2.0)
        
    }
    
    //Pokemon code
    
    func setupPokemon() {
        self.pokemonSprite = SKSpriteNode(imageNamed: pokemon.imageFileName!)
        //Size of pokemon from the defined constants
        self.pokemonSprite.size = kPokemonSize
        //Positioning the Pokemon
        self.pokemonSprite.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        //zPosition = 1 states that it is above the background image
        self.pokemonSprite.zPosition = 1
        
        self.addChild(pokemonSprite)
        
        
      //Movements of the pokemon
        
        let moveRight = SKAction.moveBy(x: 100, y: 0, duration: 3.0)
        //A sequence for movement of the pokemon
        let sequence = SKAction.sequence([moveRight, moveRight.reversed(), moveRight.reversed(), moveRight])
        //To keep the movement of pokemon forever
        self.pokemonSprite.run(SKAction.repeatForever(sequence))
        
    }
    
    
    //Pokeball code
    
    func setupPokeball()  {
        self.pokeballSprite = SKSpriteNode(imageNamed: "pokeball")
        //Size of pokeball from the defined constants
        self.pokeballSprite.size = kPokeballSize
        //Positioning the Pokeball
        self.pokeballSprite.position = CGPoint(x: self.size.width/2, y: 50)
        //zPosition = 1 states that it is above the background image
        self.pokeballSprite.zPosition = 1
        
        self.addChild(pokeballSprite)
    }
    
}














