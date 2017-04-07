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
    
    
    //Other Variables
    var startCount = false
    var maxTime = 20
    var myTime = 20
    var pokemonCaught = false
    
    
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
        
        
        self.perform(#selector(setupPokemon), with: nil, afterDelay: 2.0)
        self.perform(#selector(setupPokeball), with: nil, afterDelay: 2.0)
        
        
        //Body physics setup
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = kEdgeCategory
        
        self.physicsWorld.contactDelegate = self
        
        
        self.addChild(battleBg)
        
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
        
        
        self.addChild(pokemonSprite)
        
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
        
        
        //Setup pokeball physics
        self.pokeballSprite.physicsBody = SKPhysicsBody(circleOfRadius: self.pokeballSprite.frame.size.width/2)
        self.pokeballSprite.physicsBody?.affectedByGravity = true
        self.pokeballSprite.physicsBody?.isDynamic = true
        self.pokeballSprite.physicsBody?.mass = 0.5
        
        
        //Setup bitmasks of pokeball
        self.pokeballSprite.physicsBody?.categoryBitMask = kPokeballCategory
        self.pokeballSprite.physicsBody?.contactTestBitMask = kPokemonCategory
        self.pokeballSprite.physicsBody?.collisionBitMask = kPokemonCategory | kEdgeCategory
        
        self.addChild(pokeballSprite)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let location = touch?.location(in: self)
        
        if self.pokeballSprite.frame.contains(location!) {
            
            self.canThroughPokeball = true
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if canThroughPokeball {
            let touch = touches.first
            let location = touch?.location(in: self)
            self.touchPoint = location!
            if self.canThroughPokeball {
                throwPokeball()
            }
        
        }
        
    }
    
    func throwPokeball() {
        
        self.canThroughPokeball = false
        let dt : CGFloat = 1.0/50
        let distance = CGVector(dx: self.touchPoint.x - self.pokeballSprite.position.x, dy: self.touchPoint.y - self.pokeballSprite.position.y)
        let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
        self.pokeballSprite.physicsBody?.velocity = velocity
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask {
        case kPokemonCategory | kPokeballCategory :
            print("Pokemon has been caught")
            self.pokemonCaught = true
            endgame()
        default :
            return
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        
    }
    
    
    func endgame() {
        self.pokeballSprite.removeFromParent()
        self.pokemonSprite.removeFromParent()
        
        if pokemonCaught {
            
            self.makeMessageWith(imageName: "gotcha")
            self.pokemon.timesCaught += 1
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        } else {
            
            self.makeMessageWith(imageName: "footprints")
        
        }
        
        self.perform(#selector(endbattle), with: nil, afterDelay: 3.0)
        
    }
    
    func endbattle() {
        
        NotificationCenter.default.post(name: NSNotification.Name("CloseBattle"), object: nil)
        
    }
    
    func makeMessageWith(imageName : String) {
        let message = SKSpriteNode (imageNamed: imageName)
        message.size = CGSize(width: 150, height: 150)
        message.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        message.run(SKAction.sequence([SKAction.wait(forDuration: 2.0), SKAction.removeFromParent()]))
        
        self.addChild(message)
    }
    
}














