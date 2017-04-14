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
    func scaleZdirection(sprite: SKSpriteNode){
        sprite.run(SKAction.repeatForever(SKAction.sequence([SKAction.scale(by: 2.0, duration: 0.5),SKAction.scale(by: 1.0, duration: 2.0)])))
    }
  
    func redColorAnimation(sprite: SKSpriteNode, animDuration: TimeInterval) {
        sprite.run(SKAction.repeatForever(SKAction.sequence([SKAction.colorize(with: SKColor.red, colorBlendFactor: 1.0, duration: animDuration), SKAction.colorize(withColorBlendFactor: 0.0, duration: animDuration)])))
    }
}

