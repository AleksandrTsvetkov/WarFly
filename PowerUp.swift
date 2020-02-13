//
//  PowerUp.swift
//  WarFly
//
//  Created by Александр Цветков on 12.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit

class PowerUp: SKSpriteNode {
    fileprivate let initialSize = CGSize(width: 52, height: 52)
    fileprivate let textureAtlas: SKTextureAtlas!
    fileprivate var textureNameBeginsWith = ""
    fileprivate var animationSpriteArray = [SKTexture]()
    
    init(textureAtlas: SKTextureAtlas) {
        self.textureAtlas = textureAtlas
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture1 = textureAtlas.textureNamed(textureName)
        textureNameBeginsWith = String(textureName.dropLast(6))
        super.init(texture: texture1, color: .clear, size: initialSize)
        self.name = "sprite"
        self.setScale(0.7)
        self.zPosition = 20
        let offsetX = self.frame.size.width * self.anchorPoint.x
        let offsetY = self.frame.size.height * self.anchorPoint.y
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 21 - offsetX, y: 29 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 17 - offsetX, y: 32 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 11 - offsetX, y: 29 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 11 - offsetX, y: 20 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 11 - offsetX, y: 9 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 16 - offsetX, y: 5 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 25 - offsetX, y: 8 - offsetY), transform: .identity)
        path.closeSubpath()
        self.physicsBody = SKPhysicsBody(polygonFrom: path)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.powerUp.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.player.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMovement() {
        performRotation()
        let moveForward = SKAction.moveTo(y: -100, duration: 5)
        self.run(moveForward)
    }
    
    fileprivate func performRotation() {
        for i in 1...15 {
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
