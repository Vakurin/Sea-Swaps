//
//  CreationNode.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 13.08.17.
//  Copyright © 2017 Vakurin Maxim. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func createEnemyFish() -> SKSpriteNode {
        var enemyYellowFish = SKSpriteNode()
        let randomIndex = arc4random() % UInt32(6)
        if randomIndex == 0 {enemyYellowFish = SKSpriteNode(imageNamed: "fish_yellow")}
        else if randomIndex == 1 {enemyYellowFish = SKSpriteNode(imageNamed: "fish_blue")}
        else if randomIndex == 2 {enemyYellowFish = SKSpriteNode(imageNamed: "fish_red")}
        else if randomIndex == 3 {enemyYellowFish = SKSpriteNode(imageNamed: "fish_green")}
        else if randomIndex == 4 {enemyYellowFish = SKSpriteNode(imageNamed: "fish_pink")}
        else if randomIndex == 5 {enemyYellowFish = SKSpriteNode(imageNamed: "fish_gray")}
        //рандомный размер от 0.5 до 0.7
        let randomScale = CGFloat(arc4random() % 3 + 5) / 10
        enemyYellowFish.xScale = randomScale
        enemyYellowFish.yScale = randomScale
        //устанавливаем позицию образования рыбок
        enemyYellowFish.position.x = CGFloat(arc4random()).truncatingRemainder(dividingBy: frame.size.width)
        enemyYellowFish.position.y = frame.size.height + enemyYellowFish.size.height
        enemyYellowFish.name = "enemyFish"
        enemyYellowFish.physicsBody = SKPhysicsBody(texture: enemyYellowFish.texture!, size: enemyYellowFish.size)
        enemyYellowFish.zPosition = 1
        levelUp()
        enemyYellowFish.physicsBody?.categoryBitMask = PhysicsCategory.enemyCategory
        //c кем должен столкутся
        enemyYellowFish.physicsBody?.collisionBitMask = PhysicsCategory.fishCategory | PhysicsCategory.enemyCategory | PhysicsCategory.coinCategory
        //должно ли чтонибуль происходить при столкновении с объектом
        enemyYellowFish.physicsBody?.contactTestBitMask = PhysicsCategory.fishCategory
        enemyYellowFish.physicsBody?.velocity.dx = CGFloat(drand48() * 2 - 1) * 100
        return enemyYellowFish
    }
    
    func createSpikeFish() -> SKSpriteNode {
        let spikeFish = SKSpriteNode(imageNamed: "spikeFish")
        //устанавливаем позицию образования рыбок
        spikeFish.position.x = CGFloat(arc4random()).truncatingRemainder(dividingBy: frame.size.width)
        spikeFish.position.y = frame.size.height + spikeFish.size.height
        spikeFish.name = "spikeFish"
        spikeFish.physicsBody = SKPhysicsBody(texture: spikeFish.texture!, size: spikeFish.size)
        //spikeFish.zPosition = 1
        let moveSpikeFish = SKAction.moveBy(x: 0, y: -self.frame.size.height, duration: 3)
        let removeAction = SKAction.removeFromParent()
        let spikeFishMoveForever = SKAction.repeatForever(SKAction.sequence([moveSpikeFish, removeAction]))
        spikeFish.run(spikeFishMoveForever)
        spikeFish.physicsBody?.categoryBitMask = PhysicsCategory.enemyCategory
        //c кем должен столкутся
        spikeFish.physicsBody?.collisionBitMask = PhysicsCategory.fishCategory
        //должно ли чтонибуль происходить при столкновении с объектом
        spikeFish.physicsBody?.contactTestBitMask = PhysicsCategory.fishCategory
        animation.scaleZDirection(sprite: spikeFish)
        animation.redColorAnimation(sprite: spikeFish, animDuration: 0.5)
        levelUp()
        return spikeFish
    }
    
    func createJellyFish() -> SKSpriteNode {
        let jellyFish = SKSpriteNode(imageNamed: "jellyfish")
        //устанавливаем позицию образования рыбок
        jellyFish.position.x = CGFloat(arc4random()).truncatingRemainder(dividingBy: frame.size.width)
        jellyFish.position.y = frame.size.height + jellyFish.size.height
        jellyFish.name = "jellyFish"
        jellyFish.physicsBody = SKPhysicsBody(texture: jellyFish.texture!, size: jellyFish.size)
        let moveJellyFish = SKAction.moveBy(x: -self.frame.size.width, y: 0, duration: 2.5)
        let moveJellyFishTo = SKAction.moveTo(x: self.frame.size.width, duration: 2.5)
        //let removeAction = SKAction.removeFromParent()
        let jellyFishMoveForever = SKAction.repeatForever(SKAction.sequence([moveJellyFish,moveJellyFishTo,//removeAction
            ]))
        jellyFish.run(jellyFishMoveForever)
        jellyFish.physicsBody?.categoryBitMask = PhysicsCategory.enemyCategory
        //c кем должен столкутся
        jellyFish.physicsBody?.collisionBitMask = PhysicsCategory.fishCategory | PhysicsCategory.enemyCategory
        //должно ли чтонибуль происходить при столкновении с объектом
        jellyFish.physicsBody?.contactTestBitMask = PhysicsCategory.fishCategory
        levelUp()
        return jellyFish
    }
    
    func createSeaDevil() -> SKSpriteNode {
        let seaDevil = SKSpriteNode(imageNamed: "sea_devil")
        seaDevilTextureArray = [SKTexture(imageNamed: "sea_devil"), SKTexture(imageNamed: "sea_devil2")]
        let seaDevilRunAnimation = SKAction.animate(with: seaDevilTextureArray, timePerFrame: 0.25)
        let runSeaDevil = SKAction.repeatForever(seaDevilRunAnimation)
        seaDevil.run(runSeaDevil)
        //устанавливаем позицию образования рыбок
        seaDevil.position.x = CGFloat(arc4random()).truncatingRemainder(dividingBy: frame.size.width)
        seaDevil.position.y = frame.size.height + seaDevil.size.height
        seaDevil.name = "sea_devil"
        seaDevil.physicsBody = SKPhysicsBody(texture: seaDevil.texture!, size: seaDevil.size)
        seaDevil.physicsBody?.categoryBitMask = PhysicsCategory.enemyCategory
        //должно ли чтонибуль происходить при столкновении с объектом
        seaDevil.physicsBody?.contactTestBitMask = PhysicsCategory.fishCategory
        //animation.scaleZDirection(sprite: seaDevil)
        levelUp()
        return seaDevil
    }
    
    func createCoin() -> SKSpriteNode {
        let coin = SKSpriteNode(imageNamed: "coin.png")
        //рандомный размер от 0.5 до 0.7
        let randomScale = (CGFloat(arc4random() % 3 + 5) / 10)
        coin.xScale = randomScale
        coin.yScale = randomScale
        //устанавливаем позицию образования монеток
        coin.position.x = CGFloat(arc4random()).truncatingRemainder(dividingBy: frame.size.width)
        coin.position.y = frame.size.height + coin.size.height
        coin.name = "coin"
        coin.physicsBody = SKPhysicsBody(texture: coin.texture!, size: coin.size)
        coin.zPosition = 3
        coin.physicsBody?.categoryBitMask = PhysicsCategory.coinCategory
        //c кем должен столкутся
        coin.physicsBody?.collisionBitMask = PhysicsCategory.fishCategory | PhysicsCategory.enemyCategory | PhysicsCategory.coinCategory
        coin.physicsBody?.velocity.dx = CGFloat(drand48() * 2 - 1) * 100
        levelUp()
        return coin
    }

}
