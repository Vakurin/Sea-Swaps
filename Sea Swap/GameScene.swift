//  GameScene.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 13.03.17.
//  Copyright © 2017 Максим Вакурин. All rights reserved.

import SpriteKit
import GameplayKit
import AVFoundation

protocol GameDelegate {
    func gameDelegateDidUpdate(score: Int)
    func gameDelegateGameOver(score: Int)
    func gameDelegateMoney(score: Int)
    func gameDelegateReset()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var animation = AnimationClass()
    var gameDelegate: GameDelegate?
    var gameSettings: GameSettings!
    var rawValue = 1
    
    //Texture Pack
    var fishTextureArray = [SKTexture]()
    var seaDevilTextureArray = [SKTexture]()
    
    var fish: SKSpriteNode!
    var background: SKSpriteNode!
    var jellyFish : SKSpriteNode!
    var seaDevil : SKSpriteNode!
    var spikeFish : SKSpriteNode!

    //Layer Node
    var fishLayer: SKNode!
    var enemyLayer: SKNode!
    var coinLayer: SKNode!
    var jellyFishLayer: SKNode!
    var seaDevilLayer: SKNode!
    var spikeFishLayer: SKNode!
    
    //Emitters
    var bubbleLayer: SKNode!
    
    //MARK: SoundSettings.swift
    var musicPlayer: AVAudioPlayer!
    var musicOn: Bool = true
    var sound: Bool = true
    
    //MARK: Touches.swift
    var fishPickedUp: Bool = false
    var lastlocation: CGPoint = CGPoint.zero
    
    //Bool
    var gameIsPaused: Bool = false
    var gameOver: Bool = false
    var image = UIImage(named: "noButton")

    func layerNodeAndzPosition(nodeLayer: SKNode, zPosition: CGFloat){
        nodeLayer.zPosition = zPosition
        addChild(nodeLayer)
    }
    
    //MARK: didMove
    override func didMove(to view: SKView) {
    
        //при запуске каждый раз была новая последовательность рандомных значений
        srand48(time(nil))
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.2)
        coinLayer = SKNode()
        layerNodeAndzPosition(nodeLayer: coinLayer, zPosition: 2)
        spikeFishLayer = SKNode()
        layerNodeAndzPosition(nodeLayer: spikeFishLayer, zPosition: 3)
        enemyLayer = SKNode()
        layerNodeAndzPosition(nodeLayer: enemyLayer, zPosition: 4)
        jellyFishLayer = SKNode()
        layerNodeAndzPosition(nodeLayer: jellyFishLayer, zPosition: 5)
        seaDevilLayer = SKNode()
        layerNodeAndzPosition(nodeLayer: seaDevilLayer, zPosition: 6)
        waterBubbleEmitter()
        createFish()
        bubbleAfterHero(positionX: 0, positionY: -40, forResource: "bubble")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.generationCoin()
            self.generationEnemyFish()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5 ) {
            self.generationSpikeFish()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            //self.generationJellyFish()
            //self.generationSeaDevil()
        }
 
        playMusic()
        resetTheGame()
        continueTheGame()
    }
    
        
    override func update(_ currentTime: TimeInterval) {
        
    }
}
