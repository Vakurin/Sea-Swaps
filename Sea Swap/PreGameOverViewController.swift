//
//  PreGameOverViewController.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 15.03.17.
//  Copyright © 2017 Максим Вакурин. All rights reserved.
//

import UIKit
import UnityAds
protocol PreGameOverViewControllerDelegate {
    func continueViewControllerPlayButtonPressed(viewController: PreGameOverViewController)
    func noViewControllerHeroesButtonPressed(viewController: PreGameOverViewController)

}

class PreGameOverViewController: UIViewController, UnityAdsDelegate {
    
    var myTimer: Timer!
    var timerLeft = 10
    var count = 0
    
    var delegate: PreGameOverViewControllerDelegate!
    
    @IBOutlet weak var adButtonLabel: UIButton!

    @IBOutlet weak var labelTimer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adButtonLabel.isHidden = true
        UnityAds.initialize("1358366", delegate: self)
        
    }


    
    @IBAction func adButton(_ sender: Any) {
        if count == 0 {
            unityAdsDidStart("")
            myTimer.invalidate()
            unityAdsDidFinish("rewardedVideo", with: .completed)
            UnityAds.show(self, placementId: "rewardedVideo")
            delegate.continueViewControllerPlayButtonPressed(viewController: self)
            labelTimer.text = "10"
        }
    }
    
    @IBAction func noButton(_ sender: Any) {

        myTimer.invalidate()
        count = 0
        delegate.noViewControllerHeroesButtonPressed(viewController: self)
        labelTimer.text = "10"
        
    }
    
    func unityAdsReady(_ placementId: String) {
        //adButtonLabel.isHidden = false
    }
    
    func unityAdsDidStart(_ placementId: String) {
    }
    
    func unityAdsDidError(_ error: UnityAdsError, withMessage message: String) {
        
    }
    func unityAdsDidFinish(_ placementId: String, with state: UnityAdsFinishState) {
        
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(_ animated: Bool) {
        start()
        super.viewDidAppear(animated)
    }
    
    
    func start() {
        timerLeft = 10
        myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PreGameOverViewController.timerRun), userInfo: nil, repeats: true)
    }
    
    func timerRun(){
        timerLeft -= 1
        labelTimer.text = "\(timerLeft)"
        if timerLeft == 0 {
            myTimer.invalidate()
            //delegate.noViewControllerHeroesButtonPressed(viewController: self)
            
        }
    }
   
}
