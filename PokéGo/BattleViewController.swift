//
//  BattleViewController.swift
//  PokéGo
//
//  Created by Jigar Parekh on 07/04/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit
import SpriteKit

class BattleViewController: UIViewController {
    
    var pokemon : Pokemon!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        //Created a constant which calls the BattleScene object and sets the size of the view
        let scene = BattleScene(size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        //Making the SKView
        self.view = SKView()
        
        let skView = self.view as! SKView
        
        //To remove the FPS and NodeCount from the view
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        
        //To set the order of the elements on the view
        skView.ignoresSiblingOrder = false
        
        //To get the pokemon from the ViewController
        scene.pokemon = pokemon
        
        //To scale the view
        scene.scaleMode = .aspectFit
        
        //Loading the BattleScene to the view
        skView.presentScene(scene)
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
