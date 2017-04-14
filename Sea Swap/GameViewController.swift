//
//  GameViewController.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 13.03.17.
//  Copyright © 2017 Максим Вакурин. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import UserNotifications
import UnityAds

class GameViewController: UIViewController, UNUserNotificationCenterDelegate, UnityAdsDelegate {

    var scene = GameScene(size: CGSize(width: 1024, height: 768))
    var pauseViewController: PauseViewController!
    var gameOverViewController: GameOverViewController!
    var gameSettings: GameSettings!
    var preGameOverViewController: PreGameOverViewController!
    var heroesViewController: HeroesViewController!
    var continiueViewController: ContiniueViewController!
    var cont = 0
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
         scene.pauseTheGame()
         showGameScreen(viewController: pauseViewController)
        if scene.sound == true {
            let hitSoundAction = SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: true)
            scene.run(hitSoundAction)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameSettings = GameSettings()
        gameDelegateMoney(score: gameSettings.money)
        
        pauseViewController = storyboard?.instantiateViewController(withIdentifier: "pauseViewController") as! PauseViewController
        //1
        pauseViewController.delegate = self
        
        preGameOverViewController = storyboard?.instantiateViewController(withIdentifier: "PreGameOverViewController") as! PreGameOverViewController
        preGameOverViewController.delegate = self
        
        heroesViewController = storyboard?.instantiateViewController(withIdentifier: "HeroesViewController") as! HeroesViewController
        heroesViewController.delegate = self
        
        continiueViewController = storyboard?.instantiateViewController(withIdentifier: "ContiniueViewController") as! ContiniueViewController
        continiueViewController.delegate = self
        
        gameOverViewController = storyboard?.instantiateViewController(withIdentifier: "GameOverViewController") as! GameOverViewController
        gameOverViewController.delegate = self
        gameOverViewController.gameSettings = gameSettings
        
        let view = self.view as! SKView
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        pauseButton.isHidden = false
        //размер экрана должен быть ограничен рамками экрана
        scene.size = UIScreen.main.bounds.size
        scene.gameDelegate = self as GameDelegate
        scene.gameSettings = gameSettings
        
        // Present the scene
        view.ignoresSiblingOrder = true
        //view.showsFPS = true
        //view.showsNodeCount = true
        
