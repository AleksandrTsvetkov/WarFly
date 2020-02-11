//
//  Cloud.swift
//  WarFly
//
//  Created by Александр Цветков on 11.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit

protocol GameBackgroundSpriteable {
    static func populateSprite(at point: CGPoint) -> Self
}

final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
    static func populateSprite(at point: CGPoint) -> Cloud {
        let cloudImageName = configureName()
        let cloud = Cloud(imageNamed: cloudImageName)
        cloud.setScale(randomScale)
        cloud.position = point
        cloud.zPosition = 10
        cloud.run(move(from: point))
        return cloud
    }
    
    fileprivate static func configureName() -> String {
        return "cl\(Int.random(in: 1...3))"
    }
    
    fileprivate static var randomScale: CGFloat {
        return CGFloat.random(in: 1.5...2.5)
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 15.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: Double(duration))
    }
}
