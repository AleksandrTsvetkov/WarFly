//
//  ParentScene.swift
//  WarFly
//
//  Created by Александр Цветков on 14.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit

class ParentScene: SKScene {
    
    let sceneManager = SceneManager.shared
    var backScene: SKScene?
    
    func setHeaderAndBackground(with name: String?, andBackground backgroundName: String) {
        let header = ButtonNode(titled: name, backgroundName: backgroundName)
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        self.addChild(header)
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1)
    }
}
