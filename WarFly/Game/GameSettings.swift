//
//  GameSettings.swift
//  WarFly
//
//  Created by Александр Цветков on 14.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class GameSettings: NSObject {
    let ud = UserDefaults.standard
    var isMusic = true
    var isSound = true
    let musicKey = "music"
    let soundKey = "sound"
    var highScore: [Int] = []
    var currentScore = 0
    let highScoreKey = "highScore"
    
    override init() {
        super.init()
        loadGameSettings()
        loadScores()
    }
    
    func saveScore() {
        highScore.append(currentScore)
        highScore = highScore.sorted(by: >)
        highScore = Array(highScore.prefix(3))
        ud.set(highScore, forKey: highScoreKey)
        ud.synchronize()
    }
    
    func loadScores() {
        guard ud.value(forKey: highScoreKey) != nil else { return }
        highScore = ud.value(forKey: highScoreKey) as! [Int]
    }
    
    func saveGameSettings() {
        ud.set(isMusic, forKey: musicKey)
        ud.set(isSound, forKey: soundKey)
    }
    
    func loadGameSettings() {
        guard ud.value(forKey: musicKey) != nil && ud.value(forKey: soundKey) != nil else { return }
        isMusic = ud.bool(forKey: musicKey)
        isSound = ud.bool(forKey: soundKey)
    }
    
}
