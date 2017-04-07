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
    
    //To move/load the game scene in the view
    override func didMove(to view: SKView) {
        
        //print("Welcome to the PokéGo Battle")
        //print(pokemon.name)
        
        
        //Background Code
        
        let battleBg = SKSpriteNode(imageNamed: "bggg")
        
        battleBg.size = self.size
        battleBg.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        battleBg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        battleBg.zPosition = -1
        self.addChild(battleBg)
        
    }
    
}
