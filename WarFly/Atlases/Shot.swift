//
//  Shot.swift
//  WarFly
//
//  Created by Александр Цветков on 13.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit

class Shot: SKSpriteNode {
    fileprivate let screenSize = UIScreen.main.bounds
    fileprivate let initialSize = CGSize(width: 187, height: 237)
    fileprivate let textureAtlas: SKTextureAtlas!
    fileprivate var textureNameBeginsWith = ""
    fileprivate var animationSpriteArray = [SKTexture]()
    
    init(textureAtlas: SKTextureAtlas) {
        self.textureAtlas = textureAtlas
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture1 = textureAtlas.textureNamed(textureName)
        textureNameBeginsWith = String(textureName.dropLast(6))
        super.init(texture: texture1, color: .clear, size: initialSize)
        self.name = "shotSprite"
        self.setScale(0.3)
        self.zPosition = 30
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 187 * 0.3, height: 237 * 0.3))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = BitMaskCategory.shot.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMovement() {
        performRotation()
        let moveForward = SKAction.moveTo(y: screenSize.height + 100, duration: 1)
        self.run(moveForward)
    }
    
    fileprivate func performRotation() {
        for i in 1...32 {
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: textureNameBeginsWith + number.description))
        }
        SKTexture.preload(animationSpriteArray) {
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
        
    }
}