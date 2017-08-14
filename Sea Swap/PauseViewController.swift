//
//  PauseViewController.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 08.03.17.
//  Copyright © 2017 Максим Вакурин. All rights reserved.
//

import UIKit

protocol PauseViewControllerDelegate {
    func pauseViewControllerPlayButtonPressed(viewController: PauseViewController)
    func pauseViewControllerHeroesButtonPressed(viewController: PauseViewController)
    func pauseViewControllerMusicButtonPressed(viewController: PauseViewController)
}

class PauseViewController: UIViewController {

    var delegate: PauseViewControllerDelegate!
    
    @IBAction func heroesButtonPressed(_ sender: UIButton) {
        delegate.pauseViewControllerHeroesButtonPressed(viewController: self)
    }
    @IBOutlet weak var musicButton: UIButton!
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        delegate.pauseViewControllerMusicButtonPressed(viewController: self)
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        delegate.pauseViewControllerPlayButtonPressed(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
