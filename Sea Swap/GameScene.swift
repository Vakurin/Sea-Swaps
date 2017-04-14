//
//  GameScene.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 13.03.17.
//  Copyright © 2017 Максим Вакурин. All rights reserved.
//
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
   
    //var backRandom = 0
    var rawValue = 1
    
    var timerInterval = 30
    
    //bit mask
    let fishCategory: UInt32 = 0x1 << 0
    let enemyFishCategory: UInt32 = 0x1 << 1
    let coinCategory: UInt32 = 0x1 << 3
    let jellyFishCategory: UInt32 = 0x1 << 4
    let seaDevilCategory: UInt32 = 0x1 << 5
    let spikeFishCategory: UInt32 = 0x1 << 6
    
    //array
    var fishTextureArray = [SKTexture]()
    var seaDevilTextureArray = [SKTexture]()
    
    //свойство, чтобы его использовать везде
    var fish: SKSpriteNode!
    var background: SKSpriteNode!
    var jellyFish : SKSpriteNode!
    var seaDevil : SKSpriteNode!
    var spikeFish : SKSpriteNode!
    
    //Timers
    var timerJellyFish = Timer()
    var timerSeaDevil = Timer()
    var timerSpikeFish = Timer()
    
    //texture
    var fishTex: SKTexture!
    var jellyFishTex: SKTexture!
    var seaDevilTex: SKTexture!
    var spikeFishTex: SKTexture!
    
    //layer fish or object
    var fishLayer: SKNode!
    var enemyLayer: SKNode!
    var coinLayar: SKNode!
    var jellyFishLayer: SKNode!
    var seaDevilLayer: SKNode!
    var spikeFishLayer: SKNode!
    
    //layer stars
    var starsLayer: SKNode!
    
    //music player
    var musicPlayer: AVAudioPlayer!
    
    // Bool
    var musicOn: Bool = true
    var gameIsPaused: Bool = false
    var gameOver: Bool = false
    var fishPickedUp: Bool = false
    var lastlocation: CGPoint = CGPoint.zero
    var gift: Bool = true
    var image = UIImage(named: "noButton")
    var sound: Bool = true
    
    func musicOnOrOff() {
      
        if musicOn {
            musicPlayer.play()
        } else {
            musicPlayer.stop()
        
        }
        if sound {
            
        } else {
            
        }
 
    }
    
    func pauseTheGame() {
        
        gameIsPaused = true
        self.starsLayer.isPaused = true
        self.jellyFishLayer.isPaused = true
        self.coinLayar.isPaused = true
        self.enemyLayer.isPaused = true
        self.spikeFishLayer.isPaused = true
        self.seaDevilLayer.isPaused = true
        enemyLayer.speed = 0
        coinLayar.speed = 0
        jellyFishLayer.speed = 0
        spikeFishLayer.speed = 0
        seaDevilLayer.speed = 0
        
        if enemyLayer.position.y - 20 >= UIScreen.main.bounds.size.height {
            enemyLayer.removeAllChildren()
        }
        if jellyFishLayer.position.y >= UIScreen.main.bounds.size.height {
            jellyFishLayer.removeAllChildren()
        }
        if spikeFishLayer.position.y >= UIScreen.main.bounds.size.height {
            spikeFishLayer.removeAllChildren()
        }
        if seaDevilLayer.position.y >= UIScreen.main.bounds.size.height {
            seaDevilLayer.removeAllChildren()
        }
        if coinLayar.position.y >= UIScreen.main.bounds.size.height {
            coinLayar.removeAllChildren()
        }
        
        physicsWorld.speed = 0
        
       //musicOnOrOff()
        
    }
    
    func unpauseTheGame() {
        gameIsPaused = false
        self.coinLayar.isPaused = false
        self.starsLayer.isPaused = false
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
        coinLayar.removeAllChildren()
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
        coinLayar.removeAllChildren()
        enemyLayer.removeAllChildren()
        spikeFishLayer.removeAllChildren()
        seaDevilLayer.removeAllChildren()
        fishLayer.position = CGPoint(x: frame.midX, y: frame.height / 4)
        levelUp()
        gameOver = false
        self.unpauseTheGame()
    }
    
    func updateBackground() {
        
        //background
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
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
        
        
        background.position = CGPoint(x: width / 2, y: height / 2)
        background.size = CGSize(width: width + 8, height: height + 12)
        background.zPosition = -1
        addChild(background)

    }
    
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
        self.fish.physicsBody?.categoryBitMask = self.fishCategory
        //c кем должен столкутся
        self.fish.physicsBody?.collisionBitMask = self.enemyFishCategory | self.jellyFishCategory
        //должно ли чтонибуль происходить при столкновении с объектом
        self.fish.physicsBody?.contactTestBitMask = self.enemyFishCategory | self.coinCategory | self.jellyFishCategory
        
        //create layer from fish and afterWater.sks
        fishLayer = SKNode()
        fishLayer.addChild(fish)
        fishLayer.zPosition = 3
        fish.zPosition = 1
        fishLayer.position = CGPoint(x: frame.midX, y: frame.height / 4)
        addChild(fishLayer)
    }
    
    func waterBubbleEmitter() {
        //создаем слой воды
        //путь к файлу
        let starsPath = Bundle.main.path(forResource: "water", ofType: "sks")!
        let starsEmitter = NSKeyedUnarchiver.unarchiveObject(withFile: starsPath) as! SKEmitterNode
        starsEmitter.zPosition = 0
        starsEmitter.position = CGPoint(x: frame.midX, y: -frame.height)
        starsEmitter.particlePositionRange.dx = frame.width + 90
        starsEmitter.advanceSimulationTime(20)
        starsLayer = SKNode()
        
        starsLayer.zPosition = 1
        addChild(starsLayer)
        
        starsLayer.addChild(starsEmitter)
    }
    
    func bubbleAfterHeroEmitter() {
        //create buble
        let bubblePath = Bundle.main.path(forResource: "bubble", ofType: "sks")!
        let bubbleEmitter = NSKeyedUnarchiver.unarchiveObject(withFile: bubblePath) as! SKEmitterNode
        bubbleEmitter.zPosition = 0
        bubbleEmitter.position.y = -40
        bubbleEmitter.targetNode = self
        fishLayer.addChild(bubbleEmitter)
    }
    
    func bubbleAfterSub1Emitter() {
        let bubblePath = Bundle.main.path(forResource: "sub1", ofType: "sks")!
        let bubbleEmitter = NSKeyedUnarchiver.unarchiveObject(withFile: bubblePath) as! SKEmitterNode
        bubbleEmitter.zPosition = 0
        bubbleEmitter.position.x = 175
        bubbleEmitter.position.y = -20
        bubbleEmitter.advanceSimulationTime(20)
        bubbleEmitter.targetNode = self
        fishLayer.addChild(bubbleEmitter)
    }
    
    func bubbleAfterSub2Emitter() {
        let bubblePath = Bundle.main.path(forResource: "sub1", ofType: "sks")!
        let bubbleEmitter = NSKeyedUnarchiver.unarchiveObject(withFile: bubblePath) as! SKEmitterNode
        bubbleEmitter.zPosition = 0
        bubbleEmitter.position.x = 175
        bubbleEmitter.position.y = -8
        bubbleEmitter.advanceSimulationTime(20)
        bubbleEmitter.targetNode = self
        fishLayer.addChild(bubbleEmitter)
    }
    
    func generationEnemyFish() {

        let enemyYellowCreate = SKAction.run {
            ()-> Void in
            let enemyYellowCreate = self.createEnemyYellowFish()
            self.enemyLayer.addChild(enemyYellowCreate)
        }
        
        
        let fishPerSecond: Double = 2
        let fishEnemyCreationDelay = SKAction.wait(forDuration: 1.5 / fishPerSecond, withRange: 0.5)
        let fishEnemySequenceAction = SKAction.sequence([enemyYellowCreate, fishEnemyCreationDelay])
        let fishEnemyRunAction = SKAction.repeatForever(fishEnemySequenceAction)
        self.enemyLayer.run(fishEnemyRunAction)
    }
    
    func generationSpikeFish() {
        
        let enemySpikeFishCreate = SKAction.run {
            () -> Void in
            let enemySpikeFishCreate = self.createSpikeFish()
            self.spikeFishLayer.addChild(enemySpikeFishCreate)
        }
        
        
        let spikeFishPerSecond: Double = 3
        let spikeFishCreationDelay = SKAction.wait(forDuration: 15.0/spikeFishPerSecond, withRange: 1.6)
        let spikeFishSequenceAction = SKAction.sequence([enemySpikeFishCreate, spikeFishCreationDelay])
        let spikeFishRunAction = SKAction.repeatForever(spikeFishSequenceAction)
        self.spikeFishLayer.run(spikeFishRunAction)
    }
    
    func generationJellyFish() {
        
        let enemyJellyFishCreate = SKAction.run {
            () -> Void in
            let enemyJellyFishCreate = self.createJellyFish()
            self.jellyFishLayer.addChild(enemyJellyFishCreate)
        }
        
        
        let jellyFishPerSecond: Double = 7
        let jellyFishCreationDelay = SKAction.wait(forDuration: 30.0/jellyFishPerSecond, withRange: 0.3)
        let jellyFishSequenceAction = SKAction.sequence([enemyJellyFishCreate, jellyFishCreationDelay])
        let jellyFishRunAction = SKAction.repeatForever(jellyFishSequenceAction)
        self.jellyFishLayer.run(jellyFishRunAction)
    }
    
    func generationSeaDevil() {
        
        let enemySeaDevilCreate = SKAction.run {
            () -> Void in
            let enemySeaDevilCreate = self.createSeaDevil()
            self.seaDevilLayer.addChild(enemySeaDevilCreate)
        }
        
        
        let SeaDevilPerSecond: Double = 13
        let SeaDevilCreationDelay = SKAction.wait(forDuration: 40.0/SeaDevilPerSecond * 2, withRange: 0.4)
        let SeaDevilSequenceAction = SKAction.sequence([enemySeaDevilCreate, SeaDevilCreationDelay])
        let SeaDevilRunAction = SKAction.repeatForever(SeaDevilSequenceAction)
        self.seaDevilLayer.run(SeaDevilRunAction)
    }

    func generationCoin() {
        
        let coindCreate = SKAction.run {
            ()-> Void in
            let coinCreate = self.createCoin()
            self.coinLayar.addChild(coinCreate)
        }
        let coinPerSecond: Double = 0.7
        let coinCreationDelay = SKAction.wait(forDuration: 2.0 / coinPerSecond, withRange: 0.7)
        let coinSequenceAction = SKAction.sequence([coindCreate, coinCreationDelay])
        let coinEnemyRunAction = SKAction.repeatForever(coinSequenceAction)
        
        self.coinLayar.run(coinEnemyRunAction)
    }
    
    func fireAfterDevilSea() {
        
        let firePath = Bundle.main.path(forResource: "Fire", ofType: "sks")!
        let fireEmitter = NSKeyedUnarchiver.unarchiveObject(withFile: firePath) as! SKEmitterNode
        fireEmitter.zPosition = 5
        fireEmitter.position.y = -40
        fireEmitter.targetNode = self
        spikeFishLayer.addChild(fireEmitter)
    }
    
    //MARK::
    override func didMove(to view: SKView) {
    
        //чтобы при запуске каждый раз были новая последовательность рандомных значений
        srand48(time(nil))
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.2)
        
        
        coinLayar = SKNode()
        coinLayar.zPosition = 2
        addChild(coinLayar)
        
        spikeFishLayer = SKNode()
        spikeFishLayer.zPosition = 4
        addChild(spikeFishLayer)
        
        enemyLayer = SKNode()
        enemyLayer.zPosition = 3
        addChild(enemyLayer)
 
        waterBubbleEmitter()
        createFish()
        bubbleAfterHeroEmitter()
       
        jellyFishLayer = SKNode()
        jellyFishLayer.zPosition = 5
        addChild(jellyFishLayer)
        
        seaDevilLayer = SKNode()
        seaDevilLayer.zPosition = 6
        addChild(seaDevilLayer)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.generationCoin()
            self.generationEnemyFish()
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5 ) {
            self.generationSpikeFish()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            self.generationJellyFish()
            self.generationSeaDevil()
        }
 
 
        
        
        playMusic()
        resetTheGame()
        continueTheGame()
    }
    
    //back music
    func playMusic() {
        
        //let musicPath = SKTAudio.sharedInstance().backgroundMusicPlayer
        //musicOnOrOff()
        let musicPath = Bundle.main.url(forResource: "happy_adveture", withExtension: "mp3")!
        musicPlayer = try! AVAudioPlayer(contentsOf: musicPath, fileTypeHint: nil)
        musicOnOrOff()
        //если поставить отрицательное число, то будет играть бессконечное число раз
        musicPlayer.numberOfLoops = -1
        musicPlayer.volume = 0.2
    }
    
    func pulseLockNode(_ node: SKSpriteNode)
    {
        let scaleDownAction = SKAction.scale(to: 0.35, duration: 0.5)
        let scaleUpAction = SKAction.scale(to: 0.5, duration: 0.5)
        let seq = SKAction.sequence([scaleDownAction, scaleUpAction])
        
        node.run(SKAction.repeatForever(seq))
    }
    

    
    func levelUp() {
        if 0 <= gameSettings.currentScore && gameSettings.currentScore <= 50 {
            enemyLayer.speed = 1.00
            coinLayar.speed = 1.00
            jellyFishLayer.speed = 0.6
            spikeFishLayer.speed = 0.5
            seaDevilLayer.speed = 0.56
        } else if 50 < gameSettings.currentScore && gameSettings.currentScore <= 80 {
            enemyLayer.speed = 1.08
            coinLayar.speed = 1.09
            jellyFishLayer.speed = 0.8
            spikeFishLayer.speed = 0.7
            seaDevilLayer.speed = 0.8
        } else if 80 < gameSettings.currentScore && gameSettings.currentScore <= 110{
            enemyLayer.speed = 1.15
            coinLayar.speed = 1.19
            jellyFishLayer.speed = 1.2
            spikeFishLayer.speed = 0.9
            seaDevilLayer.speed = 1.0
        } else if 110 < gameSettings.currentScore && gameSettings.currentScore <= 160 {
            enemyLayer.speed = 1.25
            coinLayar.speed = 1.29
            jellyFishLayer.speed = 1.4
            spikeFishLayer.speed = 1.2
            seaDevilLayer.speed = 1.3
        } else if 160 < gameSettings.currentScore && gameSettings.currentScore <= 210 {
            enemyLayer.speed = 1.35
            coinLayar.speed = 1.36
            jellyFishLayer.speed = 1.49
            spikeFishLayer.speed = 1.33
            seaDevilLayer.speed = 1.4
        }
        else if 210 < gameSettings.currentScore && gameSettings.currentScore <= 270 {
            enemyLayer.speed = 1.42
            coinLayar.speed = 1.45
            jellyFishLayer.speed = 1.57
            spikeFishLayer.speed = 1.4
            seaDevilLayer.speed = 1.47
        }
        else if 270 < gameSettings.currentScore && gameSettings.currentScore <= 330 {
            enemyLayer.speed = 1.47
            coinLayar.speed = 1.49
            jellyFishLayer.speed = 1.63
            spikeFishLayer.speed = 1.47
            seaDevilLayer.speed = 1.53
        }
        else if 330 < gameSettings.currentScore && gameSettings.currentScore <= 390 {
            enemyLayer.speed = 1.5
            coinLayar.speed = 1.53
            jellyFishLayer.speed = 1.69
            spikeFishLayer.speed = 1.49
            seaDevilLayer.speed = 1.59
        }
        else if 390 < gameSettings.currentScore && gameSettings.currentScore <= 450 {
            enemyLayer.speed = 1.54
            coinLayar.speed = 1.45
            jellyFishLayer.speed = 1.57
            spikeFishLayer.speed = 1.5
            seaDevilLayer.speed = 1.47
        }
        else if 450 < gameSettings.currentScore && gameSettings.currentScore <= 650 {
            enemyLayer.speed = 1.6
            coinLayar.speed = 1.6
            jellyFishLayer.speed = 1.6
            spikeFishLayer.speed = 1.52
            seaDevilLayer.speed = 1.55
        }
        else if 650 < gameSettings.currentScore && gameSettings.currentScore <= 850 {
            enemyLayer.speed = 1.66
            coinLayar.speed = 1.67
            jellyFishLayer.speed = 1.67
            spikeFishLayer.speed = 1.55
            seaDevilLayer.speed = 1.60
        }
        else if 850 < gameSettings.currentScore && gameSettings.currentScore <= 1150 {
            enemyLayer.speed = 1.7
            coinLayar.speed = 1.7
            jellyFishLayer.speed = 1.7
            spikeFishLayer.speed = 1.6
            seaDevilLayer.speed = 1.63
        }
    }
    
    func createEnemyYellowFish() -> SKSpriteNode {
        
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
        enemyYellowFish.name = "enemyYellowFish"
        enemyYellowFish.physicsBody = SKPhysicsBody(texture: enemyYellowFish.texture!, size: enemyYellowFish.size)
        enemyYellowFish.zPosition = 1
        levelUp()
        enemyYellowFish.physicsBody?.categoryBitMask = enemyFishCategory
        //c кем должен столкутся
        enemyYellowFish.physicsBody?.collisionBitMask = fishCategory | enemyFishCategory | coinCategory | seaDevilCategory | spikeFishCategory|jellyFishCategory
        //должно ли чтонибуль происходить при столкновении с объектом
        enemyYellowFish.physicsBody?.contactTestBitMask = fishCategory
        //enemyYellowFish.physicsBody?.isDynamic = false
        //ск
        enemyYellowFish.physicsBody?.velocity.dx = CGFloat(drand48() * 2 - 1) * 100
        return enemyYellowFish
    }
    
    func createSpikeFish() -> SKSpriteNode {
        
        levelUp()
        
        let spikeFish = SKSpriteNode(imageNamed: "sea_devil")
        seaDevilTextureArray = [SKTexture(imageNamed: "sea_devil"), SKTexture(imageNamed: "sea_devil2")]
        let spikeFishRunAnimation = SKAction.animate(with: seaDevilTextureArray, timePerFrame: 0.25)
        let runSpikeFish = SKAction.repeatForever(spikeFishRunAnimation)
        spikeFish.run(runSpikeFish)
        
        //устанавливаем позицию образования рыбок
        spikeFish.position.x = CGFloat(arc4random()).truncatingRemainder(dividingBy: frame.size.width)
        spikeFish.position.y = frame.size.height + spikeFish.size.height
        spikeFish.name = "sea_devil"
        spikeFish.physicsBody = SKPhysicsBody(texture: spikeFish.texture!, size: spikeFish.size)
        //spikeFish.zPosition = 1
        
        let moveSpikeFish = SKAction.moveBy(x: 0, y: -self.frame.size.height, duration: 3)
        let removeAction = SKAction.removeFromParent()
        let spikeFishMoveForever = SKAction.repeatForever(SKAction.sequence([moveSpikeFish, removeAction]))
        spikeFish.run(spikeFishMoveForever)
        
        spikeFish.physicsBody?.categoryBitMask = spikeFishCategory
        //c кем должен столкутся
        spikeFish.physicsBody?.collisionBitMask = fishCategory
        //должно ли чтонибуль происходить при столкновении с объектом
        spikeFish.physicsBody?.contactTestBitMask = fishCategory

        return spikeFish
    }
    
    func createJellyFish() -> SKSpriteNode {
        
        levelUp()
        
        
        let jellyFish = SKSpriteNode(imageNamed: "jellyfish")
        //устанавливаем позицию образования рыбок
        jellyFish.position.x = CGFloat(arc4random()).truncatingRemainder(dividingBy: frame.size.width)
        jellyFish.position.y = frame.size.height + jellyFish.size.height
        jellyFish.name = "jellyFish"
        jellyFish.physicsBody = SKPhysicsBody(texture: jellyFish.texture!, size: jellyFish.size)
        /*
        let moveJellyFish = SKAction.moveBy(x: -self.frame.size.width, y: 0, duration: 0.5)
        let moveJellyFishTo = SKAction.moveTo(x: self.frame.size.width, duration: 1)
        //let removeAction = SKAction.removeFromParent()
        let jellyFishMoveForever = SKAction.repeatForever(SKAction.sequence([moveJellyFish,moveJellyFishTo,
                                                                             //removeAction
            ]))
        jellyFish.run(jellyFishMoveForever)
        */
        jellyFish.physicsBody?.categoryBitMask = jellyFishCategory
        //c кем должен столкутся
        jellyFish.physicsBody?.collisionBitMask = fishCategory | spikeFishCategory
        //должно ли чтонибуль происходить при столкновении с объектом
        jellyFish.physicsBody?.contactTestBitMask = fishCategory
      
        return jellyFish
    }
    
    func createSeaDevil() -> SKSpriteNode {
        
        levelUp()
        
        let sea_devil = SKSpriteNode(imageNamed: "spikeFish")
        //устанавливаем позицию образования рыбок
        sea_devil.position.x = CGFloat(arc4random()).truncatingRemainder(dividingBy: frame.size.width)
        sea_devil.position.y = frame.size.height + sea_devil.size.height
        sea_devil.name = "spikeFish"
        sea_devil.physicsBody = SKPhysicsBody(texture: sea_devil.texture!, size: sea_devil.size)
        //spikeFish.zPosition = 1
        
        sea_devil.physicsBody?.categoryBitMask = seaDevilCategory
        //c кем должен столкутся
        //        jellyFish.physicsBody?.collisionBitMask = fishCategory | enemyFishCategory | coinCategory | jellyFishCategory | spikeFishCategory
        //должно ли чтонибуль происходить при столкновении с объектом
        sea_devil.physicsBody?.contactTestBitMask = fishCategory
//        animation.scaleZdirection(sprite: sea_devil)
        animation.scaleZdirection(sprite: sea_devil)
        //sea_devil.setScale(1.5)
        
        return sea_devil
    }

    func createCoin() -> SKSpriteNode {
        levelUp()
        let coin = SKSpriteNode(imageNamed:"coin.png")
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
        
        coin.physicsBody?.categoryBitMask = coinCategory
        //c кем должен столкутся
        coin.physicsBody?.collisionBitMask = fishCategory | enemyFishCategory | coinCategory | seaDevilCategory | spikeFishCategory|jellyFishCategory

        coin.physicsBody?.velocity.dx = CGFloat(drand48() * 2 - 1) * 100
        
        return coin
    }
    
    func add(points: Int) {
        gameSettings.currentScore += points
        gameDelegate?.gameDelegateDidUpdate(score: self.gameSettings.currentScore)
        
    }
    
    func addd(money: Int) {
        gameSettings.money += money
        gameDelegate?.gameDelegateMoney(score: gameSettings.money)
    }
    override func update(_ currentTime: TimeInterval) {
        
    }
    
}
