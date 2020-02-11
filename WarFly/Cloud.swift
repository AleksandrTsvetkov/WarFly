//
//  Cloud.swift
//  WarFly
//
//  Created by Александр Цветков on 11.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit

protocol GameBackgroundSpriteable {
    static func populateSprite() -> Self
    static func randomPoint() -> CGPoint
}

extension GameBackgroundSpriteable {
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let x: CGFloat = CGFloat.random(in: 0...screen.size.width)
        let y: CGFloat = CGFloat.random(in: screen.size.height + 100...screen.size.height + 200)
        return CGPoint(x: x, y: y)
    }
}

final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
    static func populateSprite() -> Cloud {
        let cloudImageName = configureName()
        let cloud = Cloud(imageNamed: cloudImageName)
        cloud.setScale(randomScale)
        cloud.position = randomPoint()
        cloud.zPosition = 10
        cloud.run(move(from: cloud.position))
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
        let moveDistance = randomPoint().y + 200
        let movementSpeed: CGFloat = 150.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: Double(duration))
    }
}
