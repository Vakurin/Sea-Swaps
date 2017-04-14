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
   
    
    //создали два ключа для хранения значений
    var keyHighscore = "highscore"
    var keyLastscore = "lastScore"
    var keyMoney = "money"
    var keyUnlock2 = "unlock2"
    var keyUnlock3 = "unlock3"
    var keyUnlock4 = "unlock4"
    var keyUnlock5 = "unlock5"
    var keyUnlock6 = "unlock6"
    var keyUnlock7 = "unlock7"
    var keyUnlock8 = "unlock8"
    var keyUnlock9 = "unlock9"
    
    
    override init() {
        //инициализация
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
        UserDefaults.standard.set(highscore, forKey: keyHighscore)
        UserDefaults.standard.set(lastScore, forKey: keyLastscore)
        UserDefaults.standard.set(money, forKey: keyMoney)
        UserDefaults.standard.set(unlock2, forKey: keyUnlock2)
        UserDefaults.standard.set(unlock3, forKey: keyUnlock3)
        UserDefaults.standard.set(unlock4, forKey: keyUnlock4)
        UserDefaults.standard.set(unlock5, forKey: keyUnlock5)
        UserDefaults.standard.set(unlock6, forKey: keyUnlock6)
        UserDefaults.standard.set(unlock7, forKey: keyUnlock7)
        UserDefaults.standard.set(unlock8, forKey: keyUnlock8)
        UserDefaults.standard.set(unlock9, forKey: keyUnlock9)

    }
    
    func loadGameSettings(){
        highscore = UserDefaults.standard.integer(forKey: keyHighscore)
        lastScore = UserDefaults.standard.integer(forKey: keyLastscore)
        money = UserDefaults.standard.integer(forKey: keyMoney)
        unlock2 = UserDefaults.standard.bool(forKey: keyUnlock2)
        unlock3 = UserDefaults.standard.bool(forKey: keyUnlock3)
        unlock4 = UserDefaults.standard.bool(forKey: keyUnlock4)
        unlock5 = UserDefaults.standard.bool(forKey: keyUnlock5)
        unlock6 = UserDefaults.standard.bool(forKey: keyUnlock6)
        unlock7 = UserDefaults.standard.bool(forKey: keyUnlock7)
        unlock8 = UserDefaults.standard.bool(forKey: keyUnlock8)
        unlock9 = UserDefaults.standard.bool(forKey: keyUnlock9)
        
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
