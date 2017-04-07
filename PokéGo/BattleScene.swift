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
    
    //Define constants
    let kPokemonSize = CGSize(width: 100, height: 100)
    let kPokeballSize = CGSize(width: 50, height: 50)
    
    
    //Define BitCategories
    let kPokeballCategory : UInt32 = 0x1 << 0
    let kPokemonCategory : UInt32 = 0x1 << 1
    let kEdgeCategory : UInt32 = 0x1 << 2
    
    
    //Physics variable setup
    var velocity : CGPoint = CGPoint.zero
    var touchPoint : CGPoint = CGPoint()
    var canThroughPokeball : Bool = false
    
    
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
        
        //Pokemon physics
        self.pokemonSprite.physicsBody = SKPhysicsBody(rectangleOf: kPokemonSize)
        self.pokemonSprite.physicsBody?.isDynamic = false
        self.pokemonSprite.physicsBody?.affectedByGravity = false
        self.pokemonSprite.physicsBody?.mass = 5.0
        
        
        //Movements of the pokemon
        
        let moveRight = SKAction.moveBy(x: 100, y: 0, duration: 3.0)
        //A sequence for movement of the pokemon
        let sequence = SKAction.sequence([moveRight, moveRight.reversed(), moveRight.reversed(), moveRight])
        //To keep the movement of pokemon forever
        self.pokemonSprite.run(SKAction.repeatForever(sequence))
        
        //Bitmasks
        self.pokemonSprite.physicsBody?.categoryBitMask = kPokemonCategory
        self.pokemonSprite.physicsBody?.collisionBitMask = kEdgeCategory
        self.pokemonSprite.physicsBody?.contactTestBitMask = kPokeballCategory
        
        
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
        
        //Setup pokeball physics
        self.pokeballSprite.physicsBody = SKPhysicsBody(circleOfRadius: self.pokeballSprite.frame.size.width/2)
        self.pokeballSprite.physicsBody?.affectedByGravity = true
        self.pokeballSprite.physicsBody?.isDynamic = true
        self.pokeballSprite.physicsBody?.mass = 0.5
        
        
        //Setup bitmasks of pokeball
        self.pokeballSprite.physicsBody?.categoryBitMask = kPokeballCategory
        self.pokeballSprite.physicsBody?.contactTestBitMask = kPokemonCategory
        self.pokeballSprite.physicsBody?.collisionBitMask = kPokemonCategory | kEdgeCategory
        
        
    }
    
}














