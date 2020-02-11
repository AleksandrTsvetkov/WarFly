//
//  GameScene.swift
//  WarFly
//
//  Created by Александр Цветков on 11.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        let screen = UIScreen.main.bounds
        for _ in 1...5 {
            let x: CGFloat = CGFloat.random(in: 0...screen.size.width)
            let y: CGFloat = CGFloat.random(in: 0...screen.size.height)
            let island = Island.populateSprite(at: CGPoint(x: x, y: y))
            let cloud = Cloud.populateSprite(at: CGPoint(x: x, y: y))
            self.addChild(island)
            self.addChild(cloud)
        }
    }
}
