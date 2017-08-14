//
//  LevelUp.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 13.08.17.
//  Copyright © 2017 Vakurin Maxim. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func speedLayer(enemy: CGFloat, coin: CGFloat, jellyFish: CGFloat, spikeFish: CGFloat, seaDevil: CGFloat) {
        enemyLayer.speed = enemy
        coinLayer.speed = coin
        jellyFishLayer.speed = jellyFish
        spikeFishLayer.speed = spikeFish
        seaDevilLayer.speed = seaDevil
    }
    
    func levelUp() {
        if 0 <= gameSettings.currentScore && gameSettings.currentScore <= 50 {
            speedLayer(enemy: 1.0, coin: 0.7, jellyFish: 1.0, spikeFish: 0.5, seaDevil: 1)
        } else if 50 < gameSettings.currentScore && gameSettings.currentScore <= 100 {
            speedLayer(enemy: 1.1, coin: 0.8, jellyFish: 1.05, spikeFish: 1, seaDevil: 1)
        } else if 100 < gameSettings.currentScore && gameSettings.currentScore <= 150{
            speedLayer(enemy: 1.2, coin: 0.9, jellyFish: 1.1, spikeFish: 1, seaDevil: 1)
        } else if 150 < gameSettings.currentScore && gameSettings.currentScore <= 200 {
            speedLayer(enemy: 1.3, coin: 1.0, jellyFish: 1.1, spikeFish: 1, seaDevil: 1)
        } else if 200 < gameSettings.currentScore && gameSettings.currentScore <= 500 {
            speedLayer(enemy: 1.4, coin: 1.1, jellyFish: 1, spikeFish: 1, seaDevil: 1)
        } else if 500 < gameSettings.currentScore && gameSettings.currentScore <= 1000 {
            speedLayer(enemy: 1.5, coin: 1.2, jellyFish: 1, spikeFish: 1, seaDevil: 1)
        }
    }
    
    func add(points: Int) {
        gameSettings.currentScore += points
        gameDelegate?.gameDelegateDidUpdate(score: self.gameSettings.currentScore)
        
    }
    
    func addMoney(_ money: Int) {
        gameSettings.money += money
        gameDelegate?.gameDelegateMoney(score: gameSettings.money)
    }

}
