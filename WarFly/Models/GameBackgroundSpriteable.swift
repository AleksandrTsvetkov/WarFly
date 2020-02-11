//
//  GameBackgroundSpriteable.swift
//  WarFly
//
//  Created by Александр Цветков on 11.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit

protocol GameBackgroundSpriteable {
    static func populateSprite(at point: CGPoint?) -> Self
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
