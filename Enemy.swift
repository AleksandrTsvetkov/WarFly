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
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 221 * 0.5, height: 204 * 0.5))
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
