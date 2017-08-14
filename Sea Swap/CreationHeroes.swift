//
//  CreateHeroes.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 13.08.17.
//  Copyright © 2017 Vakurin Maxim. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func createFish() {
        
        switch rawValue {
        
        case 1:
            self.fish = SKSpriteNode(imageNamed: "turtle")
            self.fishTextureArray = [SKTexture(imageNamed: "turtle.png"), SKTexture(imageNamed: "turtle2.png"), SKTexture(imageNamed: "turtle3.png"), SKTexture(imageNamed: "turtle4.png")]
            let fishRunAnimation = SKAction.animate(with: self.fishTextureArray, timePerFrame: 0.25)
            let runFish = SKAction.repeatForever(fishRunAnimation)
            self.fish.run(runFish)
            
        case 2:
            self.fish = SKSpriteNode(imageNamed: "water_horse")
            self.fishTextureArray = [SKTexture(imageNamed: "water_horse"), SKTexture(imageNamed: "water_horse2")]
            let fishRunAnimation = SKAction.animate(with: self.fishTextureArray, timePerFrame: 0.7)
            let runFish = SKAction.repeatForever(fishRunAnimation)
            self.fish.run(runFish)
            
        case 3:
            self.fish = SKSpriteNode(imageNamed: "octopus")
            self.fishTextureArray = [SKTexture(imageNamed: "octopus"), SKTexture(imageNamed: "octopus02")]
            let fishRunAnimation = SKAction.animate(with: self.fishTextureArray, timePerFrame: 0.7)
            let runFish = SKAction.repeatForever(fishRunAnimation)
            self.fish.run(runFish)
            
        case 4:
            self.fish = SKSpriteNode(imageNamed: "submarine_1")
            
        case 5:
            self.fish = SKSpriteNode(imageNamed: "whale")
            self.fishTextureArray = [SKTexture(imageNamed: "whale"), SKTexture(imageNamed: "whale01"),SKTexture(imageNamed: "whale"),SKTexture(imageNamed: "whale02")]
            let fishRunAnimation = SKAction.animate(with: self.fishTextureArray, timePerFrame: 0.25)
            let runFish = SKAction.repeatForever(fishRunAnimation)
            self.fish.run(runFish)
            
        case 6:
            self.fish = SKSpriteNode(imageNamed: "submarine_2")
            
        case 7:
            self.fish = SKSpriteNode(imageNamed: "walrus")
            self.fishTextureArray = [SKTexture(imageNamed: "walrus"), SKTexture(imageNamed: "walrus02"), SKTexture(imageNamed: "walrus03"), SKTexture(imageNamed: "walrus"), SKTexture(imageNamed: "walrus04")]
            let fishRunAnimation = SKAction.animate(with: self.fishTextureArray, timePerFrame: 0.25)
            let runFish = SKAction.repeatForever(fishRunAnimation)
            self.fish.run(runFish)
            
        case 8:
            self.fish = SKSpriteNode(imageNamed: "crab")
            self.fishTextureArray = [SKTexture(imageNamed: "crab"), SKTexture(imageNamed: "crab1.png"), SKTexture(imageNamed: "crab.png"), SKTexture(imageNamed: "crab3.png"), SKTexture(imageNamed: "crab4.png"), SKTexture(imageNamed: "crab5.png")]
            let fishRunAnimation = SKAction.animate(with: self.fishTextureArray, timePerFrame: 0.25)
            let runFish = SKAction.repeatForever(fishRunAnimation)
            self.fish.run(runFish)
            
        case 9:
            self.fish = SKSpriteNode(imageNamed: "pinguin")
            self.fishTextureArray = [SKTexture(imageNamed: "pinguin"), SKTexture(imageNamed: "pinguin01"), SKTexture(imageNamed: "pinguin"), SKTexture(imageNamed: "pinguin03"), SKTexture(imageNamed: "pinguin02")]
            let fishRunAnimation = SKAction.animate(with: self.fishTextureArray, timePerFrame: 0.3)
            let runFish = SKAction.repeatForever(fishRunAnimation)
            self.fish.run(runFish)
            
        default: break
        }
        
        self.fish.physicsBody = SKPhysicsBody(texture: self.fish.texture!, size: self.fish.size)
        //тело все еще динамическое, но не улетате с экрана
        self.fish.physicsBody?.isDynamic = false
        self.fish.physicsBody?.categoryBitMask = PhysicsCategory.fishCategory
        //c кем должен столкутся
        self.fish.physicsBody?.collisionBitMask = PhysicsCategory.enemyCategory
        //должно ли чтонибуль происходить при столкновении с объектом
        self.fish.physicsBody?.contactTestBitMask = PhysicsCategory.enemyCategory | PhysicsCategory.coinCategory
        
        //create layer from fish and afterWater.sks
        fishLayer = SKNode()
        fishLayer.addChild(fish)
        fishLayer.zPosition = 3
        fish.zPosition = 1
        fishLayer.position = CGPoint(x: frame.midX, y: frame.height / 4)
        addChild(fishLayer)
    }

}
