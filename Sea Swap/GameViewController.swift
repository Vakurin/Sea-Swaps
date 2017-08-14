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
        sceneSound(scene: scene, nameOfSound: Music.click)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameSettings = GameSettings()
        gameDelegateMoney(score: gameSettings.money)
        
        pauseViewController = storyboard?.instantiateViewController(withIdentifier: "pauseViewController") as! PauseViewController
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
        view.showsFPS = true
        view.showsNodeCount = true
        
        view.presentScene(scene)
    }
    
    func unityAdsReady(_ placementId: String) {
        preGameOverViewController.adButtonLabel.isHidden = false
    }
    func unityAdsDidStart(_ placementId: String) {
        //hideGameScreen(viewController: <#T##UIViewController#>)
    }
    func unityAdsDidError(_ error: UnityAdsError, withMessage message: String) {
        if error == .videoPlayerError {
            
        }
    }
    func unityAdsDidFinish(_ placementId: String, with state: UnityAdsFinishState) {
        if state == .completed {
            scene.addMoney(50)
        } else {
            hideGameScreen(viewController: self)
        }
    }

    //MARK: SHOW VC
    func showGameScreen(viewController: UIViewController){
        //чтобы VC не наслаивались друг на друга
        //добавляем в основной VC дочерний VC
        addChildViewController(viewController)
        //добавляем поверх основного new VC
        view.addSubview(viewController.view)
        //нужно использовать размеры относительно родительского VC
        viewController.view.frame = view.bounds
        viewController.view.alpha = 0
        UIView.animate(withDuration: 0.5) { () -> Void in
            viewController.view.alpha = 1
        }
    }
    //MARK: HIDE VC
    func hideGameScreen(viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.removeFromParentViewController()
        viewController.view.removeFromSuperview()
        
        viewController.view.alpha = 1
        UIView.animate(withDuration: 0.5, animations: { ()-> Void in
            viewController.view.alpha = 0
            //без completed все будет работать не плавно
        }) { (completed:Bool) -> Void in
            viewController.view.removeFromSuperview()
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

struct HeroesImage {
    static let octopuspic = "octopuspic"
    static let lockButton = "lockButton"
    static let pinguin = "pinguin"
    static let turtle = "turtle"
    static let whale = "whale"
    static let waterHorse = "water_horse"
    static let sub1pic = "sub1pic"
    static let submarine2 = "sub2pic"
    static let walpic = "walpic"
    static let crab = "crabpic"
    
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

extension GameViewController: HeroesViewControllerDelegate {
    func buyHeroes(_ gameSettings: GameSettings, rawValue: Int, image: String, label: UIButton) {
        gameSettings.money -= 400
        scene.rawValue = rawValue
        gameDelegateMoney(score: gameSettings.money)
        let image = UIImage(named: image)!
        sceneSound(scene: scene, nameOfSound: Music.positive)
        label.setImage(image, for: .normal)
    }
    func isHeroesUnlock(_ rawValue: Int, image: String, label: UIButton) {
        scene.rawValue = rawValue
        scene.resetTheGame()
        scene.fishLayer.removeAllChildren()
        scene.createFish()
        let image = UIImage(named: image)!
        label.setImage(image, for: .normal)
        hideGameScreen(viewController: heroesViewController)
        sceneSound(scene: scene, nameOfSound: Music.heroClick)
    }
    func dontHeroesUnlock(_ image: String, label: UIButton) {
        let image = UIImage(named: image)
        label.setImage(image, for: .normal)
        sceneSound(scene: scene, nameOfSound: Music.negative)
    }
    func ViewControllerTurtleButtonPressed(viewController: HeroesViewController) {
        scene.rawValue = 1
        scene.resetTheGame()
        scene.fishLayer.removeAllChildren()
        scene.createFish()
        hideGameScreen(viewController: heroesViewController)
        sceneSound(scene: scene, nameOfSound: Music.heroClick)
        scene.bubbleAfterHero(positionX: 0, positionY: -40, forResource: "bubble")
    }
    func ViewControllerWaterHorseButtonPressed(viewController: HeroesViewController) {
        if gameSettings.unlock2 == false && gameSettings.money >= 400 {
            gameSettings.unlock2 = true
            buyHeroes(gameSettings, rawValue: 2, image: HeroesImage.waterHorse, label: viewController.waterHorseLabel)
        } else if gameSettings.unlock2 == true {
            isHeroesUnlock(2, image: HeroesImage.waterHorse, label: viewController.waterHorseLabel)
        } else {
            dontHeroesUnlock(HeroesImage.lockButton, label: viewController.waterHorseLabel)
        }
    }
    func ViewControllerOctopusButtonPressed(viewController: HeroesViewController) {
        if gameSettings.unlock3 == false && gameSettings.money >= 400 {
            gameSettings.unlock3 = true
            buyHeroes(gameSettings, rawValue: 3, image: HeroesImage.octopuspic, label: viewController.octopusLabel)
        } else if gameSettings.unlock3 == true {
            isHeroesUnlock(3, image: HeroesImage.octopuspic, label: viewController.octopusLabel)
        } else {
            dontHeroesUnlock(HeroesImage.lockButton, label: viewController.octopusLabel)
        }
    }
    
    func ViewControllerSubmarine1ButtonPressed(viewController: HeroesViewController) {
        if gameSettings.unlock4 == false && gameSettings.money >= 400 {
            gameSettings.unlock4 = true
            buyHeroes(gameSettings, rawValue: 4, image: HeroesImage.sub1pic, label: viewController.submarine1Label)
        } else if gameSettings.unlock4 == true {
            isHeroesUnlock(4, image: HeroesImage.sub1pic, label: viewController.submarine1Label)
        } else {
            dontHeroesUnlock(HeroesImage.lockButton, label: viewController.submarine1Label)
        }
    }
    func ViewControllerWhaleButtonPressed(viewController: HeroesViewController) {
        if gameSettings.unlock5 == false && gameSettings.money >= 400 {
            gameSettings.unlock5 = true
            buyHeroes(gameSettings, rawValue: 5, image: HeroesImage.whale, label: viewController.whaleLabel)
        } else if gameSettings.unlock5 == true {
            isHeroesUnlock(5, image: HeroesImage.whale, label: viewController.whaleLabel)
        } else {
            dontHeroesUnlock(HeroesImage.lockButton, label: viewController.whaleLabel)
        }
    }
    func ViewControllerSubmarine2ButtonPressed(viewController: HeroesViewController) {
        if gameSettings.unlock6 == false && gameSettings.money >= 400 {
            gameSettings.unlock6 = true
            buyHeroes(gameSettings, rawValue: 6, image: HeroesImage.submarine2, label: viewController.whaleLabel)
        } else if gameSettings.unlock6 == true {
            scene.bubbleAfterHero(positionX: 175, positionY: -8, forResource: "sub1")
            isHeroesUnlock(6, image: HeroesImage.submarine2, label: viewController.submarine2Label)
        }else {
            dontHeroesUnlock(HeroesImage.lockButton, label: viewController.submarine2Label)
        }
    }
    func ViewControllerWalrusButtonPressed(viewController: HeroesViewController) {
        if gameSettings.unlock7 == false && gameSettings.money >= 400 {
            gameSettings.unlock7 = true
            buyHeroes(gameSettings, rawValue: 7, image: HeroesImage.walpic, label: viewController.walrus)
        } else if gameSettings.unlock7 == true {
            isHeroesUnlock(7, image: HeroesImage.walpic, label: viewController.walrus)
        } else {
            dontHeroesUnlock(HeroesImage.lockButton, label: viewController.walrus)
        }
    }
    func ViewControllerCrabButtonPressed(viewController: HeroesViewController) {
        if gameSettings.unlock8 == false && gameSettings.money >= 400 {
            gameSettings.unlock8 = true
            buyHeroes(gameSettings, rawValue: 8, image: HeroesImage.crab, label: viewController.crabLabel)
        } else if gameSettings.unlock8 == true {
            isHeroesUnlock(8, image: HeroesImage.crab, label: viewController.crabLabel)
        }else {
            dontHeroesUnlock(HeroesImage.lockButton, label: viewController.crabLabel)
        }
    }
    func ViewControllerPinguinButtonPressed(viewController: HeroesViewController) {
        if gameSettings.unlock9 == false && gameSettings.money >= 400 {
            gameSettings.unlock9 = true
            buyHeroes(gameSettings, rawValue: 9, image: HeroesImage.pinguin, label: viewController.pinguin)
        } else if gameSettings.unlock9 == true {
            isHeroesUnlock(9, image: HeroesImage.pinguin, label: viewController.pinguin)
        } else {
            dontHeroesUnlock(HeroesImage.lockButton, label: viewController.pinguin)
        }
    }
}

extension GameViewController: GameOverViewControllerDelegate {
    
    func gameOverViewControllerResetButton(gameOverViewController: GameOverViewController) {
        scene.resetTheGame()
        hideGameScreen(viewController: gameOverViewController)
        sceneSound(scene: scene, nameOfSound: Music.click)
    }
    func gameOverViewControllerFacebookShareButton(gameOverViewController: GameOverViewController) {
        
    }
    func gameOverViewControllerTwitterShareButton(gameOverViewController: GameOverViewController) {
        
    }
    func gameOverViewControllerFreeGiftButton(gameOverViewController: GameOverViewController) {
        UnityAds.show(self, placementId: "rewardedVideo")
        //unityAdsDidFinish("rewardedVideo", with: .completed)
        //scene.addd(money: 50)
        sceneSound(scene: scene, nameOfSound: Music.positive)
    }
    func gameOverViewControllerHeroesButton(gameOverViewController: GameOverViewController){
        hideGameScreen(viewController: gameOverViewController)
        showGameScreen(viewController: heroesViewController)
        sceneSound(scene: scene, nameOfSound: Music.click)
        
    }
}
//MARK: 
extension GameViewController: ContiniueViewControllerDelegate {
    func continiueViewControllerButtonPressed(viewController: ContiniueViewController) {
            hideGameScreen(viewController: continiueViewController)
            scene.continueTheGame()
            sceneSound(scene: scene, nameOfSound: Music.click)
    }
}
//MARK: PreGameOverDelegate
extension GameViewController: PreGameOverViewControllerDelegate {
    func continueViewControllerPlayButtonPressed(viewController: PreGameOverViewController) {
        UnityAds.show(self, placementId: "rewardedVideo")
        hideGameScreen(viewController: preGameOverViewController)
        showGameScreen(viewController: continiueViewController)
        scene.pauseTheGame()
        sceneSound(scene: scene, nameOfSound: Music.click)
    }
    func noViewControllerHeroesButtonPressed(viewController: PreGameOverViewController) {
        hideGameScreen(viewController: preGameOverViewController)
        showGameScreen(viewController: gameOverViewController)
        scene.pauseTheGame()
        sceneSound(scene: scene, nameOfSound: Music.click)
    }
}
//MARK: PauseViewControllerDelegate
extension GameViewController: PauseViewControllerDelegate {
    func pauseViewControllerPlayButtonPressed(viewController: PauseViewController){
        hideGameScreen(viewController: pauseViewController)
        scene.unpauseTheGame()
        sceneSound(scene: scene, nameOfSound: Music.click)
    }
    func pauseViewControllerHeroesButtonPressed(viewController: PauseViewController){
        hideGameScreen(viewController: pauseViewController)
        showGameScreen(viewController: heroesViewController)
        sceneSound(scene: scene, nameOfSound: Music.click)
    }
    func pauseViewControllerMusicButtonPressed(viewController: PauseViewController){
        scene.musicOn = !scene.musicOn
        scene.musicOnOrOff()
        scene.sound = !scene.sound
        let image = scene.musicOn ? UIImage(named: "soundOnButton"):UIImage(named: "soundOffButton")
        viewController.musicButton.setImage(image, for: .normal)
    }
}


