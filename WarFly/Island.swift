//
//  Island.swift
//  WarFly
//
//  Created by Александр Цветков on 11.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit

final class Island: SKSpriteNode, GameBackgroundSpriteable {
    static func populateSprite() -> Island {
        let islandImageName = configureName()
        let island = Island(imageNamed: islandImageName)
        island.setScale(randomScale)
        island.position = randomPoint()
        island.zPosition = 1
        island.run(rotateForRandomAngle())
        island.run(move(from: island.position))
        return island
    }
    
    static func populateSprite(at point: CGPoint) -> Island {
        let islandImageName = configureName()
        let island = Island(imageNamed: islandImageName)
        island.setScale(randomScale)
        island.position = point
        island.zPosition = 1
        island.run(rotateForRandomAngle())
        island.run(move(from: island.position))
        return island
    }
    
    fileprivate static func configureName() -> String {
        return "is\(Int.random(in: 1...4))"
    }
    
    fileprivate static var randomScale: CGFloat {
        return CGFloat.random(in: 0.1...1.0)
    }
    
    fileprivate static func rotateForRandomAngle() -> SKAction {
        let randomRotate = CGFloat.random(in: 0...360)
        return SKAction.rotate(toAngle: randomRotate * CGFloat(Double.pi / 180), duration: 0)
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 100.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: Double(duration))
    }
    
}
