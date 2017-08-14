//
//  HeroesViewController.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 16.03.17.
//  Copyright © 2017 Максим Вакурин. All rights reserved.
//

import UIKit
protocol HeroesViewControllerDelegate {
    func ViewControllerTurtleButtonPressed(viewController: HeroesViewController )
    func ViewControllerOctopusButtonPressed(viewController: HeroesViewController)
    func ViewControllerPinguinButtonPressed(viewController: HeroesViewController)
    func ViewControllerSubmarine1ButtonPressed(viewController: HeroesViewController)
    func ViewControllerSubmarine2ButtonPressed(viewController: HeroesViewController)
    func ViewControllerWalrusButtonPressed(viewController: HeroesViewController)
    func ViewControllerWaterHorseButtonPressed(viewController: HeroesViewController)
    func ViewControllerCrabButtonPressed(viewController: HeroesViewController)
    func ViewControllerWhaleButtonPressed(viewController: HeroesViewController)
}

class HeroesViewController: UIViewController {
    
    var delegate: HeroesViewControllerDelegate!
    

    @IBAction func turtleButton(_ sender: UIButton) {
       delegate.ViewControllerTurtleButtonPressed(viewController: self)
    }
    
    @IBAction func octopusButton(_ sender: UIButton) {
        delegate.ViewControllerOctopusButtonPressed(viewController: self)
    }
    
    @IBOutlet weak var octopusLabel: UIButton!
    
    @IBAction func pinguinButton(_ sender: UIButton) {
        delegate.ViewControllerPinguinButtonPressed(viewController: self)
    }
    
    @IBOutlet weak var pinguin: UIButton!
    
    @IBAction func submarine1Button(_ sender: UIButton) {
        delegate.ViewControllerSubmarine1ButtonPressed(viewController: self)
        
    }
    
    @IBOutlet weak var submarine1Label: UIButton!
    
    
    @IBAction func submarine2Button(_ sender: UIButton) {
        delegate.ViewControllerSubmarine2ButtonPressed(viewController: self)
    }

    @IBOutlet weak var submarine2Label: UIButton!
    
    
    @IBAction func walrusButton(_ sender: UIButton) {
        delegate.ViewControllerWalrusButtonPressed(viewController: self)
    }
    
    @IBOutlet weak var walrus: UIButton!
    
    @IBAction func water_horseButton(_ sender: UIButton) {
        delegate.ViewControllerWaterHorseButtonPressed(viewController: self)
    }
    
    @IBOutlet weak var waterHorseLabel: UIButton!
    
    @IBAction func crabButton(_ sender: UIButton) {
        delegate.ViewControllerCrabButtonPressed(viewController: self)
    }
    
    @IBOutlet weak var crabLabel: UIButton!
    
    
    @IBAction func whaleButton(_ sender: UIButton) {
        delegate.ViewControllerWhaleButtonPressed(viewController: self)
    }
    @IBOutlet weak var whaleLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      

    }

}
