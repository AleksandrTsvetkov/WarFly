//
//  Enemy.swift
//  WarFly
//
//  Created by Александр Цветков on 12.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {
    static var textureAtlas: SKTextureAtlas?
    var enemyTexture: SKTexture!
    
    init(enemyTexture: SKTexture) {
        let texture1 = enemyTexture
        super.init(texture: texture1, color: .clear, size: CGSize(width: 221, height: 204))
        self.xScale = 0.5
        self.yScale = -0.5
        self.zPosition = 20
        self.name = "sprite"
        let offsetX = self.frame.size.width * self.anchorPoint.x
        let offsetY = self.frame.size.height * self.anchorPoint.y
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 59 - offsetX, y: 96 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 50 - offsetX, y: 96 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 48 - offsetX, y: 84 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 31 - offsetX, y: 80 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 7 - offsetX, y: 70 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 7 - offsetX, y: 67 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 46 - offsetX, y: 50 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 52 - offsetX, y: 26 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 40 - offsetX, y: 18 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 40 - offsetX, y: 10 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 54 - offsetX, y: 5 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 71 - offsetX, y: 10 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 72 - offsetX, y: 19 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 61 - offsetX, y: 24 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 64 - offsetX, y: 50 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 103 - offsetX, y: 69 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 67 - offsetX, y: 83 - offsetY), transform: .identity)
        path.closeSubpath()
        self.physicsBody = SKPhysicsBody(polygonFrom: path)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.player.rawValue | BitMaskCategory.shot.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue | BitMaskCategory.shot.rawValue
    }
    
    func flySpiral() {
        let moveLeft = SKAction.moveTo(x: 50, duration: 3)
        moveLeft.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: UIScreen.main.bounds.width - 50, duration: 3)
        moveRight.timingMode = .easeInEaseOut
        let randomNumber = Int.random(in: 0...1)
        let asideMovementSequence = randomNumber ==
            EnemyDirection.left.rawValue
            ? SKAction.sequence([moveLeft, moveRight]) :
            SKAction.sequence([moveRight, moveLeft])
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        let forwardMovement = SKAction.moveTo(y: -110, duration: 5)
        let groupMovement = SKAction.group([foreverAsideMovement, forwardMovement])
        self.run(groupMovement)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum EnemyDirection: Int {
    case left = 0
    case right = 1
}
