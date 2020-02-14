//
//  HUD.swift
//  WarFly
//
//  Created by Александр Цветков on 14.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit

class HUD: SKNode {
	let scoreBackground = SKSpriteNode(imageNamed: "scores")
    var score: Int = 0 {
        didSet {
            scoreLabel.text = score.description
        }
    }
    let scoreLabel = SKLabelNode(text: "0")
    let menuButton = SKSpriteNode(imageNamed: "menu")
    let life1 = SKSpriteNode(imageNamed: "life")
    let life2 = SKSpriteNode(imageNamed: "life")
    let life3 = SKSpriteNode(imageNamed: "life")
    
    func configureUI(screenSize: CGSize) {
        scoreBackground.position = CGPoint(x: scoreBackground.size.width / 2 - 5, y: screenSize.height - scoreBackground.size.height / 2)
        scoreBackground.zPosition = 99
        scoreBackground.setScale(0.8)
        self.addChild(scoreBackground)
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: 75, y: 3)
        scoreLabel.zPosition = 100
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 30
        scoreBackground.addChild(scoreLabel)
        menuButton.position = CGPoint(x: 5 + menuButton.size.width / 2, y: 5 + menuButton.size.height / 2)
        menuButton.setScale(0.7)
        menuButton.zPosition = 100
        menuButton.name = "pause"
        self.addChild(menuButton)
        let lifes = [life1, life2, life3]
        for (index, life) in lifes.enumerated() {
            life.position = CGPoint(x: screenSize.width - CGFloat(index + 1) * (life.size.width + 3), y: 20)
            life.zPosition = 100
            life.anchorPoint  = CGPoint(x: 0, y: 0)
            self.addChild(life)
        }
    }
    
}
