//
//  Cloud.swift
//  WarFly
//
//  Created by Александр Цветков on 11.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit

final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
    static func populateSprite(at point: CGPoint?) -> Cloud {
        let cloudImageName = configureName()
        let cloud = Cloud(imageNamed: cloudImageName)
        cloud.setScale(randomScale)
        cloud.position = point ?? randomPoint()
        cloud.name = "backgroundSprite"
        cloud.zPosition = 10
        cloud.run(move(from: cloud.position))
        return cloud
    }
    
    fileprivate static func configureName() -> String {
        return "cl\(Int.random(in: 1...3))"
    }
    
    fileprivate static var randomScale: CGFloat {
        return CGFloat.random(in: 1.2...2.2)
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = randomPoint().y + 200
        let movementSpeed: CGFloat = 150.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: Double(duration))
    }
}
