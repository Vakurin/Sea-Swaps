//
//  Touches.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 18.03.17.
//  Copyright © 2017 Максим Вакурин. All rights reserved.

import Foundation
import SpriteKit

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameIsPaused {
            if let touch = touches.first {
                let locationTouch = touch.location(in: self)
                if atPoint(locationTouch) == fish {
                    lastlocation = locationTouch
                    fishPickedUp = true
                }
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameIsPaused {
            if let touch = touches.first {
                let locationTouch = touch.location(in: self)
                if fishPickedUp {
                    let translation = CGPoint(x: locationTouch.x - lastlocation.x, y: locationTouch.y - lastlocation.y)
                    fishLayer.position.x += translation.x
                    fishLayer.position.y += translation.y
                    lastlocation = locationTouch
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fishPickedUp = false
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        fishPickedUp = false
    }
}
