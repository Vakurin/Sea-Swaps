//
//  EmittersLayer.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 18.03.17.
//  Copyright © 2017 Максим Вакурин. All rights reserved.
//
import Foundation
import SpriteKit

class AnimationClass {
    
    //Увеличивает в х2 спрайт и обратно уменьшает
    public func scaleZDirection(sprite: SKSpriteNode){
        sprite.run(SKAction.repeatForever(SKAction.sequence([SKAction.scale(by: 2.0, duration: 0.5),SKAction.scale(by: 1.0, duration: 2.0)])))
    }
    //Перекрашивает в спрайт в красный цвет
    public func redColorAnimation(sprite: SKSpriteNode, animDuration: TimeInterval) {
        sprite.run(SKAction.repeatForever(SKAction.sequence([SKAction.colorize(with: SKColor.red, colorBlendFactor: 1.0, duration: animDuration), SKAction.colorize(withColorBlendFactor: 0.0, duration: animDuration)])))
    }
    
    public func pulseLockNode(_ node: SKSpriteNode) {
        let scaleDownAction = SKAction.scale(to: 0.35, duration: 0.5)
        let scaleUpAction = SKAction.scale(to: 0.5, duration: 0.5)
        node.run(SKAction.repeatForever(SKAction.sequence([scaleDownAction, scaleUpAction])))
    }
}

