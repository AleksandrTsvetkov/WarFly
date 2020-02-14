//
//  OptionsScene.swift
//  WarFly
//
//  Created by Александр Цветков on 14.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit

class OptionsScene: ParentScene {
    override func didMove(to view: SKView) {
        setHeaderAndBackground(with: "options", andBackground: "header_background")
        
        let musicButton = ButtonNode(titled: nil, backgroundName: "music")
        musicButton.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY)
        musicButton.name = "music"
        musicButton.label.isHidden = true
        addChild(musicButton)
        
        let soundButton = ButtonNode(titled: nil, backgroundName: "sound")
        soundButton.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY)
        soundButton.name = "sound"
        soundButton.label.isHidden = true
        addChild(soundButton)
        
        let backButton = ButtonNode(titled: "back", backgroundName: "button_background")
        backButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        backButton.name = "back"
        backButton.label.name = "back"
        addChild(backButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        if node.name == "music" {
            print("music")
        } else if node.name == "back" {
            let transition = SKTransition.crossFade(withDuration: 1)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(backScene, transition: transition)
        }
    }
}
