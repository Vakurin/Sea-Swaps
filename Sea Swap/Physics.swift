//
//  Physics.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 18.03.17.
//  Copyright © 2017 Максим Вакурин. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    override func didSimulatePhysics() {
        //выбирает все ноуды с именем и удаляет их
        
        
        enemyLayer.enumerateChildNodes(withName: "enemyYellowFish") { (enemyYellowFish:SKNode, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            if enemyYellowFish.position.y < 0 {
                enemyYellowFish.removeFromParent()
                self.add(points: 1)
            }
        }
        jellyFishLayer.enumerateChildNodes(withName: "jellyFish") { (jellyFish: SKNode, stop: UnsafeMutablePointer<ObjCBool>)-> Void in
            if jellyFish.position.y < 0{
                jellyFish.removeFromParent()
                self.add(points: 1)
            }
        }
        coinLayar.enumerateChildNodes(withName: "coin") { (coin :SKNode, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            if coin.position.y < 0 {
                coin.removeFromParent()
            }
        }
       spikeFishLayer.enumerateChildNodes(withName: "sea_devil") { (spikeFish :SKNode, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            if spikeFish.position.y < 0 {
                spikeFish.removeFromParent()
                self.add(points: 1)
            }
        }
        seaDevilLayer.enumerateChildNodes(withName: "spikeFish") { (sea_devil :SKNode, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            if sea_devil.position.y < 0 {
                sea_devil.removeFromParent()
                self.add(points: 1)
            }
        }

        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == coinCategory || contact.bodyB.categoryBitMask == coinCategory {
            let coinNode = contact.bodyA.categoryBitMask == coinCategory ? contact.bodyA.node: contact.bodyB.node
            if sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("pickCoin.mp3", waitForCompletion: true)
                run(hitSoundAction)
            }
            self.addd(money: 1)
            //удаляем монетки
            coinNode?.removeFromParent()
        }
        if contact.bodyA.categoryBitMask == enemyFishCategory || contact.bodyB.categoryBitMask == enemyFishCategory || contact.bodyA.categoryBitMask == jellyFishCategory || contact.bodyB.categoryBitMask == jellyFishCategory || contact.bodyA.categoryBitMask == spikeFishCategory || contact.bodyB.categoryBitMask == spikeFishCategory || contact.bodyA.categoryBitMask == seaDevilCategory || contact.bodyB.categoryBitMask == seaDevilCategory {
            
            if !gameOver {
                self.pauseTheGame()
                let fadeOutAction = SKAction.fadeOut(withDuration: 0.1)
                fadeOutAction.timingMode = SKActionTimingMode.easeOut
                
                let fadeInAction = SKAction.fadeIn(withDuration: 0.1)
                fadeInAction.timingMode = SKActionTimingMode.easeOut
                
                let blinkAciton = SKAction.sequence([fadeOutAction,fadeInAction])
                let blinkRepeatAction = SKAction.repeat(blinkAciton, count: 3)
                
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
