//
//  ContiniueViewController.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 24.03.17.
//  Copyright © 2017 Vakurin Maxim. All rights reserved.
//

import UIKit


protocol ContiniueViewControllerDelegate {
     func continiueViewControllerButtonPressed(viewController: ContiniueViewController)
}

class ContiniueViewController: UIViewController {

    @IBOutlet weak var adsCont: UIButton!
    
    var delegate: ContiniueViewControllerDelegate!
    var myTimer: Timer!
    var timerLeft = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adsCont.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        myTimer.invalidate()
        delegate.continiueViewControllerButtonPressed(viewController: self)
        adsCont.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        start()
        super.viewDidAppear(animated)
    }
    
    
    func start() {
        timerLeft = 5
        myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PreGameOverViewController.timerRun), userInfo: nil, repeats: true)
    }
    
    func timerRun(){
        timerLeft -= 1
        //labelTimer.text = "\(timerLeft)"
        if timerLeft == 0 {
            myTimer.invalidate()
            adsCont.isHidden = false
            //delegate.noViewControllerHeroesButtonPressed(viewController: self)
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