        view.presentScene(scene)
        
    }
    
    
    
    
    func unityAdsReady(_ placementId: String) {
        
    }
    
    func unityAdsDidStart(_ placementId: String) {
        
    }
    
    func unityAdsDidError(_ error: UnityAdsError, withMessage message: String) {
        
    }
    func unityAdsDidFinish(_ placementId: String, with state: UnityAdsFinishState) {
        if state == .completed
        {
            scene.addd(money: 50) }
        else {
            
        }
    }

    //чтобы viewController не наслаивались друг на друга реализуем этот метод
    func showGameScreen(viewController: UIViewController){
        //добавляем в основной вс дочерний вс
        addChildViewController(viewController)
        //добавляем поверх основго новый вью
        view.addSubview(viewController.view)
        //нужно использовать размеры относительно родительского
        viewController.view.frame = view.bounds
        
        viewController.view.alpha = 0
        UIView.animate(withDuration: 0.5) { () -> Void in
            viewController.view.alpha = 1
        }
    }
    
    func hideGameScreen(viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.removeFromParentViewController()
        viewController.view.removeFromSuperview()
        
        viewController.view.alpha = 1
        UIView.animate(withDuration: 0.5, animations: { ()-> Void in
            viewController.view.alpha = 0
            //без комлишена все будет работать не плавно
        }) { (completed:Bool) -> Void in
            viewController.view.removeFromSuperview()
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone || UIDevice.current.userInterfaceIdiom == .pad  {
            return .portrait
        } else {
            //return .allButUpsideDown
            return .portrait
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: GameDelegate{
    func gameDelegateDidUpdate(score: Int) {
        scoreLabel.text = "\(self.gameSettings.currentScore)"
    }
    func gameDelegateGameOver(score: Int) {
        showGameScreen(viewController: preGameOverViewController)
    }
    func gameDelegateReset() {
        scoreLabel.text = "\(self.gameSettings.currentScore)"
    }
    func gameDelegateMoney(score: Int){
        moneyLabel.text = "\(self.gameSettings.money)"
    }
}

extension GameViewController: heroesViewControllerDelegate {
    
    
    func ViewControllerTurtleButtonPressed(viewController: HeroesViewController )
    {
        
        scene.rawValue = 1
        scene.resetTheGame()
        scene.fishLayer.removeAllChildren()
        scene.createFish()
        scene.bubbleAfterHeroEmitter()
        
        hideGameScreen(viewController: heroesViewController)
        if scene.sound == true {
            let hitSoundAction = SKAction.playSoundFileNamed("heroesclick.wav", waitForCompletion: true)
            scene.run(hitSoundAction)
        }
        
    }
    func ViewControllerOctopusButtonPressed(viewController: HeroesViewController)
    {
        var image: UIImage
        if gameSettings.unlock3 == false && gameSettings.money >= 400 {
            gameSettings.money -= 400
            scene.rawValue = 3
            gameSettings.unlock3 = true
            gameDelegateMoney(score: gameSettings.money)
            image = UIImage(named: "octopuspic")!
            viewController.octopusLabel.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("positive.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        } else if gameSettings.unlock3 == true {
            scene.rawValue = 3
            scene.resetTheGame()
            scene.fishLayer.removeAllChildren()
            scene.createFish()
            image = UIImage(named: "octopuspic")!
            viewController.octopusLabel.setImage(image, for: .normal)
            hideGameScreen(viewController: heroesViewController)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("heroesclick.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        } else {
            image = UIImage(named: "lockButton")!
            viewController.octopusLabel.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("negative.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        }
    }
    func ViewControllerPinguinButtonPressed(viewController: HeroesViewController)
    {
        var image: UIImage
        if gameSettings.unlock9 == false && gameSettings.money >= 400 {
            gameSettings.money -= 400
            scene.rawValue = 9
            gameSettings.unlock9 = true
            gameDelegateMoney(score: gameSettings.money)
            image = UIImage(named: "pin")!
            viewController.pinguin.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("positive.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        } else if gameSettings.unlock9 == true {
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("heroesclick.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
            scene.rawValue = 9
            scene.resetTheGame()
            scene.fishLayer.removeAllChildren()
            scene.createFish()
            image = UIImage(named: "pin")!
            viewController.pinguin.setImage(image, for: .normal)
            hideGameScreen(viewController: heroesViewController)
        } else {
            image = UIImage(named: "lockButton")!
            viewController.pinguin.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("negative.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        }
    }
    func ViewControllerSubmarine1ButtonPressed(viewController: HeroesViewController)
    {
        var image: UIImage
        if gameSettings.unlock4 == false && gameSettings.money >= 400 {
            gameSettings.money -= 400
            scene.rawValue = 4
            gameSettings.unlock4 = true
            gameDelegateMoney(score: gameSettings.money)
            image = UIImage(named: "sub1pic")!
            viewController.submarine1Label.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("positive.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        } else if gameSettings.unlock4 == true {
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("heroesclick.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
            scene.rawValue = 4
            scene.resetTheGame()
            scene.fishLayer.removeAllChildren()
            scene.createFish()
            scene.bubbleAfterSub1Emitter()
            image = UIImage(named: "sub1pic")!
            viewController.submarine1Label.setImage(image, for: .normal)
            hideGameScreen(viewController: heroesViewController)
        } else {
            image = UIImage(named: "lockButton")!
            viewController.submarine1Label.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("negative.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        }
    }
    func ViewControllerSubmarine2ButtonPressed(viewController: HeroesViewController)
    {
        var image: UIImage
        if gameSettings.unlock6 == false && gameSettings.money >= 400 {
            gameSettings.money -= 400
            scene.rawValue = 6
            gameSettings.unlock6 = true
            gameDelegateMoney(score: gameSettings.money)
            image = UIImage(named: "sub2pic")!
            viewController.submarine2Label.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("positive.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        } else if gameSettings.unlock6 == true {
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("heroesclick.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
            scene.rawValue = 6
            scene.resetTheGame()
            scene.fishLayer.removeAllChildren()
            scene.createFish()
            scene.bubbleAfterSub2Emitter()
            image = UIImage(named: "sub2pic")!
            viewController.submarine2Label.setImage(image, for: .normal)
            hideGameScreen(viewController: heroesViewController)
        }else {
            image = UIImage(named: "lockButton")!
            viewController.submarine2Label.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("negative.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        }
    }
    func ViewControllerWalrusButtonPressed(viewController: HeroesViewController)
    {
        var image: UIImage
        if gameSettings.unlock7 == false && gameSettings.money >= 400 {
            gameSettings.money -= 400
            scene.rawValue = 7
            gameSettings.unlock7 = true
            gameDelegateMoney(score: gameSettings.money)
            image = UIImage(named: "walpic")!
            viewController.walrus.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("positive.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        } else if gameSettings.unlock7 == true {
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("heroesclick.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
            scene.rawValue = 7
            scene.resetTheGame()
            scene.fishLayer.removeAllChildren()
            scene.createFish()
            image = UIImage(named: "walpic")!
            viewController.walrus.setImage(image, for: .normal)
            hideGameScreen(viewController: heroesViewController)
        } else {
            image = UIImage(named: "lockButton")!
            viewController.walrus.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("negative.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        }
    }
    
    func ViewControllerWater_horseButtonPressed(viewController: HeroesViewController)
    {
        var image: UIImage
        if gameSettings.unlock2 == false && gameSettings.money >= 400 {
            gameSettings.money -= 400
            scene.rawValue = 2
            gameSettings.unlock2 = true
            gameDelegateMoney(score: gameSettings.money)
            image = UIImage(named: "wt2")!
            viewController.water_horseLabel.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("positive.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        } else if gameSettings.unlock2 == true {
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("heroesclick.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
            scene.rawValue = 2
            scene.resetTheGame()
            scene.fishLayer.removeAllChildren()
            scene.createFish()
            image = UIImage(named: "wt2")!
            viewController.water_horseLabel.setImage(image, for: .normal)
            hideGameScreen(viewController: heroesViewController)
        }else {
            image = UIImage(named: "lockButton")!
            viewController.water_horseLabel.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("negative.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        }
    }
    func ViewControllerCrabButtonPressed(viewController: HeroesViewController)
    {
        var image: UIImage
        if gameSettings.unlock8 == false && gameSettings.money >= 400 {
            gameSettings.money -= 400
            scene.rawValue = 8
            gameSettings.unlock8 = true
            gameDelegateMoney(score: gameSettings.money)
            image = UIImage(named: "crabpic")!
            viewController.crabLabel.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("positive.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        } else if gameSettings.unlock8 == true {
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("heroesclick.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
            scene.rawValue = 8
            scene.resetTheGame()
            scene.fishLayer.removeAllChildren()
            scene.createFish()
            image = UIImage(named: "crabpic")!
            viewController.crabLabel.setImage(image, for: .normal)
            hideGameScreen(viewController: heroesViewController)
        }else {
            image = UIImage(named: "lockButton")!
            viewController.crabLabel.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("negative.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        }
    }
    func ViewControllerWhaleButtonPressed(viewController: HeroesViewController)
    {
        var image: UIImage
        if gameSettings.unlock5 == false && gameSettings.money >= 400 {
            gameSettings.money -= 400
            scene.rawValue = 5
            gameSettings.unlock5 = true
            gameDelegateMoney(score: gameSettings.money)
            image = UIImage(named: "wahlepic")!
            viewController.whaleLabel.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("positive.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        } else if gameSettings.unlock5 == true {
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("heroesclick.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
            scene.rawValue = 5
            scene.resetTheGame()
            scene.fishLayer.removeAllChildren()
            scene.createFish()
            image = UIImage(named: "wahlepic")!
            viewController.whaleLabel.setImage(image, for: .normal)
            hideGameScreen(viewController: heroesViewController)
        } else {
            image = UIImage(named: "lockButton")!
            viewController.whaleLabel.setImage(image, for: .normal)
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("negative.wav", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
        }
    }
}

extension GameViewController: GameOverViewControllerDelegate {
    
    func gameOverViewControllerResetButton(gameOverViewController: GameOverViewController){
        scene.resetTheGame()
        hideGameScreen(viewController: gameOverViewController)
        if scene.sound == true {
            let hitSoundAction = SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: true)
            scene.run(hitSoundAction)
        }
    }
    func gameOverViewControllerFacebookShareButton(gameOverViewController: GameOverViewController)
    {
        
    }
    func gameOverViewControllerTwitterShareButton(gameOverViewController: GameOverViewController)
    {
        
    }
    func gameOverViewControllerFreeGiftButton(gameOverViewController: GameOverViewController) {
        
        UnityAds.show(self, placementId: "rewardedVideo")
        //unityAdsDidFinish("rewardedVideo", with: .completed)
        //scene.addd(money: 50)
        if scene.sound == true {
            let hitSoundAction = SKAction.playSoundFileNamed("positive.wav", waitForCompletion: true)
            scene.run(hitSoundAction)
        }
    }
    func gameOverViewControllerHeroesButton(gameOverViewController: GameOverViewController){
        hideGameScreen(viewController: gameOverViewController)
        showGameScreen(viewController: heroesViewController)
        if scene.sound == true {
            let hitSoundAction = SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: true)
            scene.run(hitSoundAction)
        }
        
    }
}

extension GameViewController: ContiniueViewControllerDelegate {
    func continiueViewControllerButtonPressed(viewController: ContiniueViewController) {
        
            hideGameScreen(viewController: continiueViewController)
            scene.continueTheGame()
            
            if scene.sound == true {
                let hitSoundAction = SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: true)
                scene.run(hitSoundAction)
            }
    }
}



extension GameViewController: PreGameOverViewControllerDelegate {
    
    func continueViewControllerPlayButtonPressed(viewController: PreGameOverViewController) {
            UnityAds.show(self, placementId: "rewardedVideo")
            
            hideGameScreen(viewController: preGameOverViewController)
            showGameScreen(viewController: continiueViewController)
            scene.pauseTheGame()
            
        
        if scene.sound == true {
            let hitSoundAction = SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: true)
            scene.run(hitSoundAction)
        }
    }
    
    func noViewControllerHeroesButtonPressed(viewController: PreGameOverViewController) {
        hideGameScreen(viewController: preGameOverViewController)
        showGameScreen(viewController: gameOverViewController)
        scene.pauseTheGame()
        if scene.sound == true {
            let hitSoundAction = SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: true)
            scene.run(hitSoundAction)
        }
    }
}



//MARK: PauseViewController
extension GameViewController: PauseViewControllerDelegate {
    
    func pauseViewControllerPlayButtonPressed(viewController: PauseViewController){
        hideGameScreen(viewController: pauseViewController)
        scene.unpauseTheGame()
        if scene.sound == true {
            let hitSoundAction = SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: true)
            scene.run(hitSoundAction)
        }
    }
    func pauseViewControllerHeroesButtonPressed(viewController: PauseViewController){
        hideGameScreen(viewController: pauseViewController)
        showGameScreen(viewController: heroesViewController)
        if scene.sound == true {
            let hitSoundAction = SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: true)
            scene.run(hitSoundAction)
        }
    }
    func pauseViewControllerMusicButtonPressed(viewController: PauseViewController){
        scene.musicOn = !scene.musicOn
        scene.musicOnOrOff()
        scene.sound = !scene.sound
        let image = scene.musicOn ? UIImage(named: "soundOnButton"):UIImage(named: "soundOffButton")
        viewController.musicButton.setImage(image, for: .normal)
    }
}


