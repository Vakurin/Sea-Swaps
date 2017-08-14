//
//  SoundSettings.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 13.08.17.
//  Copyright © 2017 Vakurin Maxim. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

extension GameScene {
    
    func musicOnOrOff() {
        if musicOn {
            musicPlayer.play()
        } else {
            musicPlayer.stop()
        }
    }
    
    func playMusic() {
        //let musicPath = SKTAudio.sharedInstance().backgroundMusicPlayer
        //musicOnOrOff()
        let musicPath = Bundle.main.url(forResource: "happy_adveture", withExtension: "mp3")!
        musicPlayer = try! AVAudioPlayer(contentsOf: musicPath, fileTypeHint: nil)
        musicOnOrOff()
        //если поставить отрицательное число, то будет играть бессконечно
        musicPlayer.numberOfLoops = -1
        musicPlayer.volume = 0.2
    }
}

struct Music {
    static let heroClick = "heroesclick.wav"
    static let negative = "negative.wav"
    static let positive = "positive.wav"
    static let click = "click.mp3"
}

func sceneSound(scene: GameScene, nameOfSound: String) {
    if scene.sound == true {
        let hitSoundAction = SKAction.playSoundFileNamed(nameOfSound, waitForCompletion: true)
        scene.run(hitSoundAction)
    }
}
