//
//  GenerationNode.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 13.08.17.
//  Copyright © 2017 Vakurin Maxim. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func timerGeneration(forDuration: TimeInterval, withRange: TimeInterval, layerNode: SKNode, actionCreate: SKAction) {
        let nodeCreationDelay = SKAction.wait(forDuration: forDuration, withRange: withRange)
        let nodeRunAction = SKAction.repeatForever(SKAction.sequence([actionCreate, nodeCreationDelay]))
        layerNode.run(nodeRunAction)
    }
    
    func generationEnemyFish() {
        let enemyYellowCreate = SKAction.run {
            ()-> Void in
            let enemyYellowCreate = self.createEnemyFish()
            self.enemyLayer.addChild(enemyYellowCreate)
        }
        timerGeneration(forDuration: 1.5 / 2.0, withRange: 0.5, layerNode: enemyLayer, actionCreate: enemyYellowCreate)
    }
    
    func generationSpikeFish() {
        let enemySpikeFishCreate = SKAction.run {
            () -> Void in
            let enemySpikeFishCreate = self.createSpikeFish()
            self.spikeFishLayer.addChild(enemySpikeFishCreate)
        }
        timerGeneration(forDuration: 15/3, withRange: 1.6, layerNode: spikeFishLayer, actionCreate: enemySpikeFishCreate)
    }
    
    func generationJellyFish() {
        let enemyJellyFishCreate = SKAction.run {
            () -> Void in
            let enemyJellyFishCreate = self.createJellyFish()
            self.jellyFishLayer.addChild(enemyJellyFishCreate)
        }
        timerGeneration(forDuration: 30.0/7.0, withRange: 0.3, layerNode: jellyFishLayer, actionCreate: enemyJellyFishCreate)
    }
    
    func generationSeaDevil() {
        let enemySeaDevilCreate = SKAction.run {
            () -> Void in
            let enemySeaDevilCreate = self.createSeaDevil()
            self.seaDevilLayer.addChild(enemySeaDevilCreate)
        }
        timerGeneration(forDuration: 40.0/13.0, withRange: 0.4, layerNode: seaDevilLayer, actionCreate: enemySeaDevilCreate)
    }
    
    func generationCoin() {
        let coinCreate = SKAction.run {
            ()-> Void in
            let coinCreate = self.createCoin()
            self.coinLayer.addChild(coinCreate)
        }
        timerGeneration(forDuration: 2.0 / 0.7, withRange: 0.8, layerNode: coinLayer, actionCreate: coinCreate)
    }
}
