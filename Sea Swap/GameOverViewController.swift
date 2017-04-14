//
//  GameOverViewController.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 10.03.17.
//  Copyright © 2017 Максим Вакурин. All rights reserved.
//

import UIKit
import Social
import UserNotifications
import UnityAds


protocol GameOverViewControllerDelegate {
    func gameOverViewControllerResetButton(gameOverViewController: GameOverViewController)
    func gameOverViewControllerFacebookShareButton(gameOverViewController: GameOverViewController)
    func gameOverViewControllerTwitterShareButton(gameOverViewController: GameOverViewController)
    func gameOverViewControllerFreeGiftButton(gameOverViewController: GameOverViewController)
    func gameOverViewControllerHeroesButton(gameOverViewController: GameOverViewController)
}



class GameOverViewController: UIViewController, UNUserNotificationCenterDelegate, UnityAdsDelegate {

    
    

    
    //создаем переменую которая принимает протокол
    var delegate: GameOverViewControllerDelegate!
    var gameSettings: GameSettings!

    var timerIntervals = 60
    
    
    @IBOutlet weak var giftLabel: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UnityAds.initialize("1358366", delegate: self)
        giftLabel.isHidden = true
    }
    @IBAction func facebookShareButton(_ sender: UIButton) {
        delegate.gameOverViewControllerFacebookShareButton(gameOverViewController: self)
        //создаем ViewController
        let facebookShares = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        //Начальный текст
        facebookShares?.setInitialText("I just  \(gameSettings.highscore) scores in a brilliant game of #SeaSwaps on iPhone and iPad!")
        //картинка
        //facebookShares?.add(UIImage(named: "turtle.png"))
        self.present(facebookShares!, animated: true, completion: nil)
    }
    
    @IBAction func twitterShareButton(_ sender: UIButton) {
        delegate.gameOverViewControllerTwitterShareButton(gameOverViewController: self)
        let tweeterShares = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        //Начальный текст
        tweeterShares?.setInitialText("I just  \(gameSettings.highscore) scores in a brilliant game of #SeaSwaps on iPhone and iPad!")
        //картинка
        //tweeterShares?.add(UIImage(named: "fb.png"))
        self.present(tweeterShares!, animated: true, completion: nil)
    }
    
    @IBAction func freeGiftButton(_ sender: UIButton) {
        delegate.gameOverViewControllerFreeGiftButton(gameOverViewController: self)
        
    }
    @IBAction func heroesButton(_ sender: UIButton) {
        delegate.gameOverViewControllerHeroesButton(gameOverViewController: self)
    }
    @IBAction func resetButton(_ sender: UIButton) {
        delegate.gameOverViewControllerResetButton(gameOverViewController: self)
    }
    
    func unityAdsReady(_ placementId: String) {
        giftLabel.isHidden = false
    }
    
    func unityAdsDidStart(_ placementId: String) {
        
    }
    
    func unityAdsDidError(_ error: UnityAdsError, withMessage message: String) {
        
    }
    func unityAdsDidFinish(_ placementId: String, with state: UnityAdsFinishState) {
        if state == .completed
        {
        
        }
        else {
            
        }
    }
    
    
    //этот метод срабатывает когда что-то появляется 
    
    override func viewDidAppear(_ animated: Bool) {
        scoreLabel.text = "\(gameSettings.currentScore)"
        bestScoreLabel.text = "\(gameSettings.highscore)"

        
        
        super.viewDidAppear(animated)
    }
}



