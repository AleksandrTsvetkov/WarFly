//
//  GameScene.swift
//  WarFly
//
//  Created by Александр Цветков on 11.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var player: PlayerPlane!
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        configureStartScene()
        spawnClouds()
        spawnIslands()
        DispatchQueue.main.asyncAfter(deadline: .now() + .nanoseconds(1)) { [unowned self] in
            self.player.performFly()
        }
        spawnPowerUp()
        spawnEnemies()
    }
    
    fileprivate func spawnPowerUp() {
        let spawnAction = SKAction.run {
            let randomNumber = Int.random(in: 0...1)
            let powerUp = randomNumber == 1 ? BluePowerUp() : GreenPowerUp()
            let randomPositionX = CGFloat.random(in: 53...self.size.width - 53)
            powerUp.position = CGPoint(x: randomPositionX, y: self.size.height + 100)
            powerUp.startMovement()
            self.addChild(powerUp)
        }
        let waitAction = SKAction.wait(forDuration: Double.random(in: 10...20))
        let sequence = SKAction.sequence([waitAction, spawnAction])
        let repeatingSequence = SKAction.repeatForever(sequence)
        self.run(repeatingSequence)
    }
    
    fileprivate func spawnEnemies() {
        let waitAction = SKAction.wait(forDuration: 3)
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies()
        }
        self.run(SKAction.repeatForever(SKAction.sequence([spawnSpiralAction, waitAction])))
    }
    
    fileprivate func spawnSpiralOfEnemies() {
        let enemyTextureAtlas1 = Assets.shared.enemy_1Atlas
        let enemyTextureAtlas2 = Assets.shared.enemy_2Atlas
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) { [unowned self] in
            let randomNumber = Int.random(in: 0...1)
            let arrayOfAtlases = [enemyTextureAtlas1, enemyTextureAtlas2]
            let textureAtlas = arrayOfAtlases[randomNumber]
            let waitAction = SKAction.wait(forDuration: 1.0)
            let spawnEnemy = SKAction.run { [unowned self] in
                let textureName = textureAtlas.textureNames.sorted()[12]
                let texture = textureAtlas.textureNamed(textureName)
                let enemy = Enemy(enemyTexture: texture)
                enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 110)
                self.addChild(enemy)
                enemy.flySpiral()
            }
            let spawnAction = SKAction.sequence([spawnEnemy, waitAction])
            let repeatAction = SKAction.repeat(spawnAction, count: 3)
            self.run(repeatAction)
        }
    }
    
    fileprivate func spawnClouds() {
        let spawnCloudWait = SKAction.wait(forDuration: 1)
        let spawnCloudAction = SKAction.run {
            let cloud = Cloud.populateSprite(at: nil)
            self.addChild(cloud)
        }
        let spawnCloudSequence = SKAction.sequence([spawnCloudWait, spawnCloudAction])
        let spawnCloudForever = SKAction.repeatForever(spawnCloudSequence)
        run(spawnCloudForever)
    }
    
    fileprivate func spawnIslands() {
        let spawnIslandWait = SKAction.wait(forDuration: 2)
        let spawnIslandAction = SKAction.run {
            let island = Island.populateSprite(at: nil)
            self.addChild(island)
        }
        let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence)
        run(spawnIslandForever)
    }
    
    fileprivate func configureStartScene() {
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        let screen = UIScreen.main.bounds
        
        let island1 = Island.populateSprite(at: CGPoint(x: 100, y: 200))
        self.addChild(island1)
        
        let island2 = Island.populateSprite(at: CGPoint(x: self.size.width - 100, y: self.size.height - 200))
        self.addChild(island2)
        
        player = PlayerPlane.populate(at: CGPoint(x: screen.size.width / 2, y: 60))
        self.addChild(player)
    }
    
    override func didSimulatePhysics() {
        player.checkPosition()
        enumerateChildNodes(withName: "sprite") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        enumerateChildNodes(withName: "shotSprite") { (node, stop) in
            if node.position.y >= self.size.height + 90 {
                node.removeFromParent()
            }
        }
    }
    
    fileprivate func playerFire() {
        let shot = YellowShot()
        shot.position = player.position
        shot.startMovement()
        self.addChild(shot)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerFire()
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        switch contactCategory {
            case [.player, .enemy]:
            print("Player vs enemy")
            case [.shot, .enemy]:
            print("Shot vs enemy")
            case [.player, .powerUp]:
            print("Player vs powerUp")
            default:
            preconditionFailure("Unable to detect collision category")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
