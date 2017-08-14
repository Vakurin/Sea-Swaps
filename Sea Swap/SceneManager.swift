//
//  GameManager.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 13.08.17.
//  Copyright © 2017 Vakurin Maxim. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func removeLayer(_ layerNode: SKNode) {
        if layerNode.position.y >= UIScreen.main.bounds.size.height {
            layerNode.removeAllChildren()
        }
    }
    
    func pauseTheGame() {
        gameIsPaused = true
        self.bubbleLayer.isPaused = true
        self.jellyFishLayer.isPaused = true
        self.coinLayer.isPaused = true
        self.enemyLayer.isPaused = true
        self.spikeFishLayer.isPaused = true
        self.seaDevilLayer.isPaused = true
        speedLayer(enemy: 0, coin: 0, jellyFish: 0, spikeFish: 0, seaDevil: 0)
        removeLayer(enemyLayer)
        removeLayer(jellyFishLayer)
        removeLayer(spikeFishLayer)
        removeLayer(seaDevilLayer)
        removeLayer(coinLayer)
        physicsWorld.speed = 0
        //musicOnOrOff()
    }
    
    func unpauseTheGame() {
        gameIsPaused = false
        self.coinLayer.isPaused = false
        self.bubbleLayer.isPaused = false
        self.enemyLayer.isPaused = false
        self.spikeFishLayer.isPaused = false
        self.jellyFishLayer.isPaused = false
        self.seaDevilLayer.isPaused = false
        levelUp()
        physicsWorld.speed = 1
        //musicOnOrOff()
    }
    
    func resetTheGame() {
        gameSettings.reset()
        gameDelegate?.gameDelegateReset()
        updateBackground()
        levelUp()
        musicOnOrOff()
        jellyFishLayer.removeAllChildren()
        coinLayer.removeAllChildren()
        enemyLayer.removeAllChildren()
        spikeFishLayer.removeAllChildren()
        seaDevilLayer.removeAllChildren()
        fishLayer.position = CGPoint(x: frame.midX, y: frame.height / 4)
        gameOver = false
        self.unpauseTheGame()
    }
    
    func continueTheGame() {
        gameSettings.continueReset()
        gameDelegate?.gameDelegateReset()
        jellyFishLayer.removeAllChildren()
        coinLayer.removeAllChildren()
        enemyLayer.removeAllChildren()
        spikeFishLayer.removeAllChildren()
        seaDevilLayer.removeAllChildren()
        fishLayer.position = CGPoint(x: frame.midX, y: frame.height / 4)
        levelUp()
        gameOver = false
        self.unpauseTheGame()
    }
    
    func updateBackground() {
        let backRandom = arc4random() % UInt32(10)
        if backRandom == 0 {background = SKSpriteNode(imageNamed: "background_1")}
        else if backRandom == 1 {background = SKSpriteNode(imageNamed: "background_2")}
        else if backRandom == 2 {background = SKSpriteNode(imageNamed: "background_3")}
        else if backRandom == 3 {background = SKSpriteNode(imageNamed: "background_4")}
        else if backRandom == 4 {background = SKSpriteNode(imageNamed: "background_5")}
        else if backRandom == 5 {background = SKSpriteNode(imageNamed: "background_6")}
        else if backRandom == 6 {background = SKSpriteNode(imageNamed: "background_7")}
        else if backRandom == 7 {background = SKSpriteNode(imageNamed: "background_8")}
        else if backRandom == 8 {background = SKSpriteNode(imageNamed: "background_9")}
        else if backRandom == 9 {background = SKSpriteNode(imageNamed: "background10")}
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        background.position = CGPoint(x: width / 2, y: height / 2)
        background.size = CGSize(width: width + 8, height: height + 12)
        background.zPosition = -1
        addChild(background)
    }

}
