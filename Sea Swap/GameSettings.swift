//
//  GameSettings.swift
//  Sea Swaps
//
//  Created by Максим Вакурин on 11.03.17.
//  Copyright © 2017 Максим Вакурин. All rights reserved.
//

import UIKit
import SpriteKit

class GameSettings: NSObject {
    
    var highscore: Int
    var currentScore: Int
    var lastScore: Int
    var money: Int
    var resetScore: Int
    var unlock2: Bool
    var unlock3: Bool
    var unlock4: Bool
    var unlock5: Bool
    var unlock6: Bool
    var unlock7: Bool
    var unlock8: Bool
    var unlock9: Bool
   
    //ключи для хранения значений
    static let keyHighscore = "highscore"
    static let keyLastscore = "lastScore"
    static let keyMoney = "money"
    static let keyUnlock2 = "unlock2"
    static let keyUnlock3 = "unlock3"
    static let keyUnlock4 = "unlock4"
    static let keyUnlock5 = "unlock5"
    static let keyUnlock6 = "unlock6"
    static let keyUnlock7 = "unlock7"
    static let keyUnlock8 = "unlock8"
    static let keyUnlock9 = "unlock9"
    
    override init() {
        highscore = 0
        currentScore = 0
        lastScore = 0
        money = 0
        resetScore = currentScore
        unlock2 = false
        unlock3 = false
        unlock4 = false
        unlock5 = false
        unlock6 = false
        unlock7 = false
        unlock8 = false
        unlock9 = false
        
        super.init()
        //подгружаем если были какие-то значения
        loadGameSettings()
    }
    
    func recordScores(score: Int) {
        if score > highscore {
            highscore = score
        }
        lastScore = score
        saveGameSettings()
    }
    
    func saveGameSettings() {
        UserDefaults.standard.set(highscore, forKey: GameSettings.keyHighscore)
        UserDefaults.standard.set(lastScore, forKey: GameSettings.keyLastscore)
        UserDefaults.standard.set(money, forKey: GameSettings.keyMoney)
        UserDefaults.standard.set(unlock2, forKey: GameSettings.keyUnlock2)
        UserDefaults.standard.set(unlock3, forKey: GameSettings.keyUnlock3)
        UserDefaults.standard.set(unlock4, forKey: GameSettings.keyUnlock4)
        UserDefaults.standard.set(unlock5, forKey: GameSettings.keyUnlock5)
        UserDefaults.standard.set(unlock6, forKey: GameSettings.keyUnlock6)
        UserDefaults.standard.set(unlock7, forKey: GameSettings.keyUnlock7)
        UserDefaults.standard.set(unlock8, forKey: GameSettings.keyUnlock8)
        UserDefaults.standard.set(unlock9, forKey: GameSettings.keyUnlock9)

    }
    
    func loadGameSettings(){
        highscore = UserDefaults.standard.integer(forKey: GameSettings.keyHighscore)
        lastScore = UserDefaults.standard.integer(forKey: GameSettings.keyLastscore)
        money = UserDefaults.standard.integer(forKey: GameSettings.keyMoney)
        unlock2 = UserDefaults.standard.bool(forKey: GameSettings.keyUnlock2)
        unlock3 = UserDefaults.standard.bool(forKey: GameSettings.keyUnlock3)
        unlock4 = UserDefaults.standard.bool(forKey: GameSettings.keyUnlock4)
        unlock5 = UserDefaults.standard.bool(forKey: GameSettings.keyUnlock5)
        unlock6 = UserDefaults.standard.bool(forKey: GameSettings.keyUnlock6)
        unlock7 = UserDefaults.standard.bool(forKey: GameSettings.keyUnlock7)
        unlock8 = UserDefaults.standard.bool(forKey: GameSettings.keyUnlock8)
        unlock9 = UserDefaults.standard.bool(forKey: GameSettings.keyUnlock9)
    }
    
    func reset() {
        currentScore = 0
    }
    
    func continueReset() {
        resetScore = currentScore
    }
    
    func resetHighScore(){
        highscore = 0
        lastScore = 0
        saveGameSettings()
    }
}
