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
        let offsetX = self.frame.size.width * self.anchorPoint.x
        let offsetY = self.frame.size.height * self.anchorPoint.y
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 49 - offsetX, y: 112 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 43 - offsetX, y: 107 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 42 - offsetX, y: 103 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 42 - offsetX, y: 100 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 42 - offsetX, y: 95 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 42 - offsetX, y: 91 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 42 - offsetX, y: 88 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 42 - offsetX, y: 84 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 42 - offsetX, y: 79 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 38 - offsetX, y: 77 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 34 - offsetX, y: 73 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 34 - offsetX, y: 67 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 38 - offsetX, y: 57 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 38 - offsetX, y: 43 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 39 - offsetX, y: 34 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 44 - offsetX, y: 27 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 50 - offsetX, y: 28 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 53 - offsetX, y: 31 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 56 - offsetX, y: 48 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 62 - offsetX, y: 52 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 60 - offsetX, y: 63 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 63 - offsetX, y: 78 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 57 - offsetX, y: 87 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 56 - offsetX, y: 93 - offsetY), transform: .identity)
        path.addLine(to: CGPoint(x: 56 - offsetX, y: 105 - offsetY), transform: .identity)
        path.closeSubpath()
        self.physicsBody = SKPhysicsBody(polygonFrom: path)
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
