//
//  Assets.swift
//  WarFly
//
//  Created by Александр Цветков on 13.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit

class Assets {
    static let shared = Assets()
    var isLoaded = false
    let yellowAmmoAtlas = SKTextureAtlas(named: "YellowAmmo")
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
    
    func preloadAssets() {
        yellowAmmoAtlas.preload {}
        enemy_1Atlas.preload {}
        enemy_2Atlas.preload {}
        greenPowerUpAtlas.preload {}
        bluePowerUpAtlas.preload {}
        playerPlaneAtlas.preload {}
    }
    
}
