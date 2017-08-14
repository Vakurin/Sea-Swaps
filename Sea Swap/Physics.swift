//
//  Physics.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 18.03.17.
//  Copyright © 2017 Максим Вакурин. All rights reserved.
//

import Foundation
import SpriteKit

struct PhysicsCategory {
    static let fishCategory:  UInt32 = 0x1 << 0
    static let enemyCategory: UInt32 = 0x1 << 1
    static let coinCategory:  UInt32 = 0x1 << 3
}

extension GameScene {
    
    override func didSimulatePhysics() {
        //выбирает все node с именем и удаляет их
        func remoteChildNode(name: String, layer: SKNode!) {
            layer.enumerateChildNodes(withName: name) { (node, _) in
                if node.position.y < UIScreen.main.bounds.minY + UIScreen.main.bounds.minY / 6 {
                    node.removeFromParent()
                    self.add(points: 1)
                }
            }
        }
        remoteChildNode(name: "enemyFish", layer: enemyLayer)
        remoteChildNode(name: "jellyFish", layer: jellyFishLayer)
        remoteChildNode(name: "coin", layer: coinLayer)
        remoteChildNode(name: "spikeFish", layer: spikeFishLayer)
        remoteChildNode(name: "sea_devil", layer: seaDevilLayer)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.coinCategory || contact.bodyB.categoryBitMask == PhysicsCategory.coinCategory {
            let coinNode = contact.bodyA.categoryBitMask == PhysicsCategory.coinCategory ? contact.bodyA.node: contact.bodyB.node
            sceneSound(scene: scene as! GameScene, nameOfSound: "pickCoin.mp3")
            self.addMoney(1)
            //удаляем монетки
            coinNode?.removeFromParent()
        }
        if contact.bodyA.categoryBitMask == PhysicsCategory.enemyCategory || contact.bodyB.categoryBitMask == PhysicsCategory.enemyCategory {
            
            if !gameOver {
                self.pauseTheGame()
                
                let fadeOutAction = SKAction.fadeOut(withDuration: 0.1)
                fadeOutAction.timingMode = SKActionTimingMode.easeOut
                
                let fadeInAction = SKAction.fadeIn(withDuration: 0.1)
                fadeInAction.timingMode = SKActionTimingMode.easeOut
                let blinkRepeatAction = SKAction.repeat(SKAction.sequence([fadeOutAction,fadeInAction]), count: 3)
                
                let delayAction = SKAction.wait(forDuration: 0.2)
                
                let gameOverAction = SKAction.run({
                    () -> Void in
                    self.gameSettings.recordScores(score: self.gameSettings.currentScore)
                    self.gameDelegate?.gameDelegateGameOver(score: self.gameSettings.currentScore)
                })
                
                let gameOverSequence = SKAction.sequence([blinkRepeatAction, delayAction, gameOverAction])
                fishLayer.run(gameOverSequence)
                
                gameOver = true
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
