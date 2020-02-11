//
//  GameScene.swift
//  WarFly
//
//  Created by Александр Цветков on 11.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    var player: SKSpriteNode!
    
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
        player = PlayerPlane.populate(at: CGPoint(x: self.size.width / 2, y: 100))
        self.addChild(player)
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            guard let data = data else { return }
            let acceleration = data.acceleration
            self.xAcceleration = CGFloat(acceleration.x * 0.7) + self.xAcceleration * 0.3
        }
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        player.position.x = xAcceleration * 50
        if player.position.x < -70 {
            player.position.x = self.size.width + 70
        } else if player.position.x > self.size.width + 70 {
            player.position.x = -70
        }
    }
    
}
