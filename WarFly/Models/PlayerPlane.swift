//
//  PlayerPlane.swift
//  WarFly
//
//  Created by Александр Цветков on 11.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit
import CoreMotion

class PlayerPlane: SKSpriteNode {
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    static func populate(at point: CGPoint) -> PlayerPlane {
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 20
        return playerPlane
    }
    
    func performFly() {
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
    
    func checkPosition() {
        self.position.x = xAcceleration * 50
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
}
